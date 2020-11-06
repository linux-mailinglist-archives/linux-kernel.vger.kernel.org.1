Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEFF2A9896
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 16:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgKFPdn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 6 Nov 2020 10:33:43 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:40631 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726422AbgKFPdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 10:33:42 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-250-Vzs4s3hLMkCqHiQhNxD6Og-1; Fri, 06 Nov 2020 15:33:36 +0000
X-MC-Unique: Vzs4s3hLMkCqHiQhNxD6Og-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 6 Nov 2020 15:33:36 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 6 Nov 2020 15:33:36 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [PATCH v1 1/3] vt: keyboard, use GENMAASK()/BIT() macros instead
 of open coded variants
Thread-Topic: [PATCH v1 1/3] vt: keyboard, use GENMAASK()/BIT() macros instead
 of open coded variants
Thread-Index: AQHWtEop3jxJkxOklE2QZhVf8THkOKm7O4Lg
Date:   Fri, 6 Nov 2020 15:33:36 +0000
Message-ID: <e461a47754974c0d8d0b61981b77ae80@AcuMS.aculab.com>
References: <20201106143551.43908-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20201106143551.43908-1-andriy.shevchenko@linux.intel.com>
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

From: Andy Shevchenko
> Sent: 06 November 2020 14:36
> 
> There are few places when GENMASK() or BIT() macro is suitable and makes code
> easier to understand.
> 
...
> -	if ((d & ~0xff) == BRL_UC_ROW) {
> -		if ((ch & ~0xff) == BRL_UC_ROW)
> +	if ((d & ~GENMASK(7, 0)) == BRL_UC_ROW) {
> +		if ((ch & ~GENMASK(7, 0)) == BRL_UC_ROW)
>  			return d | ch;

Do you really think that makes it more readable?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

