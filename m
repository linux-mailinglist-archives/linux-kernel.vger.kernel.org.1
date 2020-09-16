Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2347826BD77
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 08:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgIPGqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 02:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgIPGpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 02:45:51 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E602EC061788
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 23:45:49 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id md22so1047367pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 23:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hZYCz5nzNahLD9wsdHTKADWsrq22uAWjN70xaMi6z60=;
        b=n2XHtFO9+VtbH/rlGPlB4k4m2Tlk1t+XAlgn/+W/9KolZcZ/wbfFx+FBCfDYKoM8Y+
         QqvBTdFfFTBwWFY3p8C7N0gKWAycS8Ov0T1gK8rdXYolO34yYi5JtrFssFI/welnC+p5
         l4/XLfLa7BRm/V0TgL3v6++Mp/ViknUGx90pUVo+odHSeXoNdXcKFytsQMC7q97op0PA
         9DP5qLVUVMUnvCMaQtikQOagPILRRsi/CCdKQfxgGnjd8s/HO3uJtQRJLGsBbL07GMpp
         fzcHCFQ0hR4LT8/iV8qx3s/RTtzmXbUKphL+31S9rpot7mgKZzfHK06n0oor9bJzUB8s
         R1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hZYCz5nzNahLD9wsdHTKADWsrq22uAWjN70xaMi6z60=;
        b=a5E549i8lIcmoFUiEN0jO8V4DDFQOOUNlEICyu8JOilBFgbXWs0WzGZHZ6y6wrKQ/U
         EFg4ET71HI+IRVWsI1nta6ufqxqrgtfJ/tv7gvLnrtLCHhbPcU2gXhxc/fGqjKeH5obu
         iI0y4JVmLMuWEl5ZEqMSzNYuDompPEXBrKDUZijAHJAiTNhR2/NW2DwdtxMvnRuote1I
         lUs5fbBjfxorbZsn27flGGDb6k15K+qmWbxdT2xeHYJ0+AI5TLyx1lp1PXWMej0C2xkY
         OXkGEvIjBZw5cHmb80oTMy4zGA0gKnCqHukiPv3+8IFU7NgtwntpAUhdwoW4Tub3cgHr
         iQiw==
X-Gm-Message-State: AOAM533P2UeLeGKcDlEHBscAgBKz6t3ruJAw4PM6Kl7yboGoWYeM1B/9
        9eGyWhOjaSeowhzSt+Dz5MYSXQ==
X-Google-Smtp-Source: ABdhPJxB8nLngvmMpf3Pyv7Pfp2yrzRvcH3mr/M62gU4ciHkgNYxsRm3TMFyh056FAcIMRiQ1AiqqA==
X-Received: by 2002:a17:902:aa49:b029:d0:cbe1:e7b3 with SMTP id c9-20020a170902aa49b02900d0cbe1e7b3mr23073632plr.36.1600238749479;
        Tue, 15 Sep 2020 23:45:49 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id x3sm15458102pfq.49.2020.09.15.23.45.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 23:45:48 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, cristian.marussi@arm.com,
        sudeep.holla@arm.com, linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/4] cpufreq: stats: Remove locking
Date:   Wed, 16 Sep 2020 12:15:29 +0530
Message-Id: <2b378277fe1acfd2567a3a639cc4d9b0292b99f7.1600238586.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1600238586.git.viresh.kumar@linaro.org>
References: <cover.1600238586.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The locking isn't required anymore as stats can get updated only from
one place at a time. Remove it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_stats.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 3e7eee29ee86..314fa1d506d0 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -19,7 +19,6 @@ struct cpufreq_stats {
 	unsigned int state_num;
 	unsigned int last_index;
 	u64 *time_in_state;
-	spinlock_t lock;
 	unsigned int *freq_table;
 	unsigned int *trans_table;
 
@@ -41,7 +40,6 @@ static void cpufreq_stats_reset_table(struct cpufreq_stats *stats)
 {
 	unsigned int count = stats->max_state;
 
-	spin_lock(&stats->lock);
 	memset(stats->time_in_state, 0, count * sizeof(u64));
 	memset(stats->trans_table, 0, count * count * sizeof(int));
 	stats->last_time = get_jiffies_64();
@@ -50,7 +48,6 @@ static void cpufreq_stats_reset_table(struct cpufreq_stats *stats)
 	/* Adjust for the time elapsed since reset was requested */
 	WRITE_ONCE(stats->reset_pending, 0);
 	cpufreq_stats_update(stats, stats->reset_time);
-	spin_unlock(&stats->lock);
 }
 
 static ssize_t show_total_trans(struct cpufreq_policy *policy, char *buf)
@@ -244,7 +241,6 @@ void cpufreq_stats_create_table(struct cpufreq_policy *policy)
 	stats->state_num = i;
 	stats->last_time = get_jiffies_64();
 	stats->last_index = freq_table_get_index(stats, policy->cur);
-	spin_lock_init(&stats->lock);
 
 	policy->stats = stats;
 	ret = sysfs_create_group(&policy->kobj, &stats_attr_group);
@@ -277,11 +273,9 @@ void cpufreq_stats_record_transition(struct cpufreq_policy *policy,
 	if (old_index == -1 || new_index == -1 || old_index == new_index)
 		return;
 
-	spin_lock(&stats->lock);
 	cpufreq_stats_update(stats, stats->last_time);
 
 	stats->last_index = new_index;
 	stats->trans_table[old_index * stats->max_state + new_index]++;
 	stats->total_trans++;
-	spin_unlock(&stats->lock);
 }
-- 
2.25.0.rc1.19.g042ed3e048af

