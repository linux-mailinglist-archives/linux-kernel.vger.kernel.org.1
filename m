Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC1E2DBD2A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 09:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgLPI5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 03:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgLPI5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 03:57:48 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372B3C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 00:57:08 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id x22so1561400wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 00:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mAksUnjITJrVVrIfyDfK2h5TqrcuolGfF8vV6l695DU=;
        b=nj+8FuByuPEp+Bw7z82XVuvQxzjI4yVXiptRl//X+NzYyA/hYGD/7fvimdDIwjmSyQ
         8VUy5JOtadgACjVISM+Skwk3FLuP/HzAL0hsldvy7WXVn4CrvsA+sBoBngSh1zAyASZd
         OtUbvDct6C/nJIsSl4SrOXKVWLpDgWkqM+T8G+Fm+h3K7lFD6ZaARpJTpD1eKFwb+XPo
         E9CGOHl0KYShu2HiQl4UmMpPtAoE1+TTxgcutrnS939CyIdUoEHxv3WwwNIlrTm7GRHv
         jogzA1n+nvMc+0L5l1ekCCchwyGVp0i5GT8tjiEqmkbAHceDggsbbofCp5KH8zXC+bVo
         RGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mAksUnjITJrVVrIfyDfK2h5TqrcuolGfF8vV6l695DU=;
        b=F4olroCvtfPKU+l1XdWO8zLqdofhyt2+Mb36cwF0CDVvuY296tW7H8kRHu/EURLIbr
         EpNjKkegemosxwENwkm2faJ/vrpqp4np1jLvfFaYgVa5wZjnQAnMg/GcpaOCtEPB8IaU
         lOYOT28YWDko5AHfvIaHisiBJ0ExiQjbNNDJmYMOlBF9VcyOOwt8yCs+Jp3ZprSHXtUE
         xUV3hNWJK8vmx3lHgU+y6L416YiM7GnCkGZXQdAbccpioYWrAhnBlOXdf/sUaBmqP38l
         ZZ6C7hWXus4+tc5bEVIX0CAiHai+OG89TEf0KSdaJCiMgmH1FQVhOBXpSSupN4UrPpLY
         ZB8w==
X-Gm-Message-State: AOAM5315rDoIAD1cSUhH37RIgTNW3CrrMpWbsRT4nYUs0YLKWBMkNWFx
        Q97BfVFw5vTXJ2TaJ6gEF2NQsoPP+DENNZoa
X-Google-Smtp-Source: ABdhPJwWIeksXn0lMKYk3eKs6Wqc4Pj8h3MPahksiUpy4WoUn/YZkLMbV8uoCisYtCgjID2AVUiEww==
X-Received: by 2002:a1c:491:: with SMTP id 139mr2159276wme.81.1608109027014;
        Wed, 16 Dec 2020 00:57:07 -0800 (PST)
Received: from dell ([91.110.221.200])
        by smtp.gmail.com with ESMTPSA id f9sm2721792wrh.9.2020.12.16.00.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 00:57:06 -0800 (PST)
Date:   Wed, 16 Dec 2020 08:57:04 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: sgi-ioc3: Turn Kconfig option into a bool
Message-ID: <20201216085704.GI4776@dell>
References: <20201207141446.53898-1-tsbogend@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201207141446.53898-1-tsbogend@alpha.franken.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Dec 2020, Thomas Bogendoerfer wrote:

> Module builds of ioc3 fail with following errors:
> 
> ERROR: "spurious_interrupt" [drivers/mfd/ioc3.ko] undefined!
> ERROR: "pci_find_host_bridge" [drivers/mfd/ioc3.ko] undefined!
> 
> Exporting pci_find_host_bridge got rejected by maintainer, so easiest
> fix is to disable module building, which even makes sense since both
> SGI Origin and Octane always contain at least one IOC3 chip.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
>  drivers/mfd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
