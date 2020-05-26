Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B72D41A0A70
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 11:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgDGJuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 05:50:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgDGJuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 05:50:16 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D56A206F7;
        Tue,  7 Apr 2020 09:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586253014;
        bh=kJZYufU5JjIewIXirxoGTIPmBpw71K3gIKHtTiQfXvk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Yj2iVZSVqwW8U6FgcB8bM7y5h/kbt1kj4D6FUA8wh0ZTbhhZEqNW7UdhEjTuJePPD
         fiFDnzkzuA7XdRwdohPuExfqPec0jSDwwxLyTuJSzl7NYN0Z7Q13OHNnRb4duiZYbI
         1m7p68XBOMWdnLfhydXhOjY9VHo64tif1Y+ybqt8=
Date:   Tue, 7 Apr 2020 18:50:08 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Jann Horn <jannh@google.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>, amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: AMD DC graphics display code enables -mhard-float, -msse,
 -msse2 without any visible FPU state protection
Message-Id: <20200407185008.c819005f0174cae76c44a135@kernel.org>
In-Reply-To: <20200406102107.GI20730@hirez.programming.kicks-ass.net>
References: <CAG48ez2Sx4ELkM94aD_h_J7K7KBOeuGmvZLKRkg3n_f2WoZ_cg@mail.gmail.com>
        <4c5fe55d-9db9-2f61-59b2-1fb2e1b45ed0@amd.com>
        <20200402141308.GB20730@hirez.programming.kicks-ass.net>
        <20200403142837.f61a18d7bd32fd73777479ad@kernel.org>
        <20200403112113.GN20730@hirez.programming.kicks-ass.net>
        <20200404120808.05e9aa61500265be2e031bd6@kernel.org>
        <20200404143224.GL2452@worktop.programming.kicks-ass.net>
        <20200405121930.e3ea3e7acc7588102de483e2@kernel.org>
        <20200406102107.GI20730@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Apr 2020 12:21:07 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Sun, Apr 05, 2020 at 12:19:30PM +0900, Masami Hiramatsu wrote:
> 
> > > @@ -269,14 +269,14 @@ d4: AAM Ib (i64)
> > >  d5: AAD Ib (i64)
> > >  d6:
> > >  d7: XLAT/XLATB
> > > -d8: ESC
> > > -d9: ESC
> > > -da: ESC
> > > -db: ESC
> > > -dc: ESC
> > > -dd: ESC
> > > -de: ESC
> > > -df: ESC
> > > +d8: FPU
> > > +d9: FPU
> > > +da: FPU
> > > +db: FPU
> > > +dc: FPU
> > > +dd: FPU
> > > +de: FPU
> > > +df: FPU
> > 
> > I don't want to use FPU since Intel SDM is still using ESC because it
> > is co-processor escape code.
> 
> But we all know that co-processor is x87. Can we then perhaps put in
> 'x87' as an escape code instead of 'ESC' ?

Hmm, x87 might be good, but it still need a comment.

> 
> > Here is the new patch. 
> > 
> > From d7eca4946ab3f0d08ad1268f49418f8655aaf57c Mon Sep 17 00:00:00 2001
> > From: Masami Hiramatsu <mhiramat@kernel.org>
> > Date: Fri, 3 Apr 2020 16:58:22 +0900
> > Subject: [PATCH] x86: insn: Add insn_is_fpu()
> > 
> > Add insn_is_fpu(insn) which tells that the insn is
> > whether touch the MMX/XMM/YMM register or the instruction
> > of FP coprocessor.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> arch/x86/mm/extable.o: warning: objtool: ex_handler_fprestore()+0x8b: fpu_safe hint not an FPU instruction
> 008b  36b:      48 0f ae 0d 00 00 00    fxrstor64 0x0(%rip)        # 373 <ex_handler_fprestore+0x93>
> 
> arch/x86/kvm/x86.o: warning: objtool: kvm_load_guest_fpu.isra.0()+0x1fa: fpu_safe hint not an FPU instruction
> 01fa    1d2fa:  48 0f ae 4b 40          fxrstor64 0x40(%rbx)

Ah, fxstor will not chang the FPU/MMX/SSE regs but just store it on memory.
OK, I'll remove it from the list.

> Also, all the VMX bits seems to qualify as FPU (I can't remember seeing
> that previously):

Oops, let me check it.

Thanks!

> 
> arch/x86/kvm/vmx/vmx.o: warning: objtool: handle_apic_eoi_induced()+0x20: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: handle_apic_write()+0x20: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: handle_invlpg()+0x20: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_get_interrupt_shadow()+0x1c: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_decache_cr4_guest_bits()+0x5a: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_decache_cr0_guest_bits()+0x5a: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: handle_io()+0x24: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: handle_apic_access()+0x39: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_get_idt()+0x57: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_get_exit_info()+0x58: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_get_gdt()+0x57: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_guest_apic_has_interrupt()+0xf8: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_nmi_allowed()+0x98: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_handle_exit_irqoff()+0xb3: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_get_nmi_mask()+0x8a: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_get_rflags()+0x99: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: handle_ept_misconfig()+0x22: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_interrupt_allowed()+0x8d: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_write_pml_buffer()+0x1c5: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: handle_invpcid()+0x26a: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_read_guest_seg_ar()+0x9b: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_read_guest_seg_selector()+0x96: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_read_guest_seg_base()+0x9b: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_get_segment()+0x2da: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmwrite_error()+0x161: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: exec_controls_set.isra.0()+0x5a: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: handle_dr()+0x1bc: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: update_exception_bitmap()+0x136: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_set_interrupt_shadow()+0x8b: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: skip_emulated_instruction()+0xe9: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: handle_exception_nmi()+0x674: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_clear_hlt.isra.0()+0xe5: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_set_idt()+0x65: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_set_gdt()+0x65: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: seg_setup()+0x125: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_set_nmi_mask()+0x11c: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: __vmx_complete_interrupts()+0x167: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: handle_task_switch()+0x34d: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_set_dr7()+0x1e: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: update_cr8_intercept()+0x1a2: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_hwapic_isr_update()+0x8a: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_set_rvi()+0x87: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_load_eoi_exitmap()+0x107: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_set_rflags()+0x20f: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: fix_rmode_seg()+0x1de: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_set_segment()+0x28b: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: enter_pmode()+0x1ad: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: enter_rmode()+0x27e: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_write_l1_tsc_offset()+0x11b: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: handle_pml_full()+0x138: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_cancel_injection()+0x5d: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_queue_exception()+0x10d: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_inject_nmi()+0xd1: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_inject_irq()+0x127: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: handle_ept_violation()+0x13e: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: enable_irq_window()+0x71: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: handle_interrupt_window()+0x71: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: handle_nmi_window()+0x92: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_sync_dirty_debug_regs()+0x203: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: enable_nmi_window()+0xca: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: clear_atomic_switch_msr()+0x2ba: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: add_atomic_switch_msr.constprop.0()+0x314: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_vcpu_run()+0xc16: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_set_host_fs_gs()+0x1f9: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_vcpu_load_vmcs()+0x404: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_set_cr4()+0x240: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_get_msr()+0x49d: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_cpuid_update()+0xc89: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: ept_save_pdptrs()+0x176: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_cache_reg()+0xe3: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_set_cr3()+0x47: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_set_apic_access_page_addr()+0x9f: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_set_efer()+0x22f: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_set_cr0()+0x15e: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: handle_cr()+0xe1d: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_vcpu_reset()+0x1a98: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_set_virtual_apic_mode()+0x216: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_refresh_apicv_exec_ctrl()+0x2e0: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_set_msr()+0xf26: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_set_constant_host_state()+0x364: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: set_cr4_guest_host_mask()+0xda: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: init_vmcs()+0x1705: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: dump_vmcs.cold()+0x193c: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_handle_exit()+0xcfc: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_update_host_rsp()+0x65: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_dump_dtsel()+0x5d: FPU instruction outside of kernel_fpu_{begin,end}()
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_dump_sel()+0xda: FPU instruction outside of kernel_fpu_{begin,end}()
> 
> 
> ./objdump-func.sh defconfig-build/arch/x86/kvm/vmx/vmx.o ept_save_pdptrs | grep 176
> 0176    1d436:  41 0f 78 c4             vmread %rax,%r12
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
