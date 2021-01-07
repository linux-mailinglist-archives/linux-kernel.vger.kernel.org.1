Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2442ECDEB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 11:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbhAGKe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 05:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbhAGKeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 05:34:25 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CE9C0612F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 02:33:32 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id r4so5062653wmh.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 02:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QN5ASc980gFf0tJjjDz0JIrOvhiP7pnnl1Ex8LIbMOQ=;
        b=NeYaOqabcoGxl+fGVEjt2VEBLOfcYMJozg6lA+r+V5by5ZGDTsondG8y1LRDyCb7p4
         Yh9sKtdQAFS9NO6ipiavHEfzaIySCwvexWqx1vKOIamM2P5zFO8P5tHjdLOfVlmQrl8G
         T+eH6fkpG6zn1URyuyB/BGZ/1E0LLnfgIGDlF2eYPMYUNbCY4pNJcuG4JzvvHybfvK9U
         ww/LrBZfpHbFOZXyQnILUOo/EyxMBit+y2W2OjW7cP6mpafAz5zA0x+yc4GVy3navnmE
         CMZDjF08e+CEfELTktUwf6lu8tF+pPRbQNvTA0hCq58qCU7eqdnjF3afIn4yZr38fQNz
         4liA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QN5ASc980gFf0tJjjDz0JIrOvhiP7pnnl1Ex8LIbMOQ=;
        b=tX1E/wKtnkzT4pEiKEZDWzfEF/ODC3c00aqrQPU1yTPUdbtV41Nf55eepiafLa4hET
         R5hQrD0cls65B8sFMZqXAF6YM7HC7nNTJoOHs1UG6qvUuRH3tud6xPVdWqgGV5tIBbih
         Il0ID06+tUwE1bzTqUccwRYv8SSHDrJ8HKETDwIscnnbVian23eFraGu9FD1n2IW0vYG
         X6MTHdACGTKGIyrXZVLjhzG8YkWEauB76sqqKqjzm16jwacOv+0Dxf9jPqqze47J6llL
         QO6SjM39V10KSszvws2+kmDY5QBuDgrOS/h+5po4+GlbsxbX+9X7rShWLL2ObC9oG3VQ
         zvyw==
X-Gm-Message-State: AOAM533TjDImgmraM6F7+QUl7Iqp61vca5pJTEpwxxYCFk8R+E5UqVuB
        Wz4QjHWyKk2WRxJFisDcNRkjFg==
X-Google-Smtp-Source: ABdhPJzGND8zJBl4JFqIPFrBPtyhPrN3jt1AhZ6PxHFrN56fxua3/zmhsIjabjax/gemgLIU3/oBUw==
X-Received: by 2002:a7b:c10e:: with SMTP id w14mr7373126wmi.161.1610015610730;
        Thu, 07 Jan 2021 02:33:30 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:d7b:24c9:55f9:4b75])
        by smtp.gmail.com with ESMTPSA id i9sm7734120wrs.70.2021.01.07.02.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 02:33:29 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 1/3 v2] sched/fair: skip idle cfs_rq
Date:   Thu,  7 Jan 2021 11:33:23 +0100
Message-Id: <20210107103325.30851-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210107103325.30851-1-vincent.guittot@linaro.org>
References: <20210107103325.30851-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't waste time checking whether an idle cfs_rq could be the busiest
queue. Furthermore, this can end up selecting a cfs_rq with a high load
but being idle in case of migrate_load.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 04a3ce20da67..5428b8723e61 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9389,8 +9389,11 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		if (rt > env->fbq_type)
 			continue;
 
-		capacity = capacity_of(i);
 		nr_running = rq->cfs.h_nr_running;
+		if (!nr_running)
+			continue;
+
+		capacity = capacity_of(i);
 
 		/*
 		 * For ASYM_CPUCAPACITY domains, don't pick a CPU that could
-- 
2.17.1

