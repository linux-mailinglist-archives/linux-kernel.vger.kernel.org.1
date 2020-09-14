Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B0626827D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 04:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgINCRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 22:17:15 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:27753 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgINCRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 22:17:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600049831; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=D1hRyfc52WtHMpJxHxAiS1jEtfY8/MohItXtIX/3i6k=; b=mSlhfJ3vNjdgibTYd0IwNGYUJ6h1fvjjkBHbWH/gPZgU7j4R0hKEqbOPWbjycq+UOx213ygf
 cBILq2k9akz8kQWpS64u4Gmtd8xxZRtdhbMy+qZvUBAc/EilEN5zFOAqjyCqc1LdiNttXYV5
 QVMytqDmLN4IalFY1sBUbtGUgcQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f5ed2a7698ee477d1dd4af2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 14 Sep 2020 02:17:11
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 54235C43385; Mon, 14 Sep 2020 02:17:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EBFB6C433C6;
        Mon, 14 Sep 2020 02:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EBFB6C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tingweiz@codeaurora.org
Date:   Mon, 14 Sep 2020 10:17:00 +0800
From:   Tingwei Zhang <tingweiz@codeaurora.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     tingwei@codeaurora.org, mathieu.poirier@linaro.org,
        alexander.shishkin@linux.intel.com, mike.leach@linaro.org,
        tsoni@codeaurora.org, saiprakash.ranjan@codeaurora.org,
        kim.phillips@arm.com, lkp@intel.com, jinlmao@codeaurora.org,
        gregkh@linuxfoundation.org, coresight@lists.linaro.org,
        rdunlap@infradead.org, ykaukab@suse.de, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org, leo.yan@linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 14/24] coresight: allow funnel driver to be built as
 module
Message-ID: <20200914021659.GA22686@codeaurora.org>
References: <20200821034445.967-1-tingwei@codeaurora.org>
 <20200821034445.967-15-tingwei@codeaurora.org>
 <3d4bf829-abca-3f5f-fa2f-282305a9dc7a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d4bf829-abca-3f5f-fa2f-282305a9dc7a@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 13, 2020 at 09:24:52PM +0800, Suzuki K Poulose wrote:
> On 08/21/2020 04:44 AM, Tingwei Zhang wrote:
> >From: Kim Phillips <kim.phillips@arm.com>
> >
> >Allow to build coresight-funnel as module, for ease of development.
> >
> >- combine static and dynamic funnel init into single
> >   module_init/exit call
> >- add funnel_remove functions, for module unload
> >- add a MODULE_DEVICE_TABLE for autoloading on boot
> >
> >Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> >Cc: Leo Yan <leo.yan@linaro.org>
> >Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> >Cc: Randy Dunlap <rdunlap@infradead.org>
> >Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
> >Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >Cc: Russell King <linux@armlinux.org.uk>
> >Co-developed-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> >Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> >Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> >Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
> >Reported-by: kernel test robot <lkp@intel.com>
> >Tested-by: Mike Leach <mike.leach@linaro.org>
> >Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> >---
> >  .../hwtracing/coresight/coresight-funnel.c    | 64 ++++++++++++++++++-
> >  1 file changed, 62 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/hwtracing/coresight/coresight-funnel.c
> b/drivers/hwtracing/coresight/coresight-funnel.c
> >index 900690a9f7f0..07bc20391fac 100644
> >--- a/drivers/hwtracing/coresight/coresight-funnel.c
> >+++ b/drivers/hwtracing/coresight/coresight-funnel.c
> >@@ -274,6 +274,15 @@ static int funnel_probe(struct device *dev, struct
> resource *res)
> >  	return ret;
> >  }
> >+static int __exit funnel_remove(struct device *dev)
> >+{
> >+	struct funnel_drvdata *drvdata = dev_get_drvdata(dev);
> >+
> >+	coresight_unregister(drvdata->csdev);
> >+
> >+	return 0;
> >+}
> >+
> >  #ifdef CONFIG_PM
> >  static int funnel_runtime_suspend(struct device *dev)
> >  {
> >@@ -319,20 +328,32 @@ static int static_funnel_probe(struct
> platform_device *pdev)
> >  	return ret;
> >  }
> >+static int __exit static_funnel_remove(struct platform_device *pdev)
> >+{
> >+	funnel_remove(&pdev->dev);
> >+	pm_runtime_disable(&pdev->dev);
> >+	return 0;
> >+}
> >+
> >  static const struct of_device_id static_funnel_match[] = {
> >  	{.compatible = "arm,coresight-static-funnel"},
> >  	{}
> >  };
> >+MODULE_DEVICE_TABLE(of, static_funnel_match);
> >+
> >  #ifdef CONFIG_ACPI
> >  static const struct acpi_device_id static_funnel_ids[] = {
> >  	{"ARMHC9FE", 0},
> >  	{},
> >  };
> >+
> >+MODULE_DEVICE_TABLE(acpi, static_funnel_ids);
> >  #endif
> >  static struct platform_driver static_funnel_driver = {
> >  	.probe          = static_funnel_probe,
> >+	.remove          = static_funnel_remove,
> >  	.driver         = {
> >  		.name   = "coresight-static-funnel",
> >  		.of_match_table = static_funnel_match,
> 
> Sorry missed this. Please set the owner field here. With that :
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>
Thanks, Suzuki. I'll add owner in v11.

Thanks,
Tingwei 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
