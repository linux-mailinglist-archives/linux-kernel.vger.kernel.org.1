Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFDC2808E6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 22:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbgJAU7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:59:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:40269 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbgJAU7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:59:01 -0400
IronPort-SDR: 6YxHkvyg2f7QlNVt1YqWnOUkhySaz1+5/SYXHuV8MLditFWd+R9y4jWbXQnPDkiIo7aNRUoK6k
 ngK2JU+lBicw==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="142845748"
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="142845748"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 13:58:59 -0700
IronPort-SDR: jeuPtPMtwp6onCuVQMFiGkBz7UMIDnT8y8V9SNnYQtTfEDDPb7y1jmI1qCfFL2f/ECGl2Q1vgj
 pOp4OxIAoVyw==
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="313227300"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.160])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 13:58:58 -0700
Date:   Thu, 1 Oct 2020 13:58:57 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: How should we handle illegal task FPU state?
Message-ID: <20201001205857.GH7474@linux.intel.com>
References: <CALCETrXENKF9iVXaQrQcbgFq7fksC2pGz86tr9YGgDdeP3uR-Q@mail.gmail.com>
 <71682bce-a925-d3bd-18ef-d2e4eb8ebc8e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71682bce-a925-d3bd-18ef-d2e4eb8ebc8e@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 01:32:04PM -0700, Yu, Yu-cheng wrote:
> On 10/1/2020 10:43 AM, Andy Lutomirski wrote:
> >The question is: what do we do about it?  We have two basic choices, I think.
> >
> >a) Decide that the saved FPU for a task *must* be valid at all times.
> >If there's a failure to restore state, kill the task.
> >
> >b) Improve our failed restoration handling and maybe even
> >intentionally make it possible to create illegal state to allow
> >testing.
> >
> >(a) sounds like a nice concept, but I'm not convinced it's practical.
> >For example, I'm not even convinced that the set of valid SSP values
> >is documented.

Eh, crappy SDM writing isn't a good reason to make our lives harder.  The
SSP MSRs are canonical MSRs and follow the same rules as the SYSCALL,
FS/GS BASE, etc... MSRs.  I'll file an SDM bug.

> >So maybe (b) is the right choice.  Getting a good implementation might
> >be tricky.  Right now, we restore FPU too late in
> >arch_exit_to_user_mode_prepare(), and that function isn't allowed to
> >fail or to send signals.  We could kill the task on failure, and I
> >suppose we could consider queueing a signal, sending IPI-to-self, and
> >returning with TIF_NEED_FPU_LOAD still set and bogus state.  Or we
> >could rework the exit-to-usermode code to allow failure.  All of this
> >becomes utterly gross for the return-from-NMI path, although I guess
> >we don't restore FPU regs in that path regardless.  Or we can
> >do_exit() and just bail outright.
> >
> >I think it would be polite to at least allow core dumping a bogus FPU
> >state, and notifying ptrace() might be nice.  And, if the bogus part
> >of the FPU state is non-supervisor, we could plausibly deliver a
> >signal, but this is (as above) potentially quite difficult.
> >
> >(As an aside, our current handling of signal delivery failure sucks.
> >We should *at least* log something useful.)
> >
> >
> >Regardless of how we decide to handle this, I do think we need to do
> >*something* before applying the CET patches.
> >
> 
> Before supervisor states are introduced, XRSTOR* fails because one of the
> following: memory operand is invalid, xstate_header is wrong, or
> fxregs_state->mxcsr is wrong.  So the code in ex_handler_fprestore() was
> good.
> 
> When supervisor states are introduced for CET and PASID, XRSTORS can fail
> for only one additional reason: if it effects a WRMSR of invalid values.
> 
> If the kernel writes to the MSRs directly, there is wrmsr_safe().  If the
> kernel writes to MSRs' xstates, it can check the values first.  So this
> might not need a generalized handling (but I would not oppose it). Maybe we
> can add a config debug option to check if any writes to those MSR xstates
> are checked before being written (and print out warnings when not)?

That's not really checking the values first though, e.g. if the WRMSR succeeds,
which is the common case, but a later WRMSR fails, then you have to back out
the first MSR.  Even if all goes well, each WRMSR is 125+ cycles, which means
that loading state would get very painful and would defeat the entire reason
for shoving CET into XSAVE state.

Having a try-catch variant at the lowest level, i.e. propagating errors to the
the caller, and building on that sounds appealing.  E.g. KVM could use the
try-catch to test that incoming XSAVE state is valid when userspace is stuffing
guest state instead of manually validating every piece.  Validating CET and
PASID won't be too painful, but there might be a breaking point if the current
trend of shoving everything into XSAVE continues.

One thought for a lowish effort approach to pave the way for CET would be to
try XRSTORS multiple times in switch_fpu_return().  If the first try fails,
then WARN, init non-supervisor state and try a second time, and if _that_ fails
then kill the task.  I.e. do the minimum effort to play nice with bad FPU
state, but don't let anything "accidentally" turn off CET.
