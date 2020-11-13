Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A24F2B19F6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 12:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgKMLVL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 13 Nov 2020 06:21:11 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:33838 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726308AbgKMLVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:21:07 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-181-W32aQzzrMh2E4GxJOW8UZA-1; Fri, 13 Nov 2020 11:20:57 +0000
X-MC-Unique: W32aQzzrMh2E4GxJOW8UZA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 13 Nov 2020 11:20:56 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 13 Nov 2020 11:20:56 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'xiakaixu1987@gmail.com'" <xiakaixu1987@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: RE: [PATCH] altera-stapl: remove the unreached switch case
Thread-Topic: [PATCH] altera-stapl: remove the unreached switch case
Thread-Index: AQHWuZ5eH6LunXbvA0egUNgeh2YMZanF6l8w
Date:   Fri, 13 Nov 2020 11:20:56 +0000
Message-ID: <0d7336acc20d4a7687bbf2a8c6de3454@AcuMS.aculab.com>
References: <1605259265-14129-1-git-send-email-kaixuxia@tencent.com>
In-Reply-To: <1605259265-14129-1-git-send-email-kaixuxia@tencent.com>
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

From: xiakaixu1987@gmail.com 
> Sent: 13 November 2020 09:21
> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> The value of the variable status must be one of the 0, -EIO and -EILSEQ, so
> the switch cases -ENODATA and default are unreached. Remove them.
> 
> Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
> ---
>  drivers/misc/altera-stapl/altera.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/misc/altera-stapl/altera.c b/drivers/misc/altera-stapl/altera.c
> index 5bdf574..8ad1e9e 100644
> --- a/drivers/misc/altera-stapl/altera.c
> +++ b/drivers/misc/altera-stapl/altera.c
> @@ -2265,19 +2265,10 @@ static int altera_check_crc(u8 *p, s32 program_size)
>  				"actual %04x\n", __func__, local_expected,
>  				local_actual);
>  			break;
> -		case -ENODATA:
> -			printk(KERN_ERR "%s: expected CRC not found, "
> -				"actual CRC = %04x\n", __func__,
> -				local_actual);
> -			break;
>  		case -EIO:
>  			printk(KERN_ERR "%s: error: format isn't "
>  				"recognized.\n", __func__);
>  			break;
> -		default:
> -			printk(KERN_ERR "%s: CRC function returned error "
> -				"code %d\n", __func__, status);
> -			break;

You ought to leave a 'default' in there.
Even if it is just the same as -EIO.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

