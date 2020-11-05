Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB312A7A89
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 10:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgKEJ3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 04:29:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:59238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731654AbgKEJ3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 04:29:40 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FAAB20825;
        Thu,  5 Nov 2020 09:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604568579;
        bh=TUGk2/yx/3QWoCoFptKBQDs4MyzRTMeZYT+Q/mocS+Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vN/XkCg21EPmXipPn/2r8wxhwR6H07VQh3i2cCi7+t7zOjadC67W/b/zkRSZlsrAm
         UgHjw9r29HDCjQCjNPtesfmGn9balaAwFbW0eBsIZbmwTCXXLfhu2UYu13aXTOrrBk
         DLSrJMUqO26NDQbPHjL47LBOqZywYkYSa8ZVQJN0=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kabaL-007msQ-D9; Thu, 05 Nov 2020 09:29:37 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 05 Nov 2020 09:29:37 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Steven Price <steven.price@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Andrew Scull <ascull@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: cpu_errata: Apply Erratum 845719 to KRYO2XX
 Silver
In-Reply-To: <20201104232218.198800-5-konrad.dybcio@somainline.org>
References: <20201104232218.198800-1-konrad.dybcio@somainline.org>
 <20201104232218.198800-5-konrad.dybcio@somainline.org>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <3faa81d537320dfb20bb3f882cfaea1b@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: konrad.dybcio@somainline.org, phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org, angelogioacchino.delregno@somainline.org, marijn.suijten@somainline.org, catalin.marinas@arm.com, will@kernel.org, saiprakash.ranjan@codeaurora.org, swboyd@chromium.org, robh@kernel.org, suzuki.poulose@arm.com, steven.price@arm.com, broonie@kernel.org, ascull@google.com, anshuman.khandual@arm.com, amit.kachhap@arm.com, ionela.voinescu@arm.com, kristina.martsenko@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-04 23:22, Konrad Dybcio wrote:
> QCOM KRYO2XX Silver cores are Cortex-A53 based and are
> susceptible to the 845719 erratum. Add them to the lookup
> list to apply the erratum.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  arch/arm64/kernel/cpu_errata.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/kernel/cpu_errata.c 
> b/arch/arm64/kernel/cpu_errata.c
> index 61314fd70f13..cafaf0da05b7 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -299,6 +299,8 @@ static const struct midr_range 
> erratum_845719_list[] = {
>  	MIDR_REV_RANGE(MIDR_CORTEX_A53, 0, 0, 4),
>  	/* Brahma-B53 r0p[0] */
>  	MIDR_REV(MIDR_BRAHMA_B53, 0, 0),
> +	/* Kryo2XX Silver rAp4 */
> +	MIDR_REV(MIDR_QCOM_KRYO_2XX_SILVER, 0xa, 0x4),

Is this the only affected version? If this is actually an A53, how do 
the
revisions map between Kryo and Cortex cores?

         M.
-- 
Jazz is not dead. It just smells funny...
