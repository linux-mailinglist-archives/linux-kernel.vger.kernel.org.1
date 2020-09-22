Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A0C274398
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 15:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgIVN4v convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Sep 2020 09:56:51 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:60787 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726621AbgIVN4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:56:51 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-191-B9hMLBLvPqyihacVwf7g7g-1; Tue, 22 Sep 2020 14:56:46 +0100
X-MC-Unique: B9hMLBLvPqyihacVwf7g7g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 22 Sep 2020 14:56:46 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 22 Sep 2020 14:56:46 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christoph Hellwig' <hch@lst.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC:     Dominik Brodowski <linux@dominikbrodowski.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] dma-mapping: better document dma_addr_t and
 DMA_MAPPING_ERROR
Thread-Topic: [PATCH 3/3] dma-mapping: better document dma_addr_t and
 DMA_MAPPING_ERROR
Thread-Index: AQHWkOXa3XgKgm/pWkOhIuRYbHODmKl0rUBw
Date:   Tue, 22 Sep 2020 13:56:46 +0000
Message-ID: <f9c37e5ff1cb4a02bff6d2a8d0ea2dcc@AcuMS.aculab.com>
References: <20200922134002.1227279-1-hch@lst.de>
 <20200922134002.1227279-4-hch@lst.de>
In-Reply-To: <20200922134002.1227279-4-hch@lst.de>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig
> Sent: 22 September 2020 14:40
...
> @@ -131,6 +125,16 @@ struct dma_map_ops {
>  	unsigned long (*get_merge_boundary)(struct device *dev);
>  };
> 
> +/*
> + * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
> + * be given to a device to use as a DMA source or target.  A CPU cannot
> + * reference a dma_addr_t directly because there may be translation between its
> + * physical address space and the bus address space.

It can't access it 'directly' because it isn't a virtual address....

> + *
> + * DMA_MAPPING_ERROR is the magic error code if a mapping failed.  It should not
> + * be used directly in drivers, but checked for using dma_mapping_error()
> + * instead.
> + */

I think it might be worth adding:

A dma_addr_t value may be device dependant and differ from the
'physical address' of the memory.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

