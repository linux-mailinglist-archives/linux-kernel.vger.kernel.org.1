Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C8A27B747
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 23:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgI1VlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 17:41:15 -0400
Received: from mga17.intel.com ([192.55.52.151]:35328 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbgI1VlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 17:41:15 -0400
IronPort-SDR: oX4oF4+CrrUyFzG1ZyRmRKcGI8LLr1Z9uLtj0HLneRecYUJ4SD1ueIW7qbzXNpw9B6xOYa+DxD
 JZUa5jyMygGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="142085671"
X-IronPort-AV: E=Sophos;i="5.77,315,1596524400"; 
   d="scan'208";a="142085671"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 14:41:14 -0700
IronPort-SDR: OTd+iPriw87D2GLviynEY38Vem1m+YTu3mEbExIyscXq0e9DAgdajkULvqSVYb8toZqZ7/2PP5
 6NFWt47eW7gw==
X-IronPort-AV: E=Sophos;i="5.77,315,1596524400"; 
   d="scan'208";a="488772542"
Received: from jlasecki-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.49.78])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 14:41:07 -0700
Date:   Tue, 29 Sep 2020 00:41:05 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-sgx@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Jethro Beekman <jethro@fortanix.com>,
        Cedric Xing <cedric.xing@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        andriy.shevchenko@linux.intel.com, asapek@google.com,
        Borislav Petkov <bp@alien8.de>, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        Dave Hansen <dave.hansen@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>, josh@joshtriplett.org,
        kai.huang@intel.com, kai.svahn@intel.com, kmoy@google.com,
        Christian Ludloff <ludloff@google.com>,
        Andy Lutomirski <luto@kernel.org>, nhorman@redhat.com,
        npmccallum@redhat.com, puiterwijk@redhat.com, rientjes@google.com,
        Thomas Gleixner <tglx@linutronix.de>, yaozhangx@google.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v38 21/24] x86/vdso: Implement a vDSO for Intel SGX
 enclave call
Message-ID: <20200928214105.GD2705@linux.intel.com>
References: <20200915112842.897265-1-jarkko.sakkinen@linux.intel.com>
 <20200915112842.897265-22-jarkko.sakkinen@linux.intel.com>
 <721ca14e-21df-3df1-7bef-0b00d0ff90c3@citrix.com>
 <20200928005842.GC6704@linux.intel.com>
 <85bc15d5-93cd-e332-ae9a-1e1e66e1181d@citrix.com>
 <CAMe9rOpzXW0cSD=9E7drGEHH=pcm_NqvPiaR0pBJzYLeAt0_3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMe9rOpzXW0cSD=9E7drGEHH=pcm_NqvPiaR0pBJzYLeAt0_3g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 11:07:47AM -0700, H.J. Lu wrote:
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

Right, so I have actually two alternatives: this and boot time patching:

https://lkml.org/lkml/2020/9/25/1122

/Jarkko
