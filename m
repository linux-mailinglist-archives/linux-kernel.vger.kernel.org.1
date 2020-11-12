Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8734C2B031D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 11:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgKLKud convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Nov 2020 05:50:33 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:31780 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727982AbgKLKu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 05:50:29 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-233-NtPqp2y3NwaRSrBCxNKq9Q-1; Thu, 12 Nov 2020 10:50:24 +0000
X-MC-Unique: NtPqp2y3NwaRSrBCxNKq9Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 12 Nov 2020 10:50:24 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 12 Nov 2020 10:50:24 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>
Subject: Repeated 'watchdog soft lockup' messages
Thread-Topic: Repeated 'watchdog soft lockup' messages
Thread-Index: Ada434PEoNfBdUnWS36emNJ9dr0htA==
Date:   Thu, 12 Nov 2020 10:50:24 +0000
Message-ID: <4e624f005f3744eb82adfa1e5ef0d683@AcuMS.aculab.com>
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

Due to a coding fubar (in my own driver) I managed to sleep
a process that held a spinlock.
Unluckily all 8 cpus ended up trying to acquire the spinlock
before the process woke.
As might be expected the system froze.

I'd got a serial console connected so could see the kernel messages.
It was almost continuously generating output saying that each
cpu was 'stuck for 22s!' (sometimes 23s).

What I don't understand is what was resetting the watchdog
so that I got multiple messages for each cpu at intervals
of (typically) 28 seconds.

The watchdog code seems to only output the trace once.
But that clearly wasn't working.
Any idea why?

kernel is 5.9.0

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

