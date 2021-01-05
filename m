Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543F02EA853
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 11:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbhAEKNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 05:13:09 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12012 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728756AbhAEKNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 05:13:08 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ff43b8b0001>; Tue, 05 Jan 2021 02:12:27 -0800
Received: from [10.26.72.150] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 5 Jan
 2021 10:12:23 +0000
Subject: Re: [PATCH 1/2] clk: tegra30: Add hda clock default rates to clock
 driver
To:     Peter Geis <pgwipeout@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Peter De Schrijver" <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Sameer Pujar <spujar@nvidia.com>,
        Mohan Kumar <mkumard@nvidia.com>
CC:     <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        Ion Agorria <ion@agorria.com>
References: <20201225012025.507803-1-pgwipeout@gmail.com>
 <20201225012025.507803-2-pgwipeout@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <bcf7326a-37dc-afdc-82c6-58175e97f7d9@nvidia.com>
Date:   Tue, 5 Jan 2021 10:12:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201225012025.507803-2-pgwipeout@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1609841547; bh=gYOyUlnAGiNfPiqs6BiSy7QAqM9dPQZMRYM5DfEygxk=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=fK760iSgSh3XodQJ9/CrvYqzAPZk+ZI93qyb1QZrNWR1uQAPpW+LZwZhnM/AFsA3n
         FyriI80PBYkbrNSnQe9Sz85qgVfbPgmBifTD2EEXxT4577woLHSW95lgjpNaTh+OzI
         qKF+ApgxxWTiP1+2eMJquLWZHobORR6iqdQP+gN8DAy+SQtCDJhOd+TZYLAXjUxBNL
         VBYvj+AeoDXjG4ICyWjVoxJbzFstjcleCFz2v3LoKrYhlqDvjxOtXWsE/1C0Ery4Vv
         tNYaqwltuXnS7BdH0dOoms1fJdHwQWr6mMlcAJmA+YV0j1HOdfXwNBJ8gAhIm3UsPZ
         ahwBdesM3TKAw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25/12/2020 01:20, Peter Geis wrote:
> Current implementation defaults the hda clocks to clk_m.
> This causes hda to run too slow to operate correctly.
> Fix this by defaulting to pll_p and setting the frequency to the correct rate.
> 
> This matches upstream t124 and downstream t30.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> Tested-by: Ion Agorria <ion@agorria.com>
> ---
>  drivers/clk/tegra/clk-tegra30.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
> index 37244a7e68c2..9cf249c344d9 100644
> --- a/drivers/clk/tegra/clk-tegra30.c
> +++ b/drivers/clk/tegra/clk-tegra30.c
> @@ -1256,6 +1256,8 @@ static struct tegra_clk_init_table init_table[] __initdata = {
>  	{ TEGRA30_CLK_I2S3_SYNC, TEGRA30_CLK_CLK_MAX, 24000000, 0 },
>  	{ TEGRA30_CLK_I2S4_SYNC, TEGRA30_CLK_CLK_MAX, 24000000, 0 },
>  	{ TEGRA30_CLK_VIMCLK_SYNC, TEGRA30_CLK_CLK_MAX, 24000000, 0 },
> +	{ TEGRA30_CLK_HDA, TEGRA30_CLK_PLL_P, 102000000, 0 },
> +	{ TEGRA30_CLK_HDA2CODEC_2X, TEGRA30_CLK_PLL_P, 48000000, 0 },
>  	/* must be the last entry */
>  	{ TEGRA30_CLK_CLK_MAX, TEGRA30_CLK_CLK_MAX, 0, 0 },
>  };


This looks good to me. So ...

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
