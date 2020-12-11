Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949DD2D72DD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 10:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404475AbgLKJcr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 11 Dec 2020 04:32:47 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:44652 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390353AbgLKJcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 04:32:24 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-127-Tiqc07O5MYOoTGGjLY2vfA-1; Fri, 11 Dec 2020 09:30:44 +0000
X-MC-Unique: Tiqc07O5MYOoTGGjLY2vfA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 11 Dec 2020 09:30:43 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 11 Dec 2020 09:30:43 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Daniel Thompson' <daniel.thompson@linaro.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
CC:     "linux-netdev@vger.kernel.org" <linux-netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RESEND net-next 1/2] dpaa2-eth: send a scatter-gather FD
 instead of realloc-ing
Thread-Topic: [PATCH RESEND net-next 1/2] dpaa2-eth: send a scatter-gather FD
 instead of realloc-ing
Thread-Index: AQHWzxqS1niBehB/rU2uwbP/Q9O4LKnxoRyA
Date:   Fri, 11 Dec 2020 09:30:43 +0000
Message-ID: <c4e033fe17674685b64a60055c68704e@AcuMS.aculab.com>
References: <20200629184712.12449-2-ioana.ciornei () nxp ! com>
 <20201210173156.mbizovo6rxvkda73@holly.lan>
In-Reply-To: <20201210173156.mbizovo6rxvkda73@holly.lan>
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

From: Daniel Thompson
> Sent: 10 December 2020 17:32
> 
> On Mon, Jun 29, 2020 at 06:47:11PM +0000, Ioana Ciornei wrote:
> > Instead of realloc-ing the skb on the Tx path when the provided headroom
> > is smaller than the HW requirements, create a Scatter/Gather frame
> > descriptor with only one entry.

Is it worth simplifying the code by permanently allocating (and dma-mapping)
the extra structure for every ring entry.
It is (probably) only one page and 1 iommu entry.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

