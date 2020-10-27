Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A6629CBFB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 23:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1832421AbgJ0Wci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 18:32:38 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:49054 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2506391AbgJ0Wch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 18:32:37 -0400
Received: from mailhost.synopsys.com (sv2-mailhost1.synopsys.com [10.205.2.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4885E40515;
        Tue, 27 Oct 2020 22:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1603837956; bh=Sja1KZoIneYVxxUnkZzOBZp8oo90HsWHX/KK4Q7CDf4=;
        h=From:To:Cc:Subject:Date:From;
        b=MKdrgiFjoU9OwyG2l+530lFHRM3Umm0ABuAwQgl9tEEPtagDWQ9s+O4a82hsVx3rL
         9dVdUApGKD1nsShPqIPhAwUiYqUOBhQ9CuQbJ/a34yTW+EQJw9rZ4u4imaCbx6sD4z
         /Iy3IXb8eS+HGJTbm2Gr3tOPRID3m9JdvDpouPM91qMP/Tbom4CAfdh8WH207E0Gg6
         9IdBvlWiTxHd6bk3Fezq2St1ECL+6im6goDAhimCK82tN77TFyBLmmNlQpHzlVXO/1
         OsIjKq38EsdGdirY6KW3co3AleQUCUP5Di27h18KjEPhTLuYbUKj6VhXvlbitjEssY
         0tyVSVuiFS8DQ==
Received: from vineetg-Latitude-7400.internal.synopsys.com (unknown [10.13.183.89])
        by mailhost.synopsys.com (Postfix) with ESMTP id 9DF40A0096;
        Tue, 27 Oct 2020 22:32:34 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Alexey.Brodkin@synopsys.com,
        Eugeniy.Paltsev@synopsys.com, Igor.Guryanov@synopsys.com,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH] ARC: stack unwinding: avoid indefinite looping
Date:   Tue, 27 Oct 2020 15:32:33 -0700
Message-Id: <20201027223233.3199386-1-vgupta@synopsys.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently stack unwinder is a while(1) loop which relies on the dwarf
unwinder to signal termination, which in turn relies on dwarf info to do
so. This in theory could cause an infinite loop if the dwarf info was
somehow messed up or the register contents were etc.

This fix thus detects the excessive looping and breaks the loop.

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/kernel/stacktrace.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arc/kernel/stacktrace.c b/arch/arc/kernel/stacktrace.c
index bf40e06f3fb8..0fed32b95923 100644
--- a/arch/arc/kernel/stacktrace.c
+++ b/arch/arc/kernel/stacktrace.c
@@ -115,7 +115,7 @@ arc_unwind_core(struct task_struct *tsk, struct pt_regs *regs,
 		int (*consumer_fn) (unsigned int, void *), void *arg)
 {
 #ifdef CONFIG_ARC_DW2_UNWIND
-	int ret = 0;
+	int ret = 0, cnt = 0;
 	unsigned int address;
 	struct unwind_frame_info frame_info;
 
@@ -135,6 +135,11 @@ arc_unwind_core(struct task_struct *tsk, struct pt_regs *regs,
 			break;
 
 		frame_info.regs.r63 = frame_info.regs.r31;
+
+		if (cnt++ > 128) {
+			printk("unwinder looping too long, aborting !\n");
+			return 0;
+		}
 	}
 
 	return address;		/* return the last address it saw */
-- 
2.25.1

