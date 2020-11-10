Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164E52AE3E3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 00:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732100AbgKJXLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 18:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbgKJXLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 18:11:05 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DFBC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 15:11:05 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id w188so10891159oib.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 15:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3AJDlksROJcwvHXdH093qK02oZEJS82ZIyxFg53YWfY=;
        b=JvplCnGpk0cMioznyOdsjVtsG1V1j6oFb10YxRCz7OKMq8vFyzmyk4ry0J87GZoedJ
         Lr1Pw0qH6u4wU9AMqeZxFdEDzc59pb55UTU2tZoFCxIrYsZLgTj9gcTN4/tVUgYHqtSH
         BrIBIDvDT3idbi7NV5G6alhkrH0rZOwHMxTidNX0mSOD+Gdy0WbX1zNAo71jeANsrXx3
         msVtXkYe74ShtwclFzoEtiFIOiL1Fddqm5UcfcCJGNAMkq2W+8GPpWttIJ3/HtHxCMj+
         B1f4Y26/bkmKoyJnQQ24IYJs9L1gP0artIcJ8azwChW7e/iICYR9rlDbLrB3L/7pt4VY
         1dVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3AJDlksROJcwvHXdH093qK02oZEJS82ZIyxFg53YWfY=;
        b=BuEvFPw7GJJKgfBdEbBV9Bmq0yWhq8oaKzZHaRTuHjkZ40dYiROJQVBuUDKgsSW53A
         WCJsv4LGF2XCCyZGQrFI5q7mtjS3qvS/CzAjTgLSwMTag35Es4+BxmQZGcwXExGVtPoi
         7U7VEk76CC1wTG2g9AqMjxf4RaLdj6rslnjnMEvafsWM0bhYToblkl/o8Upm/A6ESxFw
         0R6OjkM4jaF4HWkgfBHtOHP7FlALYS/SR2Jzng7ZWkRU7jb5iR9EwLjYclNG5S/rI3a2
         6fKaH+F4Wb+D8xNoruIQplEFmZiKVdbru6YJ6370q8Jdk/K/kzCoV+vn30Y4Ap2+wxPX
         yEOQ==
X-Gm-Message-State: AOAM532Kx7rFCO8inDpsmkcNguJ8aYtLE6FwY5g2pKRveOwtUs+ciDtK
        lAoUtkfIKO5fDuSeXFcJNC6DqQ==
X-Google-Smtp-Source: ABdhPJz6QVmkq40UD6CaQxBmJL78mWRpp4m465RT2YpaJfAhRJYbHQgCeBroTOstzyMZsCtqk+yNkA==
X-Received: by 2002:aca:750d:: with SMTP id q13mr303305oic.77.1605049864458;
        Tue, 10 Nov 2020 15:11:04 -0800 (PST)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id s20sm104659oof.39.2020.11.10.15.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 15:11:03 -0800 (PST)
Date:   Tue, 10 Nov 2020 17:11:01 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Vladimir Lypak <junak.pub@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2] pinctrl: qcom: Fix msm8953 Kconfig entry to depend
 on, not select PINCTRL_MSM
Message-ID: <20201110231101.GG807@yoga>
References: <20201110215619.86076-1-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110215619.86076-1-john.stultz@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10 Nov 15:56 CST 2020, John Stultz wrote:

> One fixup following my patch commit be117ca32261 ("pinctrl:
> qcom: Kconfig: Rework PINCTRL_MSM to be a depenency rather then
> a selected config") being queued in LinusW's tree, as a new
> config entry was added for the msm8953 that also needs the
> change.
> 
> Applies to LinusW's pinctrl devel tree.
> 
> Cc: Andy Gross <agross@kernel.org>
> Cc: Prasad Sodagudi <psodagud@codeaurora.org>
> Cc: Vladimir Lypak <junak.pub@gmail.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> Change-Id: I9e8e83b1ea57aff338074be9174fce53cef29eff

Linus, please drop the change-id as you apply this.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> v2:
> * Fix flipped numbers in the soc name, pointed out by
>   Jeffrey Hugo
> ---
>  drivers/pinctrl/qcom/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> index 8bdf878fe970c..cf56e029cd9c7 100644
> --- a/drivers/pinctrl/qcom/Kconfig
> +++ b/drivers/pinctrl/qcom/Kconfig
> @@ -115,7 +115,7 @@ config PINCTRL_MSM8916
>  config PINCTRL_MSM8953
>  	tristate "Qualcomm 8953 pin controller driver"
>  	depends on GPIOLIB && OF
> -	select PINCTRL_MSM
> +	depends on PINCTRL_MSM
>  	help
>  	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>  	  Qualcomm TLMM block found on the Qualcomm MSM8953 platform.
> -- 
> 2.17.1
> 
