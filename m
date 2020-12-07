Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C772D0AB9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 07:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgLGGcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 01:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgLGGcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 01:32:54 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FF7C0613D0
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 22:32:13 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id w6so8804945pfu.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 22:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gL0NtWagJ51Gx9mXLpW/I2jalcUi5rYsF2xSyQmmfcs=;
        b=RVDjlbOay78DlQc9N55FmBroQ35hl5d56zVmIYYs+Are/KKEJVAW8HG7A4z/aKmn/p
         gcR323NH2M+nMR/5sJ3popUJq9Kddc0B2pnbSlkH5PFwvsNT8Y7KeKYxlc7++Ck7WbC/
         ay0JA2usjySCSy/RirwrQmmHeZzm2Lxfuie40pLfklIgECkyHrFrf/tNHP+RJwayM99/
         +GiAJwdY1ur9QpOdBTxsY5h6V0hIaCKwuxgf1d1AToEt9yD5nI+6AVTwJvci5ttRYwvx
         w+biiu/gdtGl5E697jyHyCzqy5byTPph9SkolTL6GaSD2giHMrJ2Y+8ANRrhSxtZ/ir9
         BnUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gL0NtWagJ51Gx9mXLpW/I2jalcUi5rYsF2xSyQmmfcs=;
        b=fOeu3Pf8dcGjsSzNgaM/1DBXoig4NROptIKxfn6WRpDqt4BaeYbu/IiTosjSXmww3q
         RDe7xgmoAryX8BY0aBmwC91OMgylK+2W0GRAcBEgVRIcYsYuiRk7RjMzRvClxEma5sn0
         Lg7DG4Kwc1b7yqxYakUJ+LsKEeS5sOWAjM2Ga/cuFY83Eos83q3bBYTVYENM0o7vP3Ae
         XngqTtxg5hn5egZWYhxA4ryqp87/i/4t/z/VMgtSz8nRl1FFOI6+sTmPLaati1nhUXh7
         ukQJ4t8JBIz1/3JmMYfG9dNC0+W56fhaWC2Xj0EI7Z/HTf2cPNKVNXgdjSs7oUz3gT0g
         JVwg==
X-Gm-Message-State: AOAM533aAiWT0wet76rb/oYViyixosHmDp5lHVZdc8Ir7EdJaby2uOJi
        4tjeOk02KprOVhcxl1npHxFblQ==
X-Google-Smtp-Source: ABdhPJwhmhtGhFNg7LTSkIGaAcj2BYkARySOwHjb+NXANwDfxnxgoneEC76MeC3efb/xq12PBvFsgw==
X-Received: by 2002:a17:902:d904:b029:da:a830:11b3 with SMTP id c4-20020a170902d904b02900daa83011b3mr14645531plz.74.1607322733367;
        Sun, 06 Dec 2020 22:32:13 -0800 (PST)
Received: from localhost ([122.172.136.109])
        by smtp.gmail.com with ESMTPSA id g85sm12739373pfb.4.2020.12.06.22.32.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 22:32:12 -0800 (PST)
Date:   Mon, 7 Dec 2020 12:02:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Walter Lozano <walter.lozano@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: imx: fix NVMEM_IMX_OCOTP dependency
Message-ID: <20201207063209.ujduxednyvkymsx6@vireshk-i7>
References: <20201203225344.1477350-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203225344.1477350-1-arnd@kernel.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-12-20, 23:53, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A driver should not 'select' drivers from another subsystem.
> If NVMEM is disabled, this one results in a warning:
> 
> WARNING: unmet direct dependencies detected for NVMEM_IMX_OCOTP
>   Depends on [n]: NVMEM [=n] && (ARCH_MXC [=y] || COMPILE_TEST [=y]) && HAS_IOMEM [=y]
>   Selected by [y]:
>   - ARM_IMX6Q_CPUFREQ [=y] && CPU_FREQ [=y] && (ARM || ARM64 [=y]) && ARCH_MXC [=y] && REGULATOR_ANATOP [=y]
> 
> Change the 'select' to 'depends on' to prevent it from going wrong,
> and allow compile-testing without that driver, since it is only
> a runtime dependency.
> 
> Fixes: 2782ef34ed23 ("cpufreq: imx: Select NVMEM_IMX_OCOTP")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/cpufreq/Kconfig.arm | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 0732854d94ec..434ef03d2762 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -94,7 +94,7 @@ config ARM_IMX6Q_CPUFREQ
>  	tristate "Freescale i.MX6 cpufreq support"
>  	depends on ARCH_MXC
>  	depends on REGULATOR_ANATOP
> -	select NVMEM_IMX_OCOTP
> +	depends on NVMEM_IMX_OCOTP || COMPILE_TEST
>  	select PM_OPP
>  	help
>  	  This adds cpufreq driver support for Freescale i.MX6 series SoCs.

Applied. Thanks.

-- 
viresh
