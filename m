Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3632F9254
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 13:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbhAQMcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 07:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728271AbhAQMcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 07:32:10 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541B2C061573
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 04:31:29 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id y8so7106985plp.8
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 04:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1eNK2LT1boji43zRY4FBu8R9cl0kHSUT5374E1w7aVU=;
        b=g8iHOUwDCOQ+25NugARDen2rDiiyuXafdPhjdwOtFuwT9nLDxZoiQaHsvkkNUZhKMO
         SPbZyE79LfcuFQzNu2etkSyFvkmHy2XJMKGuMWNsnOgvxDJWvImct8W70wjIbg/tK9s+
         Wzdp3Xv9k9eDuiKIxnURkx803UFvuHnpy9pYPvxjYMV5RjJIXXi3miWMqWOtvAXX9Fs8
         MqfurOaWf38TweXtC1dfNZ0I1GQ1j5wmR74JrEmt/cPZLATjVeOKKzfvmDNz6+BGgD10
         x81QWr8e/rvqIUp6h6SvAqWHPgPkZLB64ijwKzgF685HAUU0dXKZR99qvUxYDaWCO6wo
         ApoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1eNK2LT1boji43zRY4FBu8R9cl0kHSUT5374E1w7aVU=;
        b=X1ZF2lD0uBCQ0l54tu8i2WaKFJQRdduS1kz2wSRYm8VQnj/rszyAeP7EP3mNsWso2u
         DLpBymt0exTEj3Qsl9TUMd9n/5VwE+VhhdcT9HRAnRbWRfXGFiaPDJClBt5c2T5AuQdn
         P3NrBJfQQZES7yQ9YNZONL0DW87/US2NDQbB2lcUE1YrMugklY36W9EFCunXGl5WQNnb
         AjiFUvNpAst7SdgjaOA6hproCOLFtc00t8O2NktnLD7bTtXioBbiO+behRB+i+OMLLGu
         4v+2BzonFnnnga/EnRsayW6DiWO+QXtAmNgntmRDVucTPvTkwh4/dZCMDkcVKwEomcTj
         hnMw==
X-Gm-Message-State: AOAM533m/grUBSX1mct0q4gX4kbkpibLpSmlbuxDjzxjCLGufsuzQlvA
        7+huJ3CRi6+hcvCR/Se6Zr8=
X-Google-Smtp-Source: ABdhPJzJD7M0FXEi328T5jF/hUKYVlsHqFk+bfidz1VRg6gEmTUZ/jsB1QP677/Dym1Kd0q1sc+WXQ==
X-Received: by 2002:a17:902:7596:b029:da:b7a3:cdd0 with SMTP id j22-20020a1709027596b02900dab7a3cdd0mr21347449pll.14.1610886688713;
        Sun, 17 Jan 2021 04:31:28 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.65])
        by smtp.gmail.com with ESMTPSA id q79sm1333403pfc.63.2021.01.17.04.31.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2021 04:31:28 -0800 (PST)
From:   Jiang Biao <benbjiang@gmail.com>
X-Google-Original-From: Jiang Biao <benbjiang@tencent.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        Jiang Biao <benbjiang@tencent.com>
Subject: [PATCH] sched/fair: add protection for delta of wait time
Date:   Sun, 17 Jan 2021 20:31:04 +0800
Message-Id: <20210117123104.27589-1-benbjiang@tencent.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiang Biao <benbjiang@tencent.com>

delta in update_stats_wait_end() might be negative, which would
make following statistics go wrong.

Add protection for delta of wait time, like what have been done in
update_stats_enqueue_sleeper() for deltas of sleep/block time.

Signed-off-by: Jiang Biao <benbjiang@tencent.com>
---
 kernel/sched/fair.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c0374c1152e0..ac950ac950bc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -917,6 +917,9 @@ update_stats_wait_end(struct cfs_rq *cfs_rq, struct sched_entity *se)
 
 	delta = rq_clock(rq_of(cfs_rq)) - schedstat_val(se->statistics.wait_start);
 
+	if ((s64)delta < 0)
+		delta = 0;
+
 	if (entity_is_task(se)) {
 		p = task_of(se);
 		if (task_on_rq_migrating(p)) {
-- 
2.21.0

