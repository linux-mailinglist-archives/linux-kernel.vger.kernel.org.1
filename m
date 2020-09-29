Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C8627BEE4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgI2IKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:10:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbgI2IKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:10:41 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 568F320774;
        Tue, 29 Sep 2020 08:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601367040;
        bh=JPTKLADqxJO1lYhUklnGghxIkw2n/E6c/j+Kl0Gc6t8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JQQzh292fr9MSAgTnxe+zB+zj8FW77nPSGURHq38GcCK781pHygZo/EEQ3bcK8IPW
         e7xud7Dt4kKEseJWts3QXxaTWMBC5i8HSerzIlFxlQVtgAEXHkiRe6rYt1+TMKSvPt
         OCDpRYb6uSM7zPWn+oDvM4RJ9rx4aQD5XfGbh7BI=
Date:   Tue, 29 Sep 2020 09:10:35 +0100
From:   Will Deacon <will@kernel.org>
To:     Anthony Steinhauser <asteinhauser@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, catalin.marinas@arm.com,
        maz@kernel.org
Subject: Re: [PATCH v2] PR_SPEC_DISABLE_NOEXEC support for arm64.
Message-ID: <20200929081035.GA13576@willie-the-truck>
References: <20200921110020.GA2139@willie-the-truck>
 <20200922092153.978003-1-asteinhauser@google.com>
 <20200928130208.GA11356@willie-the-truck>
 <CAN_oZf36S=eX5qgyXg+dRi+thN5tRWxp7=SWYvjO0hZhxTAhrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN_oZf36S=eX5qgyXg+dRi+thN5tRWxp7=SWYvjO0hZhxTAhrQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anthony,

On Mon, Sep 28, 2020 at 10:10:32PM -0400, Anthony Steinhauser wrote:
> > Are you sure copy_thread() is the right place for this? afaict, that would
> > also apply to plain fork(), which isn't what we want. It looks like
> > arch_setup_new_exec() is a better fit, and matches what x86 does. Any reason
> > not to use that?
> >
> > This also looks like we basically want to issue the PR_SPEC_ENABLE prctl()
> > on execve(). We can implement it like that to keep things simple and not
> > have to worry about the actual underlying state (aside: why doesn't the
> > core code do this?).
> >
> > Anyway, I've had a crack at this. Please take a look at the diff below.
> >
> You're right that arch_setup_new_exec is a better place. You're also
> correct that the context-switch code in the x86 implementation seems
> unnecessarily complicated.
> 
> However, your version seems to allow behaviors which are not possible
> in the x86 implementation and they seem a bit counterintuitive to me.
> When PR_SPEC_FORCE_DISABLE is set to true, you can now set
> PR_SPEC_DISABLE_NOEXEC and it succeeds.

Hmm, yes, and the fact that you can query the prctl() state does make
this confusing, I agree.

> Afterwards, on the new exec the arch_prctl_spec_ctrl_set will fail, so
> the PR_SPEC_FORCE_DISABLE setting will be honored and the
> PR_SPEC_DISABLE_NOEXEC ignored, but it's a question whether it's good
> that PR_SPEC_DISABLE_NOEXEC succeeded (without an effect) instead of
> just failing with EPERM as in the x86 implementation. Similarly
> PR_SPEC_DISABLE_NOEXEC now succeeds (again without an effect) when the
> mitigation is forced on (spectre_v4_mitigation_on() returns true).
> 
> But it's up to you whether those false successes of
> PR_SPEC_DISABLE_NOEXEC and the doomed setting of the noexec flag are a
> noteworthy problem. The main purpose of the PR_SPEC_DISABLE_NOEXEC
> option on arm64 is fulfilled, so thanks for that.

I'll fold in the diff below, which I think solves the problem above; it's
closer to what you had originally, just refactored a bit and with the
execve()/fork() issue fixed.

Will

--->8

diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index 59f2ceb7a0e5..68b710f1b43f 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -660,6 +660,20 @@ void spectre_v4_enable_task_mitigation(struct task_struct *tsk)
  * prctl() may be necessary even when PSTATE.SSBS can be toggled directly
  * from userspace.
  */
+static void ssbd_prctl_enable_mitigation(struct task_struct *task)
+{
+	task_clear_spec_ssb_noexec(task);
+	task_set_spec_ssb_disable(task);
+	set_tsk_thread_flag(task, TIF_SSBD);
+}
+
+static void ssbd_prctl_disable_mitigation(struct task_struct *task)
+{
+	task_clear_spec_ssb_noexec(task);
+	task_clear_spec_ssb_disable(task);
+	clear_tsk_thread_flag(task, TIF_SSBD);
+}
+
 static int ssbd_prctl_set(struct task_struct *task, unsigned long ctrl)
 {
 	switch (ctrl) {
@@ -679,8 +693,7 @@ static int ssbd_prctl_set(struct task_struct *task, unsigned long ctrl)
 		if (spectre_v4_mitigations_on())
 			return -EPERM;
 
-		task_clear_spec_ssb_disable(task);
-		clear_tsk_thread_flag(task, TIF_SSBD);
+		ssbd_prctl_disable_mitigation(task);
 		break;
 	case PR_SPEC_FORCE_DISABLE:
 		/* Force disable speculation: force enable mitigation */
@@ -693,28 +706,33 @@ static int ssbd_prctl_set(struct task_struct *task, unsigned long ctrl)
 
 		task_set_spec_ssb_force_disable(task);
 		fallthrough;
-	case PR_SPEC_DISABLE_NOEXEC:
-		/* Disable speculation until execve(): enable mitigation */
-		fallthrough;
 	case PR_SPEC_DISABLE:
 		/* Disable speculation: enable mitigation */
 		/* Same as PR_SPEC_FORCE_DISABLE */
 		if (spectre_v4_mitigations_off())
 			return -EPERM;
 
-		task_set_spec_ssb_disable(task);
-		set_tsk_thread_flag(task, TIF_SSBD);
+		ssbd_prctl_enable_mitigation(task);
+		break;
+	case PR_SPEC_DISABLE_NOEXEC:
+		/* Disable speculation until execve(): enable mitigation */
+		/*
+		 * If the mitigation state is forced one way or the other, then
+		 * we must fail now before we try to toggle it on execve().
+		 */
+		if (task_spec_ssb_force_disable(task) ||
+		    spectre_v4_mitigations_off() ||
+		    spectre_v4_mitigations_on()) {
+			return -EPERM;
+		}
+
+		ssbd_prctl_enable_mitigation(task);
+		task_set_spec_ssb_noexec(task);
 		break;
 	default:
 		return -ERANGE;
 	}
 
-	/* Handle the 'noexec' flag separately to save bloating up the switch */
-	if (ctrl == PR_SPEC_DISABLE_NOEXEC)
-		task_set_spec_ssb_noexec(task);
-	else
-		task_clear_spec_ssb_noexec(task);
-
 	spectre_v4_enable_task_mitigation(task);
 	return 0;
 }
