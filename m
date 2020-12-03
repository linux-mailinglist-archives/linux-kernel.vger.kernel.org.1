Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA922CCE12
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 05:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgLCEvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 23:51:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:47822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgLCEvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 23:51:12 -0500
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
Subject: [PATCH v2 0/3] x86/insn: Fix not using prefixes.nbytes for loop over prefixes.bytes
Date:   Thu,  3 Dec 2020 13:50:26 +0900
Message-Id: <160697102582.3146288.10127018634865687932.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are the 2nd version of patches to fix the wrong loop boundary
check on insn.prefixes.bytes[] array.

The previous version is here;

https://lkml.kernel.org/r/160689905099.3084105.7880450206184269465.stgit@devnote2

In this version, I introduced for_each_insn_prefix() macro to
for looping on the prefixes in the given instruction and fixed
out-of-bounds-read issue by checking index first. Also, I sorted 
the patches so that the oldest commit fix becomes the first patch
because it will go into the older stable kernel and that introduces
the new iteration macro.

Kees Cook got a syzbot warning and found this issue and there were 
similar wrong boundary check patterns in the x86 code.

Since the insn.prefixes.nbytes can be bigger than the size of
insn.prefixes.bytes[] when a same prefix is repeated, we have to
check whether the insn.prefixes.bytes[i] != 0 (*) and i < 4 instead
of insn.prefixes.nbytes.

(*) Note that insn.prefixes.bytes[] should be zeroed in insn_init()
before decoding, and 0x00 is not a legacy prefix. So if you see 0
on insn.prefix.bytes[], it indicates the end of the array. Or,
if the prefixes.bytes[] is filled with prefix bytes, we can check
the index is less than 4.

Thank you,

---

Masami Hiramatsu (3):
      x86/uprobes: Fix not using prefixes.nbytes for loop over prefixes.bytes
      x86/insn-eval: Fix not using prefixes.nbytes for loop over prefixes.bytes
      x86/sev-es: Fix not using prefixes.nbytes for loop over prefixes.bytes


 arch/x86/boot/compressed/sev-es.c |    5 ++---
 arch/x86/include/asm/insn.h       |   15 +++++++++++++++
 arch/x86/kernel/uprobes.c         |   10 ++++++----
 arch/x86/lib/insn-eval.c          |   10 +++++-----
 4 files changed, 28 insertions(+), 12 deletions(-)

-- 
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
