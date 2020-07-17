Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6F1223DA5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 16:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgGQOGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 10:06:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbgGQOGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:06:00 -0400
Received: from lenoir.home (lfbn-ncy-1-317-216.w83-196.abo.wanadoo.fr [83.196.152.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 640582173E;
        Fri, 17 Jul 2020 14:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594994760;
        bh=MgaohWzGrt7HuiOM3koqYgYCQEle+96fHdhMFvnhnms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hyhOeGGfUyZhSbIA5c+Qh9AE3FNqqGN0yofZMpbobZ75AMY0frWGd7Yp89nNMV1I4
         LE6lGMOFpiB8XihMUPossXou9D/x/3Hy0O4AtCl2C+pJbgJ8dXyui2IPZc1gOtVNKF
         PudUXBGYNnXTW2z9mokNOwETkKBv1slnW4HwPRcI=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 02/12] timer: Preserve higher bits of expiration on index calculation
Date:   Fri, 17 Jul 2020 16:05:41 +0200
Message-Id: <20200717140551.29076-3-frederic@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200717140551.29076-1-frederic@kernel.org>
References: <20200717140551.29076-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The higher bits of the timer expiration are cropped while calling
calc_index() due to the implicit cast from unsigned long to unsigned int.

This loss shouldn't have consequences on the current code since all the
computation to calculate the index is done on the lower 32 bits.

However we are preparing to return the actual bucket expiration from
calc_index() in order to properly fix base->next_expiry updates.
Preserving the higher bits is a requirement to achieve that.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index df1ff803acc4..bcdc3045138d 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -487,7 +487,7 @@ static inline void timer_set_idx(struct timer_list *timer, unsigned int idx)
  * Helper function to calculate the array index for a given expiry
  * time.
  */
-static inline unsigned calc_index(unsigned expires, unsigned lvl)
+static inline unsigned calc_index(unsigned long expires, unsigned lvl)
 {
 	expires = (expires + LVL_GRAN(lvl)) >> LVL_SHIFT(lvl);
 	return LVL_OFFS(lvl) + (expires & LVL_MASK);
-- 
2.26.2

