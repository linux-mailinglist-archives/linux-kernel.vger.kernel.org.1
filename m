Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7122C0377
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 11:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgKWKi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 05:38:29 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:3872 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbgKWKi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 05:38:29 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbb91270000>; Mon, 23 Nov 2020 02:38:31 -0800
Received: from [10.26.72.66] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 23 Nov
 2020 10:38:26 +0000
Subject: Re: [PATCH v5 0/6] Tegra210 audio graph card
To:     Sameer Pujar <spujar@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>
CC:     <kuninori.morimoto.gx@renesas.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sharadg@nvidia.com>
References: <1605119676-32273-1-git-send-email-spujar@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <bbf5c039-faab-618b-7b3c-8991bb75d4a0@nvidia.com>
Date:   Mon, 23 Nov 2020 10:38:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1605119676-32273-1-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606127911; bh=rja4mFvPtVCeH4UELYSy3t07Yo+UPDvUCyzzCQixKww=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=X1usOJU0UqprKtf9SA4DFxYJrh+6K9X8SYt/mat5kG4dSMka4gKP49pcyT+p8VgMd
         C+RHSlT9DCECut9i25KXabM0IxvutDNtWbugyunFjn0LqQlhgoJXa+ta3UkfzVm4XO
         XEF+/6ueRwEjEcEWdzXXOOej6W5Qgd80k5W+UWwjNrurK3OhrJJ+i87dEmtGhT7pfr
         E1wGOeL9KWUjTZkz1tKSi1j9C8Eyvq1PfaSQ83Ks9XxpXcJ52QNV0EZAf5zjx8aI5D
         ntYZjtEFwhHiXVgiCJxXImRFz5M4DgFwlR6ST45KR+i02u0QRE2bwMHBRBHVs2/CQf
         KiJk20Zt8/N0Q==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/11/2020 18:34, Sameer Pujar wrote:
> This series adds audio graph based sound card support for Tegra210
> platforms like Jetson-TX1 an Jetson-Nano. The following preparatory
> audio graph enhancement series is already merged.
>  * https://patchwork.kernel.org/project/alsa-devel/list/?series=375629&state=*
> 
> Following are the summary of changes:
>  * Add graph/audio-graph based schemas or schema updates for Tegra210
>    component and machine drivers.
>  * Add Tegra audio graph machine driver.
>  * Add required DT support for Jetson-TX1/Nano.
> 
> This work is based on earlier discussion of DPCM usage for Tegra
> and simple card driver updates.
>  * https://lkml.org/lkml/2020/4/30/519
>  * https://lkml.org/lkml/2020/6/27/4
> 
> This series has dependency over following graph and audio-graph series.
>  * http://patchwork.ozlabs.org/project/devicetree-bindings/patch/20201102203656.220187-2-robh@kernel.org/
>  * https://patchwork.kernel.org/project/alsa-devel/list/?series=382009&state=*


Only one minor comment, but this looks good to me. Otherwise for the
series ...

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
