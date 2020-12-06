Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C68A2D056A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 15:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgLFOMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 09:12:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:38022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728273AbgLFOMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 09:12:13 -0500
From:   Masami Hiramatsu <mhiramat@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org
Subject: [PATCH  0/1] x86/kprobes: Classify opcode while preparing kprobe
Date:   Sun,  6 Dec 2020 23:11:28 +0900
Message-Id: <160726388853.3413805.4854581312983421622.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed that the kprobe x86 still has an inefficient code.

Currently kprobes x86 decodes opcode right after single
stepping in resume_execution(), which is kprobe's hot path.
But it already decoded the opcode while preparing
arch_specific_insn in arch_copy_kprobe(), so this is
inefficient.

So decode the opcode while preparing kprobes (arch_copy_kprobe())
instead of resume_execution() and set some flags for resuming from
single stepping. This also removes the custom instruction prefix
decoding, which should be done in x86 instruction decoder.

Thank you,

---

Masami Hiramatsu (1):
      x86/kprobes: Do not decode opcode in resume_execution()


 arch/x86/include/asm/kprobes.h |   11 ++-
 arch/x86/kernel/kprobes/core.c |  166 ++++++++++++++++++----------------------
 2 files changed, 80 insertions(+), 97 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
