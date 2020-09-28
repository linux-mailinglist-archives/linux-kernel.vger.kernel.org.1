Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE75727AE8A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 15:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgI1NCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 09:02:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbgI1NCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 09:02:13 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DB0020738;
        Mon, 28 Sep 2020 13:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601298133;
        bh=jdysMaLrkR71ehjBrCElC5XtY4m0W338UonI9DdcFHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j8mUCWH307c6c2xxXQZ/kCrp16905805mCM4kH0eBwTS3P621bI5SLMZ+6RgJRg2g
         52T56S3MRMNNN5KxyLim3kc/iWsgDeKMRO+1ufNBbyTJYLQXExbGLqBSk/P+Ai5HJF
         WyfpWCfrJBHEcIpreKuuz8i7bcNdJLP9vRK6Tz4s=
Date:   Mon, 28 Sep 2020 14:02:09 +0100
From:   Will Deacon <will@kernel.org>
To:     Anthony Steinhauser <asteinhauser@google.com>
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        maz@kernel.org
Subject: Re: [PATCH v2] PR_SPEC_DISABLE_NOEXEC support for arm64.
Message-ID: <20200928130208.GA11356@willie-the-truck>
References: <20200921110020.GA2139@willie-the-truck>
 <20200922092153.978003-1-asteinhauser@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922092153.978003-1-asteinhauser@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anthony,

On Tue, Sep 22, 2020 at 02:21:53AM -0700, Anthony Steinhauser wrote:
> Support of Spectre v4 PR_SPEC_DISABLE_NOEXEC mitigation mode for on arm64.
> 
> PR_SPEC_DISABLE_NOEXEC turns the mitigation on, but it is automatically
> turned off whenever a new program is being execve'ed.
> 
> Signed-off-by: Anthony Steinhauser <asteinhauser@google.com>
> ---
> 
> I added the "#include <linux/sched/task_stack.h>" line to the
> arch/arm64/kernel/proton-pack.c file just to make the kernel compilable.
> It is not a part of the PR_SPEC_DISABLE_NOEXEC implementation.

Thanks, I saw the kbuild robot complain about this with 'allnoconfig'
builds, so I'll patch that separately.

>  arch/arm64/kernel/process.c     |  7 +++++++
>  arch/arm64/kernel/proton-pack.c | 35 +++++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 9dbd35b95253..5ac43b743696 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -391,6 +391,13 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
>  
>  	ptrauth_thread_init_kernel(p);
>  
> +	if (task_spec_ssb_noexec(current)) {
> +		clear_thread_flag(TIF_SSBD);
> +		task_clear_spec_ssb_disable(current);
> +		task_clear_spec_ssb_noexec(current);
> +		spectre_v4_enable_task_mitigation(current);
> +	}

Are you sure copy_thread() is the right place for this? afaict, that would
also apply to plain fork(), which isn't what we want. It looks like
arch_setup_new_exec() is a better fit, and matches what x86 does. Any reason
not to use that?

This also looks like we basically want to issue the PR_SPEC_ENABLE prctl()
on execve(). We can implement it like that to keep things simple and not
have to worry about the actual underlying state (aside: why doesn't the
core code do this?).

Anyway, I've had a crack at this. Please take a look at the diff below.

Will

--->8

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 9dbd35b95253..085d8ca39e47 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -21,6 +21,7 @@
 #include <linux/lockdep.h>
 #include <linux/mman.h>
 #include <linux/mm.h>
+#include <linux/nospec.h>
 #include <linux/stddef.h>
 #include <linux/sysctl.h>
 #include <linux/unistd.h>
@@ -609,6 +610,11 @@ void arch_setup_new_exec(void)
 	current->mm->context.flags = is_compat_task() ? MMCF_AARCH32 : 0;
 
 	ptrauth_thread_init_user(current);
+
+	if (task_spec_ssb_noexec(current)) {
+		arch_prctl_spec_ctrl_set(current, PR_SPEC_STORE_BYPASS,
+					 PR_SPEC_ENABLE);
+	}
 }
 
 #ifdef CONFIG_ARM64_TAGGED_ADDR_ABI
diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index 1fbaa0240d4c..c0d73d02b379 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -692,6 +692,9 @@ static int ssbd_prctl_set(struct task_struct *task, unsigned long ctrl)
 
 		task_set_spec_ssb_force_disable(task);
 		fallthrough;
+	case PR_SPEC_DISABLE_NOEXEC:
+		/* Disable speculation until execve(): enable mitigation */
+		fallthrough;
 	case PR_SPEC_DISABLE:
 		/* Disable speculation: enable mitigation */
 		/* Same as PR_SPEC_FORCE_DISABLE */
@@ -705,6 +708,12 @@ static int ssbd_prctl_set(struct task_struct *task, unsigned long ctrl)
 		return -ERANGE;
 	}
 
+	/* Handle the 'noexec' flag separately to save bloating up the switch */
+	if (ctrl == PR_SPEC_DISABLE_NOEXEC)
+		task_set_spec_ssb_noexec(task);
+	else
+		task_clear_spec_ssb_noexec(task);
+
 	spectre_v4_enable_task_mitigation(task);
 	return 0;
 }
@@ -744,6 +753,9 @@ static int ssbd_prctl_get(struct task_struct *task)
 	if (task_spec_ssb_force_disable(task))
 		return PR_SPEC_PRCTL | PR_SPEC_FORCE_DISABLE;
 
+	if (task_spec_ssb_noexec(task))
+		return PR_SPEC_PRCTL | PR_SPEC_DISABLE_NOEXEC;
+
 	if (task_spec_ssb_disable(task))
 		return PR_SPEC_PRCTL | PR_SPEC_DISABLE;
 
