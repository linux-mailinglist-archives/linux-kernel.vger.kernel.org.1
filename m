Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C422FB7A6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405306AbhASLNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 06:13:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:49152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405059AbhASLCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 06:02:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D5A32075F;
        Tue, 19 Jan 2021 11:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611054097;
        bh=tJqgnp4OxGV364DlbJ5Sda9VDJ/ZKg3Jw5QRNd0Sv2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RCyW40xHeAT0nw1vEgT7YIgtn6sPL5CGXrZtBn+JAkph4OKidCA1ILfYh0Qie2bPj
         zjCcOrm45mn51shGhamdF1HjC5HOP/sp6fSmDv8SkBXIwc2go2Z+lLUJRk90Ui3i+b
         yhXEd4Q0bcs3KAy/3cX0x+x/xGYcvSWkS6ZGAdJkYzrhqurE86PPMK6pvMGaZIH4/D
         LB8JVKDvWepN5MB/pHLNBQLzyBtX1ACRarLWPtjTGPXgzY2NHMocjwyW/LMX6POwbi
         HEHtDYW/Sj/4MI6PKAFNMejw+89ssRf0OlTt5rSrfI69Bx3uD2w+W1cctUyV3Fe/2A
         YkSOEvuCaCq7g==
Date:   Tue, 19 Jan 2021 11:01:31 +0000
From:   Will Deacon <will@kernel.org>
To:     Liguang Zhang <zhangliguang@linux.alibaba.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Brown <broonie@kernel.org>, gustavoars@kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/cpuinfo: Show right CPU architecture information
Message-ID: <20210119110131.GA18433@willie-the-truck>
References: <20210119105510.27836-1-zhangliguang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119105510.27836-1-zhangliguang@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 06:55:10PM +0800, Liguang Zhang wrote:
> CPU architecture is assigned to be a fixed value, it should be obtained
> from midr register.
> 
> Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
> ---
>  arch/arm64/kernel/cpuinfo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index 77605aec25fe..0bd11e0fe9f2 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -191,7 +191,7 @@ static int c_show(struct seq_file *m, void *v)
>  
>  		seq_printf(m, "CPU implementer\t: 0x%02x\n",
>  			   MIDR_IMPLEMENTOR(midr));
> -		seq_printf(m, "CPU architecture: 8\n");
> +		seq_printf(m, "CPU architecture: %d\n", MIDR_ARCHITECTURE(midr));

Huh? Won't this always return 0xf?

Will
