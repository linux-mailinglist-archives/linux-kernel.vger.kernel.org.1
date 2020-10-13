Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3E828C822
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 07:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732299AbgJMFMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 01:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbgJMFMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 01:12:54 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE03C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 22:12:53 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id c6so10028029plr.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 22:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=02oO3Z8jOKDlfqPM7EqzxD4EZC21R1hXbEcsn0yQIcg=;
        b=AwQj+36MNZq8miR7Y9m93CEutLWF3wDTZ405RIPBqSi2Up44xIAZmFczwMhbkAH7hH
         bowC74t+9YlTmEQApnKMxQLa3Wayo9U9X1ON5A/izi7GsOsFD5O17jtM/FySTfOSF247
         HGvtGcR1Q8yrNEB/BjnSCnd9kD7ZE+nttLbVGDdNgjrLAKaj40WsLYZF27zdLX0rZixt
         BBnXTNat7Dox2abrh4KyCNUnEkLMgU/lBO+EWGlYbu19xn5cUJgSx0IDHh/R7fVwWidn
         MivCJR0WLCc9F+aEIRjHO+F/9hPLXd3L1o6iPahKXhf1o7cgfB9DwchHSIF1HtbpVORJ
         1dGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=02oO3Z8jOKDlfqPM7EqzxD4EZC21R1hXbEcsn0yQIcg=;
        b=IsjYTvG+0TqrpRO7bNnu0ZwOXKII6OreSFc5jVSxzmrkAFPR9S53qjRfhfrE3lezPw
         6aO3f4cAPDnv7ztISuJfOrc3G5qCLksZdUD2biYkcrWmOyTfqVHNBalL8opY0FhpgNPs
         BiMUZazdAknF5HRrEhMkOnDKVGrIr55IiasFFWgdgzFB/IIJpfFAtP7QKS8GY6Rc9Y89
         l+n5rsbKHoFJqqy2sFEg+viidsWEnORfRcbXUk/gqtEnejDv+z550v/Ai0KEgw6i5vF2
         8ZSeM7jU5ZwG+7dMekUmRlabNNn4D6a+LmUGM5WMV/MohiKDRk2P0QC9gmSC/cY1iDOD
         OLig==
X-Gm-Message-State: AOAM5331dSO6bdy9SwEBtZkCLj+DUDKtvB22+mFOMZKSmG7lnDiNePUn
        D0Bk9E2uF3LsLrV0Zt6x3SdYKg==
X-Google-Smtp-Source: ABdhPJzMGzjOYjEi4ZhrNYhyNrJk7b4DJ3/VFaJdEsiOxykRh3VlhDNPCXVdcptoKOxpnD6x0NBf/g==
X-Received: by 2002:a17:902:b688:b029:d2:43a9:ef1f with SMTP id c8-20020a170902b688b02900d243a9ef1fmr26248237pls.9.1602565972452;
        Mon, 12 Oct 2020 22:12:52 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id f15sm19293265pfk.21.2020.10.12.22.12.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Oct 2020 22:12:51 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sumit Gupta <sumitg@nvidia.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: Improve code around unlisted freq check
Date:   Tue, 13 Oct 2020 10:42:47 +0530
Message-Id: <37c3f1f76c055b305d1bba2c2001ac5b1d7a9b5f.1602565964.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpufreq core checks if the frequency programmed by the bootloaders
is not listed in the freq table and programs one from the table in such
a case. This is done only if the driver has set the
CPUFREQ_NEED_INITIAL_FREQ_CHECK flag.

Currently we print two separate messages, with almost the same content,
and do this with a pr_warn() which may be a bit too much as the driver
only asked us to check this as it expected this to be the case. Lower
down the severity of the print message by switching to pr_info() instead
and print a single message only.

Reported-by: Sumit Gupta <sumitg@nvidia.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 2ea245a6c0c0..99864afac272 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1461,14 +1461,13 @@ static int cpufreq_online(unsigned int cpu)
 	 */
 	if ((cpufreq_driver->flags & CPUFREQ_NEED_INITIAL_FREQ_CHECK)
 	    && has_target()) {
+		unsigned int old_freq = policy->cur;
+
 		/* Are we running at unknown frequency ? */
-		ret = cpufreq_frequency_table_get_index(policy, policy->cur);
+		ret = cpufreq_frequency_table_get_index(policy, old_freq);
 		if (ret == -EINVAL) {
-			/* Warn user and fix it */
-			pr_warn("%s: CPU%d: Running at unlisted freq: %u KHz\n",
-				__func__, policy->cpu, policy->cur);
-			ret = __cpufreq_driver_target(policy, policy->cur - 1,
-				CPUFREQ_RELATION_L);
+			ret = __cpufreq_driver_target(policy, old_freq - 1,
+						      CPUFREQ_RELATION_L);
 
 			/*
 			 * Reaching here after boot in a few seconds may not
@@ -1476,8 +1475,8 @@ static int cpufreq_online(unsigned int cpu)
 			 * frequency for longer duration. Hence, a BUG_ON().
 			 */
 			BUG_ON(ret);
-			pr_warn("%s: CPU%d: Unlisted initial frequency changed to: %u KHz\n",
-				__func__, policy->cpu, policy->cur);
+			pr_info("%s: CPU%d: Running at unlisted initial frequency: %u KHz, changing to: %u KHz\n",
+				__func__, policy->cpu, old_freq, policy->cur);
 		}
 	}
 
-- 
2.25.0.rc1.19.g042ed3e048af

