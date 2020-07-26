Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E6F22E0F4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 17:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgGZPxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jul 2020 11:53:30 -0400
Received: from mout.gmx.net ([212.227.17.22]:44649 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbgGZPxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 11:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1595778765;
        bh=WGw8FaMSZmhM49wBB1S9XHJc/RTzyoD1eWvPOwCmd6k=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=HzyUFpZ9Hd/C/lKJcZkMZjioaEKS2lk7s5kaptIZMmVhl6mxgYv79yW28MwOl5N1v
         j8tblL/ICkM639pDUFyYz7/8nw70QZBI3sYZHXuAYod4rDLngoUHRrZpLjQQqugFZH
         HjFs4llquZB+hGgZnl3K/ZJk+bpdi6PcOte51XvI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([79.150.73.70]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MN5eX-1kG0sr3PCH-00J0JT; Sun, 26
 Jul 2020 17:52:45 +0200
Date:   Sun, 26 Jul 2020 17:52:42 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 2/2] kernel/trace: Remove function callback casts
Message-ID: <20200726155148.GA9341@ubuntu>
References: <20200719155033.24201-3-oscar.carter@gmx.com>
 <20200721140545.445f0258@oasis.local.home>
 <20200724161921.GA3123@ubuntu>
 <20200724123528.36ea9c9e@oasis.local.home>
 <20200724171418.GB3123@ubuntu>
 <20200724133656.76c75629@oasis.local.home>
 <20200724134020.3160dc7c@oasis.local.home>
 <20200724175500.GD3123@ubuntu>
 <20200724143457.27755412@oasis.local.home>
 <20200725150914.GA3362@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200725150914.GA3362@ubuntu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:kVMTe1ov4nKM/9d7telveamBIojsiH6hGJFia+U1Pd1CL6ym7zX
 fBeMrZ7pJNcD1gnSN5uelpRhiNc1xCYX7Lm2GZFc1wHpd+x6YbunBa10BesxY0lGV6pkorH
 uRVC9KlxCk6FWqlxVNVns4DOi7Uf6FQ9A6ZFOM+PWnwrofGCg8OL5NNlgvTOOpdJnpKaVRy
 lht/U40KjXin+bGQ3UNyA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TegeHGck9oQ=:/W0Rhz+1yhBiERd893++Lv
 l97+yJtxMWcsnwO/xAZ7+jyAZZUkxbKhC1JBtJBroypH8Lt/F1vdC4JMWWst3jIRkCQLADNcU
 hgswVIRSkCXnnxRWOF6p8IquLFEejXdwh8MMjZy1LRlrzwr93hnyoNc7RsymYYGnipJFjsbQW
 js7pX0FKnQ48u9rXUtYBdDJBMRBcTC9t1cNcTBD6ygKjTKuGSFrZMdl+uZpg/ZfR4KUgzkJMs
 1nPe38Y5uePsD3450z/EG6z7wc49S9V/V43rActUTZSL3x+WHgyoG1RPcVff1dOPbEm6CHFaj
 Blvb1468PpaPGlyGFbUzvLzMjeVnqui8U17amc6jdNimrFpIA5QRyovqH9NHLgYsdwRmncU7p
 6vP2LnvJScdTLhttrHzeCyDwn9TmF7wIxUSc99PrPFhYqelUNo3lZDjAUMWx78v2f+5xNrvWs
 O9jcyKUUe6g/dTWGAytdEujXZq0XRu4MZeEAYqiHGch0L+jlYGt6f/lk+jvT9uClRpfOfVuie
 rfeWRDCEOD+Nxn6zueRxdDmNcret8UzSdYqhHSJ1JeKcslxZok2OTgGq2xC77BiqjMHjpz+8u
 8299M4iXjfTm1iJA61y8fpv5oXmViatU2g9Taat05KEcLQZ+LEdWUk5cdtq4wqfPgYbXMdMm0
 hVnECLfI5LTT2mQN8vKjfjDWwIlmDRo9pjG7qQRZ1dTAvaT/DXDv8n4lxif9mBeYtcCSpeYs8
 88o540MvguPzPysRHi/WJh3VYGSDOpK+QlcO6apupQ9LOEgZjBCRBjbRI3ki0iRNubgmQ+Glp
 WRQV1gD//ZrPZv/EHhDZU5oN0BgBomKvSxXJZhmsPKx87TnDuuu+xuuagvLgmfxgUyZRm/xVS
 c4xaYhXkJe8hmUZb2CHIhu0DmZPJJ5wwHOOq6KFcAdlkyz0i1V9JBCjXieS4/blq3kxenoVrB
 oKmeI6q5ExPV8Mer8PnwjqPZb6H/cfoCwHZ6p8XWyGVDpObSSMcHtld0ssYCaPWfRUkn34EJm
 0OEixUd/o80SCjcs+W92ojvCPilHlxQ/MLsCeA3hAoA3/1c0ohtnVtmxCmfNgac5ucO+pqzQX
 GE+JBD2UObA74tKp601TuIycyoJJitWRo8yeT2ivvc22DR91tvAILH1bkpDOjs5OabPP5WDKV
 jsycdNBoBZ4DNNnuc24CKpwHct3Lvq6dJ/Zl2rZ0PmkVyAQTsA9FQiy14ai4awDeYfs7cEyu2
 oe8mXGRsrHqjmjCy4NZ37/t35/Tv5LqqMtDyUYg==
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Sat, Jul 25, 2020 at 05:09:14PM +0200, Oscar Carter wrote:
> Hi Steven,
>
> On Fri, Jul 24, 2020 at 02:34:57PM -0400, Steven Rostedt wrote:
> > On Fri, 24 Jul 2020 19:55:00 +0200
> > Oscar Carter <oscar.carter@gmx.com> wrote:
> >
> > > > Which one of the above is this patch set for?
> > >
> > > This patch is the result of a warning obtained with the following:
> > >
> > > make allmodconfig ARCH=3Dpowerpc
> > > make ARCH=3Dpowerpc CROSS_COMPILE=3Dpowerpc-linux-gnu- -j4
> > >
> > > And with the -Wcast-function-type enabled in the top level makefile.
> >
> > Looking into powerpc I found this:
> >
> > arch/powerpc/include/asm/ftrace.h:
> >
> >   #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> >   #define ARCH_SUPPORTS_FTRACE_OPS 1
> >   #endif
> >
> >
> > arch/powerpc/Kconfig:
> >
> > 	select HAVE_DYNAMIC_FTRACE_WITH_REGS	if MPROFILE_KERNEL
> > [..]
> >
> >   config MPROFILE_KERNEL
> > 	depends on PPC64 && CPU_LITTLE_ENDIAN && FUNCTION_TRACER
> > 	def_bool $(success,$(srctree)/arch/powerpc/tools/gcc-check-mprofile-k=
ernel.sh $(CC) -I$(srctree)/include -D__KERNEL__)
> >
> > So, it looks like you need to be 64bit PowerPC, Little Endian, and gcc
> > needs to support -mprofile.
> >
> > Otherwise, it falls back to the old way that does the type casting.
> >
> > If you are really concerned about this, I would recommend adding
> > support to the architecture you care about, and then this will no
> > longer be an issue.
> >
> > The funny part is, you can still add support for ftrace_ops, without
> > adding support for DYNAMIC_FTRACE_WITH_REGS, if you only care about no=
t
> > having to do that typecast.
>
> I agree with you. I will try to add the support for ftrace_ops without
> adding support for DYNAMIC_FTRACE_WITH_REGS to the powerpc architecture.
>
> It's a great solution to allow a clean CFI build and so, protect this
> arch (powerpc) against attacks that try to modify the normal control
> flow.
>
> I take a look at the kernel documentation about port ftrace to other
> architectures [1] but it is out of date.
>
> If I try to do this I will need some help. Some info that point me to th=
e
> right direction would be greatly appreciated. Some advice about what
> functions I will need to implement would be really helpfull. Or point me
> to the right piece of code that I can pick as base point.

I've been searching and reading the code as much as possible. I've found
two patches that I think can be useful to guide me. One [1] adds support
for ftrace_ops to the riscv architecture. The other one [2] adds support
for ftrace_ops to the parisc architecture.

[1] commit 71e736a7d655 ("riscv/ftrace: Add ARCH_SUPPORTS_FTRACE_OPS suppo=
rt")
[2] commit d562aca37a54 ("parisc/ftrace: Add ARCH_SUPPORTS_FTRACE_OPS supp=
ort")

Due to powerpc arch calls the needed functions from assembly, I based my
idea on the patch for the RISCV arch.

Can something like the following work?

diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/=
ftrace.h
index bc76970b6ee5..1c51ff5afae1 100644
=2D-- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -61,9 +61,8 @@ struct dyn_arch_ftrace {
 };
 #endif /* __ASSEMBLY__ */

-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 #define ARCH_SUPPORTS_FTRACE_OPS 1
-#endif
+
 #endif /* CONFIG_FUNCTION_TRACER */

 #ifndef __ASSEMBLY__
diff --git a/arch/powerpc/kernel/trace/ftrace_32.S b/arch/powerpc/kernel/t=
race/ftrace_32.S
index e023ae59c429..e69a4e945986 100644
=2D-- a/arch/powerpc/kernel/trace/ftrace_32.S
+++ b/arch/powerpc/kernel/trace/ftrace_32.S
@@ -29,6 +29,10 @@ _GLOBAL(ftrace_caller)
        MCOUNT_SAVE_FRAME
        /* r3 ends up with link register */
        subi    r3, r3, MCOUNT_INSN_SIZE
+
+       /* Set ftrace_ops (r5) to the global variable function_trace_op */
+       /* Set pt_regs (r6) to NULL */
+
 .globl ftrace_call
 ftrace_call:
        bl      ftrace_stub
diff --git a/arch/powerpc/kernel/trace/ftrace_64_pg.S b/arch/powerpc/kerne=
l/trace/ftrace_64_pg.S
index 6708e24db0ab..a741448b1df9 100644
=2D-- a/arch/powerpc/kernel/trace/ftrace_64_pg.S
+++ b/arch/powerpc/kernel/trace/ftrace_64_pg.S
@@ -22,6 +22,10 @@ _GLOBAL_TOC(ftrace_caller)
        std     r3, 128(r1)
        ld      r4, 16(r11)
        subi    r3, r3, MCOUNT_INSN_SIZE
+
+       /* Set ftrace_ops (r5) to the global variable function_trace_op */
+       /* Set pt_regs (r6) to NULL */
+
 .globl ftrace_call
 ftrace_call:
        bl      ftrace_stub

To add support for ftrace_ops to the powerpc architecture is only necessar=
y
to fill the r5 and r6 registers before the call to ftrace_stub in all the
cases. The register r5 is a pointer to ftrace_ops struct and the register
r6 is a pointer to pt_regs struct. These registers are the third and fourt=
h
parameters of a function with the following prototype. The first and secon=
d
ones are yet set.

void func(unsigned long ip, unsigned long parent_ip,
	  struct ftrace_ops *ops, struct pt_regs *regs);

Am I in the right direction? or am I totally wrong?

Thanks for your time and patience.
Oscar Carter.

> > My NAK still stands. I wont let an intrusive patch be added to the
> > ftrace core code to deal with an unsupported feature in an architectur=
e.
>
> Don't worry. I agree with you and thanks for finding a better way to
> accomplish the initial purpose.
>
> > I would be will to add that linker trick to remove the warning. Or we
> > just use that warning as incentive to get architecture developers to
> > implement this feature ;-)
>
> In my opinion it would be better to leave the code as it an make the war=
ning
> visible until this feature has been added.
>
> > -- Steve
>
> [1] https://www.kernel.org/doc/html/latest/trace/ftrace-design.html
>
> Thanks again,
> Oscar Carter
