Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565D92D0F07
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 12:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgLGLaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 06:30:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:53166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbgLGLa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:30:29 -0500
Date:   Mon, 7 Dec 2020 11:29:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607340588;
        bh=PevOltpfSoa2VOQzzFcjWvvt+OU00vpXvLK5/D5qUXs=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=AUlQ9xfaq8dqQacDDAfA5Uncdfa9Y/1YFXLxQOPDFvSbZFX9TYSD2L2X9hVQRznoc
         WrRiS/8fM+PI2qboUZ0dwY88Lhl55Skm+GRDg0J9D0ydxQQisAApZPp0Y0l96gXQ3R
         ayrNFU+nY8ztzdSjEz1ApPGkb+e1F3jyRnfk0b9dD6NWb4+k1jRewsO/gtXQou2MqL
         Sp4EMQH/mXCnnNjFg25z7RV7DfLfCIyefjNGXzYp+dbZv8T1B8uS84D3rWFaijwbp/
         Q4LohxUXYQj7pEEyOxZVtIswB8p3pU41/HlQ19FzTIFAhAZo285PXqh5A0bjpiVrw6
         IYvTNP0Rhmfbw==
From:   Will Deacon <will@kernel.org>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     robin.murphy@arm.com, joro@8bytes.org, jean-philippe@linaro.org,
        Jonathan.Cameron@huawei.com, song.bao.hua@hisilicon.com,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix not checking return value about
 devm_add_action
Message-ID: <20201207112943.GC4379@willie-the-truck>
References: <1607340209-51539-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607340209-51539-1-git-send-email-tiantao6@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 07:23:29PM +0800, Tian Tao wrote:
> Use devm_add_action_or_reset to avoid the situation where the release
> function is not called when devm_add_action returns an error.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> 
> v2:
> check the return value about evm_add_action_or_reset()
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 2ddf5ec..76c28e7 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2680,7 +2680,8 @@ static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
>  		ret = -ENOMEM;
>  	} else {
>  		cmdq->valid_map = bitmap;
> -		devm_add_action(smmu->dev, arm_smmu_cmdq_free_bitmap, bitmap);
> +		ret = devm_add_action_or_reset(smmu->dev,
> +					       arm_smmu_cmdq_free_bitmap, bitmap);
>  	}
>  
>  	return ret;
> @@ -2938,7 +2939,7 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
>  	}
>  
>  	/* Add callback to free MSIs on teardown */
> -	devm_add_action(dev, arm_smmu_free_msis, dev);
> +	devm_add_action_or_reset(dev, arm_smmu_free_msis, dev);

Hmm, but you don't propagate the error here so couldn't this lead to a
use-after-free?

Will
