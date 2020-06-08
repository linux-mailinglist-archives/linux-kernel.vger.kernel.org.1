Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3262E1F1BC3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 17:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbgFHPNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 11:13:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:40704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730137AbgFHPNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 11:13:13 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFFBE2064C;
        Mon,  8 Jun 2020 15:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591629193;
        bh=tqmNda7HBIejgaZeX5xWNh1g+XYUKXmSNmP+2Xa8+uk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RRjy7+Fp91CTEsYxYNd2ee6/qMl5ukLmjlfcRoc9tsCixzdo5D5os9ofKPeQC1D0f
         Z8aGOtvK94u6jG0qLLo/Z8XMc0KArq3nPyTp1ewvZqlcTaVvKaJnO3u/DFSfyoqnOQ
         CUe2cVWU2q/IR78hgR4FfVJQ6iiczo5GT18rtF/U=
Date:   Mon, 8 Jun 2020 16:13:08 +0100
From:   Will Deacon <will@kernel.org>
To:     Jordan Crouse <jcrouse@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/arm-smmu: Mark qcom_smmu_client_of_match as
 possibly unused
Message-ID: <20200608151308.GB8060@willie-the-truck>
References: <20200604203905.31964-1-jcrouse@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604203905.31964-1-jcrouse@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 02:39:04PM -0600, Jordan Crouse wrote:
> When CONFIG_OF=n of_match_device() gets pre-processed out of existence
> leaving qcom-smmu_client_of_match unused. Mark it as possibly unused to
> keep the compiler from warning in that case.
> 
> Fixes: 0e764a01015d ("iommu/arm-smmu: Allow client devices to select direct mapping")
> Reported-by: kbuild test robot <lkp@intel.com>
> Acked-by: Will Deacon <will@kernel.org>
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
> 
>  drivers/iommu/arm-smmu-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu-qcom.c b/drivers/iommu/arm-smmu-qcom.c
> index cf01d0215a39..be4318044f96 100644
> --- a/drivers/iommu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm-smmu-qcom.c
> @@ -12,7 +12,7 @@ struct qcom_smmu {
>  	struct arm_smmu_device smmu;
>  };
>  
> -static const struct of_device_id qcom_smmu_client_of_match[] = {
> +static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
>  	{ .compatible = "qcom,adreno" },
>  	{ .compatible = "qcom,mdp4" },
>  	{ .compatible = "qcom,mdss" },

Thanks. Joerg -- can you pick this one up, please? I don't have any other
SMMU fixes pending at the moment.

Cheers,

Will
