Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80B628EEC7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 10:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388411AbgJOIuM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 15 Oct 2020 04:50:12 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:48295 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388282AbgJOIuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 04:50:11 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-86-52EWdwKJNMakoJzTZQ3pHg-1; Thu, 15 Oct 2020 09:50:06 +0100
X-MC-Unique: 52EWdwKJNMakoJzTZQ3pHg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 15 Oct 2020 09:50:06 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 15 Oct 2020 09:50:06 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arvind Sankar' <nivedita@alum.mit.edu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] compiler.h: Fix barrier_data() on clang
Thread-Topic: [PATCH] compiler.h: Fix barrier_data() on clang
Thread-Index: AQHWonC0tkOz0iWHskSkJuRX+uCeV6mYVxvw
Date:   Thu, 15 Oct 2020 08:50:05 +0000
Message-ID: <1653ace9164c4a3a8be50b3d2c9ff816@AcuMS.aculab.com>
References: <20201014212631.207844-1-nivedita@alum.mit.edu>
In-Reply-To: <20201014212631.207844-1-nivedita@alum.mit.edu>
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

From: Arvind Sankar
> Sent: 14 October 2020 22:27
...
> +/*
> + * This version is i.e. to prevent dead stores elimination on @ptr
> + * where gcc and llvm may behave differently when otherwise using
> + * normal barrier(): while gcc behavior gets along with a normal
> + * barrier(), llvm needs an explicit input variable to be assumed
> + * clobbered. The issue is as follows: while the inline asm might
> + * access any memory it wants, the compiler could have fit all of
> + * @ptr into memory registers instead, and since @ptr never escaped
> + * from that, it proved that the inline asm wasn't touching any of
> + * it. This version works well with both compilers, i.e. we're telling
> + * the compiler that the inline asm absolutely may see the contents
> + * of @ptr. See also: https://llvm.org/bugs/show_bug.cgi?id=15495
> + */
> +# define barrier_data(ptr) __asm__ __volatile__("": :"r"(ptr) :"memory")

That comment doesn't actually match the asm statement.
Although the asm statement probably has the desired effect.

The "r"(ptr) constraint only passes the address of the buffer
into the asm - it doesn't say anything at all about the associated
memory.

What the "r"(ptr) actually does is to force the address of the
associated data to be taken.
This means that on-stack space must actually be allocated.
The "memory" clobber will then force the registers caching
the variable be written out to stack.

If you only want to force stores on a single data structure
you actually want:
#define barrier_data(ptr) asm volatile("" :: "m"(*ptr))
although it would be best then to add an explicit size
and associated cast.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

