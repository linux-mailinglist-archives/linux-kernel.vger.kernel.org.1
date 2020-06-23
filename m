Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDAA9204531
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731705AbgFWAWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:22:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:48584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731569AbgFWAVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:21:53 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 236F420CC7;
        Tue, 23 Jun 2020 00:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592871713;
        bh=gn1tlwBQjxEjJ+FHG1AG7XldVGYaI61VBRJCKCiU2DM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cXnbh+t22d35FG9OlbLp5MSiXiqvzq6bBxBXBV3j1g1MxjMz2T6Tzntuu4Ck5QU2+
         7wvoWUmUztzBONHKMxmF3syFetF6YuI0vBQt2IP7TOLZLRXUenhDtx7e/+nUkZYaKO
         JExNMDxWhVKK8YgWQHnzbZh1zs+8rsaTTRweDDsE=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Peter Enderborg <peter.enderborg@sony.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 19/26] rcu: Stop shrinker loop
Date:   Mon, 22 Jun 2020 17:21:40 -0700
Message-Id: <20200623002147.25750-19-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002128.GA25456@paulmck-ThinkPad-P72>
References: <20200623002128.GA25456@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Enderborg <peter.enderborg@sony.com>

The count and scan can be separated in time, and there is a fair chance
that all work is already done when the scan starts, which might in turn
result in a needless retry.  This commit therefore avoids this retry by
returning SHRINK_STOP.

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 67912ad..0806762 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3314,7 +3314,7 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 			break;
 	}
 
-	return freed;
+	return freed == 0 ? SHRINK_STOP : freed;
 }
 
 static struct shrinker kfree_rcu_shrinker = {
-- 
2.9.5

