Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B792944A0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 23:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438728AbgJTVgF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Oct 2020 17:36:05 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:26921 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2438721AbgJTVgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 17:36:05 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-157-HDk49QzJPzOC6GM_K5-_uA-1; Tue, 20 Oct 2020 22:36:01 +0100
X-MC-Unique: HDk49QzJPzOC6GM_K5-_uA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 20 Oct 2020 22:36:00 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 20 Oct 2020 22:36:00 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arvind Sankar' <nivedita@alum.mit.edu>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 6/6] crypto: lib/sha - Combine round constants and
 message schedule
Thread-Topic: [PATCH v2 6/6] crypto: lib/sha - Combine round constants and
 message schedule
Thread-Index: AQHWpyE0sF/IXICPKESRSNEpjVVK3amhAtQw
Date:   Tue, 20 Oct 2020 21:36:00 +0000
Message-ID: <d8c1750ffcef4236904919321b872cd2@AcuMS.aculab.com>
References: <20201020203957.3512851-1-nivedita@alum.mit.edu>
 <20201020203957.3512851-7-nivedita@alum.mit.edu>
In-Reply-To: <20201020203957.3512851-7-nivedita@alum.mit.edu>
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
> Sent: 20 October 2020 21:40
> 
> Putting the round constants and the message schedule arrays together in
> one structure saves one register, which can be a significant benefit on
> register-constrained architectures. On x86-32 (tested on Broadwell
> Xeon), this gives a 10% performance benefit.

I'm actually stunned it makes that much difference.
The object code must be truly horrid (before and after).

There are probably other strange tweaks that give a similar
improvement.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

