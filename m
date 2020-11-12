Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7042B02C4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 11:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgKLKdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 05:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgKLKds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 05:33:48 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6340FC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 02:33:48 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id p1so5406892wrf.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 02:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=35zt7gixVPMG1KfL9nSOfZvseh8gr5Ny6Pqy+A2ZElg=;
        b=yz8BpGmykQJd3aJMjbiY1HRFds0VHjDm5pgAfA4tz1+MZSuebUW/P09W/VnvxdzTAx
         0s75bsDt4SbiH2guN00CswOs8QHgnlS5+ZpgKc9elSBoXxmSqNU3T6l3PJlnX9V0HZ8w
         SesBttkfCe3ZYkkWmGI9fa1nGWgY1/WGv8FJIHoQvhpdxFQxhEsp9pPA9UhLsorm3Dvu
         v0MA7j0XjgezGfcNiVjubw0NwIzRT64Mp570UTv09wmXgfcXag1HZF0vVNvwbc23KOKD
         wTdufj5qUMzn4qD2AveKJPVIjAC9yxS82Xt7ejC0yjjzYbkGhBEQz1w60dz0Tg/ew+tY
         4iFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=35zt7gixVPMG1KfL9nSOfZvseh8gr5Ny6Pqy+A2ZElg=;
        b=eN4xgWvq7jJG3vthn08Ewz3L/0SFtaEGWl+2c25AN5B3I1bQ9CFGBpZjn03tOgycTQ
         6/75kuAx/r8910nACfvKbM2FlkrMDh8NsylS3u+8Uc1qwJT3kFT0zDiqzoH5o69zvccf
         vPWCCBUh2gDUzknN2TuLxRa4ENz3Az3672uCMa9VpoTSEcJpCzfxY4fcwFmq5dQHKpYi
         3P8+sINWBj+l/P+rWzO9Te+hyCU1lbzi3OnlyMgiRKjRxWhj8HZDNze2s9wBKH9cnt96
         vIRX58D6NIIA79l1mmjrOxJESEUcuqTzxss7J5W4xF1rlLmmMiFI5rkiLHyR0pk1cn+m
         W7DQ==
X-Gm-Message-State: AOAM530zg+rXGMmRh8n8C1wuXzGsUl16uoLOMPxoenqe111fBxhNYSbb
        TMYTavXA+uQvn4/o0reQ9CEwtw==
X-Google-Smtp-Source: ABdhPJwyH5Ff/ayBEd0hcnLHq00JRNlh00wwExj7KnatYlxTXz2oxk36pVc6Y4zME3xdG+UkiIFcEQ==
X-Received: by 2002:adf:f20c:: with SMTP id p12mr7423809wro.27.1605177227114;
        Thu, 12 Nov 2020 02:33:47 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id 18sm5717871wmo.3.2020.11.12.02.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 02:33:46 -0800 (PST)
Date:   Thu, 12 Nov 2020 10:33:44 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Doug Anderson <dianders@chromium.org>,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 05/25] soc: rockchip: io-domain: Remove incorrect and
 incomplete comment header
Message-ID: <20201112103344.GF1997862@dell>
References: <20201103152838.1290217-1-lee.jones@linaro.org>
 <20201103152838.1290217-6-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201103152838.1290217-6-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Nov 2020, Lee Jones wrote:

> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/soc/rockchip/io-domain.c:57: warning: Cannot understand  * @supplies: voltage settings matching the register bits.
> 
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: linux-rockchip@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/soc/rockchip/io-domain.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/soc/rockchip/io-domain.c b/drivers/soc/rockchip/io-domain.c
> index eece97f97ef8f..d13d2d497720b 100644
> --- a/drivers/soc/rockchip/io-domain.c
> +++ b/drivers/soc/rockchip/io-domain.c
> @@ -53,9 +53,6 @@
>  
>  struct rockchip_iodomain;
>  
> -/**
> - * @supplies: voltage settings matching the register bits.
> - */
>  struct rockchip_iodomain_soc_data {
>  	int grf_offset;
>  	const char *supply_names[MAX_SUPPLIES];

Any idea who will pick this up?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
