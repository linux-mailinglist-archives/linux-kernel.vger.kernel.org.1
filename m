Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD8F2727F2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 16:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgIUOk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 10:40:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51763 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727610AbgIUOk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600699226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+enI0R7DMCyjAKerCPgkYFbbuWxHbIO4MyCZsWUDDyc=;
        b=e9bgo7aDnMqIdiImJBlvJB4rbph0IWPNqlQ7zwZzQqPbO+JhIx+hXIwZOVvc2Ll+l4GPBn
        910DubhAauVDWzG+DU/AVcqmuLI3g1Wm9ILNbHXK4X8jUhdrRvvBh+3pbdWFvIWqVVCWuc
        TB+kbwKhGIUt+gdHWgTBB5l26fTOvBE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-PhKmVfuPMJ-JDwgUEL8ctA-1; Mon, 21 Sep 2020 10:40:20 -0400
X-MC-Unique: PhKmVfuPMJ-JDwgUEL8ctA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C0D2802B4A;
        Mon, 21 Sep 2020 14:40:16 +0000 (UTC)
Received: from x1.bristot.me.redhat.com (ovpn-113-39.rdu2.redhat.com [10.10.113.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7248A60BF4;
        Mon, 21 Sep 2020 14:40:06 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "J . Avila" <elavila@google.com>, Wei Wang <wvw@google.com>,
        Todd Kjos <tkjos@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] sched/rt: Disable RT_RUNTIME_SHARE by default
Date:   Mon, 21 Sep 2020 16:39:49 +0200
Message-Id: <b776ab46817e3db5d8ef79175fa0d71073c051c7.1600697903.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RT_RUNTIME_SHARE sched feature enables the sharing of rt_runtime
between CPUs, allowing a CPU to run a real-time task up to 100% of the
time while leaving more space for non-real-time tasks to run on the CPU
that lend rt_runtime.

The problem is that a CPU can easily borrow enough rt_runtime to allow
a spinning rt-task to run forever, starving per-cpu tasks like kworkers,
which are non-real-time by design.

This patch disables RT_RUNTIME_SHARE by default, avoiding this problem.
The feature will still be present for users that want to enable it,
though.

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
---
 kernel/sched/features.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 7481cd96f391..68d369cba9e4 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -77,7 +77,7 @@ SCHED_FEAT(WARN_DOUBLE_CLOCK, false)
 SCHED_FEAT(RT_PUSH_IPI, true)
 #endif
 
-SCHED_FEAT(RT_RUNTIME_SHARE, true)
+SCHED_FEAT(RT_RUNTIME_SHARE, false)
 SCHED_FEAT(LB_MIN, false)
 SCHED_FEAT(ATTACH_AGE_LOAD, true)
 
-- 
2.26.2

