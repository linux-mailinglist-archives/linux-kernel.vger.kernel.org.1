Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950F428ED2F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 08:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbgJOGtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 02:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgJOGtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 02:49:16 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F348C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 23:49:16 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id e7so1395587pfn.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 23:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Aj3k1TUx2Xyvn7c5sjrpioU7FRQHTTQ4Isq3jtdMKxQ=;
        b=cFo/XTMdNV5gvmqI95/qCTwkq+Qc7qhkeWRNCqjy1+mqXj9CQP1ObqTG4Oc8UVWqt8
         CwqRDPNn1F82nfDOsgKXTKXzY1XSCRQ+VF5ddS5EtNSfVoHwp7NRemhuRD7Bz31NC3sB
         6DbRO36HBhecuW+qt7atEA3Ofnc7tg0RwwVSBjR+LoKSLCMseNa8pSgzwsau9mdT/teE
         jFwhrEHSGW/DAOZHBlx8kn2clsyRuBaxH161gc7Nt8ul0MqaJJoyLX5sxzXItxf1eyx3
         r0JstXls159EYV3d3asJfnB/iVXFT5V/VwpDzBlePnZEbNafgdXfgcALQ++74c3FYIxW
         xnfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Aj3k1TUx2Xyvn7c5sjrpioU7FRQHTTQ4Isq3jtdMKxQ=;
        b=VLzZ0RbeoJe0JDt7CUiPNs7BI64ZAbg1MDOuRnsCXJnmwcSYQy16yGrh/0VpUBzuEX
         4VBn2d3O12fqKJ2rlqyIjkLNcq/uj9Tszqd9tO81E/xbJ2G57I4M+RhYJnOB/Llm0g/E
         OAkOP4lWW2DK3U1Zjl8+fyDUcB0WzPsNLktIlSCd1QVwon1zNOw3H7w9RP8oEyGJ6IkU
         GLL/0A5PTqvdnAcCKluoz2C+QVwst0NFeGa7WsQMXibrsdvXqNDBCN0k3hryNO92Ymhi
         UeHuLtbQpKppidaekxJGZ9mXNtTaoGW1psm7BWujY39iIbHRhDSgxW871a9m2hY7bmyl
         ip4g==
X-Gm-Message-State: AOAM532r2FefPKTSM4/Z5B65M1pFCzYLLI2A6WOk1K+AfM16L8JWNjHo
        WoGTpkBq0iJQwu/R6JF4jCp/7YQHaQomqg==
X-Google-Smtp-Source: ABdhPJymr58AOo25YBG8RLbjEucbZlnifw45ZKQEFJTbZVIgcDJiz6yXzg9n8IVHtm8OKpiSgHjCAg==
X-Received: by 2002:a63:7549:: with SMTP id f9mr2277935pgn.47.1602744555826;
        Wed, 14 Oct 2020 23:49:15 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id s187sm2067592pgb.54.2020.10.14.23.49.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Oct 2020 23:49:15 -0700 (PDT)
From:   qianjun.kernel@gmail.com
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Cc:     jun qian <qianjun.kernel@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 1/1] Sched/fair: Improve the accuracy of sched_stat_wait statistics
Date:   Thu, 15 Oct 2020 14:48:46 +0800
Message-Id: <20201015064846.19809-1-qianjun.kernel@gmail.com>
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
Reviewed-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/sched/fair.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1a68a05..6f8ca0c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -906,6 +906,15 @@ static void update_curr_fair(struct rq *rq)
 	if (!schedstat_enabled())
 		return;
 
+	/*
+	 * When the sched_schedstat changes from 0 to 1, some sched se
+	 * maybe already in the runqueue, the se->statistics.wait_start
+	 * will be 0.So it will let the delta wrong. We need to avoid this
+	 * scenario.
+	 */
+	if (unlikely(!schedstat_val(se->statistics.wait_start)))
+		return;
+
 	delta = rq_clock(rq_of(cfs_rq)) - schedstat_val(se->statistics.wait_start);
 
 	if (entity_is_task(se)) {
-- 
1.8.3.1

