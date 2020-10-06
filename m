Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6922284FBE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 18:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgJFQWP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 6 Oct 2020 12:22:15 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:26753 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725972AbgJFQWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 12:22:15 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-214-PwnpPkW5Ose2mzPbAEManw-1; Tue, 06 Oct 2020 17:22:11 +0100
X-MC-Unique: PwnpPkW5Ose2mzPbAEManw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 6 Oct 2020 17:22:10 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 6 Oct 2020 17:22:10 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Willy Tarreau' <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>
CC:     'Nick Clifton' <nickc@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>,
        "Will Deacon" <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Thread-Index: AQHWm9Z2gJDHxIOMJkCFRnXrafG7EamKgJsQgAAvGJKAAASM8IAACo9JgAABq0A=
Date:   Tue, 6 Oct 2020 16:22:10 +0000
Message-ID: <e31a06a9c1e04b6c8c054b1fed3f897b@AcuMS.aculab.com>
References: <20201006114710.GQ2628@hirez.programming.kicks-ass.net>
 <3dfe7daed3c44f46a6989b6513ad7bb0@AcuMS.aculab.com>
 <20201006133115.GT2628@hirez.programming.kicks-ass.net>
 <20201006142324.GB416765@rowland.harvard.edu>
 <20201006144302.GY2628@hirez.programming.kicks-ass.net>
 <47bfda8f-304e-5283-c6d6-0753037b0b2c@redhat.com>
 <1dabfd1939f348198678121f94d6c9b2@AcuMS.aculab.com>
 <20201006155052.GJ29330@paulmck-ThinkPad-P72> <20201006161039.GF5822@1wt.eu>
In-Reply-To: <20201006161039.GF5822@1wt.eu>
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

From: Willy Tarreau
> Sent: 06 October 2020 17:11
> 
> On Tue, Oct 06, 2020 at 08:50:52AM -0700, Paul E. McKenney wrote:
> > Comparing 25+ assembly languages to but two compilers most definitely
> > motivates looking hard at doing something with the compilers.
> 
> +1, especially since the kernel is not special; anyone working with
> threads faces the same issues in userland, which are often hidden
> behind the implicit whole-memory clobbers of certain operations or
> the call to mutex manipulation functions, but which become a reality
> again as soon as you go slightly away from these and try to use
> lockless mechanisms.

AFAICT most windows and android apps completely ignore the problem
of thread locking - which is why the crash and lock up all the time :-)

I've spent most of the day looking at some library traces from a
customer bug.
I almost suspect a bug in the pthread mutex code on their system.
They are using a nice, modern, 3.10.0-957.el7.x86_64 kernel.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

