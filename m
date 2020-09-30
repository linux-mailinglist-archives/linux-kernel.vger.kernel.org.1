Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA08827EAF7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 16:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbgI3OcT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 30 Sep 2020 10:32:19 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:54023 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728149AbgI3OcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 10:32:19 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-195-PQuEQoKvMGmaHF5ETfZwSQ-2; Wed, 30 Sep 2020 15:32:15 +0100
X-MC-Unique: PQuEQoKvMGmaHF5ETfZwSQ-2
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 30 Sep 2020 15:32:12 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 30 Sep 2020 15:32:12 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Steven Rostedt' <rostedt@goodmis.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
CC:     Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH printk 3/5] printk: use buffer pool for sprint buffers
Thread-Topic: [PATCH printk 3/5] printk: use buffer pool for sprint buffers
Thread-Index: AQHWly6i3uftD0MwYEu+n/WNbQR9JamBPhZA
Date:   Wed, 30 Sep 2020 14:32:12 +0000
Message-ID: <3d6c42b0734a4713b45647415a51bcc1@AcuMS.aculab.com>
References: <20200922153816.5883-1-john.ogness@linutronix.de>
        <20200922153816.5883-4-john.ogness@linutronix.de>
        <20200923151129.GC6442@alley>
        <aef3626f-56a0-9040-fc0e-224ada032d02@prevas.dk>
        <2c95c16b-03e7-eadd-d3af-bedc6b0b471e@prevas.dk>
        <20200925082822.GL29288@alley>
        <4e36f308-a435-f9c1-2d4f-362e797c764e@prevas.dk>
 <20200930093552.3684aee1@gandalf.local.home>
In-Reply-To: <20200930093552.3684aee1@gandalf.local.home>
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

From: Steven Rostedt
> Sent: 30 September 2020 14:36
> 
> On Wed, 30 Sep 2020 10:06:24 +0200
> Rasmus Villemoes <rasmus.villemoes@prevas.dk> wrote:
> 
> > True. But remember that printk is called from _everywhere_, with all
> > sorts of locks held and/or preemption disabled or whatnot, and every
> > cycle spent in printk makes those windows wider. Doubling the cost of
> > every single printk by unconditionally doing vsnprintf() twice is a bad
> > idea.
> 
> But the console output is usually magnitudes more expensive than the
> vsnprintf(), would doing it twice really make a difference?

Are there any strange %pX modifiers that do anything really horrid?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

