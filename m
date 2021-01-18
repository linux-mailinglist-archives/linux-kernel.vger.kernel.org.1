Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBE02FA5F2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 17:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406267AbhARQTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 11:19:44 -0500
Received: from foss.arm.com ([217.140.110.172]:38918 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406502AbhARQSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 11:18:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CF3C31B;
        Mon, 18 Jan 2021 08:18:07 -0800 (PST)
Received: from [10.57.39.58] (unknown [10.57.39.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E86073F68F;
        Mon, 18 Jan 2021 08:18:04 -0800 (PST)
Subject: Re: [PATCH v3 5/7] iommu: Allow io_pgtable_tlb ops optional
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com, Greg Kroah-Hartman <gregkh@google.com>,
        kernel-team@android.com
References: <20201216103607.23050-1-yong.wu@mediatek.com>
 <20201216103607.23050-6-yong.wu@mediatek.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <310cc809-ac74-7048-8718-c65c815a1faa@arm.com>
Date:   Mon, 18 Jan 2021 16:18:05 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20201216103607.23050-6-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-16 10:36, Yong Wu wrote:
> This patch allows io_pgtable_tlb ops could be null since the IOMMU drivers
> may use the tlb ops from iommu framework.

There's not much in it, but I guess this does make more sense overall 
than just making .tlb_flush_all optional and drivers having to provide a 
full set of NULL callbacks.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   include/linux/io-pgtable.h | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index adde9e49be08..c81796814afa 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -206,14 +206,16 @@ struct io_pgtable {
>   
>   static inline void io_pgtable_tlb_flush_all(struct io_pgtable *iop)
>   {
> -	iop->cfg.tlb->tlb_flush_all(iop->cookie);
> +	if (iop->cfg.tlb && iop->cfg.tlb->tlb_flush_all)
> +		iop->cfg.tlb->tlb_flush_all(iop->cookie);
>   }
>   
>   static inline void
>   io_pgtable_tlb_flush_walk(struct io_pgtable *iop, unsigned long iova,
>   			  size_t size, size_t granule)
>   {
> -	iop->cfg.tlb->tlb_flush_walk(iova, size, granule, iop->cookie);
> +	if (iop->cfg.tlb && iop->cfg.tlb->tlb_flush_walk)
> +		iop->cfg.tlb->tlb_flush_walk(iova, size, granule, iop->cookie);
>   }
>   
>   static inline void
> @@ -221,7 +223,7 @@ io_pgtable_tlb_add_page(struct io_pgtable *iop,
>   			struct iommu_iotlb_gather * gather, unsigned long iova,
>   			size_t granule)
>   {
> -	if (iop->cfg.tlb->tlb_add_page)
> +	if (iop->cfg.tlb && iop->cfg.tlb->tlb_add_page)
>   		iop->cfg.tlb->tlb_add_page(gather, iova, granule, iop->cookie);
>   }
>   
> 
