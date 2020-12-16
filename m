Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26D32DC2C3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 16:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgLPPJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 10:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgLPPJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 10:09:33 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCF9C0617A7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 07:08:53 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id c5so19860041wrp.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 07:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=x22bCBMzRAxFz6sSBgolhRVuawQUHRVdIXtYqh/jdUI=;
        b=XXoR12nJ/51Cdim76vK0ddjmXjI2P2QPShPNZJAD1L68GyLqMQ+x5KY7Z4ZiUGR4Eh
         63fwF6dD1wegZWqANU6Q4TY36xZPy/+NsCxL99Wwj9TmX+W9HuK1eLXMQUBp8QsSj3Z5
         mmBKV2NdOQ4ODcsojdjTNR+GmuJARx3mWE6r42cO/+aC9KK14D7Hlr4IN5LnALmkqmjP
         6wuvgC+dzwzxjcll5T8pYAZRaEhnq4LOxr6snOHVzfRGFhPOmGuJCCtH7F8NNRE4J+Eo
         rxd9Vb33IxAcqrTroVKqzpNN9Cpmel7w4fRS+42axL58mjVr3yinPEP9J9JhmvyZ2a2I
         GuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=x22bCBMzRAxFz6sSBgolhRVuawQUHRVdIXtYqh/jdUI=;
        b=gThYx2bJwcb2DWolQLfWATxyVTH2F7jVRxu+PHEqBoyi7Egp/KLtiXqTI7NpufeBfy
         tN/IpwW4lebLfg0/saf4bW/XGOfMS4gM/WZpcHbqnZshGhWLldnjnjfq1qh1woYOEYFj
         9mAcx511gvq18Q9HxxaDX5gOpv9wLIKxAb+SOvcD4orGYvfAOse0arfvmJtXertWVCFm
         ddYPRNQOT/V3t2NG+L7Sc4DUBOyrnDpOPQw6fjkpGtlxsThYvtP4N2HQOcWO5NXqOZgu
         /y6JPR5mH7CcMq6dOAP5xgpZrDIqPoQ/y85e1q/WThFu2F9U7aN2j9a7E+8rUNjYMYbX
         YgJQ==
X-Gm-Message-State: AOAM532XpR3lN+RaYRC9Oc83ulMZHFDnFcs41K9dRAESNCVmSz140hBh
        fX2xg8joGx3WEv8x+Uc6S7YyyQ==
X-Google-Smtp-Source: ABdhPJyiTo068uJu57j2aTnPUqS3Rd6f/mMiS8boAbDC3unxQbp0sz3qKJbUoHZr6Tip0sLgPwYC8w==
X-Received: by 2002:a5d:6a4f:: with SMTP id t15mr7763158wrw.62.1608131331785;
        Wed, 16 Dec 2020 07:08:51 -0800 (PST)
Received: from dell ([91.110.221.200])
        by smtp.gmail.com with ESMTPSA id u7sm1846111wmu.47.2020.12.16.07.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 07:08:50 -0800 (PST)
Date:   Wed, 16 Dec 2020 15:08:49 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     marek.vasut+renesas@gmail.com, matti.vaittinen@fi.rohmeurope.com,
        lgirdwood@gmail.com, broonie@kernel.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, khiem.nguyen.xt@renesas.com,
        linux-power@fi.rohmeurope.com, linux-gpio@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/12] mfd: bd9571mwv: Use devm_mfd_add_devices()
Message-ID: <20201216150849.GI207743@dell>
References: <1608104275-13174-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1608104275-13174-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1608104275-13174-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Dec 2020, Yoshihiro Shimoda wrote:

> To remove mfd devices when unload this driver, should use
> devm_mfd_add_devices() instead.
> 
> Fixes: d3ea21272094 ("mfd: Add ROHM BD9571MWV-M MFD PMIC driver")
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/mfd/bd9571mwv.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
