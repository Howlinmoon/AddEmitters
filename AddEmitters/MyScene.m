//
//  MyScene.m
//  AddEmitters
//
//  Created by jim Veneskey on 6/29/15.
//  Copyright (c) 2015 Jim Veneskey. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene {
    // some ivars - aka globals...
    SKSpriteNode *ship;
    SKEmitterNode *rocketEngine;
    BOOL touching;
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
    
        // default to the screen is not being touched
        touching = NO;
        
        // add background
        SKSpriteNode *bg = [SKSpriteNode spriteNodeWithImageNamed:@"nightsky"];
        bg.position = CGPointMake(size.width/2, size.height/2);
        [self addChild:bg];
        
        // add a space ship
        ship = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        ship.position = CGPointMake(size.width/2, size.height/2);
        ship.scale = .3;
        ship.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:ship.size];
        [self addChild:ship];
        
        // add the emitter
        rocketEngine = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"EngineParticle" ofType:@"sks"]];
        rocketEngine.numParticlesToEmit = 1;
        
        // Where to place the emitter?
        // This is a bad spot
        //rocketEngine.position = ship.position;
        //[self addChild:rocketEngine];
        
        // try attaching the rocket TO the ship node
        // use relative co-ords
        rocketEngine.position = CGPointMake(0, -170);
        [ship addChild:rocketEngine];
        
        
        // edges of scene
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        // reduce gravity
        self.physicsWorld.gravity = CGVectorMake(0, -1);
        
    
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    touching = YES;
    rocketEngine.numParticlesToEmit = 0;
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    touching = NO;
    rocketEngine.numParticlesToEmit = 100;
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    // apply upwards force
    if (touching) {
        [ship.physicsBody applyForce:CGVectorMake(0, 150)];
        
        // To Do show Engines
    }
}

@end
