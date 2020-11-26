Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23EA2C58FB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 17:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391331AbgKZQD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 11:03:56 -0500
Received: from foss.arm.com ([217.140.110.172]:38108 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391161AbgKZQD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 11:03:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DFA631B;
        Thu, 26 Nov 2020 08:03:55 -0800 (PST)
Received: from [10.57.59.159] (unknown [10.57.59.159])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67D063F23F;
        Thu, 26 Nov 2020 08:03:50 -0800 (PST)
Subject: Re: [PATCH v4 09/24] iommu/io-pgtable-arm-v7s: Clear LVL_SHIFT/BITS
 macro instead of the formula
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>
Cc:     youlin.pei@mediatek.com, devicetree@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        srv_heupstream@mediatek.com, chao.hao@mediatek.com,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzk@kernel.org>, anan.sun@mediatek.com,
        Greg Kroah-Hartman <gregkh@google.com>,
        linux-arm-kernel@lists.infradead.org
References: <20201111123838.15682-1-yong.wu@mediatek.com>
 <20201111123838.15682-10-yong.wu@mediatek.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <13599074-25d5-721f-ea7b-1ea6badfd14f@arm.com>
Date:   Thu, 26 Nov 2020 16:03:49 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201111123838.15682-10-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-11 12:38, Yong Wu wrote:
> The current _ARM_V7S_LVL_BITS/ARM_V7S_LVL_SHIFT use a formula to calculate
> the corresponding value for level1 and level2 to pretend the code sane.
> Actually their level1 and level2 values are different from each other.
> This patch only clear the two macro. No functional change.

Grammar nit: to "clear" the macro sounds like you're making it empty or 
removing it entirely; I think you mean to say "clarify" here. English is 
the worst language sometimes... :)

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/io-pgtable-arm-v7s.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index 4d0aa079470f..58cc201c10a3 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -44,13 +44,11 @@
>   
>   /*
>    * We have 32 bits total; 12 bits resolved at level 1, 8 bits at level 2,
> - * and 12 bits in a page. With some carefully-chosen coefficients we can
> - * hide the ugly inconsistencies behind these macros and at least let the
> - * rest of the code pretend to be somewhat sane.
> + * and 12 bits in a page.
>    */
>   #define ARM_V7S_ADDR_BITS		32
> -#define _ARM_V7S_LVL_BITS(lvl)		(16 - (lvl) * 4)
> -#define ARM_V7S_LVL_SHIFT(lvl)		(ARM_V7S_ADDR_BITS - (4 + 8 * (lvl)))
> +#define _ARM_V7S_LVL_BITS(lvl)		((lvl) == 1 ? 12 : 8)
> +#define ARM_V7S_LVL_SHIFT(lvl)		((lvl) == 1 ? 20 : 12)
>   #define ARM_V7S_TABLE_SHIFT		10
>   
>   #define ARM_V7S_PTES_PER_LVL(lvl)	(1 << _ARM_V7S_LVL_BITS(lvl))
> 
