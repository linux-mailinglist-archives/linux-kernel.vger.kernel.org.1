Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D962281EEB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 01:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbgJBXLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 19:11:25 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54354 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBXLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 19:11:25 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 1F6DD29DC91
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Robert Richter <rric@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, kernel@collabora.com
Subject: Re: [PATCH v2 7/9] x86: Use current USER_CS to setup correct context on vmx entry
Organization: Collabora
References: <20201001205819.27879-1-krisman@collabora.com>
        <20201001205819.27879-8-krisman@collabora.com>
        <CALCETrW74MjC2-MRkRrp3uGOhapH_1zG5GCBkPsLFXs+jPXNOg@mail.gmail.com>
        <20201002224005.GF24460@linux.intel.com>
Date:   Fri, 02 Oct 2020 19:11:19 -0400
In-Reply-To: <20201002224005.GF24460@linux.intel.com> (Sean Christopherson's
        message of "Fri, 2 Oct 2020 15:40:06 -0700")
Message-ID: <878scoql48.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Thu, Oct 01, 2020 at 02:52:32PM -0700, Andy Lutomirski wrote:
>> On Thu, Oct 1, 2020 at 1:59 PM Gabriel Krisman Bertazi
>> <krisman@collabora.com> wrote:
>> >
>> > vmx_prepare_switch_to_guest shouldn't use is_64bit_mm, which has a
>> > very specific use in uprobes.  Use the user_64bit_mode helper instead.
>> > This reduces the usage of is_64bit_mm, which is awkward, since it relies
>> > on the personality at load time, which is fine for uprobes, but doesn't
>> > seem fine here.
>> >
>> > I tested this by running VMs with 64 and 32 bits payloads from 64/32
>> > programs.
>> >
>> > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>> > ---
>> >  arch/x86/kvm/vmx/vmx.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>> > index 7b2a068f08c1..b5aafd9e5f5d 100644
>> > --- a/arch/x86/kvm/vmx/vmx.c
>> > +++ b/arch/x86/kvm/vmx/vmx.c
>> > @@ -1172,7 +1172,7 @@ void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
>> >         savesegment(es, host_state->es_sel);
>> >
>> >         gs_base = cpu_kernelmode_gs_base(cpu);
>> > -       if (likely(is_64bit_mm(current->mm))) {
>> > +       if (likely(user_64bit_mode(current_pt_regs()))) {
>> >                 current_save_fsgs();
>> >                 fs_sel = current->thread.fsindex;
>> >                 gs_sel = current->thread.gsindex;
>> 
>> I disagree with this one.  This whole code path is nonsense.  Can you
>> just remove the condition entirely and use the 64-bit path
>> unconditionally?
>
> I finally came back to this one with fresh eyes.  I've read through the code
> a bajllion times and typed up half a dozen responses.  I think, finally, I
> understand what's broken.
>
> I believe your original assertion that the bug was misdiagnosed is correct
> (can't link because LKML wasn't in the loop).  I'm pretty sure your analysis
> that KVM's handling of things works mostly by coincidence is also correct.
>
> The coincidence is that "real" VMMs all use arch_prctl(), and
> do_arch_prctl_64() ensures thread.{fs,gs}base are accurate.  save_base_legacy()
> detects sel==0 and intentionally does nothing, knowing the the base is already
> accurate.
>
> Userspaces that don't use arch_prctl(), in the bug report case a 32-bit compat
> test, may or may not have accurate thread.{fs,gs}base values.  This is
> especially true if sel!=0 as save_base_legacy() explicitly zeros the base in
> this case, as load_seg_legacy() will restore the seg on the backend.
>
> KVM on the other hand assumes thread.{fs,gs}base are always fresh.  When that
> didn't hold true for userspace that didn't use arch_prctl(), the fix of
> detecting a !64-bit mm just so happened to work because all 64-bit VMMs use
> arch_prctl().
>
> It's tempting to just open code this and use RD{FS,GS}BASE when possible,
> i.e. avoid any guesswork.  Maybe with a module param that userspace can set
> to tell KVM it doesn't do anything fancy with FS/GS base (will userspace still
> use arch_prctl() even if FSGSABSE is available?).
>
>         savesegment(fs, fs_sel);
>         savesegment(gs, gs_sel);
> 	if (use_current_fsgs_base) {
> 		fs_base = current->thread.fsbase;
> 		vmx->msr_host_kernel_gs_base = current->thread.gsbase;
> 	} else if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
>                 fs_base = rdfsbase()
>                 vmx->msr_host_kernel_gs_base = __rdgsbase_inactive();
>         } else {
>                 fs_base = read_msr(MSR_FS_BASE);
>                 vmx->msr_host_kernel_gs_base = read_msr(MSR_KERNEL_GS_BASE);
>         }
>
> I'll revisit this on Monday and run a patch by Paolo.

If this is the case, I will just drop the current patch from my series
and leave it to you.  Given that is_64bit_mm() is not going away, this
use case can be fixed separately.

-- 
Gabriel Krisman Bertazi
