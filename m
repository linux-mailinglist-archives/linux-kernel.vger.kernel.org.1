Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F0F2AC3E0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbgKISc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729119AbgKISc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:32:59 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7995C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 10:32:58 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id r186so7889312pgr.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 10:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Aos7KVRDO/C6OJn4w3QYdJlpwzC57/3vij3hTuiACNM=;
        b=AW98BPBrorl9HFqhKBhVARXdI8EFQoRYhbe0rU+Lm9pQsv5uwDCVSIfrfrjsM4Z6oF
         S/vU6AkGcIg5QI4cmlL2RC0mLvddOT6rADflifsmyHCY+sFY633QoJmmyPRHujQufSzJ
         wshivmsYT8zqI6dgIS68k6BlODeuC+jg2CB7kNm6lPnmysTsYdDwbJBp27Nac2x26T+M
         HCfBb2Ax2wqm9Xu2FVVUzuq4OleL0kmA2AvjSANuAAjBGpjFsTkjNlSC8/mID8i7y07z
         3+DljRumA1KgYf/j0UNwhBkALghRMSlsgArbBjWnjDs6J8MYCcGo1tjXfvJhhS6aqAOY
         7DAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Aos7KVRDO/C6OJn4w3QYdJlpwzC57/3vij3hTuiACNM=;
        b=V49TK4e5GYAwL8IxZ11/TjVGEY9Rb57GfolW704tyy47NVJKejnXtjAk366u4i888+
         4IbzdjHfLj5E4qys2vR4c4+Rgrjyxtc5JF7u/0SaDd835ryHhqdjlBj5sG2czQJUieBy
         ncleC2EtyQzm9tSgzQLYGB6quwMAMPL7uXRU6BYW+DPf+5VV7e233bByTR3kiQz00uTm
         w1jfdZxdPk2caNv4qmojkJ43TM955J/5+ZrMC7mDZIvsNG89zHk1FI8AGUn5ilUb+tpP
         wVhUYRAExkMgW09SyXha8Lk9PSnxc3DuCgJGMdBNFWJufxTytMHrJ4BxpOqDDYndAm1m
         LKYw==
X-Gm-Message-State: AOAM531W44VNJwTINdLby38mcqoUXHxTQPvYjF3+2sHcmUjeI8xaD7jM
        1WiEnhd8s/AiYLuuWGcVrbeWNg==
X-Google-Smtp-Source: ABdhPJwuFMrqeEvKhu/AMfyAokOfgrSpiKzySM4kXBNZ6OuVgRdHLd9H/qpEwZp1z1tUXKx4xeqOlw==
X-Received: by 2002:a62:75c6:0:b029:18a:d510:ff60 with SMTP id q189-20020a6275c60000b029018ad510ff60mr14844959pfc.35.1604946778471;
        Mon, 09 Nov 2020 10:32:58 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id j184sm12308821pfg.207.2020.11.09.10.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 10:32:57 -0800 (PST)
Date:   Mon, 9 Nov 2020 11:32:55 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 22/26] coresight: etm4x: Add necessary synchronization
 for sysreg access
Message-ID: <20201109183255.GA3396611@xps15>
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
 <20201028220945.3826358-24-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028220945.3826358-24-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 10:09:41PM +0000, Suzuki K Poulose wrote:
> As per the specification any update to the TRCPRGCTLR must be synchronized
> by a context synchronization event (in our case an explicist ISB) before
> the TRCSTATR is checked.
> 
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index e36bc1c722c7..4bc2f15b6332 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -178,6 +178,15 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>  	/* Disable the trace unit before programming trace registers */
>  	etm4x_relaxed_write32(csa, 0, TRCPRGCTLR);
>  
> +	/*
> +	 * If we use system instructions, we need to synchronize the
> +	 * write to the TRCPRGCTLR, before accessing the TRCSTATR.
> +	 * See ARM IHI0064F, section
> +	 * "4.3.7 Synchronization of register updates"
> +	 */
> +	if (!csa->io_mem)
> +		isb();
> +

When I first read the documentation on system instruction section 4.3.7 really
got me thinking...  

At the very top, right after the title "Synchronization of register updates" one
can read "Software running on the PE...".  Later in the text, when specifying
the synchronisation rules, the term "trace analyzer" is used.  _Typically_ a trace
analyzer is an external box.

Arm documentation is precise and usually doesn't overlook that kind of detail.
The question is to understand if a context synchronisation event is also needed
when programming is done on the PE.  If so I think the documentation should be
amended. 

In that case:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>


>  	/* wait for TRCSTATR.IDLE to go up */
>  	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_IDLE_BIT, 1))
>  		dev_err(etm_dev,
> @@ -256,6 +265,10 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>  	/* Enable the trace unit */
>  	etm4x_relaxed_write32(csa, 1, TRCPRGCTLR);
>  
> +	/* Synchronize the register updates for sysreg access */
> +	if (!csa->io_mem)
> +		isb();
> +
>  	/* wait for TRCSTATR.IDLE to go back down to '0' */
>  	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_IDLE_BIT, 0))
>  		dev_err(etm_dev,
> -- 
> 2.24.1
> 
