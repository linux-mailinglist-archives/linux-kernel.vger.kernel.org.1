Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FA124446C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 07:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgHNFDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 01:03:01 -0400
Received: from inva020.nxp.com ([92.121.34.13]:55214 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgHNFDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 01:03:01 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9D0C61A018C;
        Fri, 14 Aug 2020 07:02:58 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C7E931A01FB;
        Fri, 14 Aug 2020 07:02:53 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id DCDA2402C9;
        Fri, 14 Aug 2020 07:02:47 +0200 (CEST)
From:   Jiafei Pan <Jiafei.Pan@nxp.com>
To:     peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, romain.perier@gmail.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        jiafei.pan@nxp.com, leoyang.li@nxp.com, vladimir.oltean@nxp.com,
        Jiafei Pan <Jiafei.Pan@nxp.com>
Subject: [PATCH v2] softirq: add irq off checking for __raise_softirq_irqoff
Date:   Fri, 14 Aug 2020 12:55:22 +0800
Message-Id: <20200814045522.45719-1-Jiafei.Pan@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__raise_softirq_irqoff() will update per-CPU mask of pending softirqs,
it need to be called in irq disabled context in order to keep it atomic
operation, otherwise it will be interrupted by hardware interrupt,
and per-CPU softirqs pending mask will be corrupted, the result is
there will be unexpected issue, for example hrtimer soft irq will
be losed and soft hrtimer will never be expire and handled.

Enable CONFIG_PROVE_LOCKING to use lockdep_assert_irqs_disabled() to
check hardirqs and softirqs status, and provide warning in irqs enabled
context.

Signed-off-by: Jiafei Pan <Jiafei.Pan@nxp.com>
---
Changes in v2:
- use lockdep_assert_irqs_disabled()
- removed extra comments
- changed commit message

 kernel/softirq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index bf88d7f62433..09229ad82209 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -481,6 +481,7 @@ void raise_softirq(unsigned int nr)
 
 void __raise_softirq_irqoff(unsigned int nr)
 {
+	lockdep_assert_irqs_disabled();
 	trace_softirq_raise(nr);
 	or_softirq_pending(1UL << nr);
 }
-- 
2.17.1

