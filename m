Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674992DBF2D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 12:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgLPLFZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Dec 2020 06:05:25 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:35988 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725768AbgLPLFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 06:05:25 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-94--UvXZFBAOeinyWm-PmDBBw-1; Wed, 16 Dec 2020 11:03:46 +0000
X-MC-Unique: -UvXZFBAOeinyWm-PmDBBw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 16 Dec 2020 11:03:46 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 16 Dec 2020 11:03:46 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Yong Wu' <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "youlin.pei@mediatek.com" <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "anan.sun@mediatek.com" <anan.sun@mediatek.com>,
        "chao.hao@mediatek.com" <chao.hao@mediatek.com>,
        Greg Kroah-Hartman <gregkh@google.com>,
        "kernel-team@android.com" <kernel-team@android.com>
Subject: RE: [PATCH v3 4/7] iommu: Switch gather->end to unsigned long long
Thread-Topic: [PATCH v3 4/7] iommu: Switch gather->end to unsigned long long
Thread-Index: AQHW05fCvUUyI8/vv0eBmqh9Irindan5jgVQ
Date:   Wed, 16 Dec 2020 11:03:46 +0000
Message-ID: <6b4a1d37a90f4663adf6b4adb9f80e2b@AcuMS.aculab.com>
References: <20201216103607.23050-1-yong.wu@mediatek.com>
 <20201216103607.23050-5-yong.wu@mediatek.com>
In-Reply-To: <20201216103607.23050-5-yong.wu@mediatek.com>
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

From: Yong Wu
> Sent: 16 December 2020 10:36
> 
> Currently gather->end is "unsigned long" which may be overflow in
> arch32 in the corner case: 0xfff00000 + 0x100000(iova + size).
> Although it doesn't affect the size(end - start), it affects the checking
> "gather->end < end"
> 
> Fixes: a7d20dc19d9e ("iommu: Introduce struct iommu_iotlb_gather for batching TLB flushes")
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  include/linux/iommu.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 794d4085edd3..6e907a95d981 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -178,7 +178,7 @@ enum iommu_dev_features {
>   */
>  struct iommu_iotlb_gather {
>  	unsigned long		start;
> -	unsigned long		end;
> +	unsigned long long	end;
>  	size_t			pgsize;
>  };

Doesn't that add two pad words on many 32bit systems?
You probably ought to re-order the structure to keep the fields
on their natural boundaries.

I'm not sure what is being mapped here, but could it make sense
to just avoid using the highest addresses?
Then you never hit the problem.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

