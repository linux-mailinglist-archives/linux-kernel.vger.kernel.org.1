Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC76283F1F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 20:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbgJES4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 14:56:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:58222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbgJES4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 14:56:20 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3456621481
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 18:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601924178;
        bh=UabuMpF8QmfxpY1Z2mOfWNbkkPCrSgLnfGtf9Ho6TZg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZsBDTJ+C9Iut5RHeCNJ8NKC9p0njVVyOIo3IKt4ZrvTkT2LIvGq3v7aYzQ78uXfSB
         Fqlf/WHZgUYvHJnv0rjTedn50e9+PgeMTku2KqEaj0VGrdhb1I9aOYH7tApOG3MXfh
         GVBZiRg9QD8lqv9ICr8e/vETexNxV8qRKmcPZhAA=
Received: by mail-wm1-f45.google.com with SMTP id l11so558658wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 11:56:18 -0700 (PDT)
X-Gm-Message-State: AOAM5305RAkwJYaoNvFuB9BJQoahVv3ZzljiFmASSkUXeGfaND7ZXYZU
        m2qQZIePbJkxAEI0zSCEbEmq7I+sF+whAXFwbmtvKA==
X-Google-Smtp-Source: ABdhPJzPhQnui4YZQTrkyr+rGYmwPK7ankFUH/YAE817uLajJ7Y1c6SlCGeovbHVVnLIdQIiT2B12M8xPxYqIeboPd4=
X-Received: by 2002:a05:600c:2241:: with SMTP id a1mr809024wmm.49.1601924176586;
 Mon, 05 Oct 2020 11:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201001205819.27879-1-krisman@collabora.com> <20201001205819.27879-8-krisman@collabora.com>
 <CALCETrW74MjC2-MRkRrp3uGOhapH_1zG5GCBkPsLFXs+jPXNOg@mail.gmail.com>
 <20201002224005.GF24460@linux.intel.com> <CALCETrWw3WkjzzqS+j5LDhLdLrr1yCoSq3j-wTD6i_Rdge8pBw@mail.gmail.com>
 <CALCETrUGySDqc1bmwWGZvdADSCNehhJLLNNneGCvaCh_xVkD4Q@mail.gmail.com>
In-Reply-To: <CALCETrUGySDqc1bmwWGZvdADSCNehhJLLNNneGCvaCh_xVkD4Q@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 5 Oct 2020 11:56:05 -0700
X-Gmail-Original-Message-ID: <CALCETrWLSteeyYr64FKNgWi+5WNSJ5H_t0rRn9vxJfOde8tNHg@mail.gmail.com>
Message-ID: <CALCETrWLSteeyYr64FKNgWi+5WNSJ5H_t0rRn9vxJfOde8tNHg@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] x86: Use current USER_CS to setup correct context
 on vmx entry
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Robert Richter <rric@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 3, 2020 at 4:04 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Fri, Oct 2, 2020 at 5:15 PM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Fri, Oct 2, 2020 at 3:40 PM Sean Christopherson
> > <sean.j.christopherson@intel.com> wrote:
> > >
> > > On Thu, Oct 01, 2020 at 02:52:32PM -0700, Andy Lutomirski wrote:
> > > > On Thu, Oct 1, 2020 at 1:59 PM Gabriel Krisman Bertazi
> > > > <krisman@collabora.com> wrote:
> > > > >
> > > > > vmx_prepare_switch_to_guest shouldn't use is_64bit_mm, which has a
> > > > > very specific use in uprobes.  Use the user_64bit_mode helper instead.
> > > > > This reduces the usage of is_64bit_mm, which is awkward, since it relies
> > > > > on the personality at load time, which is fine for uprobes, but doesn't
> > > > > seem fine here.
> > > > >
> > > > > I tested this by running VMs with 64 and 32 bits payloads from 64/32
> > > > > programs.
> > > > >
> > > > > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> > > > > ---
> > > > >  arch/x86/kvm/vmx/vmx.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > > > > index 7b2a068f08c1..b5aafd9e5f5d 100644
> > > > > --- a/arch/x86/kvm/vmx/vmx.c
> > > > > +++ b/arch/x86/kvm/vmx/vmx.c
> > > > > @@ -1172,7 +1172,7 @@ void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
> > > > >         savesegment(es, host_state->es_sel);
> > > > >
> > > > >         gs_base = cpu_kernelmode_gs_base(cpu);
> > > > > -       if (likely(is_64bit_mm(current->mm))) {
> > > > > +       if (likely(user_64bit_mode(current_pt_regs()))) {
> > > > >                 current_save_fsgs();
> > > > >                 fs_sel = current->thread.fsindex;
> > > > >                 gs_sel = current->thread.gsindex;
> > > >
> > > > I disagree with this one.  This whole code path is nonsense.  Can you
> > > > just remove the condition entirely and use the 64-bit path
> > > > unconditionally?
> > >
> > > I finally came back to this one with fresh eyes.  I've read through the code
> > > a bajllion times and typed up half a dozen responses.  I think, finally, I
> > > understand what's broken.
> > >
> > > I believe your original assertion that the bug was misdiagnosed is correct
> > > (can't link because LKML wasn't in the loop).  I'm pretty sure your analysis
> > > that KVM's handling of things works mostly by coincidence is also correct.
> > >
> > > The coincidence is that "real" VMMs all use arch_prctl(), and
> > > do_arch_prctl_64() ensures thread.{fs,gs}base are accurate.  save_base_legacy()
> > > detects sel==0 and intentionally does nothing, knowing the the base is already
> > > accurate.
> > >
> > > Userspaces that don't use arch_prctl(), in the bug report case a 32-bit compat
> > > test, may or may not have accurate thread.{fs,gs}base values.  This is
> > > especially true if sel!=0 as save_base_legacy() explicitly zeros the base in
> > > this case, as load_seg_legacy() will restore the seg on the backend.
> > >
> > > KVM on the other hand assumes thread.{fs,gs}base are always fresh.  When that
> > > didn't hold true for userspace that didn't use arch_prctl(), the fix of
> > > detecting a !64-bit mm just so happened to work because all 64-bit VMMs use
> > > arch_prctl().
> > >
> > > It's tempting to just open code this and use RD{FS,GS}BASE when possible,
> > > i.e. avoid any guesswork.  Maybe with a module param that userspace can set
> > > to tell KVM it doesn't do anything fancy with FS/GS base (will userspace still
> > > use arch_prctl() even if FSGSABSE is available?).
> > >
> > >         savesegment(fs, fs_sel);
> > >         savesegment(gs, gs_sel);
> > >         if (use_current_fsgs_base) {
> > >                 fs_base = current->thread.fsbase;
> > >                 vmx->msr_host_kernel_gs_base = current->thread.gsbase;
> >
> > I don't like this.  The FSGSBASE case is fast, and the !FSGSBASE case
> > is mostly obsolete.  I see no great reason to have a module parameter
> > asking for incorrect behavior.  There have been too many bugs in this
> > area -- let's not add more please.
> >
> > >         } else if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
> > >                 fs_base = rdfsbase()
> > >                 vmx->msr_host_kernel_gs_base = __rdgsbase_inactive();
> > >         } else {
> > >                 fs_base = read_msr(MSR_FS_BASE);
> > >                 vmx->msr_host_kernel_gs_base = read_msr(MSR_KERNEL_GS_BASE);
> > >         }
> >
> > I'm okay with this, but I think you should fix the corresponding bugs
> > on the restore side as well.  The current code is:
> >
> >         if (host_state->ldt_sel || (host_state->gs_sel & 7)) {
> >                 kvm_load_ldt(host_state->ldt_sel);
> > #ifdef CONFIG_X86_64
> >                 load_gs_index(host_state->gs_sel);
> > #else
> >                 loadsegment(gs, host_state->gs_sel);
> > #endif
> >         }
> >         if (host_state->fs_sel & 7)
> >                 loadsegment(fs, host_state->fs_sel);
> >
> > which is blatantly wrong in the case where fs_set.TI == 1, gs_set.TI
> > == 0, and ldt_sel != 0.  But it's also more subtly wrong -- this
> > corrupts all the segment attributes in the case where a segment points
> > to the GDT and the GDT attributes are non-default.  So I would suggest
> > making the code radically simpler and more correct:
> >
> > if (host_state->idt_sel)
> >   kvm_load_idt(host_state->idt_sel);  // see below
> > if (host_state->ds_sel)
> >   loadsegment(ds, host_state->ds_sel);
> > if (host_state->es_sel)
> >   loadsegment(es, host_state->es_sel);
> > if (host_state->fs_sel) {
> >   loadsegment(fs, host_state->fs_sel);
> >   x86_fsbase_write_cpu(host_state->fs_base);
> > }
> > if (host_state->gs_sel) {
> >   load_gs_index(host_state->gs_sel);
> >   x86_gsbase_write_cpu_inactive(host_state->msr_host_kernel_gs_base);
> > }
> >
> > In the IMO unlikely event that any performance-critical KVM userspace
> > runs with these selectors != 0, you could also skip the load if they
> > are set to __USER_DS.
> >
> > You can also simplify this crud:
> >
> >         if (unlikely(fs_sel != host->fs_sel)) {
> >                 if (!(fs_sel & 7))
> >                         vmcs_write16(HOST_FS_SELECTOR, fs_sel);
> >                 else
> >                         vmcs_write16(HOST_FS_SELECTOR, 0);
> >                 host->fs_sel = fs_sel;
> >         }
> >
> > There is nothing special about segments with TI set according to the
> > SDM (AFAICT) nor is anything particularly special about them in
> > Linux's segment tables, so this code makes little sense.  It could
> > just be:
> >
> > host->fs_sel = fs_sel;
> >
> > and leave the VMCS field set to 0.  Or if you do the __USER_DS
> > optimization above, you could do:
> >
> > if (unlikely(fs_sel != host->fs_sel)) {
> >   vmcs_write16(HOST_FS_SELECTOR, fs_sel == __USER_DS ? __USER_DS : 0);
> >   host->fs_sel = fs_sel;
> > }
> >
> > I suspect that the only users who care about performance (or for whom
> > we should care about performance) are normal userspace, and normal
> > 64-bit userspace has DS == ES == FS == GS == 0.
> >
> >
> > I would also be okay with making the KVM code match the context switch
> > code, but this may be distinctly nontrivial.
>
> If you're okay waiting for a couple days, I'll just do this.  I have
> it 2/3-done already, except I'm running into the utter catastrophe
> that is 32-bit stackprotector, so I'm going to fix that first.  (Or
> delete it if I get toosick of it.)

Rough draft.  This needs the rest of that branch applied to have any
chance of being correct.

I was contemplating whether we could get a meaningful speedup if we
declared that entering a VM would wipe segments, but I don't think
there's actually much speedup available.

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/unify_stack_canary&id=f5a2dd07cd222bb674bd947f5d9c698ab50ccb88
