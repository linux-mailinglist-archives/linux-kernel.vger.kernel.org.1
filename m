Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F77A2EF00E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 10:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbhAHJvB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Jan 2021 04:51:01 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:51317 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725791AbhAHJvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 04:51:00 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-219-OQYpK6Q3PCSSKUP3lf-peg-1; Fri, 08 Jan 2021 09:49:21 +0000
X-MC-Unique: OQYpK6Q3PCSSKUP3lf-peg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 8 Jan 2021 09:49:20 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 8 Jan 2021 09:49:20 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Al Viro' <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     kernel test robot <oliver.sang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        "zhengjun.xing@intel.com" <zhengjun.xing@intel.com>
Subject: RE: [x86] d55564cfc2: will-it-scale.per_thread_ops -5.8% regression
Thread-Topic: [x86] d55564cfc2: will-it-scale.per_thread_ops -5.8% regression
Thread-Index: AQHW5SP2JRv8nkj1EkuGw6TTCMykjqodevww
Date:   Fri, 8 Jan 2021 09:49:20 +0000
Message-ID: <cc0646c570f4489bb1bfb20688d64dbe@AcuMS.aculab.com>
References: <20210107134723.GA28532@xsang-OptiPlex-9020>
 <CAHk-=wgQ5EEH3-GTK9KDB5mBmWjP25YHXC6_-V_KfWd0UTDTDQ@mail.gmail.com>
 <20210107183358.GG3579531@ZenIV.linux.org.uk>
In-Reply-To: <20210107183358.GG3579531@ZenIV.linux.org.uk>
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

From: Al Viro
> Sent: 07 January 2021 18:34
> 
> On Thu, Jan 07, 2021 at 09:43:54AM -0800, Linus Torvalds wrote:
> 
> > Before, it would do the whole CLAC/STAC dance inside that loop for
> > every entry (and with that commit d55564cfc22 it would be a function
> > call, of course).
> >
> > Can you verify that this fixes the regression (and in fact I'd expect
> > it to improve that test-case)?
> 
> I'm not sure it's the best approach, TBH.  How about simply
>         for (walk = head; walk; ufds += walk->len, walk = walk->next) {
> 		if (copy_to_user(ufds, walk->entries,
> 				 walk->len * sizeof(struct pollfd))
> 			goto out_fds;
>         }
> in there?  It's both simpler (obviously matches the copyin side) and
> might very well be faster...

I bet it isn't, especially if 'user copy hardening' is enabled.
You also have to 'negotiate' all the conditionals in copy_to_user()
for misaligned lengths, very short copies and alternate algorithms for
long copies.

I'll bet there is a measurable gain from having copy_to/from_user_u64()
that is optimised for copying a structure to/from userspace in 64bit
chunks.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

