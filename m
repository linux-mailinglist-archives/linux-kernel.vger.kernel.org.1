Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5980E1EC206
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 20:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgFBSm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 14:42:28 -0400
Received: from mail.codeweavers.com ([50.203.203.244]:57690 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFBSm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 14:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IRkWRp0Qt7Bx+7ylRDtb9KZdZDKE72uiU4S/wz5/f9A=; b=mQMFARl0jrj5BKCRoVLC08Tdio
        FBnQ/TzCXcAHixBAoK/sSZOsV3ns5mhmrjY4eOFdYIW792HzYFdTW+lm3JB6V67SqcsUMp6r+OriS
        M3n2pab+f1xz8/292tBzEQVM9IxCu/KX7ObhFleUFxV9XuDGClF2R5kMfdQmmGT30SJE=;
Received: from cpe-107-184-2-226.socal.res.rr.com ([107.184.2.226] helo=zen.bslabs.net)
        by mail.codeweavers.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <bshanks@codeweavers.com>)
        id 1jgBrh-0002ML-UI; Tue, 02 Jun 2020 13:42:23 -0500
From:   Brendan Shanks <bshanks@codeweavers.com>
To:     linux-kernel@vger.kernel.org
Cc:     ricardo.neri-calderon@linux.intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        ebiederm@xmission.com, andi@notmuch.email, Babu.Moger@amd.com,
        Brendan Shanks <bshanks@codeweavers.com>
Subject: [PATCH] x86/umip: Add emulation/spoofing for SLDT and STR instructions
Date:   Tue,  2 Jun 2020 11:42:12 -0700
Message-Id: <20200602184212.10813-1-bshanks@codeweavers.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -25.8
X-Spam-Report: Spam detection software, running on the system "mail.codeweavers.com",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  Add emulation/spoofing of SLDT and STR for both 32- and 64-bit
    processes. Wine users have found a small number of Windows apps using SLDT
    that were crashing when run on UMIP-enabled systems. Reported-by: Andreas
    Rammhold <andi@notmuch.email> Originally-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
    Signed-off-by: Brendan Shanks <bshanks@codeweavers.com> --- arch/x86/kernel/umip.
    [...] 
 Content analysis details:   (-25.8 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
  -20 USER_IN_WHITELIST      From: address is in the user's white-list
 -6.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -0.5 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
  0.7 AWL                    AWL: Adjusted score from AWL reputation of From: address
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add emulation/spoofing of SLDT and STR for both 32- and 64-bit
processes.

Wine users have found a small number of Windows apps using SLDT that
were crashing when run on UMIP-enabled systems.

Reported-by: Andreas Rammhold <andi@notmuch.email>
Originally-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Brendan Shanks <bshanks@codeweavers.com>
---
 arch/x86/kernel/umip.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index 8d5cbe1bbb3b..59dfceac5cc0 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -64,6 +64,8 @@
 #define UMIP_DUMMY_GDT_BASE 0xfffffffffffe0000ULL
 #define UMIP_DUMMY_IDT_BASE 0xffffffffffff0000ULL
 
+#define UMIP_DUMMY_TASK_REGISTER_SELECTOR 0x40
+
 /*
  * The SGDT and SIDT instructions store the contents of the global descriptor
  * table and interrupt table registers, respectively. The destination is a
@@ -244,16 +246,24 @@ static int emulate_umip_insn(struct insn *insn, int umip_inst,
 		*data_size += UMIP_GDT_IDT_LIMIT_SIZE;
 		memcpy(data, &dummy_limit, UMIP_GDT_IDT_LIMIT_SIZE);
 
-	} else if (umip_inst == UMIP_INST_SMSW) {
-		unsigned long dummy_value = CR0_STATE;
+	} else if (umip_inst == UMIP_INST_SMSW || umip_inst == UMIP_INST_SLDT ||
+		   umip_inst == UMIP_INST_STR) {
+		unsigned long dummy_value;
+
+		if (umip_inst == UMIP_INST_SMSW)
+			dummy_value = CR0_STATE;
+		else if (umip_inst == UMIP_INST_STR)
+			dummy_value = UMIP_DUMMY_TASK_REGISTER_SELECTOR;
+		else
+			dummy_value = 0;
 
 		/*
-		 * Even though the CR0 register has 4 bytes, the number
+		 * For these 3 instructions, the number
 		 * of bytes to be copied in the result buffer is determined
 		 * by whether the operand is a register or a memory location.
 		 * If operand is a register, return as many bytes as the operand
 		 * size. If operand is memory, return only the two least
-		 * siginificant bytes of CR0.
+		 * siginificant bytes.
 		 */
 		if (X86_MODRM_MOD(insn->modrm.value) == 3)
 			*data_size = insn->opnd_bytes;
@@ -261,7 +271,6 @@ static int emulate_umip_insn(struct insn *insn, int umip_inst,
 			*data_size = 2;
 
 		memcpy(data, &dummy_value, *data_size);
-	/* STR and SLDT  are not emulated */
 	} else {
 		return -EINVAL;
 	}
@@ -383,10 +392,6 @@ bool fixup_umip_exception(struct pt_regs *regs)
 	umip_pr_warn(regs, "%s instruction cannot be used by applications.\n",
 			umip_insns[umip_inst]);
 
-	/* Do not emulate (spoof) SLDT or STR. */
-	if (umip_inst == UMIP_INST_STR || umip_inst == UMIP_INST_SLDT)
-		return false;
-
 	umip_pr_warn(regs, "For now, expensive software emulation returns the result.\n");
 
 	if (emulate_umip_insn(&insn, umip_inst, dummy_data, &dummy_data_size,
-- 
2.26.2

