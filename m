Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223A320AAF1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 05:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgFZDv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 23:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgFZDvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 23:51:53 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884EDC08C5DB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 20:51:53 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id j1so4077658pfe.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 20:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GyDv1eGRF/Hpb1vrzd8yB8yhzJQyRsKrTey51yyHxdU=;
        b=LUyFKxIgIyvGIQS/g+X8sYxv4buWkAC81fMiXoz7jLPGMBEGnPH8nmLaqQQekj+kJn
         Uc+6UNcsse1LFmwa6/A+rxfMb/KLnoOG7unc2sZokqvLxYttTymWWaUTjTIW2/nX2SR+
         7uJAaw+rJfyg1YJN4Huu6A7THXod2joPnZOBX3d8kAQ3yjzzn9sjdmrw2BDCkGCc7tX7
         BI6VxxjEq4EjwdIM4bFBhnt9KTlvvLozwx99WfuMnciWJf90TPU5B+CstXkh3U1RJdtp
         bD9AL38vohzyM+2gNFD/K9WI8TPrTfKi0zfF6Wa0wKpmi6UQYJIn3wVw+6W+TPLjqTjt
         RUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GyDv1eGRF/Hpb1vrzd8yB8yhzJQyRsKrTey51yyHxdU=;
        b=mQ4NXyL7eMz47XGH50BemEnJzpn9TLKbxlkvqjmUGbSyiGCZhOPnkxRXdsooAiSzLW
         OeyMH4EY64C3CEYsbtdqVwDVEaWUICVxv0+EKyLqhYdYhgwizUF5jvn50DyculdOnWoN
         sAJii2ABscMBoJ67scCm3giQ8r+YAc+Y0UZykM5GYRS6i0x85yVKIGuL24QV75hbbhQF
         yL6Ecx7Gk0hVuo1sqmriEiL0LxBf5EgSM7jvSpSP2dbn3S3qOwf4gO1oTEby87PISCc+
         sM+wzq4SArVLzpiglZUX7D/Gnv/ybIPKtFU9Kok9fCraMMUOZbdeBVvCEmO0oPyLxkFu
         NHsQ==
X-Gm-Message-State: AOAM532cIcFnvwkjFOuf5t1bxKyW+Hn4zZZweXADSdJeS2YD7z36uJtV
        9zNcjI5AFwDCL59qMYxY0CtaWrSJ1z8=
X-Google-Smtp-Source: ABdhPJzV7E/80LFIVwGK5SzKdMc4rMjKA3P/KpkYKAhHxRXt6bTuSbYaOHxkFtmPQq36vMbtcwuJYQ==
X-Received: by 2002:aa7:8388:: with SMTP id u8mr881390pfm.253.1593143513036;
        Thu, 25 Jun 2020 20:51:53 -0700 (PDT)
Received: from localhost ([122.172.127.76])
        by smtp.gmail.com with ESMTPSA id z26sm3837606pfr.187.2020.06.25.20.51.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2020 20:51:52 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com, tkjos@google.com, adharmap@codeaurora.org,
        Quentin Perret <qperret@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/3] cpufreq: Fix locking issues with governors
Date:   Fri, 26 Jun 2020 09:21:42 +0530
Message-Id: <f366ed3dd3dd111e42173b366fe4dd5a0e4647fd.1593143118.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1593143118.git.viresh.kumar@linaro.org>
References: <cover.1593143118.git.viresh.kumar@linaro.org>
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
index 0128de3603df..e798a1193bdf 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -621,6 +621,24 @@ static struct cpufreq_governor *find_governor(const char *str_governor)
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
@@ -640,28 +658,14 @@ static struct cpufreq_governor *cpufreq_parse_governor(char *str_governor)
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
@@ -815,12 +819,14 @@ static ssize_t show_scaling_available_governors(struct cpufreq_policy *policy,
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
@@ -1058,11 +1064,14 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
 	struct cpufreq_governor *def_gov = cpufreq_default_governor();
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
 		} else if (def_gov) {
@@ -1089,7 +1098,11 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
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

