Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9DEF2D9759
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 12:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407371AbgLNL2B convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Dec 2020 06:28:01 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:26169 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728291AbgLNL2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 06:28:00 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-188-DWJ8HiZYMiWHqblbGK4I2A-1; Mon, 14 Dec 2020 11:26:21 +0000
X-MC-Unique: DWJ8HiZYMiWHqblbGK4I2A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 14 Dec 2020 11:26:22 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 14 Dec 2020 11:26:22 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Pawel Laszczak' <pawell@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>
CC:     "rogerq@ti.com" <rogerq@ti.com>,
        "a-govindraju@ti.com" <a-govindraju@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kurahul@cadence.com" <kurahul@cadence.com>
Subject: RE: [PATCH] usb: cdns3: Fixes for sparse warnings
Thread-Topic: [PATCH] usb: cdns3: Fixes for sparse warnings
Thread-Index: AQHW0glE/oEkG/UXeU6lduWcFnIHxKn2cwTQ
Date:   Mon, 14 Dec 2020 11:26:22 +0000
Message-ID: <d232a54761a7473692976188aba0a5f6@AcuMS.aculab.com>
References: <20201214110433.19461-1-pawell@cadence.com>
In-Reply-To: <20201214110433.19461-1-pawell@cadence.com>
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

From: Pawel Laszczak
> Sent: 14 December 2020 11:05
> 
> Patch fixes the following warnings:
...
> cdns3-ep0.c:367: sparse: warning: restricted __le16 degrades to integer
...
> diff --git a/drivers/usb/cdns3/cdns3-ep0.c b/drivers/usb/cdns3/cdns3-ep0.c
> index b0390fe9a396..9a17802275d5 100644
> --- a/drivers/usb/cdns3/cdns3-ep0.c
> +++ b/drivers/usb/cdns3/cdns3-ep0.c
> @@ -364,7 +364,7 @@ static int cdns3_ep0_feature_handle_endpoint(struct cdns3_device *priv_dev,
>  	if (le16_to_cpu(ctrl->wValue) != USB_ENDPOINT_HALT)
>  		return -EINVAL;
> 
> -	if (!(ctrl->wIndex & ~USB_DIR_IN))
> +	if (!(le16_to_cpu(ctrl->wIndex) & ~USB_DIR_IN))
>  		return 0;

It's generally best to byteswap the constant.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

