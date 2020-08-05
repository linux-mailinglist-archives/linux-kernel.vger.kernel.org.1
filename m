Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372CC23D306
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 22:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgHEUbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 16:31:52 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35732 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726078AbgHEUbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 16:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596659509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=8B67PlklxUGzIOZVHxF/ayR8w2AByyTls0ffTVLHi6c=;
        b=S70ZBaYy9hx4LDPAnyAXZe0/vyZ1VqUNf5eX8XMQbV6vYdObGshJ+eO55wm/YN28R4Xr3U
        iXR91M44KJlonwG9f/qhzuNzjJl/UUdp/dWxrOwEF7mZwAreVXuC8T7IE+NFSH1v5vYvPU
        Js/0dPyleWQBqObm6mOtLOExlbJzyZA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-fg4jNGiPMd6zoITUhJ1LtQ-1; Wed, 05 Aug 2020 16:31:45 -0400
X-MC-Unique: fg4jNGiPMd6zoITUhJ1LtQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 731D580BCAB;
        Wed,  5 Aug 2020 20:31:44 +0000 (UTC)
Received: from pauld.bos.com (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0917610013D7;
        Wed,  5 Aug 2020 20:31:39 +0000 (UTC)
From:   Phil Auld <pauld@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Qais Yousef <qais.yousef@arm.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH] sched: Fix use of count for nr_running tracepoint
Date:   Wed,  5 Aug 2020 16:31:38 -0400
Message-Id: <20200805203138.1411-1-pauld@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The count field is meant to tell if an update to nr_running
is an add or a subtract. Make it do so by adding the missing
minus sign.

Fixes: 9d246053a691 ("sched: Add a tracepoint to track rq->nr_running")
Signed-off-by: Phil Auld <pauld@redhat.com>
---
 kernel/sched/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3fd283892761..28709f6b0975 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1999,7 +1999,7 @@ static inline void sub_nr_running(struct rq *rq, unsigned count)
 {
 	rq->nr_running -= count;
 	if (trace_sched_update_nr_running_tp_enabled()) {
-		call_trace_sched_update_nr_running(rq, count);
+		call_trace_sched_update_nr_running(rq, -count);
 	}
 
 	/* Check if we still need preemption */
-- 
2.26.2

