Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1A11F7211
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 04:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgFLCIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 22:08:25 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:46982 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726326AbgFLCIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 22:08:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07425;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0U.J3VsV_1591927700;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U.J3VsV_1591927700)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 12 Jun 2020 10:08:20 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, trivial@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH 4/4] rcu: use gp_seq instead of rcu_gp_seq for consistency
Date:   Fri, 12 Jun 2020 10:07:55 +0800
Message-Id: <20200612020755.50526-5-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200612020755.50526-1-richard.weiyang@linux.alibaba.com>
References: <20200612020755.50526-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit de30ad512a66 ("rcu: Introduce grace-period sequence numbers")
introduce gp_seq in rcu_state/rcu_node/rcu_data. And this field in last
two structure track the one in first.

While the comment use rcu_gp_seq which is a little misleading for
audience. Let's use the exact name gp_seq for consistency.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 kernel/rcu/tree.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 512829eed545..3356842bc185 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -41,7 +41,7 @@ struct rcu_node {
 	raw_spinlock_t __private lock;	/* Root rcu_node's lock protects */
 					/*  some rcu_state fields as well as */
 					/*  following. */
-	unsigned long gp_seq;	/* Track rsp->rcu_gp_seq. */
+	unsigned long gp_seq;	/* Track rsp->gp_seq. */
 	unsigned long gp_seq_needed; /* Track furthest future GP request. */
 	unsigned long completedqs; /* All QSes done for this node. */
 	unsigned long qsmask;	/* CPUs or groups that need to switch in */
@@ -149,7 +149,7 @@ union rcu_noqs {
 /* Per-CPU data for read-copy update. */
 struct rcu_data {
 	/* 1) quiescent-state and grace-period handling : */
-	unsigned long	gp_seq;		/* Track rsp->rcu_gp_seq counter. */
+	unsigned long	gp_seq;		/* Track rsp->gp_seq. */
 	unsigned long	gp_seq_needed;	/* Track furthest future GP request. */
 	union rcu_noqs	cpu_no_qs;	/* No QSes yet for this CPU. */
 	bool		core_needs_qs;	/* Core waits for quiesc state. */
-- 
2.20.1 (Apple Git-117)

