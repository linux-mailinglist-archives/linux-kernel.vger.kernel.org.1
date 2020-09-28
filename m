Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174E627B424
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgI1SMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:12:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbgI1SMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:12:22 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8F1623444
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 18:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601316742;
        bh=7q1mHjYn8Xp8QKPcJUE7lPaBq/HQxLXaK9sWb404084=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C41JIxN10W/+7tgrEeaGv7guuVM1WuB/7sSTKC5C5Z1Vv53XxQ6EZEKosLWIcZ5MD
         vCaJZU7G3x5nCzfuGGjMV8JWEml9Uodltx/OPk8C/73wiDrwM23c5vXcZbvuVFiTyI
         3DwQEMHhpQGwggLxL5N7FjiHMCpeaQO4mMtKKz8E=
Received: by mail-wr1-f49.google.com with SMTP id c18so2361448wrm.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 11:12:21 -0700 (PDT)
X-Gm-Message-State: AOAM530DhB9bRA9geHq9EzaQ0LF33k8ER7EWNwFZT4IhGVuozx0SNDLj
        2KDIzWJUWKn/4qlPWuWacD8wC3UBUILrZ2ob5U985A==
X-Google-Smtp-Source: ABdhPJzS2jc/qxqlizHZeie8xsprAFUWK199oscDa7A2aAmCVj5Zx+XpzQ3Wp0hclfOuzo/0VKDLAES6bBMx+yRI/EI=
X-Received: by 2002:a5d:5281:: with SMTP id c1mr3016925wrv.184.1601316740096;
 Mon, 28 Sep 2020 11:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200915112842.897265-1-jarkko.sakkinen@linux.intel.com>
 <20200915112842.897265-22-jarkko.sakkinen@linux.intel.com>
 <721ca14e-21df-3df1-7bef-0b00d0ff90c3@citrix.com> <20200928005842.GC6704@linux.intel.com>
 <85bc15d5-93cd-e332-ae9a-1e1e66e1181d@citrix.com> <CAMe9rOpzXW0cSD=9E7drGEHH=pcm_NqvPiaR0pBJzYLeAt0_3g@mail.gmail.com>
In-Reply-To: <CAMe9rOpzXW0cSD=9E7drGEHH=pcm_NqvPiaR0pBJzYLeAt0_3g@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 28 Sep 2020 11:12:08 -0700
X-Gmail-Original-Message-ID: <CALCETrU4Rhc0fwzzKLSUgan2YmSovxVFYOZEmFnBHC4DbZ5RfQ@mail.gmail.com>
Message-ID: <CALCETrU4Rhc0fwzzKLSUgan2YmSovxVFYOZEmFnBHC4DbZ5RfQ@mail.gmail.com>
Subject: Re: [PATCH v38 21/24] x86/vdso: Implement a vDSO for Intel SGX
 enclave call
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-sgx@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jethro Beekman <jethro@fortanix.com>,
        Cedric Xing <cedric.xing@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        asapek@google.com, Borislav Petkov <bp@alien8.de>,
        chenalexchen@google.com, Conrad Parker <conradparker@google.com>,
        cyhanish@google.com, Dave Hansen <dave.hansen@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        Josh Triplett <josh@joshtriplett.org>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Svahn, Kai" <kai.svahn@intel.com>, Keith Moyer <kmoy@google.com>,
        Christian Ludloff <ludloff@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Neil Horman <nhorman@redhat.com>,
        Nathaniel McCallum <npmccallum@redhat.com>,
        Patrick Uiterwijk <puiterwijk@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, yaozhangx@google.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 11:08 AM H.J. Lu <hjl.tools@gmail.com> wrote:
>
> On Mon, Sep 28, 2020 at 9:44 AM Andrew Cooper <andrew.cooper3@citrix.com> wrote:
> >
> > On 28/09/2020 01:58, Jarkko Sakkinen wrote:
> > > On Fri, Sep 25, 2020 at 07:23:59PM +0100, Andrew Cooper wrote:
> > >> On 15/09/2020 12:28, Jarkko Sakkinen wrote:
> > >>> diff --git a/arch/x86/entry/vdso/vsgx_enter_enclave.S b/arch/x86/entry/vdso/vsgx_enter_enclave.S
> > >>> new file mode 100644
> > >>> index 000000000000..adbd59d41517
> > >>> --- /dev/null
> > >>> +++ b/arch/x86/entry/vdso/vsgx_enter_enclave.S
> > >>> @@ -0,0 +1,157 @@
> > >>> +SYM_FUNC_START(__vdso_sgx_enter_enclave)
> > >>> <snip>
> > >>> +.Lretpoline:
> > >>> +   call    2f
> > >>> +1: pause
> > >>> +   lfence
> > >>> +   jmp     1b
> > >>> +2: mov     %rax, (%rsp)
> > >>> +   ret
> > >> I hate to throw further spanners in the work, but this is not compatible
> > >> with CET, and the user shadow stack work in progress.
> > > CET goes beyond my expertise. Can you describe, at least rudimentary,
> > > how this code is not compatible?
> >
> > CET Shadow Stacks detect attacks which modify the return address on the
> > stack.
> >
> > Retpoline *is* a ROP gadget.  It really does modify the return address
> > on the stack, even if its purpose is defensive (vs Spectre v2) rather
> > than malicious.
> >
> > >> Whichever of these two large series lands first is going to inflict
> > >> fixing this problem on the other.
> > >>
> > >> As the vdso text is global (to a first approximation), it must not be a
> > >> retpoline if any other process is liable to want to use CET-SS.
> > > Why is that?
> >
> > Because when CET-SS is enabled, the ret will suffer a #CP exception
> > (return address on the stack not matching the one recorded in the shadow
> > stack), which I presume/hope is wired into SIGSEGV.
> >
>
> Here is the CET compatible retpoline:
>
> endbr64
> /* Check if shadow stack is in use.  NB: R11 is the only usable
>    scratch register for function calls.  */
> xorl %r11d, %r11d
> rdsspq %r11
> testq %r11, %r11
> jnz 3f
> call 2f
> 1:
> pause
> lfence
> jmp 1b
> 2:
> mov %rax, (%rsp)
> ret
> 3:
> /* Shadow stack is in use.  Make the indirect call.  */
> call *%rax
> ret

What do we expect user programs to do on CET systems?  It would be
nice if we could instead ALTERNATIVE this out if X86_FEATURE_SHSTK.

--Andy
