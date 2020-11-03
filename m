Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC4B2A436C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 11:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgKCKyH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Nov 2020 05:54:07 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:24190 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726312AbgKCKyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 05:54:07 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-127-6Ph0iE8gN0mg7iPU1iOo-A-1; Tue, 03 Nov 2020 10:54:03 +0000
X-MC-Unique: 6Ph0iE8gN0mg7iPU1iOo-A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 3 Nov 2020 10:54:02 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 3 Nov 2020 10:54:02 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Tong Zhang' <ztong0001@gmail.com>, Anders Larsen <al@alarsen.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] qnx4: qnx4_block_map error handling
Thread-Topic: [PATCH v3] qnx4: qnx4_block_map error handling
Thread-Index: AQHWsW4xl10PEzYX6kyh1cQHa4gGXqm2Oy4Q
Date:   Tue, 3 Nov 2020 10:54:02 +0000
Message-ID: <7d978bf40c5845e8b89a740250ba958a@AcuMS.aculab.com>
References: <e457351a04e04aa084902fd5138d4cae@AcuMS.aculab.com>
 <20201102231420.1833852-1-ztong0001@gmail.com>
In-Reply-To: <20201102231420.1833852-1-ztong0001@gmail.com>
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

From: Tong Zhang
> Sent: 02 November 2020 23:14
> 
> qnx4_block_map() may return -EIO on funny qnx4 fs image, in this case do
> not interpret -EIO as a correct block number

That commit message is now wrong.

Also 'blknum' is only 'unsigned long' so ~0ull is wrong.
It can be worth injecting an error and checking the error
propagation works.

What is the actual maximum file size?
Is there actually an 'out of range' blknum value
that can be used to signify an error without
changing the return value to 'long long'.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

