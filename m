Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E422C22B2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731893AbgKXKUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:20:11 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50314 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731861AbgKXKUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:20:06 -0500
Received: from zn.tnic (p200300ec2f0e360052021be21853ebf1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:3600:5202:1be2:1853:ebf1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2A28D1EC0258;
        Tue, 24 Nov 2020 11:20:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606213205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HZOMF0xnv/asL+0NdEME9qH39KkBlzno1GuCd8ZruUg=;
        b=CAT2DMPjOIsYz2sqSqiaLAr/dmHpGZENawj1lawO87n6oMUCUBlHqBRrJvAsdHDAlfwmCQ
        ZWQxyEoNqDTyzCGrPAYzmMdZvTMvwmRg10OSK4IcbeNBNp0KcAgbGLXdjw0fVdwT/CL6lr
        adozS0LiPh4uOdcQqmdl4gS3kDGJYQI=
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v0 07/19] perf/x86/intel/ds: Check return values of insn decoder functions
Date:   Tue, 24 Nov 2020 11:19:40 +0100
Message-Id: <20201124101952.7909-8-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201124101952.7909-1-bp@alien8.de>
References: <20201124101952.7909-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

branch_type() doesn't need to call the full insn_decode() because it
doesn't need it in all cases thus leave the calls separate.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/events/intel/lbr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 1aadb253d296..0b7d2cc3f001 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1224,8 +1224,7 @@ static int branch_type(unsigned long from, unsigned long to, int abort)
 	is64 = kernel_ip((unsigned long)addr) || any_64bit_mode(current_pt_regs());
 #endif
 	insn_init(&insn, addr, bytes_read, is64);
-	insn_get_opcode(&insn);
-	if (!insn.opcode.got)
+	if (insn_get_opcode(&insn))
 		return X86_BR_ABORT;
 
 	switch (insn.opcode.bytes[0]) {
@@ -1262,8 +1261,7 @@ static int branch_type(unsigned long from, unsigned long to, int abort)
 		ret = X86_BR_INT;
 		break;
 	case 0xe8: /* call near rel */
-		insn_get_immediate(&insn);
-		if (insn.immediate1.value == 0) {
+		if (insn_get_immediate(&insn) || insn.immediate1.value == 0) {
 			/* zero length call */
 			ret = X86_BR_ZERO_CALL;
 			break;
@@ -1279,7 +1277,9 @@ static int branch_type(unsigned long from, unsigned long to, int abort)
 		ret = X86_BR_JMP;
 		break;
 	case 0xff: /* call near absolute, call far absolute ind */
-		insn_get_modrm(&insn);
+		if (insn_get_modrm(&insn))
+			return X86_BR_ABORT;
+
 		ext = (insn.modrm.bytes[0] >> 3) & 0x7;
 		switch (ext) {
 		case 2: /* near ind call */
-- 
2.21.0

