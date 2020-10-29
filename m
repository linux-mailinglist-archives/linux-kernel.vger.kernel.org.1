Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1A429F183
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgJ2Qbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbgJ2QaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:30:21 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B36C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:30:21 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id z1so1529609plo.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vcHK4825w50DBTSha+e++zZ+jcuoIRUk3Irih8jfEF8=;
        b=JbVh5KljJKPssEnSLGiN5zJB+T0YkdkDMs9rznkEcHglOK2pfptGo+wZrZZ2GYGpdd
         ppxCPrxB/jaQGj3vtvIFoDqW6VxCQR8u0JWWMJayiuuBWGOFEXOV+Hv6dX3fOiJYKGrD
         sRnPilkjkOXtqRIfWFXgO8h5q9sg5unQk/nJjwq5j6Q4HaXpAFASI82siftX1imeoO7c
         xqFClt4mW1nrAI48OW6A3lzoyvjNHPn+Ukz+g9fZMt+33nCOhl0ZSG50FZvRMXSdE7HB
         7AzBKcnUnP5XDGMjOqDK5iFLHe7tS0LfHwnZXqLxWN0Mtna3v3xa/ux7b24dTl/cvFsJ
         Pjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vcHK4825w50DBTSha+e++zZ+jcuoIRUk3Irih8jfEF8=;
        b=UBfI6H12Ymggg0tJfl7wvOUa7gvk6hxTIq4FvU1zOFvWQAZLlUjTgWXlkDlOJWyqYV
         AGJuVH5cIAu+jzIIZ98od2GKDOAB7Owdfw6nxxcx1A5c+gHjm3L3fire+p/tT0MvDIgG
         7PnSG8cQMrvRhEm1QYEVI0k0aQmXafHcGyvj6u086ap2ntvajeK8Xl6kibIIUM7jpWfq
         imYrURZakEd1ehyOC/hYmr2hwEPE3yBW6kS4d00UuIlxMX0WQw+qOP3YOaVuERZ3O2ib
         YZ82W1FDB9UFPPvNgW05OoCCXSp7cIMbLOVCod/jUSuFGyM5mIwQ3XwS84N36xvx0Mw8
         aLmQ==
X-Gm-Message-State: AOAM531PpOZaLS/og+2xxg/HHMhrBYQ8WUrHC5r2AGKlgXW+TRDomrPU
        eMVSZRbh/DxVRH1y2OP/Nv+3rA==
X-Google-Smtp-Source: ABdhPJx2zoXJSVcH/cAX+n8ggt5fWcT6jJMKyX2fGiFI7NZ/eP1D68Jb9IerKmhJz/LrryNhnIaiuA==
X-Received: by 2002:a17:902:a60c:b029:d5:dc92:a1ca with SMTP id u12-20020a170902a60cb02900d5dc92a1camr5074295plq.16.1603989020646;
        Thu, 29 Oct 2020 09:30:20 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id w19sm3567260pff.6.2020.10.29.09.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 09:30:19 -0700 (PDT)
Date:   Thu, 29 Oct 2020 10:30:17 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
        alexander.shishkin@linux.intel.com, lcherian@marvell.com
Subject: Re: [PATCH] coresight: Fix uninitialised pointer bug in
 etm_setup_aux()
Message-ID: <20201029163017.GA1267404@xps15>
References: <20201028174301.15033-1-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028174301.15033-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 05:43:01PM +0000, Mike Leach wrote:
> Commit [bb1860efc817] changed the sink handling code introducing an
> uninitialised pointer bug. This results in the default sink selection
> failing.
> 
> Prior to commit:
> 
> static void etm_setup_aux(...)
> 
> <snip>
>         struct coresight_device *sink;
> <snip>
> 
>         /* First get the selected sink from user space. */
>         if (event->attr.config2) {
>                 id = (u32)event->attr.config2;
>                 sink = coresight_get_sink_by_id(id);
>         } else {
>                 sink = coresight_get_enabled_sink(true);
>         }
> <ctd>
> 
> *sink always initialised - possibly to NULL which triggers the
> automatic sink selection.
> 
> After commit:
> 
> static void etm_setup_aux(...)
> 
> <snip>
>         struct coresight_device *sink;
> <snip>
> 
>         /* First get the selected sink from user space. */
>         if (event->attr.config2) {
>                 id = (u32)event->attr.config2;
>                 sink = coresight_get_sink_by_id(id);
>         }
> <ctd>
> 
> *sink pointer uninitialised when not providing a sink on the perf command
> line. This breaks later checks to enable automatic sink selection.
> 
> Fixes [bb1860efc817] ("coresight: etm: perf: Sink selection using sysfs is deprecated")
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-etm-perf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index c2c9b127d074..bdc34ca449f7 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -210,7 +210,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>  	u32 id;
>  	int cpu = event->cpu;
>  	cpumask_t *mask;
> -	struct coresight_device *sink;
> +	struct coresight_device *sink = NULL;

Yes, obviously - thanks for catching that.

As checkpatch has complained about, the Fixes line you added isn't correct.  It
should have been:

Fixes: bb1860efc817 ("coresight: etm: perf: Sink selection using sysfs is deprecated")

I made the modification and applied to my tree.

Thanks,
Mathieu

>  	struct etm_event_data *event_data = NULL;
>  
>  	event_data = alloc_event_data(cpu);
> -- 
> 2.17.1
> 
