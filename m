Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 973AF2F46DC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbhAMIsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbhAMIsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:48:52 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127FDC061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:48:12 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id o8so1586460ybq.22
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=6kBkoRmwgSX0XZNbrQ/NiZAgYv6EjZ4WHmZjTKohjcg=;
        b=oE/uSwlrTjAOl0k8myxDW/ELoP2k8x8pkxMFae9ReIKNAwJsKxq2BkTafxUHdxM6hL
         lgMZNhws20h8DUcnGuu2TTYlcQGcn5aYDvxJSZYIQY2Eub0qOb63pbzRJPojbgygEj2V
         RqlCmlKMZx38TX4Xo2+7qXqjE5dtf5cT52a1i5t0UKtus4c2PR9RoIGYLA/4MEgUW8kh
         OHY7COlHzxPudUxaLmSi2e9kUWvi7qRSh4h9Noo41o9vbASxNXlwhd79FZQ8VbVhH0JU
         zuN3FaXV/Q6PnjsslLN1JdxNQuCx3vSHdW6hO+4a+6C1xCajYjGbgnuAxrziYHl8tix9
         6uPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=6kBkoRmwgSX0XZNbrQ/NiZAgYv6EjZ4WHmZjTKohjcg=;
        b=SSdPq1oIHGrP1tT04zchZ0Tr/dQRCulw2moiYR1d7fmIIT38J8aVlYw8haCodQYJFv
         NtUvAskArjN7zhNal95q5EtlbCT5GLdBqZNXbj+8+4fvRpMwdXZI2TNKS0J98FvhUOLY
         hGA6hrTAi0GAo7ZIYkq/Pmj9LnDbSI+mW3Aj0rcCpIlq5WIZFJvCRJxvAF5FxUZyE8z3
         jQ6uQnQOEuNGT52c7gktoiFhCdZKG8Ajgl6o9b1KSOHt28Bj+cTe2yJA8UdrjhENq0Kl
         UswsYeY2tR8ycr2S8/fuTtAUVYvy8yOX8Jb8wdC6LfMfRaJyZPWo4Oshubg7scMtTsLp
         tkCg==
X-Gm-Message-State: AOAM530HvfoHfya6AlsjU5738oqJLMY41f3BYcpcCM7APgp25GyoNfer
        IPjc8gEqrJ6F0Litv9pbHVv6QhloweCo
X-Google-Smtp-Source: ABdhPJw4n1bvyGtMHzAv7qSDD72Jr5XVTRYp0aqSH/E/dTLw4wKOB5lSscIpoe77nQFBaO5xdyFEgJ6nmVn1
Sender: "amistry via sendgmr" <amistry@nandos.syd.corp.google.com>
X-Received: from nandos.syd.corp.google.com ([2401:fa00:9:14:725a:fff:fe46:72ab])
 (user=amistry job=sendgmr) by 2002:a25:c6cc:: with SMTP id
 k195mr1665853ybf.503.1610527691192; Wed, 13 Jan 2021 00:48:11 -0800 (PST)
Date:   Wed, 13 Jan 2021 19:47:19 +1100
Message-Id: <20210113194619.RFC.1.I8f559ecdb01ffa98d5a1ee551cb802f288a81a38@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [RFC PATCH] x86/speculation: Add finer control for when to issue IBPB
From:   Anand K Mistry <amistry@google.com>
To:     x86@kernel.org
Cc:     asteinhauser@google.com, tglx@linutronix.de, bp@alien8.de,
        joelaf@google.com, Anand K Mistry <amistry@google.com>,
        Anand K Mistry <amistry@chromium.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Julien Thierry <jthierry@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Mark Gross <mgross@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When IB speculation is conditionally disabled for a process (via prctl()
or seccomp), IBPB is issued whenever that process is switched to/from.
However, this results more IBPBs than necessary. The goal is to protect
a victim process from an attacker poisoning the BTB by issuing IBPB in
the attacker->victim switch. However, the current logic will also issue
IBPB in the victim->attacker switch, because there's no notion of
whether the attacker or victim has IB speculation disabled.

Instead of always issuing IBPB when either the previous or next process
has IB speculation disabled, add a boot flag to explicitly choose
to issue IBPB when the IB spec disabled process is entered or left.

Signed-off-by: Anand K Mistry <amistry@google.com>
Signed-off-by: Anand K Mistry <amistry@chromium.org>
---
Background:
IBPB is slow on some CPUs.

More detailed background:
On some CPUs, issuing an IBPB can cause the address space switch to be
10x more expensive (yes, 10x, not 10%). On a system that makes heavy use
of processes, this can cause a very significant performance hit.
Although we can choose which processes will pay the IBPB
cost by using prctl(), the performance hit is often still too high
because IBPB is being issued more often than necessary.

This proposal attempts to reduce that cost by letting the system
developer choose whether to issue the IBPB on entry or exit of an IB
speculation disabled process (default is both, which is current
behaviour). Documentation/admin-guide/hw-vuln/spectre.rst documents two
mitigation strategies that use conditional IBPB;
"Protect sensitive programs", and "Sandbox untrusted programs".

In the first case of protecting sensitive programs, the victim process
has IB spec disabled. So the attacker->victim switch is an _entry_ of
an IB spec disabled process. Conversly, the second case of sandboxing
and untrusted process, the attacker has IB spec disabled and so we want
to issue of IBPB on _exit_ of the IB spec disabled process.

I understand this is likely to be very contentious. Obviously, this
isn't ready for code review, but I'm hoping to get some thoughts on the
problem and this approach.

 arch/x86/include/asm/nospec-branch.h |  3 ++
 arch/x86/kernel/cpu/bugs.c           | 42 ++++++++++++++++++++++++++++
 arch/x86/mm/tlb.c                    | 11 ++++++--
 3 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index cb9ad6b73973..bcccc153af75 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -250,6 +250,9 @@ DECLARE_STATIC_KEY_FALSE(switch_to_cond_stibp);
 DECLARE_STATIC_KEY_FALSE(switch_mm_cond_ibpb);
 DECLARE_STATIC_KEY_FALSE(switch_mm_always_ibpb);
 
+DECLARE_STATIC_KEY_TRUE(switch_mm_cond_ibpb_enter);
+DECLARE_STATIC_KEY_TRUE(switch_mm_cond_ibpb_leave);
+
 DECLARE_STATIC_KEY_FALSE(mds_user_clear);
 DECLARE_STATIC_KEY_FALSE(mds_idle_clear);
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d41b70fe4918..a87200db7786 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -69,6 +69,9 @@ DEFINE_STATIC_KEY_FALSE(switch_mm_cond_ibpb);
 /* Control unconditional IBPB in switch_mm() */
 DEFINE_STATIC_KEY_FALSE(switch_mm_always_ibpb);
 
+DEFINE_STATIC_KEY_TRUE(switch_mm_cond_ibpb_enter);
+DEFINE_STATIC_KEY_TRUE(switch_mm_cond_ibpb_leave);
+
 /* Control MDS CPU buffer clear before returning to user space */
 DEFINE_STATIC_KEY_FALSE(mds_user_clear);
 EXPORT_SYMBOL_GPL(mds_user_clear);
@@ -640,6 +643,12 @@ enum spectre_v2_user_cmd {
 	SPECTRE_V2_USER_CMD_SECCOMP_IBPB,
 };
 
+enum spectre_v2_user_ibpb_mode {
+	SPECTRE_V2_USER_IBPB_BOTH,
+	SPECTRE_V2_USER_IBPB_ENTER,
+	SPECTRE_V2_USER_IBPB_LEAVE,
+};
+
 static const char * const spectre_v2_user_strings[] = {
 	[SPECTRE_V2_USER_NONE]			= "User space: Vulnerable",
 	[SPECTRE_V2_USER_STRICT]		= "User space: Mitigation: STIBP protection",
@@ -700,12 +709,31 @@ spectre_v2_parse_user_cmdline(enum spectre_v2_mitigation_cmd v2_cmd)
 	return SPECTRE_V2_USER_CMD_AUTO;
 }
 
+static enum spectre_v2_user_ibpb_mode __init
+spectre_v2_parse_user_ibpb_mode(void)
+{
+	char arg[8];
+	int ret;
+
+	ret = cmdline_find_option(boot_command_line,
+				  "spectre_v2_user_ibpb_mode",
+				  arg, sizeof(arg));
+
+	if (ret == 5 && !strncmp(arg, "enter", 5))
+		return SPECTRE_V2_USER_IBPB_ENTER;
+	if (ret == 5 && !strncmp(arg, "leave", 5))
+		return SPECTRE_V2_USER_IBPB_LEAVE;
+
+	return SPECTRE_V2_USER_IBPB_BOTH;
+}
+
 static void __init
 spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
 {
 	enum spectre_v2_user_mitigation mode = SPECTRE_V2_USER_NONE;
 	bool smt_possible = IS_ENABLED(CONFIG_SMP);
 	enum spectre_v2_user_cmd cmd;
+	enum spectre_v2_user_ibpb_mode ibpb_mode;
 
 	if (!boot_cpu_has(X86_FEATURE_IBPB) && !boot_cpu_has(X86_FEATURE_STIBP))
 		return;
@@ -761,6 +789,20 @@ spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
 			"always-on" : "conditional");
 	}
 
+	if (static_key_enabled(&switch_mm_cond_ibpb)) {
+		ibpb_mode = spectre_v2_parse_user_ibpb_mode();
+		switch (ibpb_mode) {
+		case SPECTRE_V2_USER_IBPB_ENTER:
+			static_branch_disable(&switch_mm_cond_ibpb_leave);
+			break;
+		case SPECTRE_V2_USER_IBPB_LEAVE:
+			static_branch_disable(&switch_mm_cond_ibpb_enter);
+			break;
+		default:
+			break;
+		}
+	}
+
 	/*
 	 * If no STIBP, enhanced IBRS is enabled or SMT impossible, STIBP is not
 	 * required.
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 569ac1d57f55..f5a1f1ca0753 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -379,9 +379,14 @@ static void cond_ibpb(struct task_struct *next)
 		 * Issue IBPB only if the mm's are different and one or
 		 * both have the IBPB bit set.
 		 */
-		if (next_mm != prev_mm &&
-		    (next_mm | prev_mm) & LAST_USER_MM_IBPB)
-			indirect_branch_prediction_barrier();
+		if (next_mm != prev_mm) {
+			if ((next_mm & LAST_USER_MM_IBPB &&
+			     static_branch_likely(&switch_mm_cond_ibpb_enter)) ||
+			    (prev_mm & LAST_USER_MM_IBPB &&
+			     static_branch_likely(&switch_mm_cond_ibpb_leave))) {
+				indirect_branch_prediction_barrier();
+			}
+		}
 
 		this_cpu_write(cpu_tlbstate.last_user_mm_ibpb, next_mm);
 	}
-- 
2.30.0.284.gd98b1dd5eaa7-goog

