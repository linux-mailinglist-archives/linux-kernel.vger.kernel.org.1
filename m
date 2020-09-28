Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2ED427B205
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgI1Qf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgI1Qfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:35:50 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB262C0613D9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:38 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id n14so1520682pff.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OgGSOrCXLQyAV2gZxStMZAfdrZXXx22iIYuK3Is0SJo=;
        b=n7Xg3DD0ia9d5X4Xq+I9G1N/47h6NlnuPRHdCgaErHYEr2dY7lmMVbAeFx7OI2qFK7
         xDrcakHPanZ42XZHfO5yOF1VKEvuwXN9NPMqySjSetLQLz5jRz8AixQWFBcTew9rgZxu
         G52dWoSB1je8D/F14sHHK3yV7DPubWHS1YpcTGqdyqC75hynrSUIcEoUKAeOXCPGSPWX
         7aWnia/1uq176tELxPJsqd1prGCBWTVeqbpnRvDnicRS7KHqDbv9Q/OFbOsGMDx+Ry7c
         3W70KxUg9FkTvLuniyaPD3BIskWp5mNoMsIDZQLGxiH9/mhmlKbb5i1T/dYm5+kXd5BA
         HOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OgGSOrCXLQyAV2gZxStMZAfdrZXXx22iIYuK3Is0SJo=;
        b=s/kpBIcsTOaGCvC8d7vKHOv12vXGUEwinI9oGScjjzI6TsnEJ0vUNWdoHgVFfUBboT
         1yWMWKJseWaFa/rgGINvq/hYMHx4GQJCdTJu2alMorqF7poObeoYz08XtwJRrEdljYCJ
         cb2bdklkEmtr9N5bofL41ytCf8QZHnSg1lemv8o5BZV/Dmqq0UOkMgdDuE4abXeSzoZK
         aB/srtqtHklzb8ZwWGAxUfjE8QJeQ0XjCjrhw1OfZAhqy7kvSB7r0gZuQXUWxwh9k36v
         oWP8wEv1PG4SJq1OdlGTYn8AYv9u1aM2G3DfSWj42IwvE/N+gu07u/39MSw8v3h4QyO9
         GiTg==
X-Gm-Message-State: AOAM530+sfFu+5jjCL8bIrD8klTwEx5hyeuz8uCR7PjFwIyko/XmbPEX
        4Pko8JDvzHh4TCQIrcIKT8DxCg==
X-Google-Smtp-Source: ABdhPJzhtAbdoo90Cfy9sdx/HUlWhZbTmy/0j/EfBnrYEIHYG6jKtAOj89mNLKLIVedbXd+3jEvmZw==
X-Received: by 2002:a63:c18:: with SMTP id b24mr1847450pgl.208.1601310938403;
        Mon, 28 Sep 2020 09:35:38 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id f19sm2345640pfd.45.2020.09.28.09.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 09:35:37 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 22/25] coresight: tmc-etr: Add function to register catu ops
Date:   Mon, 28 Sep 2020 10:35:10 -0600
Message-Id: <20200928163513.70169-23-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928163513.70169-1-mathieu.poirier@linaro.org>
References: <20200928163513.70169-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mian Yousaf Kaukab <ykaukab@suse.de>

Make etr_catu_buf_ops static. Instead of directly accessing it in
etr_buf_ops[], add a function to let catu driver register the ops at
runtime. Break circular dependency between tmc-etr and catu drivers.

Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-catu.c  | 22 +++++++++++++++++--
 drivers/hwtracing/coresight/coresight-catu.h  |  2 --
 .../hwtracing/coresight/coresight-tmc-etr.c   | 15 +++++++++++--
 drivers/hwtracing/coresight/coresight-tmc.h   |  3 +++
 4 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index 1801804a7762..47696a7d24a7 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -358,7 +358,7 @@ static int catu_alloc_etr_buf(struct tmc_drvdata *tmc_drvdata,
 	return 0;
 }
 
-const struct etr_buf_operations etr_catu_buf_ops = {
+static const struct etr_buf_operations etr_catu_buf_ops = {
 	.alloc = catu_alloc_etr_buf,
 	.free = catu_free_etr_buf,
 	.sync = catu_sync_etr_buf,
@@ -582,4 +582,22 @@ static struct amba_driver catu_driver = {
 	.id_table			= catu_ids,
 };
 
-builtin_amba_driver(catu_driver);
+static int __init catu_init(void)
+{
+	int ret;
+
+	ret = amba_driver_register(&catu_driver);
+	if (ret)
+		pr_info("Error registering catu driver\n");
+	tmc_etr_set_catu_ops(&etr_catu_buf_ops);
+	return ret;
+}
+
+static void __exit catu_exit(void)
+{
+	tmc_etr_remove_catu_ops();
+	amba_driver_unregister(&catu_driver);
+}
+
+module_init(catu_init);
+module_exit(catu_exit);
diff --git a/drivers/hwtracing/coresight/coresight-catu.h b/drivers/hwtracing/coresight/coresight-catu.h
index 80ceee3c739c..6160c2d75a56 100644
--- a/drivers/hwtracing/coresight/coresight-catu.h
+++ b/drivers/hwtracing/coresight/coresight-catu.h
@@ -108,6 +108,4 @@ static inline bool coresight_is_catu_device(struct coresight_device *csdev)
 	return true;
 }
 
-extern const struct etr_buf_operations etr_catu_buf_ops;
-
 #endif
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index ad991a37e2d2..714f9e867e5f 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -794,10 +794,21 @@ static inline void tmc_etr_disable_catu(struct tmc_drvdata *drvdata)
 static const struct etr_buf_operations *etr_buf_ops[] = {
 	[ETR_MODE_FLAT] = &etr_flat_buf_ops,
 	[ETR_MODE_ETR_SG] = &etr_sg_buf_ops,
-	[ETR_MODE_CATU] = IS_ENABLED(CONFIG_CORESIGHT_CATU)
-						? &etr_catu_buf_ops : NULL,
+	[ETR_MODE_CATU] = NULL,
 };
 
+void tmc_etr_set_catu_ops(const struct etr_buf_operations *catu)
+{
+	etr_buf_ops[ETR_MODE_CATU] = catu;
+}
+EXPORT_SYMBOL_GPL(tmc_etr_set_catu_ops);
+
+void tmc_etr_remove_catu_ops(void)
+{
+	etr_buf_ops[ETR_MODE_CATU] = NULL;
+}
+EXPORT_SYMBOL_GPL(tmc_etr_remove_catu_ops);
+
 static inline int tmc_etr_mode_alloc_buf(int mode,
 					 struct tmc_drvdata *drvdata,
 					 struct etr_buf *etr_buf, int node,
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 6e8d2dc33d17..b91ec7dde7bc 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -326,4 +326,7 @@ tmc_sg_table_buf_size(struct tmc_sg_table *sg_table)
 
 struct coresight_device *tmc_etr_get_catu_device(struct tmc_drvdata *drvdata);
 
+void tmc_etr_set_catu_ops(const struct etr_buf_operations *catu);
+void tmc_etr_remove_catu_ops(void);
+
 #endif
-- 
2.25.1

