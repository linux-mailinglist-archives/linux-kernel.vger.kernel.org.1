Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE342EEFB4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 10:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbhAHJb2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Jan 2021 04:31:28 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:55568 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727629AbhAHJbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 04:31:24 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-146-1FI48KQOPHOmmMChUE2yHA-1; Fri, 08 Jan 2021 09:29:43 +0000
X-MC-Unique: 1FI48KQOPHOmmMChUE2yHA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 8 Jan 2021 09:29:42 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 8 Jan 2021 09:29:42 +0000
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
Thread-Index: AQHW5S+2ndv+N/v8PE2rPRBCL8mR5Koddc2w
Date:   Fri, 8 Jan 2021 09:29:42 +0000
Message-ID: <e5316226f4174de7925c895cca65a94e@AcuMS.aculab.com>
References: <20210107134723.GA28532@xsang-OptiPlex-9020>
 <CAHk-=wgQ5EEH3-GTK9KDB5mBmWjP25YHXC6_-V_KfWd0UTDTDQ@mail.gmail.com>
 <20210107183358.GG3579531@ZenIV.linux.org.uk>
 <CAHk-=wiZaFRt9hGen9=eOr7LA+Q8o5f980eGEvtxBD6+os7nqA@mail.gmail.com>
 <20210107190445.GK3579531@ZenIV.linux.org.uk>
 <CAHk-=whneXU5Sr=iOOrzcqZt6q85zp-8CUSviOwGPj5ePBW4CQ@mail.gmail.com>
 <20210107195734.GL3579531@ZenIV.linux.org.uk>
In-Reply-To: <20210107195734.GL3579531@ZenIV.linux.org.uk>
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
> Sent: 07 January 2021 19:58
> 
> On Thu, Jan 07, 2021 at 11:33:36AM -0800, Linus Torvalds wrote:
> 
> > In fact, even some threaded app that does what I suspect it could do
> > would likely be ok with it 99% of the time. Because the situation
> > where you change the fd in the poll array is likely not the common
> > case, and even if some -1 file descriptor gets overwritten by a valid
> > one by the poll() system call again, it probably ends up being very
> > hard to see a failure.
> >
> > Which just makes me even more nervous.
> 
> Hmm...  But anything like that will have another problem - we do
> copyin only once.  And we repeat fdget() on each iteration of
> do_poll() loop.  Sure, we don't actually put anything on the
> queues after the first time around, and __pollwait() keeps the
> ones we are actually waiting for pinned, but...  If another
> thread stores -1 to ->fd, then closes what used to be there
> and moves on, what will it see?  ->poll() calls will be done
> for whatever file we'd reused the descriptor for.  Sure,
> the kernel won't break, but the caller of poll() would need
> to be very careful about what it sees...
> 
> Frankly, I'd consider seeing that kind of games in the userland
> as a big red flag; I'm not saying it's OK to break the suckers
> even worse than they are now, but I'm curious whether anything
> in the userland does it *and* how many bugs does it have around
> those uses of poll()...

It is much more likely that an application will change the 'events'
field - in particular enabling POLLOUT if a write() returned EAGAIN.

It could also change the fd, but defer doing the actual close() until
much later - that needs to be synchronised between the application
threads.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

