Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2FE2CB7C3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 09:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387967AbgLBIvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 03:51:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:36566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387805AbgLBIvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 03:51:39 -0500
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
Subject: [PATCH 0/3] x86/insn: Fix not using prefixes.nbytes for loop over prefixes.bytes
Date:   Wed,  2 Dec 2020 17:50:51 +0900
Message-Id: <160689905099.3084105.7880450206184269465.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are the patches to fix the wrong loop boundary check
on insn.prefixes.bytes[] array.

Kees Cook reported that this issue that there are similar
wrong boundary check patterns in the x86 code.

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
      x86/sev-es: Fix not using prefixes.nbytes for loop over prefixes.bytes
      x86/uprobes: Fix not using prefixes.nbytes for loop over prefixes.bytes
      x86/insn-eval: Fix not using prefixes.nbytes for loop over prefixes.bytes


 arch/x86/boot/compressed/sev-es.c |    2 +-
 arch/x86/kernel/uprobes.c         |    4 ++--
 arch/x86/lib/insn-eval.c          |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

-- 
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
