Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E3D2CA1F9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 13:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389782AbgLAL4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 06:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389039AbgLAL4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 06:56:32 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1C9C0613D4;
        Tue,  1 Dec 2020 03:55:52 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id f11so1450906oij.6;
        Tue, 01 Dec 2020 03:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1totvta4MYx/IWBz7d/RYAzHEnXN/7YX7D4elOq7TTs=;
        b=sMLmmeHJmIuef9ZKoH2JjQdNALszqLf6iCOKtINubKdPzSDybTx+femwo88aSDcviz
         ur+X2hCg0anXhb7tvvFlmUQperjKB1xCEqSR5fN0H6KAq0vZkUrnfYc0iok6RkBH7J16
         oknXMTsCrzDcnx5Zl69MSxs7DkmFT5w56e0Z5MyCEkYHLe3Ryv4jzXJJfKZhKCNrzbMl
         ndOd0twBCC3opNN/o6EXRsl0TRdJ4QcU3fotqePc4UonD3mr/ZfWCyxQFOq3uev0D6bG
         ZPLOkaAprnisezk1BMZgIxhET8da1ozSX8Gwf4BZyl+NAsthE2lkyWryyTDqqGhXdGVD
         c5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1totvta4MYx/IWBz7d/RYAzHEnXN/7YX7D4elOq7TTs=;
        b=WmfhotLtRPHq4KGRGvSAF8l6UMdj05yRR56dBal8Wl9f4J3nKfJp4uMSCVOBOlDk6g
         iQJxMnZauyf/+Xa3FmzESBcGZskeCD8HQos1o28j6Kk3C/uOBY3jOevs9tXEpIkTaHMv
         sz3XhTtyW5WGRxYFFnxgrt/jrgzgnuu+N+KavRA9ZbEsVMzOuWaojGlyghfD2/+8c+K+
         GWDnhPVQiOKe4zrbTfqb3PZjfQ85ogg5KcmUDeDSqa8JIrwj1Nea9MHBeaE59PEvyxNC
         El+iiA8L6W1K0cq+abd+2JPL7gISStyYTMGbRJZfFHp6Ub6ujpbLJ7whe7jukAP+bBm2
         oJYw==
X-Gm-Message-State: AOAM5318FWmiqBTm8dJ6s0wTq/38+lBm9C4ApE8/FJN7eTD6UYJaeN4d
        6AN38wmmqLtY7shVAjMzS6U=
X-Google-Smtp-Source: ABdhPJyRL24dwuqp3Fc21IO2Lu3zpVD5AX3ZlMyU5KUgFxfM3HzK90aKXrifUKc2n3ZIRghlZuD/iw==
X-Received: by 2002:a54:4d8f:: with SMTP id y15mr1461791oix.150.1606823751734;
        Tue, 01 Dec 2020 03:55:51 -0800 (PST)
Received: from localhost.localdomain ([122.225.203.131])
        by smtp.gmail.com with ESMTPSA id o6sm342592oon.7.2020.12.01.03.55.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Dec 2020 03:55:51 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mgorman@suse.de, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, qianjun.kernel@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 5/6] sched, rt: support sched_stat_runtime tracepoint for RT sched class
Date:   Tue,  1 Dec 2020 19:54:15 +0800
Message-Id: <20201201115416.26515-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20201201115416.26515-1-laoar.shao@gmail.com>
References: <20201201115416.26515-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The runtime of a RT task has already been there, so we only need to
place the sched_stat_runtime tracepoint there.

One difference between fair task and RT task is that there is no vruntime
in RT task. To reuse the sched_stat_runtime tracepoint, '0' is passed as
vruntime for RT task.

The output of this tracepoint for RT task as follows,
          stress-9748    [039] d.h.   113.519352: sched_stat_runtime: comm=stress pid=9748 runtime=997573 [ns] vruntime=0 [ns]
          stress-9748    [039] d.h.   113.520352: sched_stat_runtime: comm=stress pid=9748 runtime=997627 [ns] vruntime=0 [ns]
          stress-9748    [039] d.h.   113.521352: sched_stat_runtime: comm=stress pid=9748 runtime=998203 [ns] vruntime=0 [ns]

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/sched/rt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 2d543a270dfe..da989653b0a2 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1011,6 +1011,8 @@ static void update_curr_rt(struct rq *rq)
 	schedstat_set(curr->stats.exec_max,
 		      max(curr->stats.exec_max, delta_exec));
 
+	trace_sched_stat_runtime(curr, delta_exec, 0);
+
 	curr->se.sum_exec_runtime += delta_exec;
 	account_group_exec_runtime(curr, delta_exec);
 
-- 
2.18.4

