Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4D3269095
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 17:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgINPru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 11:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgINPpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:45:17 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F5BC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 08:45:17 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z19so12961434pfn.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 08:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/eV1+kFX5j6l4A7G4UXNGix1Gqkh7mTO0zqJxtAgte8=;
        b=BRcom2km1V1p1iqSvEt9daBCWYvxDEBP2xMOAxm6zhNJ3dpHgMyDRoHqGqs/gCmWCU
         dmsMSVaLXAFqFnRCf3QPlsCCLbSh7ShUoGbIYG6Q/9mxRnkILBt4XbPJPCYp0CvCGMej
         Co/uea1pXfMsK62HFidPkg39WecwDOcAefTvUWBAlYqvrI6ptOFU2LAiERcck+I1wAcN
         bTKj+OIe3KPsL4sutC+2zv2hnVRBxaeQ0HpLByuD09fifEyAV3+vG2Pz6E0mOA2a6Osf
         PBC9V4Kz2+1tET/NDaaI1SIDQDSjkcTjslfssRxA4ppXpsTEVUBssFpz7MnAXhuI5Jvc
         yo3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/eV1+kFX5j6l4A7G4UXNGix1Gqkh7mTO0zqJxtAgte8=;
        b=KGsvNDsXByD1eRU3DRkJZwoOt8Te6kbbfXU6Z6aNbWb8gu16oSd1K/QfvfFImX0rER
         tCkOroRXn/Vt8SG2rThMhJbKSfqoMiSYQDOlrA7QjXKInVkUB85OOJDVZMQqk1x6ACKz
         mSrR1vGsdYUVizoyp/zUmbJwtRzW9XOjsUP+c8wWMSkpWMoOjCI3El94zhibnz6szlXL
         Eq/nPQwShfRceVkeGyFsIXvBCXmWi3zLgoNX/rCXSWrIWiIiicyf/Dstmu3vQeKgNXT3
         o9ojYTQhLtPjE3lQP4VZMgyBMMjChosMn3GkYXIozxmFB7k2hwJVOlJbXU4LtilFFM+T
         /3SA==
X-Gm-Message-State: AOAM530xhb/F+kESCXGbvJyTb25FxCJefubGnwg6ZVgjzrGB1ZXZI58y
        9pTV4zkAkymCUS24ifJF0DlvKg==
X-Google-Smtp-Source: ABdhPJyLXR+26NTuHvBpZLGO8w1ekklGuKBLniOMo6i4BD7QY8X/AijX/tFW2farr7WpR7hnDVNPAQ==
X-Received: by 2002:a63:d04b:: with SMTP id s11mr11086355pgi.241.1600098316782;
        Mon, 14 Sep 2020 08:45:16 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id s16sm8841083pgl.78.2020.09.14.08.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 08:45:16 -0700 (PDT)
Date:   Mon, 14 Sep 2020 09:45:13 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tingwei Zhang <tingweiz@codeaurora.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>, tingwei@codeaurora.org,
        alexander.shishkin@linux.intel.com, mike.leach@linaro.org,
        tsoni@codeaurora.org, saiprakash.ranjan@codeaurora.org,
        kim.phillips@arm.com, jinlmao@codeaurora.org,
        gregkh@linuxfoundation.org, coresight@lists.linaro.org,
        rdunlap@infradead.org, ykaukab@suse.de, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org, leo.yan@linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 09/24] coresight: etm3x: allow etm3x to be built as a
 module
Message-ID: <20200914154513.GA3238264@xps15>
References: <20200821034445.967-1-tingwei@codeaurora.org>
 <20200821034445.967-10-tingwei@codeaurora.org>
 <0c2abd02-4fe6-5eaa-e9d3-41811f062ac1@arm.com>
 <20200914021927.GB22686@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914021927.GB22686@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 10:19:28AM +0800, Tingwei Zhang wrote:
> On Sun, Sep 13, 2020 at 09:17:05PM +0800, Suzuki K Poulose wrote:
> > On 08/21/2020 04:44 AM, Tingwei Zhang wrote:
> > >From: Kim Phillips <kim.phillips@arm.com>
> > >
> > >Allow to build coresight-etm3x as a module, for ease of development.
> > >
> > >- Kconfig becomes a tristate, to allow =m
> > >- append -core to source file name to allow module to
> > >   be called coresight-etm3x by the Makefile
> > >- add an etm_remove function, for module unload
> > >- add a MODULE_DEVICE_TABLE for autoloading on boot
> > >
> > >Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > >Cc: Leo Yan <leo.yan@linaro.org>
> > >Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > >Cc: Randy Dunlap <rdunlap@infradead.org>
> > >Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
> > >Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >Cc: Russell King <linux@armlinux.org.uk>
> > >Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> > >Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
> > >Reviewed-by: Mike Leach <mike.leach@linaro.org>
> > 
> > 
> > >diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c
> > b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> > >similarity index 97%
> > >rename from drivers/hwtracing/coresight/coresight-etm3x.c
> > >rename to drivers/hwtracing/coresight/coresight-etm3x-core.c
> > >index bf22dcfd3327..ba9c86497acb 100644
> > >--- a/drivers/hwtracing/coresight/coresight-etm3x.c
> > >+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> > >@@ -895,6 +895,23 @@ static int etm_probe(struct amba_device *adev,
> > const struct amba_id *id)
> > >  	return ret;
> > >  }
> > >+static int __exit etm_remove(struct amba_device *adev)
> > >+{
> > >+	struct etm_drvdata *drvdata = dev_get_drvdata(&adev->dev);
> > >+
> > >+	etm_perf_symlink(drvdata->csdev, false);
> > >+
> > >+	if (--etm_count == 0) {
> > >+
> > cpuhp_remove_state_nocalls(CPUHP_AP_ARM_CORESIGHT_STARTING);
> > >+		if (hp_online)
> > >+			cpuhp_remove_state_nocalls(hp_online);
> > >+	}
> > >+
> > >+	coresight_unregister(drvdata->csdev);
> > >+
> > >+	return 0;
> > >+}
> > >+
> > 
> > Don't we need to fix the races like we did for ETMv4 ?
> > 
> > Suzuki
> > 
> Yes, we need that.  Unfortunately, I don't have ETMv3 devie to verify the
> change.  Mathieu has been very kind to offer his help to take care of
> ETMv3.

Correct - I will do the testing but the implementation still has to come from
you.

> 
> Thanks,
> Tingwei
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
