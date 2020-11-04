Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3A62A62BE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 11:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbgKDK5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 05:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgKDK5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 05:57:48 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A49C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 02:57:47 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id h22so1911954wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 02:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZaEiQb68LVc3sL00jXh1ghe9emoMO0BGhl5hPYKmGBs=;
        b=N7ZxMSJnYBGsgtULz91r9R9uEfWuPjmD03JnRrs8LzssyxlOVjfSBjrK3BHircBcgq
         8RzJ138W97Gt5RSWySFXTZAo2aFabM/oV+5Ur+3b23GlhIAvFfLKmhwal79LBvzcvvt+
         Lo50PrcMJdQIv48aiqAOmuFO7mdSfOT4E4AsKFeryTovSb37tRe1dsJ3q0zZujtANv5j
         gVq3PFFZWnhd/FFLFPGHyXPg9Upiu2uLDfVJoq/GY02sSY6znyeVs0Drx5/UJdIDKpK1
         Qxw+C7FVweceKGY5JqKaRM5wdfk+aTuts81muSLH1Vu5gOEj0XWuFpf4ny5f5IvskT/W
         60dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZaEiQb68LVc3sL00jXh1ghe9emoMO0BGhl5hPYKmGBs=;
        b=HVv3UfT0UZsebze6A1JkxPU2tjDsUxjZqXueF97bkOQrOc+xJAwo4QwWu9mJLTkxUK
         9B8GFg7fjYymxIq++e2Lkgwwz2CcbBStT3sMZBP83RZqnW8H9UDOQtFFqGJBQcvtFzaZ
         UE8/iY8jwU26NhFO8fzBhApPuiCtc+FUSvk5HHHfEV458y4hPrHe9V+rlKfHyEV9GuAn
         A0jkHIpMa/Ha35k7jm4Jn5/NILTUjtlREGA7vrlRfWORLvf6PRoV6ZHB4N6UM9lM1BjT
         5JiJ4wr7c/z/dHf4wuIDZJv9tMZeAnzaBBQ7UU4wxRvOUI8Cw7vkSW1fSD3BAdXkb0hP
         vZZw==
X-Gm-Message-State: AOAM531hipeQefjVud1VLVobJ+mGqZM5mZRL38+b4qfKTUPntg+ospHi
        TaCJA3pWiHIh5/YrCsC/9m4uSA==
X-Google-Smtp-Source: ABdhPJyEMhMBG3yi1Tan+yGKgU14XKycLleo1nVW0lohmZ/haQr0tX1UvU142dPC5SOM5kE+uAOINg==
X-Received: by 2002:a1c:f606:: with SMTP id w6mr3761360wmc.136.1604487466452;
        Wed, 04 Nov 2020 02:57:46 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id k22sm1687206wmi.34.2020.11.04.02.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 02:57:45 -0800 (PST)
Date:   Wed, 4 Nov 2020 10:57:44 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 4/8] mfd: wm: Constify static struct resource
Message-ID: <20201104105744.GV4488@dell>
References: <20200922192659.14535-1-rikard.falkeborn@gmail.com>
 <20200922192659.14535-5-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200922192659.14535-5-rikard.falkeborn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Sep 2020, Rikard Falkeborn wrote:

> Constify a number of static struct resource. The only usage of the
> structs are to assign their address to the resources field in the
> mfd_cell struct. This allows the compiler to put them in read-only
> memory. Done with the help of Coccinelle.
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---
>  drivers/mfd/wm831x-core.c | 52 +++++++++++++++++++--------------------
>  drivers/mfd/wm8994-core.c |  4 +--
>  2 files changed, 28 insertions(+), 28 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
