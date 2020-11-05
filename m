Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8662E2A8A74
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 00:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732581AbgKEXJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 18:09:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:34452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732441AbgKEXJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:09:25 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B339217A0;
        Thu,  5 Nov 2020 23:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604617765;
        bh=h9SU9vUbFz1ijbGCGqgEEi7VUhGXALuvKvMWjnAg/ic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zKec6P5P48azcbUiknmOX3WIZdYMMiqstS8TE1SQEzl9+F2vYv1zg0yVSFFTqQM1V
         1BmyNveJ+TR3tv3//okfK0B8LqNRJDx5TH6UH4NkkoFsLmYDEWiG5KXQTgMw+G5iRP
         mECAIH9IMzPL5cfOoCjVx9gh7+RlNz2gp+bWjnrA=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Asif Rasheed <b00073877@aus.edu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 04/16] list.h: Update comment to explicitly note circular lists
Date:   Thu,  5 Nov 2020 15:09:09 -0800
Message-Id: <20201105230921.19017-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105230856.GA18904@paulmck-ThinkPad-P72>
References: <20201105230856.GA18904@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Asif Rasheed <b00073877@aus.edu>

The students in the Operating System Lecture Section at the
American University of Sharjah were confused by the header comment
in include/linux/list.h, which says "Simple doubly linked list
implementation".  This comment means "simple" as in "not complex",
but "simple" is often used in this context to mean "not circular".
This commit therefore avoids this ambiguity by explicitly calling out
"circular".

Signed-off-by: Asif Rasheed <b00073877@aus.edu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/list.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index a18c87b..89bdc92 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -9,7 +9,7 @@
 #include <linux/kernel.h>
 
 /*
- * Simple doubly linked list implementation.
+ * Circular doubly linked list implementation.
  *
  * Some of the internal functions ("__xxx") are useful when
  * manipulating whole lists rather than single entries, as
-- 
2.9.5

