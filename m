Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38B826C9BB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgIPTVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbgIPTTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 15:19:30 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B23FC061797
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 12:17:46 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id e4so3718831pln.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 12:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uwz7uDiSpijhZG4h1tserEStKWNE3HZkcr8/salV8us=;
        b=POX3iV6nlCb0dIrYb1Gn/NjEpUNZlcqETAyRE7QwmNxuJnURWKse4aRCc0oxZFvFxQ
         NLxaRsFQ33H8dikTXbDpTdr75xDM5Q4EqDHzbHxwNqVMkBh8KcTjq+r8d9FX76CcJ5tl
         YqqT4UjP4undHKXoQnkb02v1e4PD5RlDaxnd1dxy2BJevRKMMSagD/is5TW3e+fYJRZx
         kA0FhRzYob0WRAdz+hl2TaUtTJEcqhReLPa89j61Z29U9bSM4uspgI8LiQOKdZFE6hyo
         SYW251azdWJqq9g5xpvAoh6VxBNlUIJJAJ5uVeV7kxzntD2wKM5+bVcrtMClsubV13Fr
         6btA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uwz7uDiSpijhZG4h1tserEStKWNE3HZkcr8/salV8us=;
        b=jRQ3C4JJYf1Kqj4AIANOAbweW4Bf4dlc/inG0u94keE5Rc/UO4UdzveW8fGMg+jS33
         u0cZb9Y1WiaiA+99RaV6BU6CwW5n1d9UP45ZiUK0Oo/TFDeFPmBvusLw0KQ+JSE1BO0D
         PSrvranWzgZ9IOvDaD+8LkMQFFim14Ffpvrq3C0EtIAZdy7csYQe+Xs//DDVgH5OVKZb
         L9TGkvHonZdQlOka9Z3zjFQYFXMsGktP/FXlPB4gI0NYVhdesQIlb3pE3Vpl4CpDQ+3U
         RKZsv08IeXCq8Pp6qD8E5TR7gvJBGYk2vYh3RbZDJlR1EoA0o8jJjTyCRIKl2uDt1iGj
         FxWg==
X-Gm-Message-State: AOAM530TiyKIl4+d3J4Wrauvqr+LQ7qYzm2gplT3V+BsqwRK6Fjv80CO
        TKZpw2ax81nhiuR4imOHgzT6Sw==
X-Google-Smtp-Source: ABdhPJymvRW+Zat6n+q9jRaLx3Lamg31OZ5/XkFmEre09r7lk2LGVcjpGdqpqkkE0ExchqtAUQeQSg==
X-Received: by 2002:a17:90b:3105:: with SMTP id gc5mr5357689pjb.225.1600283866159;
        Wed, 16 Sep 2020 12:17:46 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id b2sm11373688pfp.3.2020.09.16.12.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 12:17:45 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/16] coresight: cti: remove pm_runtime_get_sync() from CPU hotplug
Date:   Wed, 16 Sep 2020 13:17:27 -0600
Message-Id: <20200916191737.4001561-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200916191737.4001561-1-mathieu.poirier@linaro.org>
References: <20200916191737.4001561-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tingwei Zhang <tingwei@codeaurora.org>

Below BUG is triggered by call pm_runtime_get_sync() in
cti_cpuhp_enable_hw(). It's in CPU hotplug callback with interrupt
disabled. Pm_runtime_get_sync() calls clock driver to enable clock
which could sleep. Remove pm_runtime_get_sync() in cti_cpuhp_enable_hw()
since pm_runtime_get_sync() is called in cti_enabld and pm_runtime_put()
is called in cti_disabled. No need to increase pm count when CPU gets
online since it's not decreased when CPU is offline.

[  105.800279] BUG: scheduling while atomic: swapper/1/0/0x00000002
[  105.800290] Modules linked in:
[  105.800327] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W
5.9.0-rc1-gff1304be0a05-dirty #21
[  105.800337] Hardware name: Thundercomm Dragonboard 845c (DT)
[  105.800353] Call trace:
[  105.800414]  dump_backtrace+0x0/0x1d4
[  105.800439]  show_stack+0x14/0x1c
[  105.800462]  dump_stack+0xc0/0x100
[  105.800490]  __schedule_bug+0x58/0x74
[  105.800523]  __schedule+0x590/0x65c
[  105.800538]  schedule+0x78/0x10c
[  105.800553]  schedule_timeout+0x188/0x250
[  105.800585]  qmp_send.constprop.10+0x12c/0x1b0
[  105.800599]  qmp_qdss_clk_prepare+0x18/0x20
[  105.800622]  clk_core_prepare+0x48/0xd4
[  105.800639]  clk_prepare+0x20/0x34
[  105.800663]  amba_pm_runtime_resume+0x54/0x90
[  105.800695]  __rpm_callback+0xdc/0x138
[  105.800709]  rpm_callback+0x24/0x78
[  105.800724]  rpm_resume+0x328/0x47c
[  105.800739]  __pm_runtime_resume+0x50/0x74
[  105.800768]  cti_starting_cpu+0x40/0xa4
[  105.800795]  cpuhp_invoke_callback+0x84/0x1e0
[  105.800814]  notify_cpu_starting+0x9c/0xb8
[  105.800834]  secondary_start_kernel+0xd8/0x164
[  105.800933] CPU1: Booted secondary processor 0x0000000100 [0x517f803c]

Fixes: e9b880581d55 ("coresight: cti: Add CPU Hotplug handling to CTI driver")
Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-cti.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti.c b/drivers/hwtracing/coresight/coresight-cti.c
index d6fea6efec71..c4e9cc7034ab 100644
--- a/drivers/hwtracing/coresight/coresight-cti.c
+++ b/drivers/hwtracing/coresight/coresight-cti.c
@@ -141,9 +141,7 @@ static int cti_enable_hw(struct cti_drvdata *drvdata)
 static void cti_cpuhp_enable_hw(struct cti_drvdata *drvdata)
 {
 	struct cti_config *config = &drvdata->config;
-	struct device *dev = &drvdata->csdev->dev;
 
-	pm_runtime_get_sync(dev->parent);
 	spin_lock(&drvdata->spinlock);
 	config->hw_powered = true;
 
@@ -163,7 +161,6 @@ static void cti_cpuhp_enable_hw(struct cti_drvdata *drvdata)
 	/* did not re-enable due to no claim / no request */
 cti_hp_not_enabled:
 	spin_unlock(&drvdata->spinlock);
-	pm_runtime_put(dev->parent);
 }
 
 /* disable hardware */
-- 
2.25.1

