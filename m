Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10C229D2F2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgJ1Vjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbgJ1Vj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:39:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE1CC0613D1;
        Wed, 28 Oct 2020 14:39:28 -0700 (PDT)
Date:   Wed, 28 Oct 2020 20:10:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603912255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=VPk+kaJfeoG+B3H81aUbzAQmseyhIwjeeSTJ0VNDmrY=;
        b=tT6dU2cR+BQA37VONU2ZxSPm9Es3hDgpsNvd9EENqu92zUWYpe7v61xPocE3YXJzK6tdxE
        11Av3DiCI8cpn5On2YPzN1JavoENI/n27ooN2rnoQHBcZ+HOl2fsaQ88oxAT4QV35AAZoI
        asf3L8iE+l9Twg1+ACj4UboIJjaXA6a+/PpzGmt7tb+fYHQi3KaVLF539HmNoh1reQbJvS
        wTzVspLvfHqU7XfqhB+Sl1wCYWDrQV6raOAD7AtAGETyWyZfZ+ibV+sVHLS5VkrOeu4VWX
        nPIEOZpy7pwYNHLcyjOMSc21PsY+AeXvdK5W5cFP/cBs8TovECCvcRX4Eu7UXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603912255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=VPk+kaJfeoG+B3H81aUbzAQmseyhIwjeeSTJ0VNDmrY=;
        b=K2hKwVW6mugMK0qdTROr+2GD9MqgtX32saTcek77ieSJrEVsMPA02HyznNSXh6CNuFs/1J
        vNacJYiPf5YG21CA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT] mm/memcontrol: Disable preemption in
 __mod_memcg_lruvec_state()
Message-ID: <20201028191054.u5ucftllw7slxu4b@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The callers expect disabled preemption/interrupts while invoking
__mod_memcg_lruvec_state(). This works mainline because a lock of
some kind is acquired.

Use preempt_disable_rt() where per-CPU variables are accessed and a
stable pointer is expected. This is also done in __mod_zone_page_state()
for the same reason.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 mm/memcontrol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f35ffe52cc4f8..09fa87f7a8119 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -829,6 +829,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
 	memcg = pn->memcg;
 
+	preempt_disable_rt();
 	/* Update memcg */
 	__mod_memcg_state(memcg, idx, val);
 
@@ -848,6 +849,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 		x = 0;
 	}
 	__this_cpu_write(pn->lruvec_stat_cpu->count[idx], x);
+	preempt_enable_rt();
 }
 
 /**
-- 
2.28.0

