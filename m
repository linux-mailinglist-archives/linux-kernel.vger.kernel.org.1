Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8161A6172
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 04:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgDMCHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Apr 2020 22:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgDMCHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 22:07:52 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E03C0A3BE0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 19:07:52 -0700 (PDT)
Received: from oscar.flets-west.jp (softbank060142179096.bbtec.net [60.142.179.96]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 03D25t9Y009526;
        Mon, 13 Apr 2020 11:05:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 03D25t9Y009526
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1586743556;
        bh=CiA+LS3srZDXaba4IVzHQlWKWt2AFnfnDeWfK+2rQZM=;
        h=From:To:Cc:Subject:Date:From;
        b=qFtvBi3fH02TZP3DCJxedKNk+7iJhrFZVTTyCqA7c7oyKwkFi7UMFDsu8ZYHAD/fe
         wYEKhglT8w3aRZcUVwJ3/ubS2ndbTwilLLOqn8xfjgOp00LkJmcdWD00facLVpBvMP
         gdfcUmzkpJ8IdKNDcO6r6B75uI8tp//TYq8exTms/anPo9HMbEKv+5zAM2Uh7gwecL
         qwVa1KldLU3yvLsqmhjhp+FPb5jwo0wMviJk4n+kJ0nxpLRSaHl5KKd8V5GzDxPoz1
         sw8sNJ5v0SerRXHV63DONY0CZB+ZwHPyROj2JXgpXpt0Eb7I7wiO01vJodiOp9ri4e
         KLrC6hLtm66rg==
X-Nifty-SrcIP: [60.142.179.96]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Allison Randal <allison@lohutok.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arc: remove #ifndef CONFIG_AS_CFI_SIGNAL_FRAME
Date:   Mon, 13 Apr 2020 11:05:38 +0900
Message-Id: <20200413020538.31322-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_AS_CFI_SIGNAL_FRAME is never defined for ARC.

Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/arc/kernel/unwind.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arc/kernel/unwind.c b/arch/arc/kernel/unwind.c
index 27ea64b1fa33..f87758a6851b 100644
--- a/arch/arc/kernel/unwind.c
+++ b/arch/arc/kernel/unwind.c
@@ -1178,11 +1178,9 @@ int arc_unwind(struct unwind_frame_info *frame)
 #endif
 
 	/* update frame */
-#ifndef CONFIG_AS_CFI_SIGNAL_FRAME
 	if (frame->call_frame
 	    && !UNW_DEFAULT_RA(state.regs[retAddrReg], state.dataAlign))
 		frame->call_frame = 0;
-#endif
 	cfa = FRAME_REG(state.cfa.reg, unsigned long) + state.cfa.offs;
 	startLoc = min_t(unsigned long, UNW_SP(frame), cfa);
 	endLoc = max_t(unsigned long, UNW_SP(frame), cfa);
-- 
2.25.1

