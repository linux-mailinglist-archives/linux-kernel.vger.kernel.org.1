Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B51284BBC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 14:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgJFMhM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 6 Oct 2020 08:37:12 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:33940 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726459AbgJFMhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 08:37:10 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-194-qMDTpG-TMdWdMAHSEoaX-A-1; Tue, 06 Oct 2020 13:37:07 +0100
X-MC-Unique: qMDTpG-TMdWdMAHSEoaX-A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 6 Oct 2020 13:37:06 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 6 Oct 2020 13:37:06 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        "linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>,
        "Will Deacon" <will@kernel.org>, Paul McKenney <paulmck@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Subject: RE: Control Dependencies vs C Compilers
Thread-Topic: Control Dependencies vs C Compilers
Thread-Index: AQHWm9Z2gJDHxIOMJkCFRnXrafG7EamKgJsQ
Date:   Tue, 6 Oct 2020 12:37:06 +0000
Message-ID: <3dfe7daed3c44f46a6989b6513ad7bb0@AcuMS.aculab.com>
References: <20201006114710.GQ2628@hirez.programming.kicks-ass.net>
In-Reply-To: <20201006114710.GQ2628@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra
> Sent: 06 October 2020 12:47
> Hi,
> 
> Let's give this linux-toolchains thing a test-run...
> 
> As some of you might know, there's a bit of a discrepancy between what
> compiler and kernel people consider 'valid' use of the compiler :-)
> 
> One area where this shows up is in implicit (memory) ordering provided
> by the hardware, which we kernel people would like to use to avoid
> explicit fences (expensive) but which the compiler is unaware of and
> could ruin (bad).
...
> 
> In short, the control dependency relies on the hardware never
> speculating stores (instant OOTA) to provide a LOAD->STORE ordering.
> That is, a LOAD must be completed to resolve a conditional branch, the
> STORE is after the branch and cannot be made visible until the branch is
> determined (which implies the load is complete).
> 
> However, our 'dear' C language has no clue of any of this.
> 
> So given code like:
> 
> 	x = *foo;
> 	if (x > 42)
> 		*bar = 1;
> 
> Which, if literally translated into assembly, would provide a
> LOAD->STORE order between foo and bar, could, in the hands of an
> evil^Woptimizing compiler, become:
> 
> 	x = *foo;
> 	*bar = 1;
> 
> because it knows, through value tracking, that the condition must be
> true.
> 
> Our Documentation/memory-barriers.txt has a Control Dependencies section
> (which I shall not replicate here for brevity) which lists a number of
> caveats. But in general the work-around we use is:
> 
> 	x = READ_ONCE(*foo);
> 	if (x > 42)
> 		WRITE_ONCE(*bar, 1);

An alternative is to 'persuade' the compiler that
any 'tracked' value for a local variable is invalid.
Rather like the way that barrier() 'invalidates' memory.
So you generate:

	x = *foo
	asm ("" : "+r" (x));
	if (x > 42)
		*bar = 1;

Since the "+r" constraint indicates that the value of 'x'
might have changed it can't optimise based on any
presumed old value.
(Unless it looks inside the asm opcodes...)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

