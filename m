Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640771EE258
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 12:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgFDKXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 06:23:47 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:8933 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726209AbgFDKXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 06:23:47 -0400
From:   Peter Enderborg <peter.enderborg@sony.com>
To:     "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, <rcu@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Peter Enderborg <peter.enderborg@sony.com>
Subject: [PATCH] rcu: Stop shrinker loop
Date:   Thu, 4 Jun 2020 12:23:20 +0200
Message-ID: <20200604102320.15914-1-peter.enderborg@sony.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-SEG-SpamProfiler-Analysis: v=2.3 cv=VdGJw2h9 c=1 sm=1 tr=0 a=Jtaq2Av1iV2Yg7i8w6AGMw==:117 a=nTHF0DUjJn0A:10 a=z6gsHLkEAAAA:8 a=ZjHLJIMreXujHcPb9Y4A:9 a=d-OLMTCWyvARjPbQ-enb:22
X-SEG-SpamProfiler-Score: 0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The count and scan can be separated in time. It is a fair chance
that all work is already done when the scan starts. It
then might retry. This is can be avoided with returning SHRINK_STOP.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c716eadc7617..8b36c6b2887d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3310,7 +3310,7 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 			break;
 	}
 
-	return freed;
+	return freed == 0 ? SHRINK_STOP : freed;
 }
 
 static struct shrinker kfree_rcu_shrinker = {
-- 
2.17.1

