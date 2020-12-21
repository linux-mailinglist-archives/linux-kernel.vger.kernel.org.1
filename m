Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32CDA2DFF64
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgLUSLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgLUSLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:11:14 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195DEC0611C5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:10:27 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id j13so6893709pjz.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QDw9TIBxEMEN6i9q2u9TMr2zZpLOC0nfMm+mSUVGuU8=;
        b=BC4K4mt4lAy7z5ZtA2xF+LotI4/acaXphEASuJnyXq7Ojte4T04rOZVqtvjZhUP7mc
         CFvwiVnVQkKj/yWBOkMqGLRPyc8+rJCgWd7wlx2JzeIhDY6ldV7J+OOl1zDGSwE8l502
         4xNz3JJVFK1qZFLlOlRaxyAk3bC2xsZ/8c/u1ThfH0zsCcDQq3GX6ePbMeWTd3nWPBAg
         Dsz+hjnD6IFACioECE24tHB+EXT/ThdWNSsnxaukR94KIdqA2wSmt7ACf3BeP2BMw79h
         cv55LBQ8tF4SCnOG/ELxLilaaxJ+ci2TqfkOxGWhSVadlhkIW8osSk8/d4j59WUT5P+k
         sbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QDw9TIBxEMEN6i9q2u9TMr2zZpLOC0nfMm+mSUVGuU8=;
        b=r+qvQTvYmfEXx12lD2jsuqLTZE31HajagTSwXuHD3D0eGeriTLEvZ8045MlobJ4vIs
         xa56LKYbbsgq8jWUqrdfeHD+Gh8rrPcmSdY2SbpeaY2Hj98hin2AtI32QJGPSBnwJFpa
         2NhD9ycGZki0WmzCmdIr/o9sbcv19sbGEcUszh+L+J/s0oO9lvlS+JjuqgBSuu6q7dOx
         uJIOpjLPfwTz3U/rD4gN+Q8JbwPfKnJjQbqOMgXfA/oh9jWF7xDjrWWeTuMg6/mJdiLK
         Hut4W+Ljwf1UKPvdd7Fn17oDHTUgLietcImhsGPK1lX2GdHYX79WXAkSIF5+4pH10S7L
         aBaQ==
X-Gm-Message-State: AOAM531hBm7ooKK77kZAUv6ML4oPpg4q6ZrBSTwtWIyLwAI6Xp/yKu9h
        fI8c6UvNifEPeaImtVxzmR3zvQ==
X-Google-Smtp-Source: ABdhPJxOYn/fOObbUR4qYMCfXdaa9zBx2/yubrwkpdb4V02PkQNCDZ43Hen6nlO9LBsICft1v/r+bA==
X-Received: by 2002:a17:90a:248:: with SMTP id t8mr18609348pje.193.1608574226474;
        Mon, 21 Dec 2020 10:10:26 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id d203sm17521810pfd.148.2020.12.21.10.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 10:10:25 -0800 (PST)
Date:   Mon, 21 Dec 2020 10:10:18 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH] KVM: SVM: Add register operand to vmsave call in
 sev_es_vcpu_load
Message-ID: <X+DlCpHSu+opeOge@google.com>
References: <20201219063711.3526947-1-natechancellor@gmail.com>
 <X+Df2oQczVBmwEzi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X+Df2oQczVBmwEzi@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Michael, as this will conflict with an in-progress series to use VMSAVE in the
common SVM run path.

https://lkml.kernel.org/r/20201214174127.1398114-1-michael.roth@amd.com

On Mon, Dec 21, 2020, Sean Christopherson wrote:
> On Fri, Dec 18, 2020, Nathan Chancellor wrote:
> > When using LLVM's integrated assembler (LLVM_IAS=1) while building
> > x86_64_defconfig + CONFIG_KVM=y + CONFIG_KVM_AMD=y, the following build
> > error occurs:
> > 
> >  $ make LLVM=1 LLVM_IAS=1 arch/x86/kvm/svm/sev.o
> >  arch/x86/kvm/svm/sev.c:2004:15: error: too few operands for instruction
> >          asm volatile(__ex("vmsave") : : "a" (__sme_page_pa(sd->save_area)) : "memory");
> >                       ^
> >  arch/x86/kvm/svm/sev.c:28:17: note: expanded from macro '__ex'
> >  #define __ex(x) __kvm_handle_fault_on_reboot(x)
> >                  ^
> >  ./arch/x86/include/asm/kvm_host.h:1646:10: note: expanded from macro '__kvm_handle_fault_on_reboot'
> >          "666: \n\t"                                                     \
> >                  ^
> >  <inline asm>:2:2: note: instantiated into assembly here
> >          vmsave
> >          ^
> >  1 error generated.
> > 
> > This happens because LLVM currently does not support calling vmsave
> > without the fixed register operand (%rax for 64-bit and %eax for
> > 32-bit). This will be fixed in LLVM 12 but the kernel currently supports
> > LLVM 10.0.1 and newer so this needs to be handled.
> > 
> > Add the proper register using the _ASM_AX macro, which matches the
> > vmsave call in vmenter.S.
> 
> There are also two instances in tools/testing/selftests/kvm/lib/x86_64/svm.c
> that likely need to be fixed.
>  
> > Fixes: 861377730aa9 ("KVM: SVM: Provide support for SEV-ES vCPU loading")
> > Link: https://reviews.llvm.org/D93524
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1216
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  arch/x86/kvm/svm/sev.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > index e57847ff8bd2..958370758ed0 100644
> > --- a/arch/x86/kvm/svm/sev.c
> > +++ b/arch/x86/kvm/svm/sev.c
> > @@ -2001,7 +2001,7 @@ void sev_es_vcpu_load(struct vcpu_svm *svm, int cpu)
> >  	 * of which one step is to perform a VMLOAD. Since hardware does not
> >  	 * perform a VMSAVE on VMRUN, the host savearea must be updated.
> >  	 */
> > -	asm volatile(__ex("vmsave") : : "a" (__sme_page_pa(sd->save_area)) : "memory");
> > +	asm volatile(__ex("vmsave %%"_ASM_AX) : : "a" (__sme_page_pa(sd->save_area)) : "memory");
> 
> I vote to add a helper in svm.h to encode VMSAVE, even if there is only the one
> user.  Between the rAX behavior (it _must_ be rAX) and taking the HPA of the
> VMCB, the semantics of VMSAVE are just odd enough to cause a bit of head
> scratching when reading the code for the first time.  E.g. something like:
> 
> void vmsave(struct page *vmcb)
> {
> 	/*
> 	 * VMSAVE takes the HPA of a VMCB in rAX (hardcoded by VMSAVE itself).
> 	 * The _ASM_AX operand is required to specify the address size, which
> 	 * means VMSAVE cannot consume a 64-bit address outside of 64-bit mode.
> 	 */
> 	hpa_t vmcb_pa = __sme_page_pa(vmcb);
> 
> 	BUG_ON(!IS_ENABLED(CONFIG_X86_64) && (vmcb_pa >> 32));
> 
> 	asm volatile(__ex("vmsave %%"_ASM_AX) : : "a" (vmcb_pa) : "memory");
> }
> 
> >  
> >  	/*
> >  	 * Certain MSRs are restored on VMEXIT, only save ones that aren't
> > -- 
> > 2.30.0.rc0
> > 
