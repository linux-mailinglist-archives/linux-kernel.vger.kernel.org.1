Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3F32C2AD7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 16:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389566AbgKXPGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 10:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389339AbgKXPGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 10:06:35 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14353C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 07:06:34 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id 92so16545091otd.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 07:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M1JIh9Gvo+fVeTXrdxTsWH/t0Vo2H6hJ0sjI+YjVK2Y=;
        b=Ugg/FqWrlzR1e5TdZeLJmsbexWvbLVVy23q00IwmNjzmrnNQeg0ucP8qcuv8lr92Ng
         TrtV2KuEz/Kwj5njm23Ly/yw+h/gbgcACmnmHYHq6KQY879rJH9RgXY/ck6jT7B32Cu5
         E9PZStZLp412Y88kd6u0CH+J6SGwY1dUBGCibuV1sC/sBCTvDy5OI3rKbxxTpQcYBsQt
         ydXqanHuLunbmKNlChCEJilDjbStk7arzsdHBgg5+sq04Pr0kOjI4FxCcVUDaAXgAHfH
         1RF7FklAuFnylDYA2BlNBemqD/BrdAr/7DNX4UEEjVGhPKKnNNDdoT+oVP8Zqz/7vusJ
         JWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M1JIh9Gvo+fVeTXrdxTsWH/t0Vo2H6hJ0sjI+YjVK2Y=;
        b=bXh47etHy8VfTMCysxXXlb4UgWlZbqoYU8l4QdlNU1snXVpy0RLYxRdCBebeVfoY4Y
         cRUDhHPKj1w0/ThFPrwFIqrXFI9eneq8z10Dsrv0mtfBMdUzXs6kiZ6vB1D355qpkBMd
         7nmFtIUfPmyxjQQDgFLptpFDRs3yFojqpnfFOOUCz8rMPPkXN7b/3wM6/hUpOUjXJ6u5
         yqIxa6LVmaaow6MeRd1gjYQHUsZ13m/hd05du78FBkAbNryLgT4i7r00Y0NP2dnJ8XiC
         OGw2a+PQzMIBMOPoccwMTdr4WoVRTGhqWSocEIERSnCv8xuSp6StOT2iNstq8xl9FEuD
         kD6Q==
X-Gm-Message-State: AOAM533ABK0Vl3/Oxjw0NLHnaBsFg7diZ/fhtdVD2vp+op/IVbw3S0Cg
        6VwbDwNFUaI/UETg+Ajch1rtnw==
X-Google-Smtp-Source: ABdhPJyyH3zdGmckUNlYogT9rzP4dT6TW87eVwpuDgu+JLX6RMweOa/pRusXoD79T0i3fgd680etlg==
X-Received: by 2002:a9d:3e1b:: with SMTP id a27mr3559963otd.291.1606230393458;
        Tue, 24 Nov 2020 07:06:33 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id m2sm8791896ots.11.2020.11.24.07.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 07:06:32 -0800 (PST)
Date:   Tue, 24 Nov 2020 09:06:31 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-pm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH v2] cpuidle: arm: qcom: fix Kconfig problems
Message-ID: <20201124150631.GL95182@builder.lan>
References: <20201124063919.30243-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124063919.30243-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 24 Nov 00:39 CST 2020, Randy Dunlap wrote:

> The Kconfig symbol ARM_QCOM_SPM_CPUIDLE wildly selects other
> Kconfig symbols when it should not.
> This causes kconfig warnings and subsequent build errors,
> as listed below, so modify this symbol's Kconfig entry to
> constrain and tame it.
> 
> WARNING: unmet direct dependencies detected for QCOM_SCM
>   Depends on [n]: ARM [=y] && HAVE_ARM_SMCCC [=n] || ARM64
>   Selected by [y]:
>   - ARM_QCOM_SPM_CPUIDLE [=y] && CPU_IDLE [=y] && (ARM [=y] || ARM64) && (ARCH_QCOM [=n] || COMPILE_TEST [=y]) && !ARM64
> 
> WARNING: unmet direct dependencies detected for ARM_CPU_SUSPEND
>   Depends on [n]: ARCH_SUSPEND_POSSIBLE [=n]
>   Selected by [y]:
>   - ARM_QCOM_SPM_CPUIDLE [=y] && CPU_IDLE [=y] && (ARM [=y] || ARM64) && (ARCH_QCOM [=n] || COMPILE_TEST [=y]) && !ARM64
> 
> and
> 
> arm-linux-gnueabi-ld: arch/arm/kernel/sleep.o: in function `__cpu_suspend':
> (.text+0x68): undefined reference to `cpu_sa110_suspend_size'
> arm-linux-gnueabi-ld: arch/arm/kernel/suspend.o: in function `__cpu_suspend_save':
> suspend.c:(.text+0x138): undefined reference to `cpu_sa110_do_suspend'
> arm-linux-gnueabi-ld: suspend.c:(.text+0x170): undefined reference to `cpu_sa110_do_resume'
> arm-linux-gnueabi-ld: drivers/firmware/qcom_scm-smc.o: in function `__scm_smc_do_quirk':
> qcom_scm-smc.c:(.text+0x54): undefined reference to `__arm_smccc_smc'
> arm-linux-gnueabi-ld: drivers/firmware/qcom_scm-legacy.o: in function `scm_legacy_call':
> qcom_scm-legacy.c:(.text+0x168): undefined reference to `__arm_smccc_smc'
> arm-linux-gnueabi-ld: drivers/firmware/qcom_scm-legacy.o: in function `scm_legacy_call_atomic':
> qcom_scm-legacy.c:(.text+0x2e0): undefined reference to `__arm_smccc_smc'
> 
> Fixes: a871be6b8eee ("cpuidle: Convert Qualcomm SPM driver to a generic CPUidle driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: linux-pm@vger.kernel.org
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Cc: Lina Iyer <ilina@codeaurora.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: John Stultz <john.stultz@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> v2: change to depends on QCOM_SCM (suggested by Bjorn)
> 
>  drivers/cpuidle/Kconfig.arm |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20201123.orig/drivers/cpuidle/Kconfig.arm
> +++ linux-next-20201123/drivers/cpuidle/Kconfig.arm
> @@ -108,10 +108,10 @@ config ARM_TEGRA_CPUIDLE
>  config ARM_QCOM_SPM_CPUIDLE
>  	bool "CPU Idle Driver for Qualcomm Subsystem Power Manager (SPM)"
>  	depends on (ARCH_QCOM || COMPILE_TEST) && !ARM64
> +	depends on QCOM_SCM
>  	select ARM_CPU_SUSPEND
>  	select CPU_IDLE_MULTIPLE_DRIVERS
>  	select DT_IDLE_STATES
> -	select QCOM_SCM
>  	help
>  	  Select this to enable cpuidle for Qualcomm processors.
>  	  The Subsystem Power Manager (SPM) controls low power modes for the
