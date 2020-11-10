Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1318C2ACA84
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 02:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbgKJBeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 20:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKJBeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 20:34:01 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6ABC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 17:34:01 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id z9so7000763qvo.20
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 17:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=ozgb9YGxleEdx7k5QcanT69s8iNvHYTBqSVYepR1XPM=;
        b=JYXJC71oY8EsuAaCVFCPpss3WYK4JbvNM/RxM62Z8ydsipRxTsh6csxtQuRYQrxwjX
         49wRoO9nG7FFXnsO0g+8QCwyLxDwMn36sT6RTbhTJbuPcDFIE9cmixlQ/3Gdubri2CBJ
         +ZGGEsD8c7mA9S1arTWP4OQORkul9a4asQ+8/Du845AGqSGX40YaMosin3OxdnKPYNhU
         ZbkodIoz9M97jAquTayijxsY38sZCeKEC+FJxvrl1evjXwXt7JZjkI494K/qLYbiKKJL
         ZfdzkLnMbOEUdFK7FjIJS0FMAgFF2P3Y5wEgvUXRl1YQY+YEygyna16mR9dVjDhT+EjS
         xkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=ozgb9YGxleEdx7k5QcanT69s8iNvHYTBqSVYepR1XPM=;
        b=sCz91EQap7CfLfYihzPvp0IQbocFa7QZhxmxpGYcjgNxZnLh8sHWSpWah/67cU9G8p
         iw1CNV7tPpuahmLk/tcGkJDjkdPP2mzHTT/cN+pmxoWgTIvU0A8RWQ1hskjihWxQ0Y/n
         wKMDafL/bFa/2WlpHZXIST4s3zlV7Mm6kP6Tar5Q26CgDwlEG8V8hXVIlJqiPiHTWOCB
         Do5FiBI0zHpOJtqdFF9mAcAlLauDKcnDQoABHsECQ285k1zNDbIKErfK2oC9Fbskb5r8
         bXbCUvHD/KLMAx2WaFVCpeikibewYSB3mQPXUSKyo1FatNPc7DaGRWQTuTRJzYCvx3sq
         elcg==
X-Gm-Message-State: AOAM533mC1B3V0LLYWxBu+1Crmcv4Tzv+WlNyMOggWP4Zfp8a6Y61eC5
        N69BSYlip/ol28Wyz21b1pMo+S9v0eYX
X-Google-Smtp-Source: ABdhPJwGV69AmNhbhvN0E0fKylgquXu9isRGDfJEPTyw94UxzQHuue1VnEyOC9BHkQm6jNh//NFclovU0VXU
Sender: "amistry via sendgmr" <amistry@nandos.syd.corp.google.com>
X-Received: from nandos.syd.corp.google.com ([2401:fa00:9:14:725a:fff:fe46:72ab])
 (user=amistry job=sendgmr) by 2002:a0c:d68d:: with SMTP id
 k13mr16831976qvi.62.1604972040790; Mon, 09 Nov 2020 17:34:00 -0800 (PST)
Date:   Tue, 10 Nov 2020 12:33:53 +1100
Message-Id: <20201110123349.1.Id0cbf996d2151f4c143c90f9028651a5b49a5908@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH] x86/speculation: Fix prctl() when spectre_v2_user={seccomp,prctl},ibpb
From:   Anand K Mistry <amistry@google.com>
To:     x86@kernel.org
Cc:     joelaf@google.com, Thomas.Lendacky@amd.com,
        asteinhauser@google.com, tglx@linutronix.de,
        Anand K Mistry <amistry@google.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When spectre_v2_user={seccomp,prctl},ibpb, IBPB is force-enabled and
STIPB is conditionally-enabled (or not available). However, since
commit 21998a351512 ("x86/speculation: Avoid force-disabling IBPB based on
STIBP and enhanced IBRS.") the spectre_v2_user_ibpb variable is set to
SPECTRE_V2_USER_{PRCTL,SECCOMP} instead of SPECTRE_V2_USER_STRICT, which
is the actual behaviour. Because the issuing of IBPB relies on the
switch_mm_*_ibpb static branches, the mitigations behave as expected.

Since commit 1978b3a53a74 ("x86/speculation: Allow IBPB to be conditionally
enabled on CPUs with always-on STIBP") this discrepency caused the
misreporting of IB speculation via prctl().

On CPUs with STIBP always-on and spectre_v2_user=seccomp,ibpb,
prctl(PR_GET_SPECULATION_CTRL) would return PR_SPEC_PRCTL |
PR_SPEC_ENABLE instead of PR_SPEC_DISABLE since both IBPB and STIPB are
always on. It also allowed prctl(PR_SET_SPECULATION_CTRL) to set the IB
speculation mode, even though the flag is ignored.

Similarly for CPUs without SMT, prctl(PR_GET_SPECULATION_CTRL) should
also return PR_SPEC_DISABLE since IBPB is always on and STIBP is not
available.

Fixes: 21998a351512 ("x86/speculation: Avoid force-disabling IBPB based on STIBP and enhanced IBRS.")
Fixes: 1978b3a53a74 ("x86/speculation: Allow IBPB to be conditionally enabled on CPUs with always-on STIBP")
Signed-off-by: Anand K Mistry <amistry@google.com>

---
This is a follow up to my last patch (https://lore.kernel.org/lkml/20201105163246.v2.1.Ifd7243cd3e2c2206a893ad0a5b9a4f19549e22c6@changeid/).
Unlike that one, this one does not change the behaviour or allow
enabling/disabling of IB speculation. Rather, it fixes the way the
prctl() responds. The last patch exposed an existing oversight in way
migitations were being tracked. Basically, the switch_mm_*_ibpb static
branches and the spectre_v2_user_ibpb variable were not consistent. This
patch tried to line those ducks in a row, as well as you can wrangle
ducks. Unfortunately, duck-wrangling is not one of my areas of
expertise.

 arch/x86/kernel/cpu/bugs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 581fb7223ad0..d41b70fe4918 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -739,11 +739,13 @@ spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
 	if (boot_cpu_has(X86_FEATURE_IBPB)) {
 		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
 
+		spectre_v2_user_ibpb = mode;
 		switch (cmd) {
 		case SPECTRE_V2_USER_CMD_FORCE:
 		case SPECTRE_V2_USER_CMD_PRCTL_IBPB:
 		case SPECTRE_V2_USER_CMD_SECCOMP_IBPB:
 			static_branch_enable(&switch_mm_always_ibpb);
+			spectre_v2_user_ibpb = SPECTRE_V2_USER_STRICT;
 			break;
 		case SPECTRE_V2_USER_CMD_PRCTL:
 		case SPECTRE_V2_USER_CMD_AUTO:
@@ -757,8 +759,6 @@ spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
 		pr_info("mitigation: Enabling %s Indirect Branch Prediction Barrier\n",
 			static_key_enabled(&switch_mm_always_ibpb) ?
 			"always-on" : "conditional");
-
-		spectre_v2_user_ibpb = mode;
 	}
 
 	/*
-- 
2.29.2.222.g5d2a92d10f8-goog

