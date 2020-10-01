Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EACF2805B4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732902AbgJARoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:44:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:45208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732096AbgJARoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:44:11 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F7AE21D7D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 17:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601574250;
        bh=fLvm4Ft+DYqk3IETLdVq73IjtN47CxnvQvs1UKyFaq8=;
        h=From:Date:Subject:To:Cc:From;
        b=Rhg6Rtx6kanJEMJ/XjJoGRZN3IoYnLtkUngwGYb+l9EGKZYEToSCaE89cnDau657J
         u3eem0WOjDEtMODU3r5lYcDmFRJrcICmQE9E/rWKvuWnbxZnBrKPoXCMqrWQd+a44K
         i57x4mciSbXJTvdufGdUijyEhKtRSvJWTzovbKpA=
Received: by mail-wr1-f50.google.com with SMTP id c18so6774038wrm.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 10:44:10 -0700 (PDT)
X-Gm-Message-State: AOAM532TFEKOdvInhNiEm+h+EAQjtCzzre+T0/eyCJjI7XKNZr+nrRl7
        YxspKbzscLZJJobTILoQsfEqTN7tJx7M7bk3CmmxIA==
X-Google-Smtp-Source: ABdhPJy+0yoWJLIrtCZR7WksuCtRy5d12jdS0uidYVqdJ8n8QXnmTJirFIyF1thT7xuFyezhJIudwNEpnpWVsxTf6Vg=
X-Received: by 2002:a5d:5281:: with SMTP id c1mr10242876wrv.184.1601574248742;
 Thu, 01 Oct 2020 10:44:08 -0700 (PDT)
MIME-Version: 1.0
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 1 Oct 2020 10:43:58 -0700
X-Gmail-Original-Message-ID: <CALCETrXENKF9iVXaQrQcbgFq7fksC2pGz86tr9YGgDdeP3uR-Q@mail.gmail.com>
Message-ID: <CALCETrXENKF9iVXaQrQcbgFq7fksC2pGz86tr9YGgDdeP3uR-Q@mail.gmail.com>
Subject: How should we handle illegal task FPU state?
To:     Dave Hansen <dave.hansen@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Rik van Riel <riel@surriel.com>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our current handling of illegal task FPU state is currently rather
simplistic.  We basically ignore the issue with this extable code:

/*
 * Handler for when we fail to restore a task's FPU state.  We should never get
 * here because the FPU state of a task using the FPU (task->thread.fpu.state)
 * should always be valid.  However, past bugs have allowed userspace to set
 * reserved bits in the XSAVE area using PTRACE_SETREGSET or sys_rt_sigreturn().
 * These caused XRSTOR to fail when switching to the task, leaking the FPU
 * registers of the task previously executing on the CPU.  Mitigate this class
 * of vulnerability by restoring from the initial state (essentially, zeroing
 * out all the FPU registers) if we can't restore from the task's FPU state.
 */
__visible bool ex_handler_fprestore(const struct exception_table_entry *fixup,
                                    struct pt_regs *regs, int trapnr,
                                    unsigned long error_code,
                                    unsigned long fault_addr)
{
        regs->ip = ex_fixup_addr(fixup);

        WARN_ONCE(1, "Bad FPU state detected at %pB, reinitializing
FPU registers.",
                  (void *)instruction_pointer(regs));

        __copy_kernel_to_fpregs(&init_fpstate, -1);
        return true;
}
EXPORT_SYMBOL_GPL(ex_handler_fprestore);

In other words, we mostly pretend that illegal FPU state can't happen,
and, if it happens, we print a WARN and we blindly run the task with
the wrong state.  This is at least an improvement from the previous
code -- see

commit d5c8028b4788f62b31fb79a331b3ad3e041fa366
Author: Eric Biggers <ebiggers@google.com>
Date:   Sat Sep 23 15:00:09 2017 +0200

    x86/fpu: Reinitialize FPU registers if restoring FPU state fails

And we have some code that tries to sanitize user state to avoid this.

IMO this all made a little bit of sense when "FPU" meant literally FPU
or at least state that was more or less just user registers.  But now
we have this fancy "supervisor" state, and I don't think we should be
running user code in a context with potentially corrupted or even
potentially incorrectly re-initialized supervisor state.  This is an
issue for SHSTK -- if an attacker can find a straightforward way to
corrupt a target task's FPU state, then that task will run with CET
disabled.  Whoops!

The question is: what do we do about it?  We have two basic choices, I think.

a) Decide that the saved FPU for a task *must* be valid at all times.
If there's a failure to restore state, kill the task.

b) Improve our failed restoration handling and maybe even
intentionally make it possible to create illegal state to allow
testing.

(a) sounds like a nice concept, but I'm not convinced it's practical.
For example, I'm not even convinced that the set of valid SSP values
is documented.

So maybe (b) is the right choice.  Getting a good implementation might
be tricky.  Right now, we restore FPU too late in
arch_exit_to_user_mode_prepare(), and that function isn't allowed to
fail or to send signals.  We could kill the task on failure, and I
suppose we could consider queueing a signal, sending IPI-to-self, and
returning with TIF_NEED_FPU_LOAD still set and bogus state.  Or we
could rework the exit-to-usermode code to allow failure.  All of this
becomes utterly gross for the return-from-NMI path, although I guess
we don't restore FPU regs in that path regardless.  Or we can
do_exit() and just bail outright.

I think it would be polite to at least allow core dumping a bogus FPU
state, and notifying ptrace() might be nice.  And, if the bogus part
of the FPU state is non-supervisor, we could plausibly deliver a
signal, but this is (as above) potentially quite difficult.

(As an aside, our current handling of signal delivery failure sucks.
We should *at least* log something useful.)


Regardless of how we decide to handle this, I do think we need to do
*something* before applying the CET patches.
