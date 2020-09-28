Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2744427B20D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgI1QgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgI1Qft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:35:49 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0757CC0613DA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:40 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 5so1331690pgf.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a5qzpqB7NQwWfYWvXhPMQqYvIW0wXYJS9U1EnLj7ruo=;
        b=Ic0DY+J4C7T5LjPKaY4f1P+MKDv7vcA8G3ERrgMfjQdQKXKH7gg8XcteDcKNQVkb/w
         W9VzGFkFHpcqhT89hnbCjFlJz6ItgXaRng6EcxuiHJlSf2zZCRcpel3/YCZe3Rmokcxe
         5QibuNLDGU5KGnebELfIs+xwqr6tfHNN1GPHadWuPJmVlMq+JuOE2x5bb7LX4JrzARNV
         Tr16VNkd6vwoB9pAvfU2/MKN4fmXBjJS0Abu5BCb3RgO7GtAXakSTeb8GFzi5oLqdI+o
         UAEjC6jnvLYLI0v4eMROP1ejo/1Id5iKjlUBnxFMxY+0tEm0bhPg/FxWBXEtzAjj+wn0
         HZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a5qzpqB7NQwWfYWvXhPMQqYvIW0wXYJS9U1EnLj7ruo=;
        b=RCpDMF2RJ7VRoJLdtcmkEYS8TgHLvKFps1og/WxajRW+A7Yrs/rFsRoy3fFLvnsSga
         yGA7wWDlm6ddbS9D2Lp1o7XR9p1y0PK4I9kWOOn3CTjlKzeubfFPsfMoRy9ovMYd08+t
         +I9X+Z5yOtiHdH+xWvCzj1JkGQR4hVF4yWZqtTLiPAqXK0bx/bExoPnS1YyFN8IiPEvR
         4kJGExs85yY5yE+MA+lY1mWL8PBTWdz8iuFLM2Mb20vtazf7dHEcRAOoNW5g58tYikTD
         N555ZK70ki2ZbB/oLA8nT15BwDt4S+J8zBAL8+6qbcB5Nr6bnfZ8qsJEH7HF+PTumT6r
         HVeQ==
X-Gm-Message-State: AOAM533jFhixIDSDT3p7jRzP4a5Udknq8Djnedfyn/RpXDzZedXiU/+n
        1GBPfMvoPv7LGS1ZkCONXzPaB9uRcpo4PQ==
X-Google-Smtp-Source: ABdhPJyrfmcxHn6Dqmy7WiI9wq+pv73WPhJjs+7K6iNf57RwQrTXeHC+VngefGDNXBEVFF2emPaF1A==
X-Received: by 2002:a62:7747:0:b029:13f:d779:5f95 with SMTP id s68-20020a6277470000b029013fd7795f95mr256880pfc.2.1601310939553;
        Mon, 28 Sep 2020 09:35:39 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id f19sm2345640pfd.45.2020.09.28.09.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 09:35:38 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 23/25] coresight: catu: Allow catu drivers to be built as modules
Date:   Mon, 28 Sep 2020 10:35:11 -0600
Message-Id: <20200928163513.70169-24-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928163513.70169-1-mathieu.poirier@linaro.org>
References: <20200928163513.70169-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tingwei Zhang <tingwei@codeaurora.org>

Allow to build coresight-catu as modules, for ease of development.
- Kconfig becomes a tristate, to allow =m
- add catu_remove functions, for module unload
- add a MODULE_DEVICE_TABLE for autoloading on boot

Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
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
2.25.1

