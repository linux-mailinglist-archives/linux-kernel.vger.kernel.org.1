Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83DF82E8FD8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 05:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbhADEmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 23:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbhADEmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 23:42:07 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F66C061574
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jan 2021 20:41:26 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id n42so24927977ota.12
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2021 20:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LQsoArKeoDDIzzmEcCee/1QYJsiriJnD7Bph1nwU680=;
        b=cpIHEHcE0bdZ+C9OGyNQg5lW/iRtwISkh5KnApATeYc9TXaI63y6vFJPsZ5XO1ZHjN
         xSEDuVoJbcG5w4PPp5p3DToqthfgQOBmh4YODivz8TLwBtNuaF+98dDFSe86/oSI2l9R
         K7qVS2ncohLyNrDhe7/0kgUqtQ8OqDtBVCY7zkIEnibh+vBNU8Iy7dxstZjTgfSFVlb5
         sFZQ4Spa5FJJ6e6mDKwxKGk/ZTOMaRpxZVmm4smwQ5cC04Etc8BOKfzG++e+DSqFCvS9
         WW5Ba0aXQ4Omcof9SQBCCiZJbNjL3S+mYs+9dz5TwcnBDrdoENFYwG8/siWIZt7YEKyn
         4MoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LQsoArKeoDDIzzmEcCee/1QYJsiriJnD7Bph1nwU680=;
        b=nYEO+XFVwo3KJiDA6b5WEV4tvaWJsS977Jw2MisBZyNWU3a1Ny8QP5ioxeA5Yf0hlc
         up6e0653X/wFmpJ6AI+XumeMC00plk/se2/bQi8WIVxeogUF/uez4HSEnDVGXyWX0kne
         +wNLzGpd/dzCJQH9Pfu00OMgeombLbX4SujHYXoRpSomiNILcSA76thzN6zWhk4z1sAh
         w371HE39JcUBZnGIcc9DkIS4KEKF1ZUtKie3Ul7rlbLlicepQDy8PLH27H4tbfU+aR3u
         jUlb31Id774ByF8xtZha0UDlxmgdYGP+cjZ7WySP6tQ6tnBwvo0PK+OzNtuNQkARRalI
         TJNw==
X-Gm-Message-State: AOAM532TqYD5muyVPAWNx4zhXixR8U0EV9v/6k5PqlwthqlYFGNVs6Dz
        qCqy0Xft91pPB6hv/NutqxEkow==
X-Google-Smtp-Source: ABdhPJyuXa8n/nqALq+NGEHPZkNacsHjNmAXIJj0PitcrzgBc83MnKH2rp8YOcvObr3Q8iVSaL+1iw==
X-Received: by 2002:a9d:6b99:: with SMTP id b25mr52448757otq.49.1609735286036;
        Sun, 03 Jan 2021 20:41:26 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id z8sm8670970oon.10.2021.01.03.20.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 20:41:25 -0800 (PST)
Date:   Sun, 3 Jan 2021 22:41:23 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>,
        David Collins <collinsd@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: qcom-rpmh: add QCOM_COMMAND_DB dependency
Message-ID: <X/Kcc9Rj6h4pJifU@builder.lan>
References: <20201230145712.3133110-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230145712.3133110-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 30 Dec 08:56 CST 2020, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> A built-in regulator driver cannot link against a modular cmd_db driver:
> 
> qcom-rpmh-regulator.c:(.text+0x174): undefined reference to `cmd_db_read_addr'
> 
> There is already a dependency for RPMh, so add another one of this
> type for cmd_db.
> 
> Fixes: 34c5aa2666db ("regulator: Kconfig: Fix REGULATOR_QCOM_RPMH dependencies to avoid build error")
> Fixes: 46fc033eba42 ("regulator: add QCOM RPMh regulator driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/regulator/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index 53fa84f4d1e1..5abdd29fb9f3 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -881,6 +881,7 @@ config REGULATOR_QCOM_RPM
>  config REGULATOR_QCOM_RPMH
>  	tristate "Qualcomm Technologies, Inc. RPMh regulator driver"
>  	depends on QCOM_RPMH || (QCOM_RPMH=n && COMPILE_TEST)
> +	depends on QCOM_COMMAND_DB || (QCOM_COMMAND_DB=n && COMPILE_TEST)
>  	help
>  	  This driver supports control of PMIC regulators via the RPMh hardware
>  	  block found on Qualcomm Technologies Inc. SoCs.  RPMh regulator
> -- 
> 2.29.2
> 
