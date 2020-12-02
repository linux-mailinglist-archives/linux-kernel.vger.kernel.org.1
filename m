Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E612CB7C4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 09:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387975AbgLBIvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 03:51:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:36632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387721AbgLBIvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 03:51:51 -0500
From:   Masami Hiramatsu <mhiramat@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Jann Horn <jannh@google.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] x86/sev-es: Fix not using prefixes.nbytes for loop over prefixes.bytes
Date:   Wed,  2 Dec 2020 17:51:04 +0900
Message-Id: <160689906460.3084105.3134729514028168934.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <160689905099.3084105.7880450206184269465.stgit@devnote2>
References: <160689905099.3084105.7880450206184269465.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the insn.prefixes.nbytes can be bigger than the size of
insn.prefixes.bytes[] when a same prefix is repeated, we have to
check whether the insn.prefixes.bytes[i] != 0 and i < 4 instead
of insn.prefixes.nbytes.

Fixes: 25189d08e516 ("x86/sev-es: Add support for handling IOIO exceptions")
Reported-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/boot/compressed/sev-es.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/sev-es.c b/arch/x86/boot/compressed/sev-es.c
index 954cb2702e23..6a7a3027c9ac 100644
--- a/arch/x86/boot/compressed/sev-es.c
+++ b/arch/x86/boot/compressed/sev-es.c
@@ -36,7 +36,7 @@ static bool insn_has_rep_prefix(struct insn *insn)
 
 	insn_get_prefixes(insn);
 
-	for (i = 0; i < insn->prefixes.nbytes; i++) {
+	for (i = 0; insn->prefixes.bytes[i] && i < 4; i++) {
 		insn_byte_t p = insn->prefixes.bytes[i];
 
 		if (p == 0xf2 || p == 0xf3)

