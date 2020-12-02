Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7AB2CB7C5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 09:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387990AbgLBIwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 03:52:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:36704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387721AbgLBIwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 03:52:02 -0500
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
Subject: [PATCH 2/3] x86/uprobes: Fix not using prefixes.nbytes for loop over prefixes.bytes
Date:   Wed,  2 Dec 2020 17:51:16 +0900
Message-Id: <160689907597.3084105.18019089399087866918.stgit@devnote2>
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

Fixes: 2b1444983508 ("uprobes, mm, x86: Add the ability to install and remove uprobes breakpoints")
Cc: stable@vger.kernel.org
Reported-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/kernel/uprobes.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 3fdaa042823d..bb3ea3705b99 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -257,7 +257,7 @@ static bool is_prefix_bad(struct insn *insn)
 {
 	int i;
 
-	for (i = 0; i < insn->prefixes.nbytes; i++) {
+	for (i = 0; insn->prefixes.bytes[i] && i < 4; i++) {
 		insn_attr_t attr;
 
 		attr = inat_get_opcode_attribute(insn->prefixes.bytes[i]);
@@ -746,7 +746,7 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
 	 * Intel and AMD behavior differ in 64-bit mode: Intel ignores 66 prefix.
 	 * No one uses these insns, reject any branch insns with such prefix.
 	 */
-	for (i = 0; i < insn->prefixes.nbytes; i++) {
+	for (i = 0; insn->prefixes.bytes[i] && i < 4; i++) {
 		if (insn->prefixes.bytes[i] == 0x66)
 			return -ENOTSUPP;
 	}

