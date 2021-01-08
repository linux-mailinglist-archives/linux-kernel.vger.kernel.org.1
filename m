Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9772EF0D3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 11:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbhAHKpp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Jan 2021 05:45:45 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:53255 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726752AbhAHKpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 05:45:44 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-17-04M2xobfMwm9oKu886QCTg-1; Fri, 08 Jan 2021 10:44:05 +0000
X-MC-Unique: 04M2xobfMwm9oKu886QCTg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 8 Jan 2021 10:44:04 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 8 Jan 2021 10:44:04 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>
CC:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        kernel test robot <oliver.sang@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Borislav Petkov" <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        "zhengjun.xing@intel.com" <zhengjun.xing@intel.com>
Subject: RE: [x86] d55564cfc2: will-it-scale.per_thread_ops -5.8% regression
Thread-Topic: [x86] d55564cfc2: will-it-scale.per_thread_ops -5.8% regression
Thread-Index: AQHW5SyQsxcCoz6xzUCV1q8xqWXcS6odd5WggAAF3gCAAAqDgA==
Date:   Fri, 8 Jan 2021 10:44:04 +0000
Message-ID: <bd305585311745ae9f721b7d50307fc5@AcuMS.aculab.com>
References: <20210107134723.GA28532@xsang-OptiPlex-9020>
 <CAHk-=wgQ5EEH3-GTK9KDB5mBmWjP25YHXC6_-V_KfWd0UTDTDQ@mail.gmail.com>
 <20210107183358.GG3579531@ZenIV.linux.org.uk>
 <CAHk-=wiZaFRt9hGen9=eOr7LA+Q8o5f980eGEvtxBD6+os7nqA@mail.gmail.com>
 <20210107190445.GK3579531@ZenIV.linux.org.uk>
 <CAHk-=whneXU5Sr=iOOrzcqZt6q85zp-8CUSviOwGPj5ePBW4CQ@mail.gmail.com>
 <824461ae2cb642b1b2f82fac140a98da@AcuMS.aculab.com>
 <X/grPFTgOMvtqEVZ@hirez.programming.kicks-ass.net>
In-Reply-To: <X/grPFTgOMvtqEVZ@hirez.programming.kicks-ass.net>
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
> Sent: 08 January 2021 09:52
> 
> On Fri, Jan 08, 2021 at 09:37:45AM +0000, David Laight wrote:
> > The lack of spinlocks in userspace really kills you.
> 
> Glibc has them, but please don't complain about lock holder preemption
> issues if you do actually use them ;-)

Nothing that glibc can do can help.
It would need to disable interrupts - which isn't allowed in userspace.

The problem isn't that the process holding the lock gets preempted,
but that the lock hold time goes from a few instructions to ~1ms.

It is also entirely noticeable (and a problem) that the futex call
that implements cv_broadcast() gets each process to wake up the next one.
There are two issues:
1) It takes time for the cpu to come out of the sleep states.
   These happen in sequence rather than all together.
2) If the processor affinities mean that one of the threads can't
   be run immediately, then none of the later threads runs either.

I realise this is (probably) done to avoid the 'thundering herd'
on the related mutex - but this code gets nowhere near acquiring
the mutex before the delays, and the mutex is released pretty
soon after 'return to user'.

The delays are far longer than a normal system call or even a 
process switch.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

