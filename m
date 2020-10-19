Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E72C292366
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 10:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbgJSIJZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Oct 2020 04:09:25 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:54720 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728645AbgJSIJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 04:09:24 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-172-DH4pvv-uOUyEe9KpmauANQ-1; Mon, 19 Oct 2020 09:09:19 +0100
X-MC-Unique: DH4pvv-uOUyEe9KpmauANQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 19 Oct 2020 09:09:19 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 19 Oct 2020 09:09:19 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Joe Perches' <joe@perches.com>,
        Colin King <colin.king@canonical.com>,
        =?iso-8859-1?Q?J=E9r=F4me_Pouiller?= <jerome.pouiller@silabs.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] staging: wfx: make a const array static, makes object
 smaller
Thread-Topic: [PATCH] staging: wfx: make a const array static, makes object
 smaller
Thread-Index: AQHWpEyScXzNIHcPFUeKDbuJ6I0Y36melJgA
Date:   Mon, 19 Oct 2020 08:09:19 +0000
Message-ID: <048fded745634e369fa2646f87a05ec4@AcuMS.aculab.com>
References: <20201016223303.687278-1-colin.king@canonical.com>
 <09cd7e609324d460afdf14829baf3c2f1a9cb9cd.camel@perches.com>
In-Reply-To: <09cd7e609324d460afdf14829baf3c2f1a9cb9cd.camel@perches.com>
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
> Sent: 17 October 2020 01:12
> 
> On Fri, 2020-10-16 at 23:33 +0100, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > Don't populate const array filter_ies on the stack but instead
> > make it static. Makes the object code smaller by 261 bytes.
> >
> > Before:
> >    text	   data	    bss	    dec	    hex	filename
> >   21674	   3166	    448	  25288	   62c8	drivers/staging/wfx/sta.o
> >
> > After:
> >    text	   data	    bss	    dec	    hex	filename
> >   21349	   3230	    448	  25027	   61c3	drivers/staging/wfx/sta.o
> 
> Thanks.
> 
> It's odd to me it's so large a change as it's only
> 24 bytes of initialization. (3 entries, each 8 bytes)

Perhaps the 'stack protector' crap?

Interestingly, loading the data from the 'readonly' section
is probably a data cache miss.
Which might end up being slower than the extra code to
update the on-stack data.
The extra code might get prefetched...

	David
 

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

