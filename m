Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F692A1E88
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 15:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgKAOaf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 1 Nov 2020 09:30:35 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:28092 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726480AbgKAOaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 09:30:35 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mtapsc-3-b26fjlLoNLCbFSzV-D9BNQ-1; Sun, 01 Nov 2020 14:30:30 +0000
X-MC-Unique: b26fjlLoNLCbFSzV-D9BNQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sun, 1 Nov 2020 14:30:29 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sun, 1 Nov 2020 14:30:29 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Marc Zyngier' <maz@kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Android Kernel Team" <kernel-team@android.com>
Subject: RE: [PATCH 0/2] arm64: Allow the rescheduling IPI to bypass
 irq_enter/exit
Thread-Topic: [PATCH 0/2] arm64: Allow the rescheduling IPI to bypass
 irq_enter/exit
Thread-Index: AQHWsFD3rGtiop/dtkOamYA82M1uH6mzVJew
Date:   Sun, 1 Nov 2020 14:30:29 +0000
Message-ID: <7bac58d011f5443b9442eea38b285dfa@AcuMS.aculab.com>
References: <20201101131430.257038-1-maz@kernel.org>
In-Reply-To: <20201101131430.257038-1-maz@kernel.org>
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

From: Marc Zyngier
> Sent: 01 November 2020 13:14
> 
> Vincent recently reported [1] that 5.10-rc1 showed a significant
> regression when running "perf bench sched pipe" on arm64, and
> pinpointed it to the recent move to handling IPIs as normal
> interrupts.
> 
> The culprit is the use of irq_enter/irq_exit around the handling of
> the rescheduling IPI, meaning that we enter the scheduler right after
> the handling of the IPI instead of deferring it to the next preemption
> event. This accounts for most of the overhead introduced.
> 
> On architectures that have architected IPIs at the CPU level (x86
> being the obvious one), the absence of irq_enter/exit is natural. ARM
> (both 32 and 64bits) mimicked this behaviour by having some
> arch-specific handling for the interrupts that are used to implement
> IPIs. Moving IPIs on the normal interrupt path introduced the
> regression.
> 
> This couple of patches try to acknowledge the fact that some IPIs are
> "special", in the sense that they don't need to follow the standard
> interrupt handling flow.
> 
> The good news is that it cures the regression on arm64, and could
> be similarly beneficial to both 32bit ARM, MIPS, or any other
> architecture that uses a unique IRQ to represent the scheduler IPI.
> 
> The bad news is that these patches are ugly as sin, and I really don't
> like them. I specially hate that they can give driver authors the idea
> that they can make random interrupts "faster".
> 
> Comments, suggestions and hate mails appreciated, as always.

One problem is that the only explanation is in the cover note.
Nothing in the patches even gives a hint as to what difference
the 'NAKED' flag makes nor why its is applied to one interrupt.

Which all means someone might revert it all as part of a cleanup.
A couple of comments is probably all it needs.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

