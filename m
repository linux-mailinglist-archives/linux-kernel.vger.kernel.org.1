Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5CB029BD4B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1795005AbgJ0POv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 11:14:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:44354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1793898AbgJ0PI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 11:08:57 -0400
Received: from localhost.localdomain (i16-lef01-ix2-212-195-25-126.ft.lns.abo.bbox.fr [212.195.25.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89BFF20657;
        Tue, 27 Oct 2020 15:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603811337;
        bh=IAiyoMSp5eobg2tYTlH1ydz13QN9WNKa7GSzZyxSfPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yelSqX+njT/MlciL+fm4HSbY42RzztO0ZWOK+6jadfytp2t9KrGZMFitRyUeLQzwd
         JbIYRxP/4OL5LXoGFl3IFUwp//Hj/OcXxT0f8ezW4ZZvc8odwlgF8+WTgd5eddI88W
         FgjtUy0mzmRKhqZr9tCvm5Qy1rtz2Bv3owHUhN58=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 4/5] context_tracking: Only define schedule_user() on !HAVE_CONTEXT_TRACKING_OFFSTACK archs
Date:   Tue, 27 Oct 2020 16:08:26 +0100
Message-Id: <20201027150827.148821-5-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027150827.148821-1-frederic@kernel.org>
References: <20201027150827.148821-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

schedule_user() was traditionally used by the entry code's tail to
preempt userspace after the call to user_enter(). Indeed the call to
user_enter() used to be performed upon syscall exit slow path which was
right before the last opportunity to schedule() while resuming to
userspace. The context tracking state had to be saved on the task stack
and set back to CONTEXT_KERNEL temporarily in order to safely switch to
another task.

Only a few archs use it now and those implementing
HAVE_CONTEXT_TRACKING_OFFSTACK definetly can't rely on it.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Phil Auld <pauld@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c23d7cb5aee3..44426e5acde2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4631,7 +4631,7 @@ void __sched schedule_idle(void)
 	} while (need_resched());
 }
 
-#ifdef CONFIG_CONTEXT_TRACKING
+#if defined(CONFIG_CONTEXT_TRACKING) && !defined(CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK)
 asmlinkage __visible void __sched schedule_user(void)
 {
 	/*
-- 
2.25.1

