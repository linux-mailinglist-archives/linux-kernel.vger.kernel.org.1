Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79182EB73A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 01:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbhAFA6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 19:58:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:55892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbhAFA6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 19:58:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16B0C22E00;
        Wed,  6 Jan 2021 00:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609894658;
        bh=rQqR/tewAPDEPU8nV2ulHgvuwNzLDzb0hVd3JyVLCME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f3QXOxcSXAdES8yMuy+ppeLduCf7aQY/vFWGh/by6FnMEfBV4aNAAyvZAEFzMjuOE
         jAinXz3LM9fFUoT0KuHObg1keiasPSHqMDccQ3XUeq0O0tXCM/tT+RiJVsrl4XYtKF
         1tfJNbX+2g5A47i6nKVDsMy7C6bl8HyApTTnexzWefeQDz9khCiAohfU8j8DICcH1K
         Fjch7R/p4MbM/2DuKSS0qWIlPnP9OGEXoMOk4aL4M3Cz72B8KlUJ1nGleR7HSvQ8Qe
         aLvYtJ4dJTIxwBZuLjyasx40/k3VOO6SJxAuKIvUdV81mHkHNkCQE030ry3/LT18Xp
         xputc4D3nFWuQ==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Wang Qing <wangqing@vivo.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 2/6] locking: Remove duplicate include of percpu-rwsem.h
Date:   Tue,  5 Jan 2021 16:57:32 -0800
Message-Id: <20210106005736.12613-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106005713.GA12492@paulmck-ThinkPad-P72>
References: <20210106005713.GA12492@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

This commit removes an unnecessary #include.

Signed-off-by: Wang Qing <wangqing@vivo.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/locking/locktorture.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 62d215b..af99e9c 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -27,7 +27,6 @@
 #include <linux/moduleparam.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
-#include <linux/percpu-rwsem.h>
 #include <linux/torture.h>
 
 MODULE_LICENSE("GPL");
-- 
2.9.5

