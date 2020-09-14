Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D7E268283
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 04:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgINCVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 22:21:20 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:35074 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725965AbgINCVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 22:21:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600050075; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=YR2CY8Aoc5W8KKHnf5cqCmesLaHWMxeTt/MPPHRHUhg=; b=PFCu5VB2x2kbmDUc8mnQKRblSZtptsseFXAT41Pm7V8N8k+31HBGpF0tIyajqF0+FkrxnEtq
 k4+maB3NyFIUKEGXrf7nAa7EQEtfDaIXquQT35sfD3XGF6wEkIcVM1Wqcar0ll8LZNRE59IC
 rAp5iB8uI3rpkJOAkBeRDOziWj0=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f5ed338d7b4e269139cd2b9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 14 Sep 2020 02:19:36
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BB24EC43387; Mon, 14 Sep 2020 02:19:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 46145C433CA;
        Mon, 14 Sep 2020 02:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 46145C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tingweiz@codeaurora.org
Date:   Mon, 14 Sep 2020 10:19:28 +0800
From:   Tingwei Zhang <tingweiz@codeaurora.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     tingwei@codeaurora.org, mathieu.poirier@linaro.org,
        alexander.shishkin@linux.intel.com, mike.leach@linaro.org,
        tsoni@codeaurora.org, saiprakash.ranjan@codeaurora.org,
        kim.phillips@arm.com, jinlmao@codeaurora.org,
        gregkh@linuxfoundation.org, coresight@lists.linaro.org,
        rdunlap@infradead.org, ykaukab@suse.de, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org, leo.yan@linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 09/24] coresight: etm3x: allow etm3x to be built as a
 module
Message-ID: <20200914021927.GB22686@codeaurora.org>
References: <20200821034445.967-1-tingwei@codeaurora.org>
 <20200821034445.967-10-tingwei@codeaurora.org>
 <0c2abd02-4fe6-5eaa-e9d3-41811f062ac1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c2abd02-4fe6-5eaa-e9d3-41811f062ac1@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 13, 2020 at 09:17:05PM +0800, Suzuki K Poulose wrote:
> On 08/21/2020 04:44 AM, Tingwei Zhang wrote:
> >From: Kim Phillips <kim.phillips@arm.com>
> >
> >Allow to build coresight-etm3x as a module, for ease of development.
> >
> >- Kconfig becomes a tristate, to allow =m
> >- append -core to source file name to allow module to
> >   be called coresight-etm3x by the Makefile
> >- add an etm_remove function, for module unload
> >- add a MODULE_DEVICE_TABLE for autoloading on boot
> >
> >Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> >Cc: Leo Yan <leo.yan@linaro.org>
> >Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> >Cc: Randy Dunlap <rdunlap@infradead.org>
> >Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
> >Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >Cc: Russell King <linux@armlinux.org.uk>
> >Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> >Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
> >Reviewed-by: Mike Leach <mike.leach@linaro.org>
> 
> 
> >diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c
> b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> >similarity index 97%
> >rename from drivers/hwtracing/coresight/coresight-etm3x.c
> >rename to drivers/hwtracing/coresight/coresight-etm3x-core.c
> >index bf22dcfd3327..ba9c86497acb 100644
> >--- a/drivers/hwtracing/coresight/coresight-etm3x.c
> >+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> >@@ -895,6 +895,23 @@ static int etm_probe(struct amba_device *adev,
> const struct amba_id *id)
> >  	return ret;
> >  }
> >+static int __exit etm_remove(struct amba_device *adev)
> >+{
> >+	struct etm_drvdata *drvdata = dev_get_drvdata(&adev->dev);
> >+
> >+	etm_perf_symlink(drvdata->csdev, false);
> >+
> >+	if (--etm_count == 0) {
> >+
> cpuhp_remove_state_nocalls(CPUHP_AP_ARM_CORESIGHT_STARTING);
> >+		if (hp_online)
> >+			cpuhp_remove_state_nocalls(hp_online);
> >+	}
> >+
> >+	coresight_unregister(drvdata->csdev);
> >+
> >+	return 0;
> >+}
> >+
> 
> Don't we need to fix the races like we did for ETMv4 ?
> 
> Suzuki
> 
Yes, we need that.  Unfortunately, I don't have ETMv3 devie to verify the
change.  Mathieu has been very kind to offer his help to take care of
ETMv3.

Thanks,
Tingwei
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
