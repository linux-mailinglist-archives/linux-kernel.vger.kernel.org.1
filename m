Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41BFF2FCD14
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 10:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbhATJA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 04:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbhATI7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 03:59:51 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32B5C0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 00:48:24 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id a12so22222108wrv.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 00:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Gj2SSDcR/lcOEweODkO2ajBiYmOm+Uz7CAyJG5h4b/Y=;
        b=BFmWt4HX68zoZQF/WqhUm4m2zHpgpZElFTMr3+epZrgZv+VYA4EuRtAsrIgBgzOkOE
         H1xaKKVvn/IiEPqHVX75RFd5T2tyKVrRrnh6BWMlCHMr+sI/AtDNO8bwIz19Sk6TyOOg
         /UhdGaVGnRgzRSCD7zcLnRUXsUCxYoFEp9YSka8oGMbQ1XYidi0N67nCFAEjj5v4HgqE
         xvDpKvHm2LpkvP3vX7cl1lh/LcNVOKJYnGYLfZ1YCT2x8VVWX/ZijsNs7XnUQktWbH+p
         ZRdKjyMRVUNZn2cssC3dJek4HW3+cyrYfCNvojYDH+wWxNI7CQCWf2IoKFDTT76jpvlc
         ei0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Gj2SSDcR/lcOEweODkO2ajBiYmOm+Uz7CAyJG5h4b/Y=;
        b=CIrlH4YnRAQhMwIHfrHXfl2wFisIn/QMk2foJtlPfLFV2uO8lX31cSl7QET2pXVAKD
         LjJOgEIGdIsjkAUxG65pUREvN7ykXFNPC3whQpyf89+7t0n0W59lju0eZZ8IdJ99aa7O
         F21rpZDDEWPpysrGQV4fJhluzv2w+L6F6KGpouqXZZCqp3TVvdienwqv7FwUxygpUhvI
         5Q367FWjMKTOd4A1x2p3CvzYX2+l1z87PUIFJjkFVzhnP+ATE4DYfJsi/BAvqM4OLpRh
         rLztcoR0PDNisavd6JI9ziqYF2FE6WqsYg7zqQbUg/sdRi5bC/bSl1Yrb7dK4JeJGo8V
         I2mg==
X-Gm-Message-State: AOAM5316ZbO3XxR6i04gisNcAU+u0D+4BrNlgyEf5ye/M3BVKS2au/xl
        Y4SVCQPTWLkz6LHvYlcj6Unwkw==
X-Google-Smtp-Source: ABdhPJwjcov5efX8hRmYe5wuneBd4CxmhfR+MMnODuBQq9Jjxf8bcSSB5aTyR5Q+mmlQzeIfdtSHlg==
X-Received: by 2002:a05:6000:1788:: with SMTP id e8mr8163262wrg.171.1611132503654;
        Wed, 20 Jan 2021 00:48:23 -0800 (PST)
Received: from dell ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id u6sm2562828wrm.90.2021.01.20.00.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 00:48:23 -0800 (PST)
Date:   Wed, 20 Jan 2021 08:48:21 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] mfd: iqs62x: Do not change clock frequency during
 ATI
Message-ID: <20210120084821.GS4903@dell>
References: <1610942228-7275-1-git-send-email-jeff@labundy.com>
 <1610942228-7275-7-git-send-email-jeff@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1610942228-7275-7-git-send-email-jeff@labundy.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jan 2021, Jeff LaBundy wrote:

> After a reset event, the device automatically triggers ATI at the
> default core clock frequency (16 MHz). Soon afterward, the driver
> loads firmware which may attempt to lower the frequency.
> 
> If this initial ATI cycle is still in progress when the frequency
> is changed, however, the device incorrectly reports channels 0, 1
> and 2 to be in a state of touch once ATI finally completes.
> 
> To solve this problem, wait until ATI is complete before lowering
> the frequency. Because this particular ATI cycle occurs following
> a reset event, its duration is predictable and a simple delay can
> suffice.
> 
> Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
> Changes in v2:
>   - Added Acked-for-MFD-by trailer
> 
>  drivers/mfd/iqs62x.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
