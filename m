Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F9A2B1D36
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 15:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgKMOYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 09:24:46 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52700 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbgKMOYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 09:24:38 -0500
Message-Id: <20201113141734.788853107@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605277476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=H39LibppQlvIcymGFnJumuF0TnrJv/wQeeJyrMh1wnE=;
        b=bibqvpSiXbaOS4h7rid9FwsrfZSPl9dqxvvgGgVUV9uMsDpeVlzjuZBL5vmTImnrP8aKgV
        W75ixYNzPjvGLHB88W8l/PfqJkl2eNqE+AOJfxUdflFalLioQXWlwzFwEOeErkpduUMv2T
        hDTxcgjpz300WGMDoXe9QVdQolKoXoyQeFZRUG+sc6QOFdLOEug1POHDDMo0Rnw6dn/VhC
        3bHFASxxIKjReHu3RkXYKgSweZTTUxfSnAG5kRhGsvHOJpthEpvQH0zTb/i3PIzTTYrKar
        lGIj6hnPgNEg7qHHgMND18ig/lg3lWYVjZh91/LIpb63t+M6EiR2BKOd8cBqGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605277476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=H39LibppQlvIcymGFnJumuF0TnrJv/wQeeJyrMh1wnE=;
        b=r81MeMUbNWSbPQgCuPKytMvpffni1swCI25j1iY9kSh6gfm/DKBFJAFvtL/QEa+0xZbfNJ
        zDN9yQZWdSAL1bAQ==
Date:   Fri, 13 Nov 2020 15:02:25 +0100
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
Subject: [patch 18/19] tasklets: Use static inlines for stub implementations
References: <20201113140207.499353218@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inlines exist for a reason.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/interrupt.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -672,9 +672,9 @@ static inline void tasklet_unlock_wait(s
 		cpu_relax();
 }
 #else
-#define tasklet_trylock(t) 1
-#define tasklet_unlock_wait(t) do { } while (0)
-#define tasklet_unlock(t) do { } while (0)
+static inline int tasklet_trylock(struct tasklet_struct *t) { return 1; }
+static inline void tasklet_unlock(struct tasklet_struct *t) { }
+static inline void tasklet_unlock_wait(struct tasklet_struct *t) { }
 #endif
 
 extern void __tasklet_schedule(struct tasklet_struct *t);

