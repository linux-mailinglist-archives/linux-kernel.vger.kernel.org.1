Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBD12D7361
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 11:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405795AbgLKKGQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 11 Dec 2020 05:06:16 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:20158 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405764AbgLKKF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 05:05:28 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-249-bCdh2ug7OF-rDdSrCZLxFQ-1; Fri, 11 Dec 2020 10:03:48 +0000
X-MC-Unique: bCdh2ug7OF-rDdSrCZLxFQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 11 Dec 2020 10:03:47 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 11 Dec 2020 10:03:47 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Ioana Ciornei' <ioana.ciornei@nxp.com>
CC:     'Daniel Thompson' <daniel.thompson@linaro.org>,
        "linux-netdev@vger.kernel.org" <linux-netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RESEND net-next 1/2] dpaa2-eth: send a scatter-gather FD
 instead of realloc-ing
Thread-Topic: [PATCH RESEND net-next 1/2] dpaa2-eth: send a scatter-gather FD
 instead of realloc-ing
Thread-Index: AQHWzxqS1niBehB/rU2uwbP/Q9O4LKnxoRyAgAADk4CAAATMgA==
Date:   Fri, 11 Dec 2020 10:03:47 +0000
Message-ID: <cc8ec04373a14e8880a6ca35da5c151d@AcuMS.aculab.com>
References: <20200629184712.12449-2-ioana.ciornei () nxp ! com>
 <20201210173156.mbizovo6rxvkda73@holly.lan>
 <c4e033fe17674685b64a60055c68704e@AcuMS.aculab.com>
 <20201211093856.gj3do6ntnmxsqtzp@skbuf>
In-Reply-To: <20201211093856.gj3do6ntnmxsqtzp@skbuf>
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

From: Ioana Ciornei
> Sent: 11 December 2020 09:39
> 
> On Fri, Dec 11, 2020 at 09:30:43AM +0000, David Laight wrote:
> > From: Daniel Thompson
> > > Sent: 10 December 2020 17:32
> > >
> > > On Mon, Jun 29, 2020 at 06:47:11PM +0000, Ioana Ciornei wrote:
> > > > Instead of realloc-ing the skb on the Tx path when the provided headroom
> > > > is smaller than the HW requirements, create a Scatter/Gather frame
> > > > descriptor with only one entry.
> >
> > Is it worth simplifying the code by permanently allocating (and dma-mapping)
> > the extra structure for every ring entry.
> > It is (probably) only one page and 1 iommu entry.
> 
> 
> That is exactly what I was thinking. At the moment the SGT structure is
> pre-allocated but not pre-mapped.
> 
> I'll let you know how it goes.

How much does the dma-map actually cost?
For short fragments it is probably worth copying into a pre-allocated
pre-mapped transmit buffer area.
You'd want to do aligned full-word copies and use separate cache lines
for each frame.
It does make tx setup more error prone - since you need the space in
the tx buffer area as well as in the tx ring.

For one OS (not sun's) on a sparc mbus+sbus system one of my colleagues
measured a cutoff point of about 1k.

The copy to tx buffer path also helps with the pathological skb that
are 1500 bytes in 1 byte fragments.
(Maybe skb can't get that bad, but I've seen that on other OS.)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

