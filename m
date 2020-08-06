Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6BDF23E0E4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 20:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbgHFSjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 14:39:00 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:9611 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgHFSbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:31:47 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f2c4abf0001>; Thu, 06 Aug 2020 11:24:00 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 06 Aug 2020 11:24:13 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 06 Aug 2020 11:24:13 -0700
Received: from [10.26.73.183] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 6 Aug
 2020 18:24:07 +0000
Subject: Re: [PATCH v5 09/11] arm64: defconfig: Build ADMA and ACONNECT driver
To:     Sameer Pujar <spujar@nvidia.com>, <broonie@kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>,
        <kuninori.morimoto.gx@renesas.com>, <robh+dt@kernel.org>,
        <lgirdwood@gmail.com>
CC:     <thierry.reding@gmail.com>, <digetx@gmail.com>,
        <alsa-devel@alsa-project.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sharadg@nvidia.com>,
        <mkumard@nvidia.com>, <viswanathl@nvidia.com>,
        <rlokhande@nvidia.com>, <dramesh@nvidia.com>,
        <atalambedu@nvidia.com>, <nwartikar@nvidia.com>,
        <swarren@nvidia.com>, <nicoleotsuka@gmail.com>
References: <1595134890-16470-1-git-send-email-spujar@nvidia.com>
 <1595134890-16470-10-git-send-email-spujar@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <86606b00-8ec8-608e-4b94-eff3e6ad2723@nvidia.com>
Date:   Thu, 6 Aug 2020 19:24:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595134890-16470-10-git-send-email-spujar@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596738240; bh=cTftzqwrcOCcgqbdPCuAeNHtGbe/8tzV0BRaVzfY7L0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=UXnpUM3bOKlamWewcwTU7jrr8O+fpdIHdPil6rIITe74wWhK8MxNAeF6W612FQ9vu
         Rt865JY8RIwKW2kYND7ndjYPgp4o5S3Rngy6jAY+iFLxkotNI8IEu2eKOJxfsJP5LH
         hTjjrL12auCb+M6VlbOwTPaw7h8WX9gzrp/++lrfe0bcdZGH4shJ7TOm5aYm5DpK5X
         u8+MDuaR0uEcuVzGRDIgTEi1FSUQgMO3ry5ZxonAqulla0irV2tlZeG78ChNyJNyJv
         qKAIY0O1b+46+uIs4UV1Mb6o+QmR/wOF0qidaZyvmF9GIVXDYej13ZOYfv8+ChYlgs
         XaXnFdu+uADRg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19/07/2020 06:01, Sameer Pujar wrote:
> This commit builds ADMA and ACONNECT drivers which can be used on
> Tegra210 and later platforms to transfer audio data to/from AHUB
> (Audio Hub).
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  arch/arm64/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 4976e1a..7bc093a 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -219,6 +219,7 @@ CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
>  CONFIG_HISILICON_LPC=y
>  CONFIG_SIMPLE_PM_BUS=y
>  CONFIG_FSL_MC_BUS=y
> +CONFIG_TEGRA_ACONNECT=m
>  CONFIG_MTD=y
>  CONFIG_MTD_BLOCK=y
>  CONFIG_MTD_CFI=y
> @@ -788,6 +789,7 @@ CONFIG_MV_XOR_V2=y
>  CONFIG_OWL_DMA=y
>  CONFIG_PL330_DMA=y
>  CONFIG_TEGRA20_APB_DMA=y
> +CONFIG_TEGRA210_ADMA=m
>  CONFIG_QCOM_BAM_DMA=y
>  CONFIG_QCOM_HIDMA_MGMT=y
>  CONFIG_QCOM_HIDMA=y

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic
