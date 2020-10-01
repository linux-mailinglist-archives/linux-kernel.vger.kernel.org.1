Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CD6280965
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 23:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733026AbgJAV07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 17:26:59 -0400
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:37842 "EHLO
        esa1.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgJAV07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 17:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1601587620;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=NOZNF47ur+0SexRLYTKp2dLrB2spnFA1n9g1wn7WrI0=;
  b=Hhm/HbwS7tXATDlItMumv+vH+QElFxzY2WLAQJW51V+UANSycgpxGKMc
   99W9nAesqggl4Lg4YDKMGsWKS4qJRuXqlrS/rJNUjY8uc0eySfW6pv7Ff
   AArem5IV7HWOzYXfeotrfORdLdV1deWZJJeREf69cWXQu2EctLHdEmVRr
   c=;
Authentication-Results: esa1.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: mtvjRlBS1f2o5cdHfV1n1wQ90ltUWco3cbqAOdDabpYAl4NbUhZQS+SXfhaC5hnIX/ibKHh6Do
 ET9F4YwgX8fF5Qc1Pe+NBEmrfBOS/yNaEv4bYTVNpEFf5t1jc9pY4eIipIlRjxTQPNaeiHPI1M
 9ed7fqGFCYFHn4bQZ8exRyE9S7AGpJa3p6XjKYTGje3Qto0tU/3yTH7EMH7XvS+MhOcQROSO+1
 mCT4nGhS9FNG47tYZ3aaL2v7zxXnacObOFDaYDsXL8PTMt1auR4wgqFiTTxQAiiqEn5HFyN7hf
 IZA=
X-SBRS: None
X-MesageID: 28455620
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.77,325,1596513600"; 
   d="scan'208";a="28455620"
Subject: Re: How should we handle illegal task FPU state?
To:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, "X86 ML" <x86@kernel.org>,
        Rik van Riel <riel@surriel.com>
References: <CALCETrXENKF9iVXaQrQcbgFq7fksC2pGz86tr9YGgDdeP3uR-Q@mail.gmail.com>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <675cdebe-e06f-ff4d-2db6-ea531d21168f@citrix.com>
Date:   Thu, 1 Oct 2020 22:26:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CALCETrXENKF9iVXaQrQcbgFq7fksC2pGz86tr9YGgDdeP3uR-Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 FTLPEX02CL05.citrite.net (10.13.108.178)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/2020 18:43, Andy Lutomirski wrote:
> Our current handling of illegal task FPU state is currently rather
> simplistic.  We basically ignore the issue with this extable code:
>
> /*
>  * Handler for when we fail to restore a task's FPU state.  We should never get
>  * here because the FPU state of a task using the FPU (task->thread.fpu.state)
>  * should always be valid.  However, past bugs have allowed userspace to set
>  * reserved bits in the XSAVE area using PTRACE_SETREGSET or sys_rt_sigreturn().
>  * These caused XRSTOR to fail when switching to the task, leaking the FPU
>  * registers of the task previously executing on the CPU.  Mitigate this class
>  * of vulnerability by restoring from the initial state (essentially, zeroing
>  * out all the FPU registers) if we can't restore from the task's FPU state.
>  */
> __visible bool ex_handler_fprestore(const struct exception_table_entry *fixup,
>                                     struct pt_regs *regs, int trapnr,
>                                     unsigned long error_code,
>                                     unsigned long fault_addr)
> {
>         regs->ip = ex_fixup_addr(fixup);
>
>         WARN_ONCE(1, "Bad FPU state detected at %pB, reinitializing FPU registers.",
>                   (void *)instruction_pointer(regs));
>
>         __copy_kernel_to_fpregs(&init_fpstate, -1);
>         return true;
> }
> EXPORT_SYMBOL_GPL(ex_handler_fprestore);
>
> In other words, we mostly pretend that illegal FPU state can't happen,
> and, if it happens, we print a WARN and we blindly run the task with
> the wrong state.  This is at least an improvement from the previous
> code -- see
>
> commit d5c8028b4788f62b31fb79a331b3ad3e041fa366
> Author: Eric Biggers <ebiggers@google.com>
> Date:   Sat Sep 23 15:00:09 2017 +0200
>
>     x86/fpu: Reinitialize FPU registers if restoring FPU state fails
>
> And we have some code that tries to sanitize user state to avoid this.
>
> IMO this all made a little bit of sense when "FPU" meant literally FPU
> or at least state that was more or less just user registers.  But now
> we have this fancy "supervisor" state, and I don't think we should be
> running user code in a context with potentially corrupted or even
> potentially incorrectly re-initialized supervisor state.  This is an
> issue for SHSTK -- if an attacker can find a straightforward way to
> corrupt a target task's FPU state, then that task will run with CET
> disabled.  Whoops!

-1 would not recommend.

> The question is: what do we do about it?  We have two basic choices, I think.
>
> a) Decide that the saved FPU for a task *must* be valid at all times.
> If there's a failure to restore state, kill the task.
>
> b) Improve our failed restoration handling and maybe even
> intentionally make it possible to create illegal state to allow
> testing.
>
> (a) sounds like a nice concept, but I'm not convinced it's practical.
> For example, I'm not even convinced that the set of valid SSP values
> is documented.

SSP is just a stack pointer, but its not included in XSTATE.

The CET_U XSTATE component contains MSR_PL3_SSP and MSR_U_CET, both of
which have well defined validity descriptions in the manual.

The CET_S XSTATE component contains MSR_PL{2..0}_SSP, but this will be
of no interest to Linux at all.

As these can only be loaded in supervisor mode, neither operate on the
currently active SSP.

Given how broken Rings 1 and 2 are by CET-SS, I'm very surprised that an
XSTATE was allocated for this purpose.  Nothing in the architecture ever
updates these values in hardware, so they're never modified since the
last XRSTORS, unless someone played with the MSRs directly.

> So maybe (b) is the right choice.  Getting a good implementation might
> be tricky.  Right now, we restore FPU too late in
> arch_exit_to_user_mode_prepare(), and that function isn't allowed to
> fail or to send signals.  We could kill the task on failure, and I
> suppose we could consider queueing a signal, sending IPI-to-self, and
> returning with TIF_NEED_FPU_LOAD still set and bogus state.  Or we
> could rework the exit-to-usermode code to allow failure.  All of this
> becomes utterly gross for the return-from-NMI path, although I guess
> we don't restore FPU regs in that path regardless.  Or we can
> do_exit() and just bail outright.
>
> I think it would be polite to at least allow core dumping a bogus FPU
> state, and notifying ptrace() might be nice.  And, if the bogus part
> of the FPU state is non-supervisor, we could plausibly deliver a
> signal, but this is (as above) potentially quite difficult.
>
> (As an aside, our current handling of signal delivery failure sucks.
> We should *at least* log something useful.)
>
>
> Regardless of how we decide to handle this, I do think we need to do
> *something* before applying the CET patches.

Conceptually, a fault on [F]XRSTOR[S] ought to be fatal.  Something
corrupt there is definitely an exceptional circumstance.

Making it accessible in a coredump is a nice touch.  In theory it should
be impossible, but CPUs don't have a perfect track record of being able
to consume the data they emit - the Haswell/Broadwell TSX errata with
LBR MSRs come to mind, even if it wasn't XSTATE.

Identifying the faulty state isn't necessarily trivial.  Even presuming
no memory corruption, it could be one or multiple of the components, and
even if you can find the bad one(s), this issue demonstrates that
zeroing it isn't necessarily the safe thing to do.

This condition is going to be a slowpath anyway.  What about a fixup
function which runs across an arbitrary XSTATE blob, and tries to
sanitises it?  This can be reused by software (i.e. non-[F]XSAVE[S]
sources) of XSTATE to reject bad input, and on fault to try and cope
with fallout.  If the fixed up version faults again, then you have to
terminate the task anyway.

Whatever happens, even if running the task with fixed up state, the
fixup action needs to be very loud in the logs, so someone will
investigate and fix the root cause.

~Andrew
