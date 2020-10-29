Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5E529E3FE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgJ2HZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbgJ2HYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:24:38 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95467C08E88D
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 23:52:10 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id l1so1233967qvr.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 23:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ycGNe9+r6ZtsYB7fMYl9NQm2H2sRV2pn//velGjkXrw=;
        b=UcYBwkrfGiUksGFx6YqPe5lAsbqVsJJDCMxpB9iTr12x8RG/i3A0UFNFrSM64saniq
         lqYyP47C0NJVpHaVeCdHGTyCpgnFt5GXXearFPPOnsJF9EOU44ljR1W3/s1bTQ76VZ/4
         W5GwGKHRFND7DxNvzXW7DHXbtzidINzQxhr87mBFQnXJGz678M3fedCuzXwPp/E3RosE
         OOsjEOIfiucJnpjmkotP2IPdhH7M3dYefoNEAFvqB5n0Ph7DzeL1r/w7DXCIi+Kcx7Mw
         UVZHQl25UbxPdHDNJEHObUR1GnY5I4Sd/WAU/YSbOjwWBEf+VeuGFEaodQsONRN9PpOH
         Q2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ycGNe9+r6ZtsYB7fMYl9NQm2H2sRV2pn//velGjkXrw=;
        b=oTvvyXJVpcEOQVFCs4jwRXu803Xm0zQCxZU35DGQj4VuTyxlDRPWWFrHCSTj2uFC22
         RKothdqcuxcru7s0kkJp2Pge8E2l7Qg3iXYKyTosJ8SsnY6xg9PGaSjZ8n+IaxjoKLjS
         NH4UMZgL2rWw+WqzjJvzPxJZQaNTbEcv0NEq1luKLxqpYk5RAVWsIONUg31d0/LPXiGJ
         9+s7x8bOVSGvjM66GA5cwQ6Iww+di050Z1QlaZctaDq8ZfM8Z/xDgJPzV7W5Qgfipun7
         dbH6w6SrKeGbCYvtBCcL9NYPanI3XbfEZhY8C88b9woQqem1x5M6e01+6Jb4XN5QSZXV
         xiCg==
X-Gm-Message-State: AOAM530DbcYP6oxj61u1EsmG9ZqSX9u6OvVX+ZtW/qrR89G3N7/i9vEl
        q0fzzIcp2Y/ZJ9CZeFjW//1r2ZtoAznW
X-Google-Smtp-Source: ABdhPJzK5gaXnV13yTy5JF/hpV2rHUzTu1Sa8j7G2DA016DdYFQGrUgnA9Tc5GbyzDqvj2+ntcfeMRHyjxuW
Sender: "amistry via sendgmr" <amistry@nandos.syd.corp.google.com>
X-Received: from nandos.syd.corp.google.com ([2401:fa00:9:14:725a:fff:fe46:72ab])
 (user=amistry job=sendgmr) by 2002:a0c:8d05:: with SMTP id
 r5mr2873241qvb.31.1603954329701; Wed, 28 Oct 2020 23:52:09 -0700 (PDT)
Date:   Thu, 29 Oct 2020 17:51:33 +1100
In-Reply-To: <20201029065133.3027749-1-amistry@google.com>
Message-Id: <20201029175120.1.Ifd7243cd3e2c2206a893ad0a5b9a4f19549e22c6@changeid>
Mime-Version: 1.0
References: <20201029065133.3027749-1-amistry@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH 1/1] x86/speculation: Allow IBPB to be conditionally enabled
 on CPUs with always-on STIBP
From:   Anand K Mistry <amistry@google.com>
To:     x86@kernel.org, linux-kernel@kernel.org
Cc:     Thomas.Lendacky@amd.com, joelaf@google.com,
        asteinhauser@google.com, tglx@linutronix.de,
        Anand K Mistry <amistry@google.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Vineela Tummalapalli <vineela.tummalapalli@intel.com>,
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

At a high level, this change does one thing. If either STIBP is IBPB is
set to conditional, allow the prctl to change the task flag. Also,
reflect that capability when querying the state. This isn't perfect
since it doesn't take into account if only STIBP or IBPB is
unconditionally on. But it allows the conditional feature to work as
expected, without affecting the unconditional one.

Signed-off-by: Anand K Mistry <amistry@google.com>

---

 arch/x86/kernel/cpu/bugs.c | 41 +++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d3f0db463f96..fb64e02eed6f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1254,6 +1254,11 @@ static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
 	return 0;
 }
 
+static bool is_spec_ib_user(enum spectre_v2_user_mitigation mode)
+{
+	return mode == SPECTRE_V2_USER_PRCTL || mode == SPECTRE_V2_USER_SECCOMP;
+}
+
 static int ib_prctl_set(struct task_struct *task, unsigned long ctrl)
 {
 	switch (ctrl) {
@@ -1262,13 +1267,16 @@ static int ib_prctl_set(struct task_struct *task, unsigned long ctrl)
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
 		 */
-		if (spectre_v2_user_ibpb == SPECTRE_V2_USER_STRICT ||
-		    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT ||
-		    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED ||
+		if ((!is_spec_ib_user(spectre_v2_user_ibpb) &&
+		     !is_spec_ib_user(spectre_v2_user_stibp)) ||
 		    task_spec_ib_force_disable(task))
 			return -EPERM;
 		task_clear_spec_ib_disable(task);
@@ -1283,9 +1291,8 @@ static int ib_prctl_set(struct task_struct *task, unsigned long ctrl)
 		if (spectre_v2_user_ibpb == SPECTRE_V2_USER_NONE &&
 		    spectre_v2_user_stibp == SPECTRE_V2_USER_NONE)
 			return -EPERM;
-		if (spectre_v2_user_ibpb == SPECTRE_V2_USER_STRICT ||
-		    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT ||
-		    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED)
+		if (!is_spec_ib_user(spectre_v2_user_ibpb) &&
+		    !is_spec_ib_user(spectre_v2_user_stibp))
 			return 0;
 		task_set_spec_ib_disable(task);
 		if (ctrl == PR_SPEC_FORCE_DISABLE)
@@ -1351,20 +1358,18 @@ static int ib_prctl_get(struct task_struct *task)
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
+	else if (is_spec_ib_user(spectre_v2_user_ibpb) ||
+		 is_spec_ib_user(spectre_v2_user_stibp)) {
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

