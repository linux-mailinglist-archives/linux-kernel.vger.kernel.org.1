Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A12E2D5752
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 10:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732682AbgLJJg1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Dec 2020 04:36:27 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:48991 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732639AbgLJJgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 04:36:23 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-88-VZuhpelxODGJV8wFgwzj7w-1; Thu, 10 Dec 2020 09:34:38 +0000
X-MC-Unique: VZuhpelxODGJV8wFgwzj7w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 10 Dec 2020 09:34:37 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 10 Dec 2020 09:34:37 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Joe Perches' <joe@perches.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     LKML <linux-kernel@vger.kernel.org>
Subject: RE: checkpatch
Thread-Topic: checkpatch
Thread-Index: AQHWzrUw0a7UmS3NhEOklnWYktoEBKnwEOAg
Date:   Thu, 10 Dec 2020 09:34:37 +0000
Message-ID: <32a8677e1bcf4d69ba019bfcefc9ea59@AcuMS.aculab.com>
References: <87zh2mzw3h.fsf@nanos.tec.linutronix.de>
 <aea0efa93c17e431205eeb932a73efa7e21598a3.camel@perches.com>
In-Reply-To: <aea0efa93c17e431205eeb932a73efa7e21598a3.camel@perches.com>
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

From: Joe Perches
> Sent: 10 December 2020 05:26
> 
> On Wed, 2020-12-09 at 19:13 +0100, Thomas Gleixner wrote:
> > Joe,
> 
> Hi Thomas.
> 
> > the below made it through my filters for some reason so I actually
> > looked and immediately wondered why checkpatch.pl did not identify this
> > as pure garbage.
> >
> >  Original mail is here: lore.kernel.org/r/69cb540a-09d5-4956-b062-071ccded7090@web.de
> >
> > Can you have a look please? Adding brackets in the middle of the code
> > for absolutely no reason is wrong to begin with and then not indenting
> > the enclosed code makes it even worse.
> 
> Well, maybe something like this, but there are probably some
> drawbacks with initializations.

Isn't the other likely problem where an extra code block
is being squeezed in after a case label without generating
a double-indent.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

