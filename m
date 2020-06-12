Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B161F7210
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 04:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgFLCIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 22:08:24 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:46637 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726321AbgFLCIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 22:08:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0U.JqOrS_1591927698;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U.JqOrS_1591927698)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 12 Jun 2020 10:08:18 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, trivial@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH 1/4] rcu: gp_max is protected by root rcu_node's lock
Date:   Fri, 12 Jun 2020 10:07:52 +0800
Message-Id: <20200612020755.50526-2-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200612020755.50526-1-richard.weiyang@linux.alibaba.com>
References: <20200612020755.50526-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gp_max is protected by root rcu_node's lock, let's move the definition
to the place where comments indicate.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 kernel/rcu/tree.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 43991a40b084..ed9b534ad870 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -301,6 +301,8 @@ struct rcu_state {
 	u8	boost ____cacheline_internodealigned_in_smp;
 						/* Subject to priority boost. */
 	unsigned long gp_seq;			/* Grace-period sequence #. */
+	unsigned long gp_max;			/* Maximum GP duration in */
+						/*  jiffies. */
 	struct task_struct *gp_kthread;		/* Task for grace periods. */
 	struct swait_queue_head gp_wq;		/* Where GP task waits. */
 	short gp_flags;				/* Commands for GP task. */
@@ -346,8 +348,6 @@ struct rcu_state {
 						/*  a reluctant CPU. */
 	unsigned long n_force_qs_gpstart;	/* Snapshot of n_force_qs at */
 						/*  GP start. */
-	unsigned long gp_max;			/* Maximum GP duration in */
-						/*  jiffies. */
 	const char *name;			/* Name of structure. */
 	char abbr;				/* Abbreviated name. */
 
-- 
2.20.1 (Apple Git-117)

