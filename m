Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424D42A3626
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 22:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgKBVqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 16:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgKBVqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 16:46:36 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C27C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 13:46:36 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id y14so12304830pfp.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 13:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NuAK5iU+OB5uwgmefiNZ92vlEQCJHA3+TVIKzsNC8/Q=;
        b=PmBlyYUxet0pQz4Kq7fTrLy5nPvS/FiNVis6+GO0WuqHhybCtrLbmb89ZojZH+caQT
         BYwdEgUSIAnFnVx/BdCKv2E9nEtFAYMGfol+eXsTlcBAJjm4GYaq8lY8VakgxbRSzwfL
         X2KFvZAAu+5G8djht/XSlC5F12rPHBnwkUHEMVjjv47S7Y6w6WgPBSmxzNri3nQPrk4p
         0yMHBC8j/+mmI5Hd0wCTaxk8MWGzIJuTOQKtc1jxySg+n3YG12HM4jMCi8fa4bp+cCDG
         43VLHSE5VSo5STKVUza8IG7D6ndFh44r82gSW2XBaT9OTbvLZoMSYESEHju8kMtIkWvU
         oDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NuAK5iU+OB5uwgmefiNZ92vlEQCJHA3+TVIKzsNC8/Q=;
        b=SBTd0Y9adPk1iuDoexAUM3TtLPYG0uQww43MhVhHZYV1+nbzyNx2nUN1vSJ4asy+2X
         nKTYPcKaEnvAO+nVdV2f9oVZtiLkR9gjPxqY6ioo4G+/3Su3I1Z8q7/CeAxtnI1dhtlI
         0CSZ5KBSz15r3jE8w2kHVPiNlkcsFPWhWyB6O7Xu4mGS3bOf+dnR9MXPfROfI34V01Yj
         PHvxXLVvdMN2eciBg9YxNOqmI9fp281RZwe6+6qJLJHAJbTnbH/7vbRvMXDiV4pa1i6m
         R7E9CVQ5Y6pmVbXWjD/Zs4lhPSQYYYJjPa72EkS4Egx4eRujro+HbDCW8mVj4+F/1vNC
         1nAw==
X-Gm-Message-State: AOAM530fmDUlBUah1g8/4dCGxjvt4fd3nUFkbXUmdSHjOXAmMLrrleqD
        ev0IsFBcLBon5asFjTDqdHLrmg==
X-Google-Smtp-Source: ABdhPJy2WBxIE36mCDneHzdb8Jqk4jEXiLdHF0aRYDJZcW7w78FEN7ogF1O0a7WLCCGS5s2YPRUdcw==
X-Received: by 2002:a62:25c7:0:b029:156:72a3:b0c0 with SMTP id l190-20020a6225c70000b029015672a3b0c0mr23140079pfl.59.1604353596231;
        Mon, 02 Nov 2020 13:46:36 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id ca5sm453566pjb.27.2020.11.02.13.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 13:46:35 -0800 (PST)
Date:   Mon, 2 Nov 2020 14:46:33 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/26] coresight: etm4x: Handle access to TRCSSPCICRn
Message-ID: <20201102214633.GD2749502@xps15>
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
 <20201028220945.3826358-8-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028220945.3826358-8-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Wed, Oct 28, 2020 at 10:09:25PM +0000, Suzuki K Poulose wrote:
> TRCSSPCICR<n> is present only if all of the following are true:
> 	TRCIDR4.NUMSSCC > n.
> 	TRCIDR4.NUMPC > 0b0000 .
> 	TRCSSCSR<n>.PC == 0b1
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index d78a37b6592c..0310eac9dc16 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -175,8 +175,9 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>  			       drvdata->base + TRCSSCCRn(i));
>  		writel_relaxed(config->ss_status[i],
>  			       drvdata->base + TRCSSCSRn(i));
> -		writel_relaxed(config->ss_pe_cmp[i],
> -			       drvdata->base + TRCSSPCICRn(i));
> +		if (drvdata->nr_pe)

Aren't you missing to check the value of the PC bit in TRCSSCSRn?

                /*
                 * TRCSSCSRn:PC, bit[3]: Indidate support for single-shot PE
                 * comparator input.
                 */
                if (drvdata->nr_pe && (config->ss_status[i] & BIT(3)))


I have picked up patches 1 to 5 and added a "Cc:stable" to paches 2, 4 and 5.
More comments to come tomorrow.


Thanks,
Mathieu

> +			writel_relaxed(config->ss_pe_cmp[i],
> +				       drvdata->base + TRCSSPCICRn(i));
>  	}
>  	for (i = 0; i < drvdata->nr_addr_cmp; i++) {
>  		writeq_relaxed(config->addr_val[i],
> @@ -1228,7 +1229,8 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
>  	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
>  		state->trcssccr[i] = readl(drvdata->base + TRCSSCCRn(i));
>  		state->trcsscsr[i] = readl(drvdata->base + TRCSSCSRn(i));
> -		state->trcsspcicr[i] = readl(drvdata->base + TRCSSPCICRn(i));
> +		if (drvdata->nr_pe)
> +			state->trcsspcicr[i] = readl(drvdata->base + TRCSSPCICRn(i));
>  	}
>  
>  	for (i = 0; i < drvdata->nr_addr_cmp * 2; i++) {
> @@ -1344,8 +1346,9 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
>  			       drvdata->base + TRCSSCCRn(i));
>  		writel_relaxed(state->trcsscsr[i],
>  			       drvdata->base + TRCSSCSRn(i));
> -		writel_relaxed(state->trcsspcicr[i],
> -			       drvdata->base + TRCSSPCICRn(i));
> +		if (drvdata->nr_pe)
> +			writel_relaxed(state->trcsspcicr[i],
> +				       drvdata->base + TRCSSPCICRn(i));
>  	}
>  
>  	for (i = 0; i < drvdata->nr_addr_cmp * 2; i++) {
> -- 
> 2.24.1
> 
