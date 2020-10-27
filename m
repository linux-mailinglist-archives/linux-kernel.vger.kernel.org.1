Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A921A29BF0E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 18:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1814890AbgJ0RAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 13:00:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1793900AbgJ0PI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 11:08:59 -0400
Received: from localhost.localdomain (i16-lef01-ix2-212-195-25-126.ft.lns.abo.bbox.fr [212.195.25.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A66B321D41;
        Tue, 27 Oct 2020 15:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603811339;
        bh=F/3unrXBIqFN1AMtFeEOTOxOuveYqZ1JM6MxSNhHAkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a16xy+MeBE3VjTxI9eCTlJ2ucnojMIn2gI+TquK41qMK/AEP8nLqaxM1CHjCKLgKV
         K38QFxbMxOCnGBwH5Bee9Vge7SW4rzMQLpR3YaKqgYKRMibVQQA6cm3whnIN0G+JF1
         ZFXkYmn/COJEVspLbG82uro+qp5II9OnMsJ7eIqw=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 5/5] x86: Support HAVE_CONTEXT_TRACKING_OFFSTACK
Date:   Tue, 27 Oct 2020 16:08:27 +0100
Message-Id: <20201027150827.148821-6-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027150827.148821-1-frederic@kernel.org>
References: <20201027150827.148821-1-frederic@kernel.org>
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

