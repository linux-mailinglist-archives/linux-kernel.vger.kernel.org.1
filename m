Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2D5283431
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 12:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgJEKtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 06:49:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbgJEKtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 06:49:35 -0400
Received: from localhost.localdomain (unknown [94.238.213.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAAD22075A;
        Mon,  5 Oct 2020 10:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601894975;
        bh=rDBul0gkB3Z2Wq2yMzSWV4891jWR2/YLkBWeeghgjK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iihw14mT/Q/4MzZgjhHOvuZnBhBkDqI8ofOzOr9Rdv4qz/ni6vNyCDVHyTIidDMVG
         q/26Te7pMtbgOy+ZngqBbCPCmrtkXP3COYv/kPEb5ABX/BD5qtRZWlt1CMLu8WWtsr
         5dGfLjeYFZR20UUYrp/zbyocF3dQoCXsOfgxMI+E=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 5/5] x86: Support HAVE_CONTEXT_TRACKING_OFFSTACK
Date:   Mon,  5 Oct 2020 12:49:19 +0200
Message-Id: <20201005104919.5250-6-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201005104919.5250-1-frederic@kernel.org>
References: <20201005104919.5250-1-frederic@kernel.org>
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
index 7101ac64bb20..7a66865f32a8 100644
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

