Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABE21F7213
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 04:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgFLCIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 22:08:39 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:48263 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726305AbgFLCIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 22:08:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0U.Jo89s_1591927699;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U.Jo89s_1591927699)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 12 Jun 2020 10:08:19 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, trivial@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH 2/4] rcu: grplo/grphi just records CPU number
Date:   Fri, 12 Jun 2020 10:07:53 +0800
Message-Id: <20200612020755.50526-3-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200612020755.50526-1-richard.weiyang@linux.alibaba.com>
References: <20200612020755.50526-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We store lowest and highest CPU number belongs to a rcu_node, which is
not the group number.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 kernel/rcu/tree.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index ed9b534ad870..ce9ab7371706 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -73,8 +73,8 @@ struct rcu_node {
 	unsigned long ffmask;	/* Fully functional CPUs. */
 	unsigned long grpmask;	/* Mask to apply to parent qsmask. */
 				/*  Only one bit will be set in this mask. */
-	int	grplo;		/* lowest-numbered CPU or group here. */
-	int	grphi;		/* highest-numbered CPU or group here. */
+	int	grplo;		/* lowest-numbered CPU here. */
+	int	grphi;		/* highest-numbered CPU here. */
 	u8	grpnum;		/* CPU/group number for next level up. */
 	u8	level;		/* root is at level 0. */
 	bool	wait_blkd_tasks;/* Necessary to wait for blocked tasks to */
-- 
2.20.1 (Apple Git-117)

