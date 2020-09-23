Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBEE275B86
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgIWPVt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 23 Sep 2020 11:21:49 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:40478 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726156AbgIWPVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:21:47 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-279-RO2zBdHMMA6wi2dLfDiKZw-1; Wed, 23 Sep 2020 16:21:42 +0100
X-MC-Unique: RO2zBdHMMA6wi2dLfDiKZw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 23 Sep 2020 16:21:41 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 23 Sep 2020 16:21:41 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Petr Mladek' <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>
CC:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH printk 3/5] printk: use buffer pool for sprint buffers
Thread-Topic: [PATCH printk 3/5] printk: use buffer pool for sprint buffers
Thread-Index: AQHWkbvTttZV2GpHGUOQ6CZ1VgO6Jal2Vhqg
Date:   Wed, 23 Sep 2020 15:21:41 +0000
Message-ID: <f4c854b05b394a5f9548715698fd5f59@AcuMS.aculab.com>
References: <20200922153816.5883-1-john.ogness@linutronix.de>
 <20200922153816.5883-4-john.ogness@linutronix.de>
 <20200923151129.GC6442@alley>
In-Reply-To: <20200923151129.GC6442@alley>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Mladek
> Sent: 23 September 2020 16:11
> 
> On Tue 2020-09-22 17:44:14, John Ogness wrote:
> > vprintk_store() is using a single static buffer as a temporary
> > sprint buffer for the message text. This will not work once
> > @logbuf_lock is removed. Replace the single static buffer with a
> > pool of buffers.
> 
> The buffer is used because we do not know the length of the
> formatted message to reserve the right space in the ring buffer
> in advance.
> 
> There was the idea to call vsprintf(NULL, fmt, args) to count
> the length in advance.
> 
> AFAIK, there is one catch. We need to use va_copy() around
> the 1st call because va_format can be proceed only once.
> See, va_format() in lib/vsprintf.c as an example.
> 
> Is there any other problem, please?

Potentially the data can change after the vsprintf(NULL, ...)
call so that the buffer isn't guaranteed to be the right length.

Never mind the extra cost of doing all the work twice.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

