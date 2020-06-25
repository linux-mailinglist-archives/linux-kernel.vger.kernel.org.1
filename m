Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D230B209D21
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 12:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404134AbgFYKyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 06:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404043AbgFYKyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 06:54:36 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D730CC061573
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 03:54:35 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u185so830116pfu.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 03:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yx0lD7fGCawYLo67/HEDDyL+lrRFtxEIUe5sUIZ62J4=;
        b=KFzDILrifAGB9mux0K0myeWdvE++5mwEPTLiZlUHtmvaSd5Zbbi+N3aDQqCfvRoADy
         vgu0THEKzIO32WFExI06AHflnZAeytfQquxOij2If7MxulGyiquIDz2kpgr2AJd62yFE
         3EZvh4hdkirQqJk9q1MFSAbrG6rxcjUIzDerLiZOKUwQDsgK6eKLTA39sis77KVz1WCW
         3ABVAvDmDdqCrr64wSHg8vwrkmjxjunuQRddTA1lZ/o5ZNmBfPvqa38Wq3dg9cKfx6xR
         j+chsV3sY3Dt/QO9DgGVZcTCU2SFcl7FcON/wIZIgrJ/iJxcQWBQzn0Kaqflv4RwZ8n6
         L3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yx0lD7fGCawYLo67/HEDDyL+lrRFtxEIUe5sUIZ62J4=;
        b=hzDk0TIs1DCNfkpZXIR5xBB3Xtm+5I/IUzZBf2/6gD+c/0sDm7l2C8JUCXptRtbMp8
         DchvNVtsy6Bk9ppkLmRPMHWpkcmLzogoQsPgXEaLRUJLZigAsSp93tCK+cFEa/ReVFyN
         YcAtNmKQbdKxupAdUOVY0aUoW5hHR45Dd7aOVBeBnzOmhWnWiARcwNRn7g/6hT8dkFrD
         HXgKwzcZ8my7zGlDtDbnf3hozzIA1mXWzYqv2NbzE2Tk/E9CncUf4syQiNmy2S3alkG0
         UJ5w0get4WfM7U1rBe8VygxBWSbPgMJa8EgKI8o6+UKbTPj9uptyo8rkxNns7bCx5Y7a
         V42w==
X-Gm-Message-State: AOAM530sVenFAZOxuV6O/r+blaCbMLfrZcKQyjLnVH5uBmgYkcpZxp/l
        gZHgm70/GowAaVYJf0/t/D6ptg==
X-Google-Smtp-Source: ABdhPJy0/PWHlw5xC2GRTtLNg6G2ne3hVL381s0Dp6vTcQq3l/hAhoPTcjAsPJSL5gnb3vM45ejGAA==
X-Received: by 2002:aa7:82d5:: with SMTP id f21mr7333895pfn.244.1593082475155;
        Thu, 25 Jun 2020 03:54:35 -0700 (PDT)
Received: from localhost ([122.172.111.76])
        by smtp.gmail.com with ESMTPSA id u4sm23045364pfl.102.2020.06.25.03.54.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2020 03:54:34 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: Fix locking issues with governors
Date:   Thu, 25 Jun 2020 16:24:16 +0530
Message-Id: <49c7d64460cdb39b006991e5251260eb0eea9f2a.1593082448.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The locking around governors handling isn't adequate currently. The list
of governors should never be traversed without locking in place. Also we
must make sure the governor isn't removed while it is still referenced
by code.

Reported-by: Quentin Perret <qperret@google.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 59 ++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 23 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 4b1a5c0173cf..dad6b85f4c89 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -624,6 +624,24 @@ static struct cpufreq_governor *find_governor(const char *str_governor)
 	return NULL;
 }
 
+static struct cpufreq_governor *get_governor(const char *str_governor)
+{
+	struct cpufreq_governor *t;
+
+	mutex_lock(&cpufreq_governor_mutex);
+	t = find_governor(str_governor);
+	if (!t)
+		goto unlock;
+
+	if (!try_module_get(t->owner))
+		t = NULL;
+
+unlock:
+	mutex_unlock(&cpufreq_governor_mutex);
+
+	return t;
+}
+
 static unsigned int cpufreq_parse_policy(char *str_governor)
 {
 	if (!strncasecmp(str_governor, "performance", CPUFREQ_NAME_LEN))
@@ -643,28 +661,14 @@ static struct cpufreq_governor *cpufreq_parse_governor(char *str_governor)
 {
 	struct cpufreq_governor *t;
 
-	mutex_lock(&cpufreq_governor_mutex);
-
-	t = find_governor(str_governor);
-	if (!t) {
-		int ret;
-
-		mutex_unlock(&cpufreq_governor_mutex);
-
-		ret = request_module("cpufreq_%s", str_governor);
-		if (ret)
-			return NULL;
-
-		mutex_lock(&cpufreq_governor_mutex);
+	t = get_governor(str_governor);
+	if (t)
+		return t;
 
-		t = find_governor(str_governor);
-	}
-	if (t && !try_module_get(t->owner))
-		t = NULL;
-
-	mutex_unlock(&cpufreq_governor_mutex);
+	if (request_module("cpufreq_%s", str_governor))
+		return NULL;
 
-	return t;
+	return get_governor(str_governor);
 }
 
 /**
@@ -818,12 +822,14 @@ static ssize_t show_scaling_available_governors(struct cpufreq_policy *policy,
 		goto out;
 	}
 
+	mutex_lock(&cpufreq_governor_mutex);
 	for_each_governor(t) {
 		if (i >= (ssize_t) ((PAGE_SIZE / sizeof(char))
 		    - (CPUFREQ_NAME_LEN + 2)))
-			goto out;
+			break;
 		i += scnprintf(&buf[i], CPUFREQ_NAME_PLEN, "%s ", t->name);
 	}
+	mutex_unlock(&cpufreq_governor_mutex);
 out:
 	i += sprintf(&buf[i], "\n");
 	return i;
@@ -1060,11 +1066,14 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
 {
 	struct cpufreq_governor *gov = NULL;
 	unsigned int pol = CPUFREQ_POLICY_UNKNOWN;
+	bool put_governor = false;
+	int ret;
 
 	if (has_target()) {
 		/* Update policy governor to the one used before hotplug. */
-		gov = find_governor(policy->last_governor);
+		gov = get_governor(policy->last_governor);
 		if (gov) {
+			put_governor = true;
 			pr_debug("Restoring governor %s for cpu %d\n",
 				 policy->governor->name, policy->cpu);
 		} else if (default_governor) {
@@ -1091,7 +1100,11 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
 			return -ENODATA;
 	}
 
-	return cpufreq_set_policy(policy, gov, pol);
+	ret = cpufreq_set_policy(policy, gov, pol);
+	if (put_governor)
+		module_put(gov->owner);
+
+	return ret;
 }
 
 static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy, unsigned int cpu)
-- 
2.25.0.rc1.19.g042ed3e048af

