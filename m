Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4CCB26A39A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 12:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgIOKuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 06:50:05 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:32275 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726344AbgIOKnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 06:43:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600166628; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=M5/xXu6HYlgRATMJNeIelorJ8LLk4BCwPkBuu8u1x7Y=; b=GNNtG70oHCC9pkMtroal5ZHbuxDUd7lbiINVkwWaP8pTQiNhnqr20RmY4caUQSnGBR9O4euA
 DIVHB7pRtyVekB2c38LWF/yNIJmuQNn542uNh8YRrBjPeGvlTNGzdfG53sFIBJ+IAurUpSJb
 3hwwYyVxySAf9nktq76oGWGF9gA=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f609ae3d3d3df8c39c27143 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Sep 2020 10:43:47
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1C9E7C433FE; Tue, 15 Sep 2020 10:43:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CA7D9C43385;
        Tue, 15 Sep 2020 10:43:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CA7D9C43385
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tingwei@codeaurora.org
From:   Tingwei Zhang <tingwei@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leo Yan <leo.yan@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Kim Phillips <kim.phillips@arm.com>,
        Mian Yousaf Kaukab <ykaukab@suse.de>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v11 23/24] coresight: catu: allow catu drivers to be built as modules
Date:   Tue, 15 Sep 2020 18:41:15 +0800
Message-Id: <20200915104116.16789-24-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200915104116.16789-1-tingwei@codeaurora.org>
References: <20200915104116.16789-1-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to build coresight-catu as modules, for ease of development.
- Kconfig becomes a tristate, to allow =m
- add catu_remove functions, for module unload
- add a MODULE_DEVICE_TABLE for autoloading on boot

Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/Kconfig          |  5 ++++-
 drivers/hwtracing/coresight/coresight-catu.c | 15 +++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index b04aae2ceecc..dfe407cde262 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -42,7 +42,7 @@ config CORESIGHT_LINK_AND_SINK_TMC
 	  module will be called coresight-tmc.
 
 config CORESIGHT_CATU
-	bool "Coresight Address Translation Unit (CATU) driver"
+	tristate "Coresight Address Translation Unit (CATU) driver"
 	depends on CORESIGHT_LINK_AND_SINK_TMC
 	help
 	   Enable support for the Coresight Address Translation Unit (CATU).
@@ -52,6 +52,9 @@ config CORESIGHT_CATU
 	   by looking up the provided table. CATU can also be used in pass-through
 	   mode where the address is not translated.
 
+	   To compile this driver as a module, choose M here: the
+	   module will be called coresight-catu.
+
 config CORESIGHT_SINK_TPIU
 	tristate "Coresight generic TPIU driver"
 	depends on CORESIGHT_LINKS_AND_SINKS
diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index 47696a7d24a7..99430f6cf5a5 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -567,11 +567,21 @@ static int catu_probe(struct amba_device *adev, const struct amba_id *id)
 	return ret;
 }
 
+static int __exit catu_remove(struct amba_device *adev)
+{
+	struct catu_drvdata *drvdata = dev_get_drvdata(&adev->dev);
+
+	coresight_unregister(drvdata->csdev);
+	return 0;
+}
+
 static struct amba_id catu_ids[] = {
 	CS_AMBA_ID(0x000bb9ee),
 	{},
 };
 
+MODULE_DEVICE_TABLE(amba, catu_ids);
+
 static struct amba_driver catu_driver = {
 	.drv = {
 		.name			= "coresight-catu",
@@ -579,6 +589,7 @@ static struct amba_driver catu_driver = {
 		.suppress_bind_attrs	= true,
 	},
 	.probe				= catu_probe,
+	.remove				= catu_remove,
 	.id_table			= catu_ids,
 };
 
@@ -601,3 +612,7 @@ static void __exit catu_exit(void)
 
 module_init(catu_init);
 module_exit(catu_exit);
+
+MODULE_AUTHOR("Suzuki K Poulose <suzuki.poulose@arm.com>");
+MODULE_DESCRIPTION("Arm CoreSight Address Translation Unit (CATU) Driver");
+MODULE_LICENSE("GPL v2");
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

