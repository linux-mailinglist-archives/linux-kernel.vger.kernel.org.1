Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B96D2EEA8D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 01:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbhAHAua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 19:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbhAHAua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 19:50:30 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721D0C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 16:49:49 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id h10so5148042pfo.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 16:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bWwf6/4j4tVvES7fVpbsX1jLm+cH+7knbN6V1u2/IfA=;
        b=FuUOoESBvVMOtLaY+nWl466nPXdTItMSrURONIbA7uC2PhHdOCKZmlsGJ718BPoOuf
         OGeKnQBixA8VYW8BW133gy/wwlUnEpUp9PuuSCsnY/AGIeNKnQ/invNDLvjuIsX7xgyE
         yzoLaBELBQoiyiuYC8yDef7jRsOSTS4Z/JNj1bItsys4WHT73DPf0sOGwtSH7SLxsNYS
         a30F9IDMkGrX02gO7LIxldaN9+AtKolbUWeJevYsjs8DsSYvETLzV5DT2r2zwspPjBjl
         jLapb1iqSa3bxPj9rGlShZCnr9SArJNXHb+8aWy8jV8AWNsIl7oNCze3Na17LSNS3VlV
         r8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bWwf6/4j4tVvES7fVpbsX1jLm+cH+7knbN6V1u2/IfA=;
        b=kR6YRuY9CDGMLznSD3XDDEP/MSgMLk6zxDjJUsiDlxVdo/ackoX/Ngb4Js1PJ9RsKz
         cpuFR3+9ag62Go8JbblJ6hKawRbKAgdN0ElLG0XqsS4CFAAeyvU6imQvcJmZWby9ZXT3
         ppU8FcgwSnt7OoSsUjMS+ssx5AOrura8sj/LJEKpN+T+Pgd6B5Jl4eo7BYYVWe/R+JJZ
         j/Qzeldlk7Ckh4jdgo6WWQrcTyQLpxxk4jGQPdMTP8ogUwtyY6AHXf63Y8gpjlAaNwbp
         TlH2lJndRnmgvNhsK7X3ndoHshYCV6kbRISKCk3oEztl02EfUMVwtNEzzPY97qzn2lYe
         hN9g==
X-Gm-Message-State: AOAM533ucIdxmChKbiATg8OCYc3UAc4WOA3bZehxVum+nBjbLlLyz30h
        5TW7SXDNgDXgxQq7QNn8Uq+FbEknoDRneA==
X-Google-Smtp-Source: ABdhPJxL7i4DsWOU0fETM4nqI82E7mp5+9hr0CKEiGTdF2QrVsGhC8Tr+k1fHZg0LjBPNNyXikKJ9w==
X-Received: by 2002:a62:ac09:0:b029:1a9:dd65:2f46 with SMTP id v9-20020a62ac090000b02901a9dd652f46mr1089803pfe.15.1610066988994;
        Thu, 07 Jan 2021 16:49:48 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id t25sm7480075pgv.30.2021.01.07.16.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 16:49:48 -0800 (PST)
Date:   Thu, 7 Jan 2021 17:49:46 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, leo.yan@linaro.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com,
        liuqi115@huawei.com
Subject: Re: [PATCH v6 22/26] coresight: etm4x: Run arch feature detection on
 the CPU
Message-ID: <20210108004946.GF43045@xps15>
References: <20210107123859.674252-1-suzuki.poulose@arm.com>
 <20210107123859.674252-23-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107123859.674252-23-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 12:38:55PM +0000, Suzuki K Poulose wrote:
> As we are about to add support for system register based devices,
> we don't get an AMBA pid. So, the detection code could check
> the system registers running on the CPU to check for the architecture
> specific features. Thus we move the arch feature detection to
> run on the CPU. We cannot always read the PID from the HW (i.e even
> for AMBA devices), as the as the PID could be overridden by DT for

s/as the as the/as the

I made the change.

> broken devices. So, use the PID from AMBA layer if available.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: liuqi115@huawei.com
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 228845f6fdd8..f4fbb65b4cc1 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -60,6 +60,7 @@ static u64 etm4_get_access_type(struct etmv4_config *config);
>  static enum cpuhp_state hp_online;
>  
>  struct etm4_init_arg {
> +	unsigned int		pid;
>  	struct etmv4_drvdata	*drvdata;
>  	struct csdev_access	*csa;
>  };
> @@ -884,6 +885,8 @@ static void etm4_init_arch_data(void *info)
>  	etm4_os_unlock_csa(drvdata, csa);
>  	etm4_cs_unlock(drvdata, csa);
>  
> +	etm4_check_arch_features(drvdata, init_arg->pid);
> +
>  	/* find all capabilities of the tracing unit */
>  	etmidr0 = etm4x_relaxed_read32(csa, TRCIDR0);
>  
> @@ -1750,6 +1753,7 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
>  
>  	init_arg.drvdata = drvdata;
>  	init_arg.csa = &desc.access;
> +	init_arg.pid = etm_pid;
>  
>  	if (smp_call_function_single(drvdata->cpu,
>  				etm4_init_arch_data,  &init_arg, 1))
> @@ -1794,8 +1798,6 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
>  		drvdata->boot_enable = true;
>  	}
>  
> -	etm4_check_arch_features(drvdata, etm_pid);
> -
>  	return 0;
>  }
>  
> -- 
> 2.24.1
> 
