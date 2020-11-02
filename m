Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38FB62A36CF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 23:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgKBWyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 17:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgKBWyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 17:54:52 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CBAC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 14:54:52 -0800 (PST)
Received: from zn.tnic (p200300ec2f086a0078c4452c9be44e60.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:6a00:78c4:452c:9be4:4e60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 112261EC03E3;
        Mon,  2 Nov 2020 23:54:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1604357690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+vN7IpZ/SytUSqPRUGm4GBCXUDCJtxn/N8dIULTEM2c=;
        b=d8HQUP3M6yOAsSf1I1U7QtmTXTZD5BqXFVYHXf5Hnnj/a33P0eShUkhDwQq+FB+tR8UVnN
        u/pAX+9ARIEEOcA76RLbndCFwPavpmQknjrc9PGLROIyBjZ61fZKe8LQc2s0D3FsRtFp7K
        /hZ6OMTeA31aNknPeqOvsB+6H6xrnPg=
Date:   Mon, 2 Nov 2020 23:54:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     shuo.a.liu@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Yakui Zhao <yakui.zhao@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengwei Yin <fengwei.yin@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v5 04/17] x86/acrn: Introduce hypercall interfaces
Message-ID: <20201102225439.GI15392@zn.tnic>
References: <20201019061803.13298-1-shuo.a.liu@intel.com>
 <20201019061803.13298-5-shuo.a.liu@intel.com>
 <20201102145657.GD15392@zn.tnic>
 <20201102160901.GU2672@gate.crashing.org>
 <20201102171950.GF15392@zn.tnic>
 <20201102181000.GX2672@gate.crashing.org>
 <20201102183430.GG15392@zn.tnic>
 <20201102200113.GY2672@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201102200113.GY2672@gate.crashing.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 02:01:13PM -0600, Segher Boessenkool wrote:
> It just asks the general_operand function, which (for registers) accepts
> the hard registers that are accessible.  This does include the float and
> vector etc. registers, normally.
> 
> But you usually have a pseudo-register there (which is always allowed
> here), unless you used some register asm variable.

You mean like this:

---
int main(void)
{
	register float foo asm ("xmm0") = 0.99f;

        asm volatile("movl %0, %%r8d\n\t"
                      "vmcall\n\t"
                      :: "g" (foo));

        return 0;
}
---

That works ok AFAICT:

---

0000000000000000 <main>:
   0:   55                      push   %rbp
   1:   48 89 e5                mov    %rsp,%rbp
   4:   f3 0f 10 05 00 00 00    movss  0x0(%rip),%xmm0        # c <main+0xc>
   b:   00 
   c:   66 0f 7e c0             movd   %xmm0,%eax
  10:   41 89 c0                mov    %eax,%r8d
  13:   0f 01 c1                vmcall 
  16:   b8 00 00 00 00          mov    $0x0,%eax
  1b:   5d                      pop    %rbp
  1c:   c3                      retq

---

gcc smartypants shuffles it through a GPR before sticking it into %r8.

It works too If I use a float immediate:

---
int main(void)
{
        asm volatile("movl %0, %%r8d\n\t"
                      "vmcall\n\t"
                      :: "g" (0.99f));
                      
        return 0;     
}
---

---
0000000000000000 <main>:
   0:   55                      push   %rbp
   1:   48 89 e5                mov    %rsp,%rbp
   4:   41 b8 a4 70 7d 3f       mov    $0x3f7d70a4,%r8d
   a:   0f 01 c1                vmcall 
   d:   b8 00 00 00 00          mov    $0x0,%eax
  12:   5d                      pop    %rbp
  13:   c3                      retq
---

or maybe I'm missing some freaky way to specify the input operand so
that I can make it take a float register. But even if I could, it would
error out when generating the asm, I presume, due to invalid insn or
whatnot.

> And pseudos usually are allocated a simple integer register during
> register allocation, in an asm that is.

Interesting.

> > Might even make people copying from bad examples
> > to go look at the docs first...
> 
> Optimism is cool :-)

In my experience so far, documenting stuff better might not always bring
the expected results but sometimes it does move people in the most
unexpected way and miracles happen.

:-)))


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
