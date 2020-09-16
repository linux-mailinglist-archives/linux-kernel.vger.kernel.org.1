Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C345E26CA0F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbgIPToj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgIPTS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 15:18:26 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB5EC061756
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 12:17:41 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id r19so3718091pls.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 12:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cY9qq0UTJdrHZLOBosy7Hke2d1u48dWNW8TgCKuAPxU=;
        b=ggy8YTLP75CQgZYBBvnkkAh/RNppSuBP82IpD3hpb0RqQuBBlzPVkUqa06MTenRfCe
         eLvMmOOupzFhjWnNz9YYBOro9CKDTZw6aA2xg774/JrPgYbJ9AkekzHXArr7IQaejlKu
         PUdgn3k6A+EkwVQkJxhGa807Qgl//q6W6olinhCBIY3y8h5hmycpTjoflf6ej0WQuM0+
         2cQRwBxQrZnZ3bE1TbAHulzA8U2gUl2NY4kXKCocQFtZKuXjVWw8M5/W8P7xqF2eMskr
         pP5c4d4u2LTxSjTwb1SHfgJxd1uSNxmdrL1B2qFmQxKrmvrx48n3yKgjRmRbfMKvu33C
         vrzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cY9qq0UTJdrHZLOBosy7Hke2d1u48dWNW8TgCKuAPxU=;
        b=PV6yJ89fnFvNNtQU+gOCQ3rNCnb0grj+U8a5jHsboyaMxQnsXXRq3OTEF4iHcy3Ry0
         A1DgTITqLaGzhm6dGQsepic9lxtlSXaAb7czI5YTlKm+4bAMSCG4fwh9Oz4Utn8CVZcF
         EguEkHO8ovuUseWAUNIxZn9CCcU5nb3c6CShyP780oZSYHAGAFFJSPl/P8vqxOGGl3Xi
         YOMsXpqYXqJOBSmg12aqLzfTD45qq0U3ZZ8XP2DQquqS1cVjjM1jjSfUMjesG4NLWDfm
         yEQgRq5Vzh4wT8953FtsZZch5HMRj6NT7zxkwXof0rrC8TeogGxCEU8gZ7JpIJCwnY34
         6Omw==
X-Gm-Message-State: AOAM530pAXTjYT9J6dv41Zf6yHCpjxKRw3/vev0yTmslbs0YQe/kc8kG
        gvoCuBnaMBIr2XZH16m4694MFw==
X-Google-Smtp-Source: ABdhPJwOWdYxJTkhuLXAeymfRUBOsd1OQDTqSARmHDegoDAnAfvj8i7Jwj2ec4u2ERzOxsalpoVQUQ==
X-Received: by 2002:a17:902:d913:b029:d0:cbe1:e712 with SMTP id c19-20020a170902d913b02900d0cbe1e712mr25790469plz.32.1600283860693;
        Wed, 16 Sep 2020 12:17:40 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id b2sm11373688pfp.3.2020.09.16.12.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 12:17:40 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/16] coresight: etm4x: Fix etm4_count race by moving cpuhp callbacks to init
Date:   Wed, 16 Sep 2020 13:17:22 -0600
Message-Id: <20200916191737.4001561-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200916191737.4001561-1-mathieu.poirier@linaro.org>
References: <20200916191737.4001561-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

etm4_count keeps track of number of ETMv4 registered and on some systems,
a race is observed on etm4_count variable which can lead to multiple calls
to cpuhp_setup_state_nocalls_cpuslocked(). This function internally calls
cpuhp_store_callbacks() which prevents multiple registrations of callbacks
for a given state and due to this race, it returns -EBUSY leading to ETM
probe failures like below.

 coresight-etm4x: probe of 7040000.etm failed with error -16

This race can easily be triggered with async probe by setting probe type
as PROBE_PREFER_ASYNCHRONOUS and with ETM power management property
"arm,coresight-loses-context-with-cpu".

Prevent this race by moving cpuhp callbacks to etm driver init since the
cpuhp callbacks doesn't have to depend on the etm4_count and can be once
setup during driver init. Similarly we move cpu_pm notifier registration
to driver init and completely remove etm4_count usage. Also now we can
use non cpuslocked version of cpuhp callbacks with this movement.

Fixes: 9b6a3f3633a5 ("coresight: etmv4: Fix CPU power management setup in probe() function")
Fixes: 58eb457be028 ("hwtracing/coresight-etm4x: Convert to hotplug state machine")
Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Tested-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 65 +++++++++----------
 1 file changed, 31 insertions(+), 34 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 96425e818fc2..45d169a2512c 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -48,8 +48,6 @@ module_param(pm_save_enable, int, 0444);
 MODULE_PARM_DESC(pm_save_enable,
 	"Save/restore state on power down: 1 = never, 2 = self-hosted");
 
-/* The number of ETMv4 currently registered */
-static int etm4_count;
 static struct etmv4_drvdata *etmdrvdata[NR_CPUS];
 static void etm4_set_default_config(struct etmv4_config *config);
 static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
@@ -1397,28 +1395,25 @@ static struct notifier_block etm4_cpu_pm_nb = {
 	.notifier_call = etm4_cpu_pm_notify,
 };
 
-/* Setup PM. Called with cpus locked. Deals with error conditions and counts */
-static int etm4_pm_setup_cpuslocked(void)
+/* Setup PM. Deals with error conditions and counts */
+static int __init etm4_pm_setup(void)
 {
 	int ret;
 
-	if (etm4_count++)
-		return 0;
-
 	ret = cpu_pm_register_notifier(&etm4_cpu_pm_nb);
 	if (ret)
-		goto reduce_count;
+		return ret;
 
-	ret = cpuhp_setup_state_nocalls_cpuslocked(CPUHP_AP_ARM_CORESIGHT_STARTING,
-						   "arm/coresight4:starting",
-						   etm4_starting_cpu, etm4_dying_cpu);
+	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ARM_CORESIGHT_STARTING,
+					"arm/coresight4:starting",
+					etm4_starting_cpu, etm4_dying_cpu);
 
 	if (ret)
 		goto unregister_notifier;
 
-	ret = cpuhp_setup_state_nocalls_cpuslocked(CPUHP_AP_ONLINE_DYN,
-						   "arm/coresight4:online",
-						   etm4_online_cpu, NULL);
+	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+					"arm/coresight4:online",
+					etm4_online_cpu, NULL);
 
 	/* HP dyn state ID returned in ret on success */
 	if (ret > 0) {
@@ -1427,21 +1422,15 @@ static int etm4_pm_setup_cpuslocked(void)
 	}
 
 	/* failed dyn state - remove others */
-	cpuhp_remove_state_nocalls_cpuslocked(CPUHP_AP_ARM_CORESIGHT_STARTING);
+	cpuhp_remove_state_nocalls(CPUHP_AP_ARM_CORESIGHT_STARTING);
 
 unregister_notifier:
 	cpu_pm_unregister_notifier(&etm4_cpu_pm_nb);
-
-reduce_count:
-	--etm4_count;
 	return ret;
 }
 
-static void etm4_pm_clear(void)
+static void __init etm4_pm_clear(void)
 {
-	if (--etm4_count != 0)
-		return;
-
 	cpu_pm_unregister_notifier(&etm4_cpu_pm_nb);
 	cpuhp_remove_state_nocalls(CPUHP_AP_ARM_CORESIGHT_STARTING);
 	if (hp_online) {
@@ -1497,22 +1486,12 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	if (!desc.name)
 		return -ENOMEM;
 
-	cpus_read_lock();
 	etmdrvdata[drvdata->cpu] = drvdata;
 
 	if (smp_call_function_single(drvdata->cpu,
 				etm4_init_arch_data,  drvdata, 1))
 		dev_err(dev, "ETM arch init failed\n");
 
-	ret = etm4_pm_setup_cpuslocked();
-	cpus_read_unlock();
-
-	/* etm4_pm_setup_cpuslocked() does its own cleanup - exit on error */
-	if (ret) {
-		etmdrvdata[drvdata->cpu] = NULL;
-		return ret;
-	}
-
 	if (etm4_arch_supported(drvdata->arch) == false) {
 		ret = -EINVAL;
 		goto err_arch_supported;
@@ -1559,7 +1538,6 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 
 err_arch_supported:
 	etmdrvdata[drvdata->cpu] = NULL;
-	etm4_pm_clear();
 	return ret;
 }
 
@@ -1597,4 +1575,23 @@ static struct amba_driver etm4x_driver = {
 	.probe		= etm4_probe,
 	.id_table	= etm4_ids,
 };
-builtin_amba_driver(etm4x_driver);
+
+static int __init etm4x_init(void)
+{
+	int ret;
+
+	ret = etm4_pm_setup();
+
+	/* etm4_pm_setup() does its own cleanup - exit on error */
+	if (ret)
+		return ret;
+
+	ret = amba_driver_register(&etm4x_driver);
+	if (ret) {
+		pr_err("Error registering etm4x driver\n");
+		etm4_pm_clear();
+	}
+
+	return ret;
+}
+device_initcall(etm4x_init);
-- 
2.25.1

