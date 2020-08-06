Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A6E23D5F8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 06:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgHFEOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 00:14:48 -0400
Received: from inva021.nxp.com ([92.121.34.21]:38082 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbgHFEOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 00:14:44 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5ABBD200764;
        Thu,  6 Aug 2020 06:14:42 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6A77220074E;
        Thu,  6 Aug 2020 06:14:37 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B13714032D;
        Thu,  6 Aug 2020 06:14:31 +0200 (CEST)
From:   Jiafei Pan <Jiafei.Pan@nxp.com>
To:     peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, romain.perier@gmail.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        jiafei.pan@nxp.com, leoyang.li@nxp.com, vladimir.oltean@nxp.com,
        Jiafei Pan <Jiafei.Pan@nxp.com>
Subject: [PATCH] softirq: add irq off checking for __raise_softirq_irqoff
Date:   Thu,  6 Aug 2020 12:07:29 +0800
Message-Id: <20200806040729.39186-1-Jiafei.Pan@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__raise_softirq_irqoff will update per-CPU mask of pending softirqs,
it need to be called in irq disabled context in order to keep it atomic
operation, otherwise it will be interrupted by hardware interrupt,
and per-CPU softirqs pending mask will be corrupted, the result is
there will be unexpected issue, for example hrtimer soft irq will
be losed and soft hrtimer will never be expire and handled.

Adding irqs disabled checking here to provide warning in irqs enabled
context.

Signed-off-by: Jiafei Pan <Jiafei.Pan@nxp.com>
---
 kernel/softirq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index bf88d7f62433..11f61e54a3ae 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -481,6 +481,11 @@ void raise_softirq(unsigned int nr)
 
 void __raise_softirq_irqoff(unsigned int nr)
 {
+	/* This function can only be called in irq disabled context,
+	 * otherwise or_softirq_pending will be interrupted by hardware
+	 * interrupt, so that there will be unexpected issue.
+	 */
+	WARN_ON_ONCE(!irqs_disabled());
 	trace_softirq_raise(nr);
 	or_softirq_pending(1UL << nr);
 }
-- 
2.17.1

