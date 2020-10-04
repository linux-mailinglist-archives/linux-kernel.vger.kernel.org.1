Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED706282A0B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 12:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgJDKB3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 4 Oct 2020 06:01:29 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:41028 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725825AbgJDKB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 06:01:28 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-261-Ghl-Rsi1Paaf30webE8vMA-1; Sun, 04 Oct 2020 11:01:23 +0100
X-MC-Unique: Ghl-Rsi1Paaf30webE8vMA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sun, 4 Oct 2020 11:01:23 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sun, 4 Oct 2020 11:01:23 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Ross Schmidt' <ross.schm.dev@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/8] staging: rtl8723bs: replace RND4 with round_up()
Thread-Topic: [PATCH 1/8] staging: rtl8723bs: replace RND4 with round_up()
Thread-Index: AQHWmew0DoS2fLKzG0OejM3ZccTfWamHNZkg
Date:   Sun, 4 Oct 2020 10:01:23 +0000
Message-ID: <4f67bdfee5d74096b4ea0e92524e4951@AcuMS.aculab.com>
References: <20201004011743.10750-1-ross.schm.dev@gmail.com>
In-Reply-To: <20201004011743.10750-1-ross.schm.dev@gmail.com>
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

From: Ross Schmidt
> Sent: 04 October 2020 02:18
> 
> Use round_up instead of define RND4.

RND4 was also particularly horrid!
...
> diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c
> b/drivers/staging/rtl8723bs/core/rtw_security.c
> index 7f74e1d05b3a..159d32ace2bc 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_security.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_security.c
> @@ -260,7 +260,7 @@ void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
>  				arcfour_encrypt(&mycontext, payload+length, crc, 4);
> 
>  				pframe += pxmitpriv->frag_len;
> -				pframe = (u8 *)RND4((SIZE_PTR)(pframe));
> +				pframe = (u8 *)round_up((SIZE_PTR)(pframe), 4);

I also suspect this is equivalent to:
				pframe == round_up(pxmitpriv->frag_len, 4);

Does make one wonder whether the skipped bytes need to be
zeroed though.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

