Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D522A7713
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 06:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbgKEFdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 00:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgKEFdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 00:33:19 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD6AC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 21:33:17 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id z4so381111ybk.15
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 21:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=sh15ve9aIvV3iUKmUFgbshLz15IkNtmvtGR64NHNI4g=;
        b=bGqehADRmpx4IlNrUpqWtNgbTY0vfazlhmZ3NqdwdP43lIkWy24mviOEaHlFRLnGgT
         NHM4s4RxMF368sALCmqu/ujwxW6UJIje82EGYFuPVNCnyoHc/592PCP4539P2VlPoopA
         pYeBl3FAO3QFfJqK4IQ7WOWF7i4q5JpCUu8N47TbMUvRdtBn253vy/IjeUaw+cpX8Gav
         tCLzAmyldDyIpKwoR7HdWpdqAB4nc7nsjVib8LUs+Jgi52Jtq+DpR0MPzFdNJrxUF7BN
         2vA0B50I0bV4gKD23ZhPKyBurHav1XZ92vW1jCXx4LNyaNferaTBo0oJdIQrZxYIludO
         qdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=sh15ve9aIvV3iUKmUFgbshLz15IkNtmvtGR64NHNI4g=;
        b=aFjgxZnqVBcKO6zcQ4EX1PZiuZ+N1GpEvPrHrcr2HangGk82msVFjqKqV2+Km+yaHI
         iWml5ybW7Cws2hs64PskUucL/NXDPwWDtjkjZy7R4IdAH+wSM86x/udyYlzHfSE0BeAL
         fbCBchiivGclWnWN4DSWiDUu6nyTqn17t2zZwfK5kBUydFeO56DRIPPFA/1ondD4vS3S
         OWD2GnBsnIciLYPkPTPKsjDQEuQLhpli5RBj8QMXZSpUNJp2dvG8QWpGtJkIhx5ACHBl
         HhfLTcHCt+PnA7AHYrg4t4s+1u8yMsbcgeLASyqqVL5QSu6aR354mNSfZFZspoNXcVW3
         uGbQ==
X-Gm-Message-State: AOAM532U73t5yPeuDCw/AGE6uaDOkkxNVzP9LCyp8Wb4ZjZ3w6twQprI
        85AaUydWczAMEhUcsI9QvvbdYqRwQdLF
X-Google-Smtp-Source: ABdhPJwM1UgQrmtfpE2KIiuAVQCe7/kdgsdmuymz0Z7eZ9loVwo0KvBSewNHrbzygygsepJaBL0yJw1C+DrF
Sender: "amistry via sendgmr" <amistry@nandos.syd.corp.google.com>
X-Received: from nandos.syd.corp.google.com ([2401:fa00:9:14:725a:fff:fe46:72ab])
 (user=amistry job=sendgmr) by 2002:a25:32c1:: with SMTP id
 y184mr1246892yby.298.1604554396445; Wed, 04 Nov 2020 21:33:16 -0800 (PST)
Date:   Thu,  5 Nov 2020 16:33:04 +1100
Message-Id: <20201105163246.v2.1.Ifd7243cd3e2c2206a893ad0a5b9a4f19549e22c6@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v2] x86/speculation: Allow IBPB to be conditionally enabled on
 CPUs with always-on STIBP
From:   Anand K Mistry <amistry@google.com>
To:     x86@kernel.org
Cc:     asteinhauser@google.com, Thomas.Lendacky@amd.com,
        tglx@linutronix.de, joelaf@google.com,
        Anand K Mistry <amistry@google.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On AMD CPUs which have the feature X86_FEATURE_AMD_STIBP_ALWAYS_ON,
STIBP is set to on and 'spectre_v2_user_stibp ==
SPECTRE_V2_USER_STRICT_PREFERRED'. At the same time, IBPB can be set to
conditional. However, this leads to the case where it's impossible to
turn on IBPB for a process because in the PR_SPEC_DISABLE case in
ib_prctl_set, the (spectre_v2_user_stibp ==
SPECTRE_V2_USER_STRICT_PREFERRED) condition leads to a return before the
task flag is set. Similarly, ib_prctl_get will return PR_SPEC_DISABLE
even though IBPB is set to conditional.

More generally, the following cases are possible:
1. STIBP = conditional && IBPB = on for spectre_v2_user=seccomp,ibpb
2. STIBP = on && IBPB = conditional for AMD CPUs with
   X86_FEATURE_AMD_STIBP_ALWAYS_ON

The first case functions correctly today, but only because
spectre_v2_user_ibpb isn't updated to reflect the IBPB mode.

At a high level, this change does one thing. If either STIBP or IBPB is
set to conditional, allow the prctl to change the task flag. Also,
reflect that capability when querying the state. This isn't perfect
since it doesn't take into account if only STIBP or IBPB is
unconditionally on. But it allows the conditional feature to work as
expected, without affecting the unconditional one.

Signed-off-by: Anand K Mistry <amistry@google.com>

---

Changes in v2:
- Fix typo in commit message
- s/is_spec_ib_user/is_spec_ib_user_controlled
- Update comment in ib_prctl_set() to reference X86_FEATURE_AMD_STIBP_ALWAYS_ON
- Have is_spec_ib_user_controlled() check both IBPB and STIBP modes

 arch/x86/kernel/cpu/bugs.c | 46 +++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d3f0db463f96..534225afe832 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1254,6 +1254,14 @@ static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
 	return 0;
 }
 
+static bool is_spec_ib_user_controlled(void)
+{
+	return spectre_v2_user_ibpb == SPECTRE_V2_USER_PRCTL ||
+		spectre_v2_user_ibpb == SPECTRE_V2_USER_SECCOMP ||
+		spectre_v2_user_stibp == SPECTRE_V2_USER_PRCTL ||
+		spectre_v2_user_stibp == SPECTRE_V2_USER_SECCOMP;
+}
+
 static int ib_prctl_set(struct task_struct *task, unsigned long ctrl)
 {
 	switch (ctrl) {
@@ -1262,13 +1270,20 @@ static int ib_prctl_set(struct task_struct *task, unsigned long ctrl)
 		    spectre_v2_user_stibp == SPECTRE_V2_USER_NONE)
 			return 0;
 		/*
-		 * Indirect branch speculation is always disabled in strict
-		 * mode. It can neither be enabled if it was force-disabled
-		 * by a  previous prctl call.
+		 * With strict mode for both IBPB and STIBP, the instruction
+		 * code paths avoid checking this task flag and instead,
+		 * unconditionally run the instruction. However, STIBP and IBPB
+		 * are independent and either can be set to conditionally
+		 * enabled regardless of the mode of the other. If either is set
+		 * to conditional, allow the task flag to be updated, unless it
+		 * was force-disabled by a previous prctl call.
+		 * Currently, this is possible on an AMD CPU which has the
+		 * feature X86_FEATURE_AMD_STIBP_ALWAYS_ON. In this case, if the
+		 * kernel is booted with 'spectre_v2_user=seccomp', then
+		 * spectre_v2_user_ibpb == SPECTRE_V2_USER_SECCOMP and
+		 * spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED.
 		 */
-		if (spectre_v2_user_ibpb == SPECTRE_V2_USER_STRICT ||
-		    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT ||
-		    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED ||
+		if (!is_spec_ib_user_controlled() ||
 		    task_spec_ib_force_disable(task))
 			return -EPERM;
 		task_clear_spec_ib_disable(task);
@@ -1283,9 +1298,7 @@ static int ib_prctl_set(struct task_struct *task, unsigned long ctrl)
 		if (spectre_v2_user_ibpb == SPECTRE_V2_USER_NONE &&
 		    spectre_v2_user_stibp == SPECTRE_V2_USER_NONE)
 			return -EPERM;
-		if (spectre_v2_user_ibpb == SPECTRE_V2_USER_STRICT ||
-		    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT ||
-		    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED)
+		if (!is_spec_ib_user_controlled())
 			return 0;
 		task_set_spec_ib_disable(task);
 		if (ctrl == PR_SPEC_FORCE_DISABLE)
@@ -1351,20 +1364,17 @@ static int ib_prctl_get(struct task_struct *task)
 	if (spectre_v2_user_ibpb == SPECTRE_V2_USER_NONE &&
 	    spectre_v2_user_stibp == SPECTRE_V2_USER_NONE)
 		return PR_SPEC_ENABLE;
-	else if (spectre_v2_user_ibpb == SPECTRE_V2_USER_STRICT ||
-	    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT ||
-	    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED)
-		return PR_SPEC_DISABLE;
-	else if (spectre_v2_user_ibpb == SPECTRE_V2_USER_PRCTL ||
-	    spectre_v2_user_ibpb == SPECTRE_V2_USER_SECCOMP ||
-	    spectre_v2_user_stibp == SPECTRE_V2_USER_PRCTL ||
-	    spectre_v2_user_stibp == SPECTRE_V2_USER_SECCOMP) {
+	else if (is_spec_ib_user_controlled()) {
 		if (task_spec_ib_force_disable(task))
 			return PR_SPEC_PRCTL | PR_SPEC_FORCE_DISABLE;
 		if (task_spec_ib_disable(task))
 			return PR_SPEC_PRCTL | PR_SPEC_DISABLE;
 		return PR_SPEC_PRCTL | PR_SPEC_ENABLE;
-	} else
+	} else if (spectre_v2_user_ibpb == SPECTRE_V2_USER_STRICT ||
+	    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT ||
+	    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED)
+		return PR_SPEC_DISABLE;
+	else
 		return PR_SPEC_NOT_AFFECTED;
 }
 
-- 
2.29.1.341.ge80a0c044ae-goog

