Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC2B2DBE4D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 11:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgLPKI4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Dec 2020 05:08:56 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:32392 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726104AbgLPKI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 05:08:56 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mtapsc-1-DQ7o0olHPkKE9tyKf8G5Zg-1; Wed, 16 Dec 2020 10:07:17 +0000
X-MC-Unique: DQ7o0olHPkKE9tyKf8G5Zg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 16 Dec 2020 10:07:17 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 16 Dec 2020 10:07:17 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Sam Ravnborg' <sam@ravnborg.org>, Arnd Bergmann <arnd@kernel.org>
CC:     Guo Ren <guoren@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        "Marco Elver" <elver@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Elena Reshetova" <elena.reshetova@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: RE: [PATCH 1/2] futex: mark futex_detect_cmpxchg() as 'noinline'
Thread-Topic: [PATCH 1/2] futex: mark futex_detect_cmpxchg() as 'noinline'
Thread-Index: AQHW0xooHlKGsPugJ0Clc+udYv6uHan5fdZg
Date:   Wed, 16 Dec 2020 10:07:17 +0000
Message-ID: <56daed1d2cbd40fea0a7170c45081cf7@AcuMS.aculab.com>
References: <20190307091514.2489338-1-arnd@arndb.de>
 <X9S28TcEXd2zghzp@elver.google.com> <87czzeg5ep.fsf@nanos.tec.linutronix.de>
 <CAK8P3a0LWjNgwm605TM4dKCsn078X7NC3sEfdBSgcMNEocQ5iA@mail.gmail.com>
 <CAJF2gTRLEbBfZJ7Y6UNOMq-cwG5OYRW=+8Pfauz6v6R8ntBjYA@mail.gmail.com>
 <CAK8P3a3+WaQNyJ6Za2qfu6=0mBgU1hApnRXrdp1b1=P7wwyRUg@mail.gmail.com>
 <20201215193800.GA1098247@ravnborg.org>
In-Reply-To: <20201215193800.GA1098247@ravnborg.org>
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

From: Sam Ravnborg
> Sent: 15 December 2020 19:38
> 
> Hi Arnd,
> 
> On Tue, Dec 15, 2020 at 12:26:10PM +0100, Arnd Bergmann wrote:
> > On Tue, Dec 15, 2020 at 7:09 AM Guo Ren <guoren@kernel.org> wrote:
...
> > - Disable SMP support for sun4m/sun4d. From the historic git
> >   tree, it's unclear how well this ever worked, and very few machines
> >   of this class ever existed
> Yeah, I have collection of sparc32 machines that I played around with
> once. Including one sun4d that I brought from a friendly Linux fellow in
> the UK. But somehow I lost interest as this is all very nice machines
> but not useful for anything real work.

ICL made a few SMP sparc32 systems.
I think the first ones used the original Cypress cpu running at 25MHz.
(I'm fairly sure these were SMP-capable, the later 40MHz definitely were.)
These were full sized VMEbus beasts.
Somewhere I've got a 32MByte memory board - over a square foot of board.
The memory is all 64k by 1 with all the pins on one edge and the chips vertical.
Really looks as though it should glow red and be used for cooking toast.
Even with 4 of those you're not going to run anything modern!

There were also some later mbus+sbus systems with dual sbus!
Designed by Fujitsu.

None of these ever ran solaris.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

