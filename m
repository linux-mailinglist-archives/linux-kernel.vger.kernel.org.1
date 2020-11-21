Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E992BBECA
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 12:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbgKULu3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 21 Nov 2020 06:50:29 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:39614 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727337AbgKULu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 06:50:29 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-45-zOLMDCtGMdWjyngmXZIzpw-1; Sat, 21 Nov 2020 11:50:23 +0000
X-MC-Unique: zOLMDCtGMdWjyngmXZIzpw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sat, 21 Nov 2020 11:50:23 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sat, 21 Nov 2020 11:50:22 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Davidlohr Bueso' <dave@stgolabs.net>
CC:     'Waiman Long' <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>
Subject: RE: [RFC PATCH 5/5] locking/rwsem: Remove reader optimistic spinning
Thread-Topic: [RFC PATCH 5/5] locking/rwsem: Remove reader optimistic spinning
Thread-Index: AQHWvqN0O6hwIV/IOUmlkB4qEdd62KnQ/N3QgACQ0wCAAOypEA==
Date:   Sat, 21 Nov 2020 11:50:22 +0000
Message-ID: <45f36a7545c84b62b49aaff95f28a49a@AcuMS.aculab.com>
References: <20201118030429.23017-1-longman@redhat.com>
 <20201118030429.23017-6-longman@redhat.com>
 <20201118053556.3fmmtat7upv6dtvd@linux-p48b.lan>
 <ee34bc01-9fef-23ff-ada1-1ec2d39533c9@redhat.com>
 <5fe76531782f4a8492b341d5f381147b@AcuMS.aculab.com>
 <20201120213828.n7f23qy75hduommo@linux-p48b.lan>
In-Reply-To: <20201120213828.n7f23qy75hduommo@linux-p48b.lan>
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

From: Davidlohr Bueso
> Sent: 20 November 2020 21:38
> 
> On Fri, 20 Nov 2020, David Laight wrote:
> >I got massive performance improvements from changing a driver
> >we have to use mutex instead of the old semaphores (the driver
> >was written a long time ago).
> >
> >While these weren't 'rw' the same issue will apply.
> >
> >The problem was that the semaphore/mutex was typically only held over
> >a few instructions (eg to add an item to a list).
> >But with semaphore if you got contention the process always slept.
> >OTOH mutex spin 'for a while' before sleeping so the code rarely slept.
> 
> The caveat here is if you are using trylock/unlock from irq, which
> is the only reason why regular semaphores are still around today. If
> not, indeed a mutex is better.

Unless you want to timeout the lock request.

Timeouts are particularly useful in code paths that might
run after an 'oops' or other deadlock.
Typically for reporting status information.
You get to choose whether to error the status request or
carry on knowing that the data is unlikely to change.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

