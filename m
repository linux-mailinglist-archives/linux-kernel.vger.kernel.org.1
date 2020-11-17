Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07E92B6B95
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgKQRTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:19:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:58830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbgKQRTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:19:52 -0500
Received: from localhost.localdomain (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F098624654;
        Tue, 17 Nov 2020 17:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605633592;
        bh=daJLU3n02mJ6i0JpeUafqSjeQahZMcJAuVKF7BfNorg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=hyVhRArxhBJv1lLMLg8aDWsMd+avk0FDIhgJpBPiQwzCrafHBqfbGejiDZ9gAyP38
         1MHHzFHMseNIb/8M3noYXl8kRMSi95ZCa8mr/9wJnvORzdYmJ4DKfwVvuwX8h8yGg1
         JmzQVLzGM7O9LOqPrJaKIrXkWUtUPcvJCaHk/cqw=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>, Tom Zanussi <zanussi@kernel.org>
Cc:     stable-rt@vger.kernel.org
Subject: [PATCH RT 1/3] mm/memcontrol: Disable preemption in __mod_memcg_lruvec_state()
Date:   Tue, 17 Nov 2020 11:19:46 -0600
Message-Id: <46fc7bbf28dfbafd2f6e87b736458c4ba060728c.1605633581.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1605633581.git.zanussi@kernel.org>
References: <cover.1605633581.git.zanussi@kernel.org>
In-Reply-To: <cover.1605633581.git.zanussi@kernel.org>
References: <cover.1605633581.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v4.19.152-rt66-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit 74858f0d38a8d3c069a0745ff53ae084c8e7cabb ]

The callers expect disabled preemption/interrupts while invoking
__mod_memcg_lruvec_state(). This works mainline because a lock of
somekind is acquired.

Use preempt_disable_rt() where per-CPU variables are accessed and a
stable pointer is expected. This is also done in __mod_zone_page_state()
for the same reason.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>

 Conflicts:
	mm/memcontrol.c
---
 include/linux/memcontrol.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index cc6b6532eb56..dbb2c4e27277 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -665,6 +665,7 @@ static inline void __mod_lruvec_state(struct lruvec *lruvec,
 
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
 
+	preempt_disable_rt();
 	/* Update memcg */
 	__mod_memcg_state(pn->memcg, idx, val);
 
@@ -675,6 +676,7 @@ static inline void __mod_lruvec_state(struct lruvec *lruvec,
 		x = 0;
 	}
 	__this_cpu_write(pn->lruvec_stat_cpu->count[idx], x);
+	preempt_enable_rt();
 }
 
 static inline void mod_lruvec_state(struct lruvec *lruvec,
-- 
2.17.1

