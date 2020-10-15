Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6FC28F507
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388870AbgJOOor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388821AbgJOOop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:44:45 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5246C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:44:44 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d81so3460315wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5JUoyfVqtjpZjkNlfJCWbI+WQsPddcI5ptqn4dRqnS4=;
        b=M1Qi00FprtY5xYwcerjaZE+WMKOs7sLUXXC6fFbubPpcPA+BWUxbUd9xBQHd3/HcKE
         V+ozmSlOesz53OdnecMn8+bIb+7IYVU0q2Gs5jaU2eB8n5bTm1KrZzQbDPfHZQpJ0ObR
         8Lb8SC5H7xz8cqqLc2zWKkhCnHtIqFPQp/7Remaws17XOPVeZ6G/VzOfzyKE1ThjQnfr
         udQlNxSufReO1qiRy5vMpt6YgJDGlKngHAcggVP7SPFfjfRruRE5j+x53h/aDOrLvGWT
         72/zvDcsy5Bmgk5bPz/pq/Q8zkIsdQndA6JLmCvMCbm/FJux+tPGPkj9HgR8p4ElAarQ
         EwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5JUoyfVqtjpZjkNlfJCWbI+WQsPddcI5ptqn4dRqnS4=;
        b=l6JLjnbIRjQgZI+Z8kjA8IEYlr7ssMboC8bX9SeRFb4LzqYuXUO/r0lDZF6mWo0cfC
         btjgjf8HrNdhFMJyiunqzIlfmZ9mCfSivCE3myaaVJA3otKqafwmVPwgAiMEGtW1Yyh2
         0k/EDeE11WFJaLjBgFdAx12uRKKv5sADNZPEKbYBm/oSuZGGG7gM4dmVuqFKlP4aRH70
         OsZvHLrhXitqXH167O3TfgCiusm9E2kGddaUiK4dZqAK8DybbbL8UCGvDJvSAQVJMVOV
         21YXR0ygAPb+kgXBbb6WjoYdVkD2kUG7gjYwdvMlo8M0rV1T5dSeeAZ1+B4hX67PZ9nW
         3adA==
X-Gm-Message-State: AOAM5323l4+RMTHGRK/UqkNYJn3LcHxfgjVYpzOnFmHIR7xdOTeJOiok
        nSqhASh/YTBXQZmeQz0gSFieUEoS7sTVqA==
X-Google-Smtp-Source: ABdhPJxMGwzaSWU0D+nse992DXxVycFwXzLw7Fz4JN4lJ70ITxImMfBOaK72fwCoAe5Fekxfl608mA==
X-Received: by 2002:a1c:bd0a:: with SMTP id n10mr4378021wmf.177.1602773083506;
        Thu, 15 Oct 2020 07:44:43 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-134-136.adsl.proxad.net. [82.252.134.136])
        by smtp.gmail.com with ESMTPSA id 40sm5053800wrc.46.2020.10.15.07.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 07:44:42 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        ilina@codeaurora.org
Subject: [PATCH 3/5] cpuidle: governor: Make possible to unregister a governor
Date:   Thu, 15 Oct 2020 16:44:29 +0200
Message-Id: <20201015144431.9979-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201015144431.9979-1-daniel.lezcano@linaro.org>
References: <20201015144431.9979-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows to unregister a governor. If the unregistered
governor is the current one, it will be replaced by the governor with
the highest rating. If it is the last governor, the cpuidle framework
will be switched off.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/governor.c | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/cpuidle.h    |  1 +
 2 files changed, 38 insertions(+)

diff --git a/drivers/cpuidle/governor.c b/drivers/cpuidle/governor.c
index d46ab8ec2dd7..6ec27ef096f5 100644
--- a/drivers/cpuidle/governor.c
+++ b/drivers/cpuidle/governor.c
@@ -84,6 +84,43 @@ int cpuidle_switch_governor(struct cpuidle_governor *gov)
 	return 0;
 }
 
+/**
+ * cpuidle_unregister_governor - unregister a governor
+ * @gov: a pointer to a cpuidle governor structure
+ *
+ * Unregister the governor specified in parameter. If it is the
+ * current one, replace by another one in the list with the highest
+ * rating. If it is the last one, then switch off cpuidle.
+ */
+void cpuidle_unregister_governor(struct cpuidle_governor *gov)
+{
+	int rating = 0;
+	struct cpuidle_governor *new_gov = NULL;
+
+	mutex_lock(&cpuidle_lock);
+
+	list_del(&gov->governor_list);
+
+	/*
+	 * The governor is currently in use, switch to the one with
+	 * the best rating.
+	 */
+	if (cpuidle_curr_governor == gov) {
+
+		list_for_each_entry(gov, &cpuidle_governors, governor_list) {
+			if (gov->rating > rating)
+				new_gov = gov;
+		}
+
+		if (new_gov)
+			cpuidle_switch_governor(new_gov);
+		else
+			cpuidle_switch_off();
+	}
+
+	mutex_unlock(&cpuidle_lock);
+}
+
 /**
  * cpuidle_register_governor - registers a governor
  * @gov: the governor
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 74fdcc6106b1..457e0786b4f9 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -271,6 +271,7 @@ struct cpuidle_governor {
 };
 
 extern int cpuidle_register_governor(struct cpuidle_governor *gov);
+extern void cpuidle_unregister_governor(struct cpuidle_governor *gov);
 extern s64 cpuidle_governor_latency_req(unsigned int cpu);
 
 #define __CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter,			\
-- 
2.17.1

