Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5316327B1FF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgI1Qfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgI1QfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:35:24 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF06C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:22 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id n14so1519882pff.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O73kpBGGK8HOLylKY/q0Q1ivmjbxjRv7jyp1mVZ/xfA=;
        b=JjHQyvZem5pU93PCTLoPYqqGDRIMNVni4NYVyaBvYticDEgRkRpfWMdh/C+HAoe/Ve
         Tk24YuFhl2Tpf8La/RCfOlFcwklF+W1URx+BIYHWADuL+YtCfG1bTOjEUjDpvgIxPUtf
         WailIZkMRWt3+Kz0f99o+jzPVw63mrlEsir/DIIdFBKUawlGxKH4CNPqPEw7FvYB6nAz
         kWEuJtHWVvFceqismX3cvXZk0b+r+5ZIOhtqeu3dQhuJ2tUrRsLIA/8kdEbCsUauioD6
         7ki0e/+DpMq+IhCmKSiSeLxU2MvH85Bpb4ZVykPLSXWLNby43yW1vVwuQqbHWE/RumWl
         t1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O73kpBGGK8HOLylKY/q0Q1ivmjbxjRv7jyp1mVZ/xfA=;
        b=tbNy18LLGEcc01G7lJJ5ylFBlNS8iB2lu7TffCQwyLllsIcgrCTwAwA19PD+mjpmpY
         TbNLP1dGulcI+FwbH9OGUKPpDbtRQ5qVO/WdgPt00MKVP3oAsEt5ec9xNii/2Kri0Por
         Q/DcBg+QBoscLRhC+zCB8J8H/G4M1quopng/oRTs+lfjaEmbJfPz3kJTVHfFtTaBK01B
         MGPFeh3U8+5MjOwMCMETryYlyCfLYO6y/2txJoCKPIx1ESKa4zF6B2z6YFS+HZ+Vg0kI
         7AeedxEXX1RunKZTHi+MXnmbZMDcAKLWRMlEykwNtfMlFfqxLITQlTYqf0iU72JwVmvX
         oU0g==
X-Gm-Message-State: AOAM531g3EhHizgVJ2xZ8/3rSy+x5/5cl7ckIz/u6eOF7ymTL/8j511o
        ZyaTzbJceYBHITU2OtRTN93xpQ==
X-Google-Smtp-Source: ABdhPJx685Iufn2gqsCjBD//uq3ZXQDyAbAQhuKDHf1FWgHy/Qy1tzwHHREjEF87YYC8QG1UWzhaEQ==
X-Received: by 2002:aa7:8299:0:b029:142:2501:397a with SMTP id s25-20020aa782990000b02901422501397amr288654pfm.63.1601310922393;
        Mon, 28 Sep 2020 09:35:22 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id f19sm2345640pfd.45.2020.09.28.09.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 09:35:21 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/25] coresight: stm: Allow to build coresight-stm as a module
Date:   Mon, 28 Sep 2020 10:34:55 -0600
Message-Id: <20200928163513.70169-8-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928163513.70169-1-mathieu.poirier@linaro.org>
References: <20200928163513.70169-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tingwei Zhang <tingwei@codeaurora.org>

- Kconfig becomes a tristate, to allow =m
- add a stm_remove function, for module unload
- add a MODULE_DEVICE_TABLE for autoloading on boot

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Tested-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/Kconfig         |  5 ++++-
 drivers/hwtracing/coresight/coresight-stm.c | 20 +++++++++++++++++++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index 4663fd1bbffc..6433f835fc97 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -86,7 +86,7 @@ config CORESIGHT_SOURCE_ETM4X
 	  data tracing may also be available.
 
 config CORESIGHT_STM
-	bool "CoreSight System Trace Macrocell driver"
+	tristate "CoreSight System Trace Macrocell driver"
 	depends on (ARM && !(CPU_32v3 || CPU_32v4 || CPU_32v4T)) || ARM64
 	select CORESIGHT_LINKS_AND_SINKS
 	select STM
@@ -96,6 +96,9 @@ config CORESIGHT_STM
 	  logging useful software events or data coming from various entities
 	  in the system, possibly running different OSs
 
+	  To compile this driver as a module, choose M here: the
+	  module will be called coresight-stm.
+
 config CORESIGHT_CPU_DEBUG
 	tristate "CoreSight CPU Debug driver"
 	depends on ARM || ARM64
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 2ba819a47cf6..b0ad912651a9 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -951,6 +951,17 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 	return ret;
 }
 
+static int __exit stm_remove(struct amba_device *adev)
+{
+	struct stm_drvdata *drvdata = dev_get_drvdata(&adev->dev);
+
+	coresight_unregister(drvdata->csdev);
+
+	stm_unregister_device(&drvdata->stm);
+
+	return 0;
+}
+
 #ifdef CONFIG_PM
 static int stm_runtime_suspend(struct device *dev)
 {
@@ -983,6 +994,8 @@ static const struct amba_id stm_ids[] = {
 	{ 0, 0},
 };
 
+MODULE_DEVICE_TABLE(amba, stm_ids);
+
 static struct amba_driver stm_driver = {
 	.drv = {
 		.name   = "coresight-stm",
@@ -991,7 +1004,12 @@ static struct amba_driver stm_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe          = stm_probe,
+	.remove         = stm_remove,
 	.id_table	= stm_ids,
 };
 
-builtin_amba_driver(stm_driver);
+module_amba_driver(stm_driver);
+
+MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
+MODULE_DESCRIPTION("Arm CoreSight System Trace Macrocell driver");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

