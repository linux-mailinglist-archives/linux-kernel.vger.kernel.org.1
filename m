Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2912CA1F0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 13:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389638AbgLALz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 06:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389210AbgLALz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 06:55:56 -0500
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7503C0613CF;
        Tue,  1 Dec 2020 03:55:15 -0800 (PST)
Received: by mail-oo1-xc43.google.com with SMTP id l10so325662oom.6;
        Tue, 01 Dec 2020 03:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GirRYv7Yp+UW6qivVdz+bDt6vd2WoU0OZWfuEpWcOf8=;
        b=sQps+LyBnJwZ8DKm64dtvjIf/x6BKWuufRfjS+uqbL1cIrvOA9kDHvxBVioORhFq/6
         xQ0wgds4a8Y4LL8lFPX85UVV9Zzkw6BCI8tNIQgbQiWcRz+MR5Md6eO/7HSK2bY4Logq
         dbp4z2OoZBso5VFKKBD6JsQvRWTeaFbKegSyDXfYUisLN1L5Hyq5FFW6ncY3PQhthsAD
         HX3W5MNdbC5/1kPf/0Njv8hVrTcLR3SQtdrcNs1qbSd/i/rjS4lKqrmJkPPmFQiisjVO
         vDgWPhG0AN/zMWKd25lJ0uOx14cz0PQdy3XO7UQ7B9bjSF1djZe9v8XQ+GX5NCGHZvdx
         kWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GirRYv7Yp+UW6qivVdz+bDt6vd2WoU0OZWfuEpWcOf8=;
        b=G9nd8OspwQ98V5J3dX++bBY50Inj+IW6UZ1ZX5uF03kPj8CKXKRXFUc6JtOzS1lPFO
         7Tx4JZGEcUEIxgu56i03sBptQ9cxEOGBPwpnYFWlEfxc0jSUWbVxhfn8vQljBZe0Zia6
         lEY3zzh0B+BKTlGagItlXv9Vp8AFsFvAmbJXGWY/AIAVqg8bmsXRqWtdxnZ6PkvvCZsc
         2GhEUZzc+eu8LA2y3s87Nsp0v32fIaExYzMPRNIUjWsYKQV3rahPWs3WZ4ZqrptEncs+
         euKrc1FqgVLlvP0F9VUeRVpZVOs6FmXq3eVeON8/sXj/bxsyxcmwvy8caKKmMWtevYm1
         BV3A==
X-Gm-Message-State: AOAM530lguqdqsN6uca0BEdx6AGzYOdqQGxnZhBBzPhlqCjGdPpXHaZl
        Ef5ortqeuK5Uj0OHGuWGsKY=
X-Google-Smtp-Source: ABdhPJzoYw2dkq4kRApu+pEYbfO+eyJUgSQ3VNrwNpbrBgbPtSTxQgaK3Uyt5T/tPSdewfyTGa6bfw==
X-Received: by 2002:a4a:d347:: with SMTP id d7mr1507916oos.47.1606823715306;
        Tue, 01 Dec 2020 03:55:15 -0800 (PST)
Received: from localhost.localdomain ([122.225.203.131])
        by smtp.gmail.com with ESMTPSA id o6sm342592oon.7.2020.12.01.03.55.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Dec 2020 03:55:14 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mgorman@suse.de, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, qianjun.kernel@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 2/6] sched, fair: use __schedstat_set() in set_next_entity()
Date:   Tue,  1 Dec 2020 19:54:12 +0800
Message-Id: <20201201115416.26515-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20201201115416.26515-1-laoar.shao@gmail.com>
References: <20201201115416.26515-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

schedstat_enabled() has been already checked, so we can use
__schedstat_set() directly.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8ff1daa3d9bb..7e7c03cede94 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4414,7 +4414,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	 */
 	if (schedstat_enabled() &&
 	    rq_of(cfs_rq)->cfs.load.weight >= 2*se->load.weight) {
-		schedstat_set(se->statistics.slice_max,
+		__schedstat_set(se->statistics.slice_max,
 			max((u64)schedstat_val(se->statistics.slice_max),
 			    se->sum_exec_runtime - se->prev_sum_exec_runtime));
 	}
-- 
2.18.4

