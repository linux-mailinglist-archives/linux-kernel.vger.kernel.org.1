Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834042B687A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 16:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733078AbgKQPQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 10:16:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:34368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729184AbgKQPQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 10:16:58 -0500
Received: from localhost.localdomain (unknown [176.167.180.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6C1324198;
        Tue, 17 Nov 2020 15:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605626218;
        bh=F/3unrXBIqFN1AMtFeEOTOxOuveYqZ1JM6MxSNhHAkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B0dX1Z6Bg3R7AZDLS5f4f6Gt07rcRZBx64QBrcoydbb0bryEAcLUDPb72xfUm0f3A
         QMTRHRY0wSEXZt6VVk9+/razvK2g2VL4d+KIrTDG9k+DlGjSWhrL11dtRiww/y7DJb
         ARhhYaqXLOAl8R2+CNaT08gi9bHccpxt9/RnsC8Y=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 5/5] x86: Support HAVE_CONTEXT_TRACKING_OFFSTACK
Date:   Tue, 17 Nov 2020 16:16:37 +0100
Message-Id: <20201117151637.259084-6-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201117151637.259084-1-frederic@kernel.org>
References: <20201117151637.259084-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A lot of ground work has been performed on x86 entry code. Fragile path
between user_enter() and user_exit() have IRQs disabled. Uses of RCU and
intrumentation in these fragile areas have been explicitly annotated
and protected.

This architecture doesn't need exception_enter()/exception_exit()
anymore and has therefore earned CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Phil Auld <pauld@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f6946b81f74a..d793361839b5 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -162,6 +162,7 @@ config X86
 	select HAVE_CMPXCHG_DOUBLE
 	select HAVE_CMPXCHG_LOCAL
 	select HAVE_CONTEXT_TRACKING		if X86_64
+	select HAVE_CONTEXT_TRACKING_OFFSTACK	if HAVE_CONTEXT_TRACKING
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
-- 
2.25.1

