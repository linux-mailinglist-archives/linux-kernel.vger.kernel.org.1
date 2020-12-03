Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711192CCE16
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 05:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgLCEvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 23:51:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:47998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgLCEvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 23:51:47 -0500
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
Subject: [PATCH v2 3/3] x86/sev-es: Fix not using prefixes.nbytes for loop over prefixes.bytes
Date:   Thu,  3 Dec 2020 13:51:01 +0900
Message-Id: <160697106089.3146288.2052422845039649176.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <160697102582.3146288.10127018634865687932.stgit@devnote2>
References: <160697102582.3146288.10127018634865687932.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the insn.prefixes.nbytes can be bigger than the size of
insn.prefixes.bytes[] when a same prefix is repeated, we have to
check whether the i < 4 and insn.prefixes.bytes[i] != 0 instead
of insn.prefixes.nbytes.

Fixes: 25189d08e516 ("x86/sev-es: Add support for handling IOIO exceptions")
Reported-by: syzbot+9b64b619f10f19d19a7c@syzkaller.appspotmail.com
Debugged-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/boot/compressed/sev-es.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/sev-es.c b/arch/x86/boot/compressed/sev-es.c
index 954cb2702e23..27826c265aab 100644
--- a/arch/x86/boot/compressed/sev-es.c
+++ b/arch/x86/boot/compressed/sev-es.c
@@ -32,13 +32,12 @@ struct ghcb *boot_ghcb;
  */
 static bool insn_has_rep_prefix(struct insn *insn)
 {
+	insn_byte_t p;
 	int i;
 
 	insn_get_prefixes(insn);
 
-	for (i = 0; i < insn->prefixes.nbytes; i++) {
-		insn_byte_t p = insn->prefixes.bytes[i];
-
+	for_each_insn_prefix(insn, i, p) {
 		if (p == 0xf2 || p == 0xf3)
 			return true;
 	}

