Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A392B02C2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 11:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgKLKdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 05:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgKLKdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 05:33:04 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8EAC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 02:33:04 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id d142so4788590wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 02:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UPml7Ag+cyD5ZpOUsCEhsFzeed/Gt64P4gFrMh0ZZKY=;
        b=Pb8VQuJIwCFqzeQjIGAHYXTufJDGSFTfprHfLDPNEjyM5STzLg/vQp5fI6xymu/6Qd
         CD1scPRwOyQTWw7OLIqv4RK7UT/B0h61kLvuBgSkGZLvovycoVbf6zrWr9GIjM4daD3c
         5beykU4oWsv8wEbZKwJkXLAtQCi9WF8MsgsyZdj3JAXi4+qFH6R8Jjxvoh7ym0wlgCCq
         cm9+SkfSRx9LNFYdrrQbCq2GMUZSjBbBk4Xo8KMmh4wrW04RYYzUgC81efqemBQ4yEW4
         tNseL4k1arQCKFoKhYWc6QkEvoUne+CsrHVoYZbYjyz0qpS3YE8ZJlHqXyw2c8Wl5wwy
         ck7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UPml7Ag+cyD5ZpOUsCEhsFzeed/Gt64P4gFrMh0ZZKY=;
        b=GNkv6A4QQXb8Zx3BZX/B8ZNJmpnuDiyFyKAO3mWFWkbBdm6nekBwrPOkWlgbzvEBcF
         lDk8E1KGllRgO+ql6vkl5pl623dVSi3x31lGALaif5pfU3zS0V/EIY6GyNOEYYyuT0kE
         hoSO0nSBikYKHe2eNkqeZODkcg7EBA29wlZxprV2gvfQVZAoE08jYPSF1xGeaLSgr/6J
         A2lZcbea1MAbWTYtXWW8UwOHbyraLhNEAWKduzkyk8EUcmLe+Se5ETEtx4o3Y17GwDn7
         V3AEcfzcescdXg/9POeo/Ee5vEhZNrRL+CBhnGij2/Xm2q283aLuoyUyK7eowQcON7LC
         Nquw==
X-Gm-Message-State: AOAM530rlMVfL4cTkWq1bEiedd1Zf/HTsIpTswIZUXUGjq9LbqWYkKcp
        JPmFILINcSOlUYJ0IfBwqbSqFg==
X-Google-Smtp-Source: ABdhPJybfLNMok1CvTRVf4Y6Qu7ivi2P2KG2tDvWy1ClR91LsorSSABSS7zH0zcIgTKID0RKbgc/AA==
X-Received: by 2002:a1c:2583:: with SMTP id l125mr8851372wml.50.1605177183172;
        Thu, 12 Nov 2020 02:33:03 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id i5sm6545274wrw.45.2020.11.12.02.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 02:33:02 -0800 (PST)
Date:   Thu, 12 Nov 2020 10:33:00 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Scott Wood <scottwood@freescale.com>, act <dmalek@jlc.net>,
        Dan Malek <dan@embeddedalley.com>,
        "Software, Inc" <source@mvista.com>,
        Vitaly Bordug <vbordug@ru.mvista.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 11/25] soc: fsl: qe: qe_common: Fix misnamed function
 attribute 'addr'
Message-ID: <20201112103300.GE1997862@dell>
References: <20201103152838.1290217-1-lee.jones@linaro.org>
 <20201103152838.1290217-12-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201103152838.1290217-12-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Nov 2020, Lee Jones wrote:

> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/soc/fsl/qe/qe_common.c:237: warning: Function parameter or member 'addr' not described in 'cpm_muram_dma'
>  drivers/soc/fsl/qe/qe_common.c:237: warning: Excess function parameter 'offset' description in 'cpm_muram_dma'
> 
> Cc: Qiang Zhao <qiang.zhao@nxp.com>
> Cc: Li Yang <leoyang.li@nxp.com>
> Cc: Scott Wood <scottwood@freescale.com>
> Cc: act <dmalek@jlc.net>
> Cc: Dan Malek <dan@embeddedalley.com>
> Cc: "Software, Inc" <source@mvista.com>
> Cc: Vitaly Bordug <vbordug@ru.mvista.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/soc/fsl/qe/qe_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/fsl/qe/qe_common.c b/drivers/soc/fsl/qe/qe_common.c
> index 75075591f6308..497a7e0fd0272 100644
> --- a/drivers/soc/fsl/qe/qe_common.c
> +++ b/drivers/soc/fsl/qe/qe_common.c
> @@ -231,7 +231,7 @@ EXPORT_SYMBOL(cpm_muram_offset);
>  
>  /**
>   * cpm_muram_dma - turn a muram virtual address into a DMA address
> - * @offset: virtual address from cpm_muram_addr() to convert
> + * @addr: virtual address from cpm_muram_addr() to convert
>   */
>  dma_addr_t cpm_muram_dma(void __iomem *addr)
>  {

Any idea who will pick this up?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
