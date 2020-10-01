Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 212DC28087B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 22:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgJAUcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:32:09 -0400
Received: from mga01.intel.com ([192.55.52.88]:14453 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbgJAUcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:32:07 -0400
IronPort-SDR: y23F4aM1+FXR0Of1BFBZ8EH+4RR5B801w5apOmZINVTLwWUD+BLH11+ozDdfOemgmry1OO6lnF
 TeZ1LVpdV19g==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="180980873"
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="180980873"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 13:32:05 -0700
IronPort-SDR: gFYPUdM9uGeXkimDstK1vbhgdOKFFXgKMWy7470aOCUde4vRmluijVbiFVMZycJY1Ns+ksyUJg
 1ngRobw9W+gw==
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="515661137"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.213.183.12]) ([10.213.183.12])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 13:32:05 -0700
Subject: Re: How should we handle illegal task FPU state?
To:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Rik van Riel <riel@surriel.com>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>
References: <CALCETrXENKF9iVXaQrQcbgFq7fksC2pGz86tr9YGgDdeP3uR-Q@mail.gmail.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <71682bce-a925-d3bd-18ef-d2e4eb8ebc8e@intel.com>
Date:   Thu, 1 Oct 2020 13:32:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CALCETrXENKF9iVXaQrQcbgFq7fksC2pGz86tr9YGgDdeP3uR-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/2020 10:43 AM, Andy Lutomirski wrote:
> Our current handling of illegal task FPU state is currently rather
> simplistic.  We basically ignore the issue with this extable code:
> 
> /*
>   * Handler for when we fail to restore a task's FPU state.  We should never get
>   * here because the FPU state of a task using the FPU (task->thread.fpu.state)
>   * should always be valid.  However, past bugs have allowed userspace to set
>   * reserved bits in the XSAVE area using PTRACE_SETREGSET or sys_rt_sigreturn().
>   * These caused XRSTOR to fail when switching to the task, leaking the FPU
>   * registers of the task previously executing on the CPU.  Mitigate this class
>   * of vulnerability by restoring from the initial state (essentially, zeroing
>   * out all the FPU registers) if we can't restore from the task's FPU state.
>   */
> __visible bool ex_handler_fprestore(const struct exception_table_entry *fixup,
>                                      struct pt_regs *regs, int trapnr,
>                                      unsigned long error_code,
>                                      unsigned long fault_addr)
> {
>          regs->ip = ex_fixup_addr(fixup);
> 
>          WARN_ONCE(1, "Bad FPU state detected at %pB, reinitializing
> FPU registers.",
>                    (void *)instruction_pointer(regs));
> 
>          __copy_kernel_to_fpregs(&init_fpstate, -1);
>          return true;
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
>      x86/fpu: Reinitialize FPU registers if restoring FPU state fails
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
> 
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
> 
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
> 

Before supervisor states are introduced, XRSTOR* fails because one of 
the following: memory operand is invalid, xstate_header is wrong, or 
fxregs_state->mxcsr is wrong.  So the code in ex_handler_fprestore() was 
good.

When supervisor states are introduced for CET and PASID, XRSTORS can 
fail for only one additional reason: if it effects a WRMSR of invalid 
values.

If the kernel writes to the MSRs directly, there is wrmsr_safe().  If 
the kernel writes to MSRs' xstates, it can check the values first.  So 
this might not need a generalized handling (but I would not oppose it). 
Maybe we can add a config debug option to check if any writes to those 
MSR xstates are checked before being written (and print out warnings 
when not)?

Thanks,
Yu-cheng
