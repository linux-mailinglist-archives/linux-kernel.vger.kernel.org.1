Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C4E28F509
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388896AbgJOOot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387861AbgJOOoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:44:44 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3311C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:44:43 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id n6so3772113wrm.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VIIJ4RMYqLNortz9z9aAlCcePVhZmZgs6l1LmiLsOiE=;
        b=uCfxLmurrBez2qGjMmn+ptUQYi+av2FATs0l5HzikkwlhbibvL4PEvj+m1Qx1MG3l4
         7zLgOcsguYhB65Vsmk240KVdyW+sDF9dbVpNCSg8v3phQgNdt1RWjdgYTvzyGoLYcyeJ
         C7Dm4+wyFTUU+WF+n6BAYd5G6nRqNSQbZdS7ktdPWe2/PnHXdNXY/ULRQwsU5kJOugAS
         NJ8jgLJpBCMzmataXfkb1Q8qLMT1GfPF3Jpm7fEDRG3JgPEPDdWu7bzXLaQLOrttI9RN
         RG2s23NUx5+1Qsp0kT41e5L6O1RxTKuv8iMF8dKi7AaTvy0DmFksKEA/iX2CPfZJWXvU
         Ho2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VIIJ4RMYqLNortz9z9aAlCcePVhZmZgs6l1LmiLsOiE=;
        b=t5kBIZzEL5efmwmPF0dkJkcVRtSgK7DDEwX1hCzOcfgJ4Pctae0WBtoKoB4kunCOll
         0ueQyw9p00lqz5oE0dfTh/jX/feMvsh07ORt4zxGYCzvmQujrk9rWUeHYH0oFgMKLCWI
         WIbg5qgVf0WQIAkM3UoPAkFRc3WdlhntZcVrimb+gfhYsenewZMwQyZ3+vlGdryeYYki
         jhrXt+zrVh+dqvm176+TJvkdIbu7QfE0pTdBIB38Wof8fghBc146AcRdNSSebtn1Cjeo
         ENl7zIRGOKGXNNRLbY+wcvuuZqMZzs1ojdIn8xUfxspORTlJ9Qi8R8SES3DpY1xaor/M
         1XDQ==
X-Gm-Message-State: AOAM5323Pb1GMbhE1fTbUpMw4WZzxeFEnLfT8DsHYkI+uA+33FtI5AJa
        COKdgiiFniCiKeKpHEn1odWvVA==
X-Google-Smtp-Source: ABdhPJz58ii7IEnKvIAByNNd6NV3E9zvGK8972TWUtcJ5J4euosrV8FaRblAj7vLawIACbsaOIXbKw==
X-Received: by 2002:adf:eb41:: with SMTP id u1mr4567937wrn.94.1602773082353;
        Thu, 15 Oct 2020 07:44:42 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-134-136.adsl.proxad.net. [82.252.134.136])
        by smtp.gmail.com with ESMTPSA id 40sm5053800wrc.46.2020.10.15.07.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 07:44:41 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        ilina@codeaurora.org
Subject: [PATCH 2/5] cpuidle: governor: Encapsulate the cpuidle on/off switch
Date:   Thu, 15 Oct 2020 16:44:28 +0200
Message-Id: <20201015144431.9979-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201015144431.9979-1-daniel.lezcano@linaro.org>
References: <20201015144431.9979-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The next patch will introduce the ability to unregister a governor
which will share part of the register function code. Instead of
duplicating, let's encapuslate the common parts into functions, so
they can be called from different places.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/governor.c | 39 ++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/cpuidle/governor.c b/drivers/cpuidle/governor.c
index 29acaf48e575..d46ab8ec2dd7 100644
--- a/drivers/cpuidle/governor.c
+++ b/drivers/cpuidle/governor.c
@@ -39,6 +39,27 @@ struct cpuidle_governor *cpuidle_find_governor(const char *str)
 	return NULL;
 }
 
+static void cpuidle_switch_off(void)
+{
+	struct cpuidle_device *dev;
+
+	cpuidle_uninstall_idle_handler();
+
+	if (cpuidle_curr_governor) {
+		list_for_each_entry(dev, &cpuidle_detected_devices, device_list)
+			cpuidle_disable_device(dev);
+	}
+}
+
+static void cpuidle_switch_on(void)
+{
+	struct cpuidle_device *dev;
+
+	list_for_each_entry(dev, &cpuidle_detected_devices, device_list)
+		cpuidle_enable_device(dev);
+	cpuidle_install_idle_handler();
+}
+
 /**
  * cpuidle_switch_governor - changes the governor
  * @gov: the new target governor
@@ -46,29 +67,19 @@ struct cpuidle_governor *cpuidle_find_governor(const char *str)
  */
 int cpuidle_switch_governor(struct cpuidle_governor *gov)
 {
-	struct cpuidle_device *dev;
-
 	if (!gov)
 		return -EINVAL;
 
 	if (gov == cpuidle_curr_governor)
 		return 0;
 
-	cpuidle_uninstall_idle_handler();
-
-	if (cpuidle_curr_governor) {
-		list_for_each_entry(dev, &cpuidle_detected_devices, device_list)
-			cpuidle_disable_device(dev);
-	}
+	cpuidle_switch_off();
 
 	cpuidle_curr_governor = gov;
 
-	if (gov) {
-		list_for_each_entry(dev, &cpuidle_detected_devices, device_list)
-			cpuidle_enable_device(dev);
-		cpuidle_install_idle_handler();
-		printk(KERN_INFO "cpuidle: using governor %s\n", gov->name);
-	}
+	cpuidle_switch_on();
+
+	printk(KERN_INFO "cpuidle: using governor %s\n", gov->name);
 
 	return 0;
 }
-- 
2.17.1

