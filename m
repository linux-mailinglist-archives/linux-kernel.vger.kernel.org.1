Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC3426948B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 20:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgINSMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 14:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgINSLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 14:11:44 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC880C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 11:11:43 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id c196so282326pfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 11:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=luFapq4yAWnCh7gOtzb0s4k6GBMzLQ8znDPJIALRzIo=;
        b=zA+3jq+1Hh4VmiPiah+gMCdRVVajSsyvGlrNdRoP/xsQe2jec1OxYNoyEF/2ef5uT3
         nVG2hbzdNP0uT2eclJt1AUw7b5zvZs0ggTMDrFo1edgHFGeHtxIZvNpvL9p1tA0+4hA2
         lJwQZEp/3C1FN/a8P7ZhVP8Be+Z/H2OpkPH9j0zO5NVG9r7+A7duyT3Fw7WSoBf5encB
         eVvt7fWZ5G3uWUXu3BRkjSwiFXQJmJ+5BGsrAnGONfqBbb+icZWbX2NKyhTQc7aOPTpT
         KdJAaLOAkFEHW9qo7mp4azWEtIrA4eY/+HmGiuR93/S1zZGo9eVlLpiQhebu6dFVFZ6w
         wTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=luFapq4yAWnCh7gOtzb0s4k6GBMzLQ8znDPJIALRzIo=;
        b=G5N94WBPpV09JmkAPM7wD6zmfsHKfnG405wpB3/v9sPlL920QiNxUoyC7J7of6Sse1
         ecjx/tKIiHdSUtOGC3yYXcxFONjUnv/3Im+2wQJQaHisGvono2IL7Dw9yIUGj7NLANmY
         SCVlDlJ//uuFvl8/5HNtzcLKTVgTGJcBjb3A6JVo1eSZ0AWILclVGqyeoxwDR8tnmpej
         Dc08qHOaghX/w/zMQzDpVlRkdbH43Dr1bfxQ3M11CyE0PBf/XU6nDPSrsRf6zrYwVyw+
         uantrKi1GMg6EVPSCNj+J6DN866rj/e+etplzmDxt5321R9l+O4z7vniqZZg8kJkJ3JD
         tyXg==
X-Gm-Message-State: AOAM5337FQphH0BufY+gqQhQY/76+ngFLHejyuXtUNjZ5wLrDhfK1KG4
        J+7ogcsT5B4iplUQ+xmDe0u9fw==
X-Google-Smtp-Source: ABdhPJyjDBiZiomw9v+dab/SIgwqqqddv11VHrmH3pw8Tb1URCEEbZec5yn7uyiyDsXxd8fEfZeNzA==
X-Received: by 2002:a05:6a00:1356:b029:13e:d13d:a084 with SMTP id k22-20020a056a001356b029013ed13da084mr14544516pfu.27.1600107103411;
        Mon, 14 Sep 2020 11:11:43 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id x20sm11052073pfr.190.2020.09.14.11.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 11:11:42 -0700 (PDT)
Date:   Mon, 14 Sep 2020 12:11:40 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     tingwei@codeaurora.org, alexander.shishkin@linux.intel.com,
        mike.leach@linaro.org, kim.phillips@arm.com,
        gregkh@linuxfoundation.org, leo.yan@linaro.org,
        rdunlap@infradead.org, linux@armlinux.org.uk, ykaukab@suse.de,
        tsoni@codeaurora.org, saiprakash.ranjan@codeaurora.org,
        jinlmao@codeaurora.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 09/24] coresight: etm3x: allow etm3x to be built as a
 module
Message-ID: <20200914181140.GD3238264@xps15>
References: <20200821034445.967-1-tingwei@codeaurora.org>
 <20200821034445.967-10-tingwei@codeaurora.org>
 <0c2abd02-4fe6-5eaa-e9d3-41811f062ac1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c2abd02-4fe6-5eaa-e9d3-41811f062ac1@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 13, 2020 at 02:17:05PM +0100, Suzuki K Poulose wrote:
> On 08/21/2020 04:44 AM, Tingwei Zhang wrote:
> > From: Kim Phillips <kim.phillips@arm.com>
> > 
> > Allow to build coresight-etm3x as a module, for ease of development.
> > 
> > - Kconfig becomes a tristate, to allow =m
> > - append -core to source file name to allow module to
> >    be called coresight-etm3x by the Makefile
> > - add an etm_remove function, for module unload
> > - add a MODULE_DEVICE_TABLE for autoloading on boot
> > 
> > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Cc: Leo Yan <leo.yan@linaro.org>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> > Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
> > Reviewed-by: Mike Leach <mike.leach@linaro.org>
> 
> 
> > diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> > similarity index 97%
> > rename from drivers/hwtracing/coresight/coresight-etm3x.c
> > rename to drivers/hwtracing/coresight/coresight-etm3x-core.c
> > index bf22dcfd3327..ba9c86497acb 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm3x.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> > @@ -895,6 +895,23 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
> >   	return ret;
> >   }
> > +static int __exit etm_remove(struct amba_device *adev)
> > +{
> > +	struct etm_drvdata *drvdata = dev_get_drvdata(&adev->dev);
> > +
> > +	etm_perf_symlink(drvdata->csdev, false);
> > +
> > +	if (--etm_count == 0) {
> > +		cpuhp_remove_state_nocalls(CPUHP_AP_ARM_CORESIGHT_STARTING);
> > +		if (hp_online)
> > +			cpuhp_remove_state_nocalls(hp_online);
> > +	}
> > +
> > +	coresight_unregister(drvdata->csdev);
> > +
> > +	return 0;
> > +}
> > +
> 
> Don't we need to fix the races like we did for ETMv4 ?

This is one of the things I wanted to get back to but Suzuki beat me to it.

I am now done reviewing this set.

Thanks,
Mathieu

> 
> Suzuki
