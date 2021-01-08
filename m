Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBBA2EF06D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 11:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbhAHKHd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Jan 2021 05:07:33 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:60074 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726205AbhAHKHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 05:07:32 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-164-B6UsFJH8P-uef6L30UKDVQ-1; Fri, 08 Jan 2021 10:05:53 +0000
X-MC-Unique: B6UsFJH8P-uef6L30UKDVQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 8 Jan 2021 10:05:52 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 8 Jan 2021 10:05:52 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Joe Perches' <joe@perches.com>, Kees Cook <keescook@chromium.org>
CC:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: RE: deprecated.rst: deprecated strcpy ? (was: [PATCH] checkpatch: add
 a new check for strcpy/strlcpy uses)
Thread-Topic: deprecated.rst: deprecated strcpy ? (was: [PATCH] checkpatch:
 add a new check for strcpy/strlcpy uses)
Thread-Index: AQHW5Vix10kkBz1uN0KCdEjPICQLQ6odf7Ew
Date:   Fri, 8 Jan 2021 10:05:52 +0000
Message-ID: <05733c9670a14463bec36b2cf0eeeede@AcuMS.aculab.com>
References: <20210105082303.15310-1-dwaipayanray1@gmail.com>
         <50cc861121b62b3c1518222f24f679c3f72b868d.camel@perches.com>
         <CABJPP5DQ0Y42z9ej_j06+KaQevT3ztWcwGMkismj4qv5EHvnxA@mail.gmail.com>
         <3ffe616d8c3fb54833bfc4d86cb73427cf6c7add.camel@perches.com>
         <202101071310.3AC5F0C4@keescook>
 <9e111f0f673ae6ced12efc01d32eefe8402c7f72.camel@perches.com>
In-Reply-To: <9e111f0f673ae6ced12efc01d32eefe8402c7f72.camel@perches.com>
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
> Sent: 08 January 2021 00:52
...
> > The original goal was to use another helper that worked on static
> > strings like this. Linus rejected that idea, so we're in a weird place.
> > I think we could perhaps build a strcpy() replacement that requires
> > compile-time validated arguments, and to break the build if not.
> >
> > i.e.
> >
> > given:
> > 	char array[8];
> > 	char *ptr;
> >
> > allow:
> >
> >
> > 	strcpy(array, "1234567");
> >
> > disallow:
> >
> > 	strcpy(array, "12345678");	/* too long */
> > 	strcpy(array, src);		/* not optimized, so use strscpy? */
> > 	strcpy(ptr, "1234567");		/* unknown destination size */
> > 	strcpy(ptr, src);		/* unknown destination size */
> 
> I think that's not a good idea as it's not a generic equivalent of the
> string.h code.
> 
> I still like the stracpy variant I proposed:
> 
> https://lore.kernel.org/lkml/24bb53c57767c1c2a8f266c305a670f7@sk2.org/T/#m0627aa770a076af1937cb5c610ed
> 71dab3f1da72
> https://lore.kernel.org/lkml/CAHk-=wgqQKoAnhmhGE-2PBFt7oQs9LLAATKbYa573UO=DPBE0Q@mail.gmail.com/
> 
> Linus liked a variant he called copy_string:
> 
> https://lore.kernel.org/lkml/CAHk-=wg8vLmmwTGhXM51NpSWJW8RFEAKoXxG0Hu_Q9Uwbjj8kw@mail.gmail.com/
> 
> I think the cocci scripts that convert:
> 
> 	strlcpy -> strscpy (only when return value unused)
> 	str<sln>cpy(array, "string") -> stracpy(foo, "string")
> 	s[cn]printf -> sysfs_emit
> 
> would leave relatively few uses of strcpy and sprintf variants and would
> make it much easier to analyze the remainder uses for potential overflows.

The advantage of allowing strcpy() but only when the when it can be
converted into a non-overflowing memcpy() is that you know that the
copies never get truncated.

The next round of string copy errors could easily by the 'silent truncation'
ones - so using such a strcpy() will cut down the next audit.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

