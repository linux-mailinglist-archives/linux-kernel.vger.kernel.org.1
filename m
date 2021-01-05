Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B2D2EA884
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 11:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbhAEKVs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Jan 2021 05:21:48 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:27007 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728981AbhAEKVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 05:21:47 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-30-uoFF9HGNMyeCKOzMT-0d8g-1; Tue, 05 Jan 2021 10:20:07 +0000
X-MC-Unique: uoFF9HGNMyeCKOzMT-0d8g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 5 Jan 2021 10:20:07 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 5 Jan 2021 10:20:07 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Joe Perches' <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
CC:     "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] checkpatch: add a new check for strcpy/strlcpy uses
Thread-Topic: [PATCH] checkpatch: add a new check for strcpy/strlcpy uses
Thread-Index: AQHW4z9Q88VHmIJ6eEaZbDSrKKOd0aoY0EBw
Date:   Tue, 5 Jan 2021 10:20:07 +0000
Message-ID: <d081ca22bbd44f969fa45a8abc543606@AcuMS.aculab.com>
References: <20210105082303.15310-1-dwaipayanray1@gmail.com>
 <50cc861121b62b3c1518222f24f679c3f72b868d.camel@perches.com>
In-Reply-To: <50cc861121b62b3c1518222f24f679c3f72b868d.camel@perches.com>
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
> Sent: 05 January 2021 08:44
> 
> On Tue, 2021-01-05 at 13:53 +0530, Dwaipayan Ray wrote:
> > strcpy() performs no bounds checking on the destination buffer.
> > This could result in linear overflows beyond the end of the buffer.
> >
> > strlcpy() reads the entire source buffer first. This read
> > may exceed the destination size limit. This can be both inefficient
> > and lead to linear read overflows.
> >
> > The safe replacement to both of these is to use strscpy() instead.
> > Add a new checkpatch warning which alerts the user on finding usage of
> > strcpy() or strlcpy().
> 
> I do not believe that strscpy is preferred over strcpy.
> 
> When the size of the output buffer is known to be larger
> than the input, strcpy is faster.
> 
> There are about 2k uses of strcpy.
> Is there a use where strcpy use actually matters?
> I don't know offhand...
> 
> But I believe compilers do not optimize away the uses of strscpy
> to a simple memcpy like they do for strcpy with a const from
> 
> 	strcpy(foo, "bar");

It ought to be possible to convert:
	strscpy(foo, "bar", constant_sz)
to a memcpy() within the .h file.

Similarly it should be possible to error
	strcpy(foo, "bar")
Unless foo is large enough and "bar" is constant.

After all with a length check
	strcpy(foo, "bar")
is actually safer than
	strspy(foo, "bar", sizeof foo)
because there is less room for error.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

