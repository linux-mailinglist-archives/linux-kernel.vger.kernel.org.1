Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CFB223DAC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 16:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgGQOGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 10:06:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727820AbgGQOGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:06:16 -0400
Received: from lenoir.home (lfbn-ncy-1-317-216.w83-196.abo.wanadoo.fr [83.196.152.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA4452173E;
        Fri, 17 Jul 2020 14:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594994776;
        bh=5DRJ0Lrnn+x7j3HLiAzOqL132J2zfnhxqr92++x1nOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hR5GTivpM37ZavR7COsJHf7F3pUhECay6OK+TQ/gIUMIm6j18Lka2S+cd+javHWxm
         YtwkQabxCjIuv1H/V/9cbQ9b2jteEeMMwFZADz/VRE6h6G2B8tBqWlR/361x4xzOVD
         3I7cOrDG9jy3gQTrv5/WCVrzptsY5BL3235l5CkI=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 12/12] timer: Lower base clock forwarding threshold
Date:   Fri, 17 Jul 2020 16:05:51 +0200
Message-Id: <20200717140551.29076-13-frederic@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200717140551.29076-1-frederic@kernel.org>
References: <20200717140551.29076-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is nothing that prevents us from forwarding the base clock if
it's one jiffy off. This reason for this arbitrary limit is historical
and doesn't seem to stand anymore.

Tested-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/time/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 8b3fb52d8c47..77e21e98ec32 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -894,7 +894,7 @@ static inline void forward_timer_base(struct timer_base *base)
 	 * Also while executing timers, base->clk is 1 offset ahead
 	 * of jiffies to avoid endless requeuing to current jffies.
 	 */
-	if ((long)(jnow - base->clk) < 2)
+	if ((long)(jnow - base->clk) < 1)
 		return;
 
 	/*
-- 
2.26.2

