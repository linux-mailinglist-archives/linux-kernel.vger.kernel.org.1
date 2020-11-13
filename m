Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB172B1D3A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 15:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgKMOY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 09:24:59 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52892 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbgKMOYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 09:24:37 -0500
Message-Id: <20201113141734.660734753@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605277475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=74sFpsXIvDvQMapG5Pk7sHOAlnsFK2WUN0Z1OZznnHw=;
        b=QExJdAkfPvDBwGkQeFoFlNrm4JXX8p/fB5MMB0uuiSdagTfMsaVZdXy9G9GBW/pJGeMMhF
        v2D/rBvzOwa2UI3CLJLGXLp9JbHgnTpigxMvChKOaxUXPDJjvXKV29RXNoCJIM02ssvFoi
        fAJSXNYmXPoUeZuLpHQOomjC1BPe/vo61ydVsoo44kvswfSQrHrQmBcsQcqiTK7Ntdx/Py
        xO9hHJhmudd3p/qulzbc5q7cT/UiquVfGqe3gjkh05B6zglrlDkMWKu7yjfwROgKAs1IpI
        nuG8KFPBmSSMRxwWYbHo6AVIPTGAZ3rfXubf5JvX0QsRdE7Y3QWJo63Q754Rlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605277475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=74sFpsXIvDvQMapG5Pk7sHOAlnsFK2WUN0Z1OZznnHw=;
        b=ZH/Vk7tQMxbpxGEvsAm2QgjQRjaIccewrZgX7RMwhumzkvb9r1Yzrpuqulq+HX3l7OQ5+E
        wyyqEioCc993+MDA==
Date:   Fri, 13 Nov 2020 15:02:24 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [patch 17/19] softirq: Replace barrier() with cpu_relax() in
 tasklet_unlock_wait()
References: <20201113140207.499353218@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A barrier() in a tight loop which waits for something to happen on a remote
CPU is a pointless exercise. Replace it with cpu_relax() which allows HT
siblings to make progress.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/interrupt.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -668,7 +668,8 @@ static inline void tasklet_unlock(struct
 
 static inline void tasklet_unlock_wait(struct tasklet_struct *t)
 {
-	while (test_bit(TASKLET_STATE_RUN, &(t)->state)) { barrier(); }
+	while (test_bit(TASKLET_STATE_RUN, &(t)->state))
+		cpu_relax();
 }
 #else
 #define tasklet_trylock(t) 1

