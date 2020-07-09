Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19838219C97
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 11:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgGIJtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 05:49:33 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:16188 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgGIJtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 05:49:33 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f06e8200000>; Thu, 09 Jul 2020 02:49:20 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 09 Jul 2020 02:49:32 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 09 Jul 2020 02:49:32 -0700
Received: from [10.26.72.135] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 9 Jul
 2020 09:49:30 +0000
Subject: Re: [PATCH v3] clk: tegra: pll: Improve PLLM enable-state detection
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     <linux-tegra@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200708075418.25295-1-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <3755bfe4-c7db-f9ac-0a02-b59b5dee401d@nvidia.com>
Date:   Thu, 9 Jul 2020 10:49:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200708075418.25295-1-digetx@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594288160; bh=tmtFSUeFXbZkZQpgqygvIy6GSaWbp3tP/Ykpb8Da64M=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=lvTUOLKoJtmttcYLgZh9E5ayJSAjhyJtJcZjoaXzkXSrEeU5rK61zjrE1Cz1GJdan
         SCO9FJutmb2Jymmh+dm7ThWOzMr5vmJl6QiobNxhZbfjwXE4hIr02Ltd2R3tLMWwF8
         1oe/DS5U9VSqftfKBAeOOg7UFS2E1wIfdbAE5Ts9zUJZq6nqK5EDmVdq5xKEVbE0Y9
         PLTnuPBs/4kDABFIqDMRzFUF3uFGaISHaU6iOZmzOLjeWaREOg6hIPn8DshNapO1SR
         V77kXSyY0IEWRT9NCLuOBUNpK8BqvmtzmDEpkeQnTCnKMxsdjSsKaLlJYUbSmhOXpe
         Z6Yo/r+nHaSBA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08/07/2020 08:54, Dmitry Osipenko wrote:
> Power Management Controller (PMC) can override the PLLM clock settings,
> including the enable-state. Although PMC could only act as a second level
> gate, meaning that PLLM needs to be enabled by the Clock and Reset
> Controller (CaR) anyways if we want it to be enabled. Hence, when PLLM is
> overridden by PMC, it needs to be enabled by CaR and ungated by PMC in
> order to be functional. Please note that this patch doesn't fix any known
> problem, and thus, it's merely a minor improvement.
> 
> Link: https://lore.kernel.org/linux-arm-kernel/20191210120909.GA2703785@ulmo/T/
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
> 
> Changelog:
> 
> v3: - Dropped unintended code change that was accidentally added to v2.
> 
> v2: - Added clarifying comment to the code.
> 
>     - Prettified the code.
> 
>  drivers/clk/tegra/clk-pll.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
> index b2d39a66f0fa..37cfcd6836c9 100644
> --- a/drivers/clk/tegra/clk-pll.c
> +++ b/drivers/clk/tegra/clk-pll.c
> @@ -327,16 +327,26 @@ int tegra_pll_wait_for_lock(struct tegra_clk_pll *pll)
>  	return clk_pll_wait_for_lock(pll);
>  }
>  
> +static bool pllm_pmc_clk_enabled(struct tegra_clk_pll *pll)
> +{
> +	u32 val = readl_relaxed(pll->pmc + PMC_PLLP_WB0_OVERRIDE);
> +
> +	return !(val & PMC_PLLP_WB0_OVERRIDE_PLLM_OVERRIDE) ||
> +		(val & PMC_PLLP_WB0_OVERRIDE_PLLM_ENABLE);
> +}
> +


I am not sure that the name of the above function really reflects what
it is doing. If it was enabled, isn't it the AND of these bits?

Futhermore, what we really want to know is if the override is enabled,
but the PMC PLLM enable is not set. In other words, the PMC is gating
the clock. So maybe we should have a function that is called something
like pllm_clk_is_gated_by_pmc().

Jon

-- 
nvpublic
