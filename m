Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F24D2CF408
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 19:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730256AbgLDS2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 13:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgLDS2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 13:28:35 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242BCC0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 10:27:55 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id e5so3600274pjt.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 10:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UiBa8wrmmIee1HgOai5JrghjADTpG0X/oWxIh9/BKcM=;
        b=R3szqApXOzhleqO5LbirR5gKIfTfm8VKz55yhE0zOFyg0zKv+hipO3Rx2b1V5cFtKC
         Hy5c1vRajoueHiyvN18vwiD8vCBxHVBLuhiZ9/2l3fA7/ROpImr/w+De57U0KYMNZSRw
         0taFxcw3rDis/hHIjNspHR+/I0A8nmMiOVDpD4R7rWoyrtbo/EZE2XNbKYUSOdTc0qBK
         SoFJzg9VLjNUSiJHgn2BH+QUMCNNbRrFWfPpm3JbSPfiHOfxFzcUfzMw66LoAFtXQhou
         PM6i6G9WyXv2xr7mgOy76z68oFUfXisN9MsiInrfm3DrRZWx0ClbypPm/vP/s2dii8B8
         HKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UiBa8wrmmIee1HgOai5JrghjADTpG0X/oWxIh9/BKcM=;
        b=g2uFEZZd7ow+OvkcNOFbAF9ox8AJj4VcDYh27QDlHbIz+ypW8hNzoz1TYH8iGn4sHE
         NDguEmkGc3LGkwO+A3FuVIzlLo9KBNjxK2gXaIRAQipvpGXYZKvCLQBAGLUsjgRYCw99
         YRhZ/5uc2oQ4DPAErsscUHgqT6GCo7O+MaPtNAF3mCDU/IvisLYOSfzwmxMXk6iraY1U
         XhOhPFXWpHH3+B2ZsBx4WnteUorQTuuxgP32ImQSugqDNoxgJSA7xSAmG4pqqJdEHbbI
         nNgSS7BAd0VDN9zpDWcmVPfH8YQ5DokYBQxTSYHCVoqESiUjusZvX/oxJjD00bsNM5B7
         EOpw==
X-Gm-Message-State: AOAM530CuYXeDRF/3FbylRLrJbn5Z/1cXwiID/muZkHM312yxwMJJHkn
        1pjXd8d7w0dPgFyx0CjUUNv4+A==
X-Google-Smtp-Source: ABdhPJwjVB3oS+U5cw5V+eL+8QbuK3M+h2Ct8oaf9k7GFRKPKFNbm4X73N4XxlNifkH+lzTIfd37XA==
X-Received: by 2002:a17:90a:bd16:: with SMTP id y22mr5127131pjr.203.1607106474631;
        Fri, 04 Dec 2020 10:27:54 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id i16sm5543737pfr.183.2020.12.04.10.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 10:27:54 -0800 (PST)
Date:   Fri, 4 Dec 2020 11:27:51 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mian Yousaf Kaukab <ykaukab@suse.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] coresight: remove broken __exit annotations
Message-ID: <20201204182751.GA1424711@xps15>
References: <20201203231232.1482792-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203231232.1482792-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 12:11:40AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Functions that are annotated __exit are discarded for built-in drivers,
> but the .remove callback in a device driver must still be kept around
> to allow bind/unbind operations.
> 
> There is now a linker warning for the discarded symbol references:
> 
> `tmc_remove' referenced in section `.data' of drivers/hwtracing/coresight/coresight-tmc-core.o: defined in discarded section `.exit.text' of drivers/hwtracing/coresight/coresight-tmc-core.o
> `tpiu_remove' referenced in section `.data' of drivers/hwtracing/coresight/coresight-tpiu.o: defined in discarded section `.exit.text' of drivers/hwtracing/coresight/coresight-tpiu.o
> `etb_remove' referenced in section `.data' of drivers/hwtracing/coresight/coresight-etb10.o: defined in discarded section `.exit.text' of drivers/hwtracing/coresight/coresight-etb10.o
> `static_funnel_remove' referenced in section `.data' of drivers/hwtracing/coresight/coresight-funnel.o: defined in discarded section `.exit.text' of drivers/hwtracing/coresight/coresight-funnel.o
> `dynamic_funnel_remove' referenced in section `.data' of drivers/hwtracing/coresight/coresight-funnel.o: defined in discarded section `.exit.text' of drivers/hwtracing/coresight/coresight-funnel.o
> `static_replicator_remove' referenced in section `.data' of drivers/hwtracing/coresight/coresight-replicator.o: defined in discarded section `.exit.text' of drivers/hwtracing/coresight/coresight-replicator.o
> `dynamic_replicator_remove' referenced in section `.data' of drivers/hwtracing/coresight/coresight-replicator.o: defined in discarded section `.exit.text' of drivers/hwtracing/coresight/coresight-replicator.o
> `catu_remove' referenced in section `.data' of drivers/hwtracing/coresight/coresight-catu.o: defined in discarded section `.exit.text' of drivers/hwtracing/coresight/coresight-catu.o
> 
> Remove all those annotations.
> 
> Fixes: 8b0cf82677d1 ("coresight: stm: Allow to build coresight-stm as a module")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I have applied this patch.

> ---
>  drivers/hwtracing/coresight/coresight-catu.c       | 2 +-
>  drivers/hwtracing/coresight/coresight-cti-core.c   | 2 +-
>  drivers/hwtracing/coresight/coresight-etb10.c      | 2 +-
>  drivers/hwtracing/coresight/coresight-etm3x-core.c | 4 ++--
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 4 ++--
>  drivers/hwtracing/coresight/coresight-funnel.c     | 6 +++---
>  drivers/hwtracing/coresight/coresight-replicator.c | 6 +++---
>  drivers/hwtracing/coresight/coresight-stm.c        | 2 +-
>  drivers/hwtracing/coresight/coresight-tmc-core.c   | 2 +-
>  drivers/hwtracing/coresight/coresight-tpiu.c       | 2 +-
>  10 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
> index 99430f6cf5a5..a61313f320bd 100644
> --- a/drivers/hwtracing/coresight/coresight-catu.c
> +++ b/drivers/hwtracing/coresight/coresight-catu.c
> @@ -567,7 +567,7 @@ static int catu_probe(struct amba_device *adev, const struct amba_id *id)
>  	return ret;
>  }
>  
> -static int __exit catu_remove(struct amba_device *adev)
> +static int catu_remove(struct amba_device *adev)
>  {
>  	struct catu_drvdata *drvdata = dev_get_drvdata(&adev->dev);
>  
> diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/hwtracing/coresight/coresight-cti-core.c
> index d28eae93e55c..61dbc1afd8da 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-core.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-core.c
> @@ -836,7 +836,7 @@ static void cti_device_release(struct device *dev)
>  	if (drvdata->csdev_release)
>  		drvdata->csdev_release(dev);
>  }
> -static int __exit cti_remove(struct amba_device *adev)
> +static int cti_remove(struct amba_device *adev)
>  {
>  	struct cti_drvdata *drvdata = dev_get_drvdata(&adev->dev);
>  
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index 1b320ab581ca..0cf6f0b947b6 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -803,7 +803,7 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
>  	return ret;
>  }
>  
> -static int __exit etb_remove(struct amba_device *adev)
> +static int etb_remove(struct amba_device *adev)
>  {
>  	struct etb_drvdata *drvdata = dev_get_drvdata(&adev->dev);
>  
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> index 47f610b1c2b1..5bf5a5a4ce6d 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> @@ -902,14 +902,14 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
>  	return 0;
>  }
>  
> -static void __exit clear_etmdrvdata(void *info)
> +static void clear_etmdrvdata(void *info)
>  {
>  	int cpu = *(int *)info;
>  
>  	etmdrvdata[cpu] = NULL;
>  }
>  
> -static int __exit etm_remove(struct amba_device *adev)
> +static int etm_remove(struct amba_device *adev)
>  {
>  	struct etm_drvdata *drvdata = dev_get_drvdata(&adev->dev);
>  
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index d78a37b6592c..3ad5c2a01033 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -1575,14 +1575,14 @@ static struct amba_cs_uci_id uci_id_etm4[] = {
>  	}
>  };
>  
> -static void __exit clear_etmdrvdata(void *info)
> +static void clear_etmdrvdata(void *info)
>  {
>  	int cpu = *(int *)info;
>  
>  	etmdrvdata[cpu] = NULL;
>  }
>  
> -static int __exit etm4_remove(struct amba_device *adev)
> +static int etm4_remove(struct amba_device *adev)
>  {
>  	struct etmv4_drvdata *drvdata = dev_get_drvdata(&adev->dev);
>  
> diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
> index 39be46b74dfe..071c723227db 100644
> --- a/drivers/hwtracing/coresight/coresight-funnel.c
> +++ b/drivers/hwtracing/coresight/coresight-funnel.c
> @@ -274,7 +274,7 @@ static int funnel_probe(struct device *dev, struct resource *res)
>  	return ret;
>  }
>  
> -static int __exit funnel_remove(struct device *dev)
> +static int funnel_remove(struct device *dev)
>  {
>  	struct funnel_drvdata *drvdata = dev_get_drvdata(dev);
>  
> @@ -328,7 +328,7 @@ static int static_funnel_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int __exit static_funnel_remove(struct platform_device *pdev)
> +static int static_funnel_remove(struct platform_device *pdev)
>  {
>  	funnel_remove(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> @@ -370,7 +370,7 @@ static int dynamic_funnel_probe(struct amba_device *adev,
>  	return funnel_probe(&adev->dev, &adev->res);
>  }
>  
> -static int __exit dynamic_funnel_remove(struct amba_device *adev)
> +static int dynamic_funnel_remove(struct amba_device *adev)
>  {
>  	return funnel_remove(&adev->dev);
>  }
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index 6772f23e5c4b..7e2a2b7f503f 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -291,7 +291,7 @@ static int replicator_probe(struct device *dev, struct resource *res)
>  	return ret;
>  }
>  
> -static int __exit replicator_remove(struct device *dev)
> +static int replicator_remove(struct device *dev)
>  {
>  	struct replicator_drvdata *drvdata = dev_get_drvdata(dev);
>  
> @@ -318,7 +318,7 @@ static int static_replicator_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int __exit static_replicator_remove(struct platform_device *pdev)
> +static int static_replicator_remove(struct platform_device *pdev)
>  {
>  	replicator_remove(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> @@ -388,7 +388,7 @@ static int dynamic_replicator_probe(struct amba_device *adev,
>  	return replicator_probe(&adev->dev, &adev->res);
>  }
>  
> -static int __exit dynamic_replicator_remove(struct amba_device *adev)
> +static int dynamic_replicator_remove(struct amba_device *adev)
>  {
>  	return replicator_remove(&adev->dev);
>  }
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index 32d29704206b..99791773f682 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -951,7 +951,7 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>  	return ret;
>  }
>  
> -static int __exit stm_remove(struct amba_device *adev)
> +static int stm_remove(struct amba_device *adev)
>  {
>  	struct stm_drvdata *drvdata = dev_get_drvdata(&adev->dev);
>  
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
> index 5653e0945c74..8169dff5a9f6 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> @@ -559,7 +559,7 @@ static void tmc_shutdown(struct amba_device *adev)
>  	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>  }
>  
> -static int __exit tmc_remove(struct amba_device *adev)
> +static int tmc_remove(struct amba_device *adev)
>  {
>  	struct tmc_drvdata *drvdata = dev_get_drvdata(&adev->dev);
>  
> diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
> index 010762a46087..d5dfee9ee556 100644
> --- a/drivers/hwtracing/coresight/coresight-tpiu.c
> +++ b/drivers/hwtracing/coresight/coresight-tpiu.c
> @@ -173,7 +173,7 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
>  	return PTR_ERR(drvdata->csdev);
>  }
>  
> -static int __exit tpiu_remove(struct amba_device *adev)
> +static int tpiu_remove(struct amba_device *adev)
>  {
>  	struct tpiu_drvdata *drvdata = dev_get_drvdata(&adev->dev);
>  
> -- 
> 2.27.0
> 
