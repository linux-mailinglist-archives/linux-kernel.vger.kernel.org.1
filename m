Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB93427DE92
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 04:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbgI3Crd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 22:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729446AbgI3Crd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 22:47:33 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDAEC061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 19:47:33 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id y5so381261otg.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 19:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sGxrRFYRD0vQg740ZJ2H+rUYx/z6zC5mWNZdnhAeh4U=;
        b=kXwbHsyNVoI4/G7NNmYs54XNqWBE57wKN3iSoTakXC9LNYp+8QkzrekZzoaQ4d6Qyl
         QvK6IaX1ksJlYJR7qVzGSQ/gpOrygf6s54dwboiJYJDZ9UhSQsXRDe0f3VPYbXMRNQeo
         1D0g1pNk+h2sG42zRLX2uU8jkziKzxAq0phVv7V+t6zw0csFSrN8JlZXuYLpUxnRJbSE
         iwhIkgrr5vjH/a2Ton3O3qQljZrt4YGSht0hsmy7eRuWC51YjGeHhfVyftD4rgCd2xk5
         abfBZwCbVu5O+mh/PTO8zmJprGBegYMGviCckJHDa0s0Q7ejIyzwMGpGvaMv36JMr4eJ
         jPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sGxrRFYRD0vQg740ZJ2H+rUYx/z6zC5mWNZdnhAeh4U=;
        b=jQkzMxjj8we0w9qnn9TExLTNbFZJjNSjK2ntAwzoKvn3GNCy2SWWUZR5lUIN8P2GMG
         MnoFUwqfW5f7oGjkPxhsZXwHYx9jstVkud7ZfaYg3Pp3u556ltyP9rQt5dahhlqVvYD1
         edHpOMeS6WYs93XvxXE0mfYeIpj4wD+eSxjM/MmsIIBekj/SFuRKmgPMDpv2fZD2sF/F
         ALBHBkvAzAKqk2j83uegUE7oPfQeXMG/BzgKpdBqKtkYMdFLdqN806zz+U3WHxnm9LIK
         MKEB7NX+XGT8v6EhsIQGbri16AM/d7Md3GngJttlgBL+r0PxkjwnXdOK5vHZW7m42z7x
         3eOA==
X-Gm-Message-State: AOAM533/LHNHQ7BZlJwcBVZrXW9mogNQTsrcUkNvw8Y1+XHblv1FMoXy
        QUSmbRQGqjj8kvmzbMIZohE=
X-Google-Smtp-Source: ABdhPJxpBFCSE8IpHGqUvd0sgt17R9lJP4ky9Glatg1kcOxiLlCPN4Jx/gwNY8S5czJW4EH2gOCUxA==
X-Received: by 2002:a9d:3a34:: with SMTP id j49mr194485otc.52.1601434052576;
        Tue, 29 Sep 2020 19:47:32 -0700 (PDT)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id k10sm82097ots.60.2020.09.29.19.47.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Sep 2020 19:47:31 -0700 (PDT)
From:   qianjun.kernel@gmail.com
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, jun qian <qianjun.kernel@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 1/1] sched/fair: Fix the wrong sched_stat_wait time
Date:   Wed, 30 Sep 2020 10:47:12 +0800
Message-Id: <20200930024712.88258-1-qianjun.kernel@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jun qian <qianjun.kernel@gmail.com>

When the sched_schedstat changes from 0 to 1, some sched se maybe
already in the runqueue, the se->statistics.wait_start will be 0.
So it will let the (rq_of(cfs_rq)) - se->statistics.wait_start)
wrong. We need to avoid this scenario.

Signed-off-by: jun qian <qianjun.kernel@gmail.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/sched/fair.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 658aa7a..dd7c3bb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -908,6 +908,14 @@ static void update_curr_fair(struct rq *rq)
 	if (!schedstat_enabled())
 		return;
 
+	/*
+	 * When the sched_schedstat changes from 0 to 1, some sched se maybe
+	 * already in the runqueue, the se->statistics.wait_start will be 0.
+	 * So it will let the delta wrong. We need to avoid this scenario.
+	 */
+	if (unlikely(!schedstat_val(se->statistics.wait_start)))
+		return;
+
 	delta = rq_clock(rq_of(cfs_rq)) - schedstat_val(se->statistics.wait_start);
 
 	if (entity_is_task(se)) {
-- 
1.8.3.1

