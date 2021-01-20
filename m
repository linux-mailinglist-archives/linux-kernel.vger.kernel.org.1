Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC39B2FCCEC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 09:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731117AbhATIna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 03:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730950AbhATInK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 03:43:10 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADD7C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 00:42:29 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id e15so2070329wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 00:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Wnqah//MfO4kvUUcBxLMh1L4EYoeB4d28WT60P9Zzpo=;
        b=wfOVNTX75VBn+9dZ+ayBVezhkkVsoHo86ameqFRKw6Uamt+rWpJHSiJXB3w3YMHW5d
         z6/wcZrQT1glZM17i6qobJVicEaacgW6FKACy7L4Y/HU16YNemPMWe1rwTvCX4JvF4PT
         fQqxD68Uu1XeAc895v7BDBLM9oW/VKYZ9hVHeaNQPM8BkR3Rtedls47N+t+vesLmbJmh
         y5Q0mPuO+SOzDGiPaT/Zn7Bw1xScQ4gLT40uzYLoVgBVY9lMkVZ2teA1Gr1rVcHZdu5N
         fJZaCArsVGR4ObV6Scrk1wl8j3yqdFyVkRWxDFnMrKXyy/2cXeRhMWqQGUTt1FUmeTwk
         ZZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Wnqah//MfO4kvUUcBxLMh1L4EYoeB4d28WT60P9Zzpo=;
        b=e5nw7t/ooVlG3Nk2otpzK3K2HKXelHixJA1Q/snJxsl2bwP2WK8WhM/ZklELrpcSwv
         SWaduDOFlu8k4b8o7P49BkvYT5z1XQ0nFrtr2hI4XxiShDMnth0yhF4dmYCyZbalfHhK
         pmtlyE/B8IG/rZ6sX6v0A36ivUx94Y4czo5LbUJqjV6KIhPltfgjWv+QQ1+SnWOxQeVh
         j0MqcyyquaqxccoLhg1JAhJTsPlPXllsZchnsqSuirzQWCiTXJZD7SJVMhRN54EHTeeT
         VUDt+zYmK8RQe22KMATCaEgrVHmVkfUikJPKnPRqBxEPDUgrqKL/cOjQtlC4If/tV8nC
         gLNQ==
X-Gm-Message-State: AOAM532T2rlY6j3w1UlWwtOWplXK1NGAATQM3phbgxH0XecH5G40LA5q
        gWA4toLxZo+TUU4RdOHuikP/0SeszSw6YNHx
X-Google-Smtp-Source: ABdhPJwwmbWpCYePsd/5hOezoi+MGr2YrXVJRHYoEmePvugJ2RRHAtvgKMm6GMky/vL3s1tCoQDrhQ==
X-Received: by 2002:a1c:cc14:: with SMTP id h20mr3160397wmb.180.1611132148674;
        Wed, 20 Jan 2021 00:42:28 -0800 (PST)
Received: from dell ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id h15sm2276227wru.4.2021.01.20.00.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 00:42:28 -0800 (PST)
Date:   Wed, 20 Jan 2021 08:42:26 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] mfd: iqs62x: Remove unused bit mask
Message-ID: <20210120084226.GO4903@dell>
References: <1610942228-7275-1-git-send-email-jeff@labundy.com>
 <1610942228-7275-3-git-send-email-jeff@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1610942228-7275-3-git-send-email-jeff@labundy.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jan 2021, Jeff LaBundy wrote:

> The register write that performed a mandatory soft reset during
> probe was removed during development of the driver, however the
> IQS62X_SYS_SETTINGS_SOFT_RESET bit mask was left behind. Remove
> it to keep stray macros out of the driver.
> 
> Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
> Changes in v2:
>   - Added Acked-for-MFD-by trailer
> 
>  drivers/mfd/iqs62x.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
