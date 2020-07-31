Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECEF2347F4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 16:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgGaOmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 10:42:36 -0400
Received: from mout.gmx.net ([212.227.15.18]:35241 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgGaOmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 10:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596206506;
        bh=t5bgTMuS5BA+IAiyPBaCZ9mzPj4FCpss/TD+Q9mI4jc=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Ij+B9IpQf742RQuzq1biBzkfDWrKxDtq/J+Q470KF+4WVs/LsIUoDBupvptA1LxQL
         EMTb4YFYtY8RsCCy3GCYQL3y/N5G9qr9Hr1ml988IEn/jR9UVKGi07lWutW/X8mni2
         9I7Na2kC6XNp4eLJmuOOaTN0JO9wrgtagcfWCyQ8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([79.150.73.70]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MjjCL-1kV2LR1lrX-00lC2A; Fri, 31
 Jul 2020 16:41:46 +0200
Date:   Fri, 31 Jul 2020 16:41:32 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 2/2] kernel/trace: Remove function callback casts
Message-ID: <20200731144132.GA6515@ubuntu>
References: <20200724161921.GA3123@ubuntu>
 <20200724123528.36ea9c9e@oasis.local.home>
 <20200724171418.GB3123@ubuntu>
 <20200724133656.76c75629@oasis.local.home>
 <20200724134020.3160dc7c@oasis.local.home>
 <20200724175500.GD3123@ubuntu>
 <20200724143457.27755412@oasis.local.home>
 <20200725150914.GA3362@ubuntu>
 <20200726155148.GA9341@ubuntu>
 <20200727095306.7f369949@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727095306.7f369949@oasis.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:FH/Vf3wNGxtmRHWftMcJXn+JACdkJavvNOQq1HxTrxSYzE/ujQC
 cZykk6K85ZhJdTJWg7D5fMCj4yPrWfZpaGNF58b0VKjiZK5kQRxQ3VYhbTn50buPDSihKQ7
 et3AgisINOma/CX3esappiNiqGugyiePgcdLyRZ+Bf6ljl+5X5SxODxQXT5xzbI8pb6QQlY
 UNuA0ENknllDr+Z7fkh3g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WTeDmc/l+T4=:g1qWGRSNIIbG8tvjLoiEvb
 a/A7dCLOGBmRJgRkhE3DdfDwP0QKcfBw4WSwKXtxsF0OroG7RybMC9pT0Ps/oYglu7M9gYAcd
 anqRxL3R0tyFFZEXOak29+q4TVn//xsKOAac8pq4x/IdMGxZOSUB0AAJYWZpZOGQUpbbNQbZZ
 G2OfjYdE+dcC5HgZl1TnMrGyfMbF+zPddo/7zRNnGXfbC0C1AuGGF9FtHIcoERUGbzOqfBscJ
 A6/jq+52ufMoBAA/4yWvON4MxmJcjdil0xs3euu7AF6VkSP6vD3KJ7iniylqu7MDOiqAchn1B
 V4h8Ao9j14iJ5e9x/kws5DT2TkhFmOGnnyawt5gg2oKIpDgSz13R8brHyXEEEOKVAlSKPJVMt
 7eF7p3oLLLuB/0z8baR03qVGvsNbIMDULvdICQquOOSYCWcGiss7T9WQA7zlMmHifykW4BtMO
 +iKf9jVqcH5OfMqqJ7O1qBc/FRs6nkGsAhSXnqA9tfgPoxHbLXwd2SFN1rGp+ZoNSh5YANzPL
 04mMPMD5dLA3kr18tOq+v5YSwnp2j/l14OXzykd3G7aLO29ZMvEIia0kGlVerjFv7DxsGf11v
 pClODt39L1rtoq7tToTLFHShP+H87c8YuL3NZctbmzPU0qWBxmuhwtZ+1LRhNd0VzL+7f433D
 K6+E2ithnQ5HNyhKmdotYMmOsyTJlJAIknwNx4MIpSpp/GZQBJJ77MlfE1vkWZ68cFfWFfLL2
 /MBl5ftLx6gE5ussRcWqBexaDxwjUEEgqDYkLbpxC6NiOfndZ/y8hn/6L+3wd3VvtLcgW2nse
 Ad31TQUXnKyCrTGjxvbZDclFdrwW8cYbgm0dr1XAxTah70wuqDlEmv8rqVIu9Eub2BAB8aPGm
 F0urMoZFwg5O6BoX932MjOqu5BkdASVDpa1OMfhOzqauSupgoREbdYc+k5FuMQrm93wGidGZ3
 f7TdiEQi5Hdu1nFotiqV5j70qHkyvLjO/MySLFRsmZSpPEE079BfIjlXTCOcl2DmWrqawJ2C2
 y1sZ3W2J1T6IRv1MsfJslYh3dDip6LwWexoxSM4NhWVBrRiOyh4zYBjgyQhiGB9wF2bklwAKU
 lzb9eRN5GacEroG03qZ44FUxXXPaIBwaOk+xrmQG9XLE6RbM6HwwcFZe4oMxGbxDEQukxcZ6b
 UgUyWjf46ZGaYx2eSSRjdUVn8uXqKBa7qZ1gC3/Q7rW+0IllibbeFl2zqFkUBSM+82nPgJ3+v
 dGop/cgHOKP/+8hdYvveV2IW+c8c645JZO7tfHw==
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Mon, Jul 27, 2020 at 09:53:06AM -0400, Steven Rostedt wrote:
> On Sun, 26 Jul 2020 17:52:42 +0200
> Oscar Carter <oscar.carter@gmx.com> wrote:
>
> > > If I try to do this I will need some help. Some info that point me t=
o the
> > > right direction would be greatly appreciated. Some advice about what
> > > functions I will need to implement would be really helpfull. Or poin=
t me
> > > to the right piece of code that I can pick as base point.
> >
> > I've been searching and reading the code as much as possible. I've fou=
nd
> > two patches that I think can be useful to guide me. One [1] adds suppo=
rt
> > for ftrace_ops to the riscv architecture. The other one [2] adds suppo=
rt
> > for ftrace_ops to the parisc architecture.
> >
> > [1] commit 71e736a7d655 ("riscv/ftrace: Add ARCH_SUPPORTS_FTRACE_OPS s=
upport")
> > [2] commit d562aca37a54 ("parisc/ftrace: Add ARCH_SUPPORTS_FTRACE_OPS =
support")
> >
> > Due to powerpc arch calls the needed functions from assembly, I based =
my
> > idea on the patch for the RISCV arch.
> >
> > Can something like the following work?
> >
> > diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/=
asm/ftrace.h
> > index bc76970b6ee5..1c51ff5afae1 100644
> > --- a/arch/powerpc/include/asm/ftrace.h
> > +++ b/arch/powerpc/include/asm/ftrace.h
> > @@ -61,9 +61,8 @@ struct dyn_arch_ftrace {
> >  };
> >  #endif /* __ASSEMBLY__ */
> >
> > -#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> >  #define ARCH_SUPPORTS_FTRACE_OPS 1
> > -#endif
> > +
> >  #endif /* CONFIG_FUNCTION_TRACER */
> >
> >  #ifndef __ASSEMBLY__
> > diff --git a/arch/powerpc/kernel/trace/ftrace_32.S b/arch/powerpc/kern=
el/trace/ftrace_32.S
> > index e023ae59c429..e69a4e945986 100644
> > --- a/arch/powerpc/kernel/trace/ftrace_32.S
> > +++ b/arch/powerpc/kernel/trace/ftrace_32.S
> > @@ -29,6 +29,10 @@ _GLOBAL(ftrace_caller)
> >         MCOUNT_SAVE_FRAME
> >         /* r3 ends up with link register */
> >         subi    r3, r3, MCOUNT_INSN_SIZE
> > +
> > +       /* Set ftrace_ops (r5) to the global variable function_trace_o=
p */
> > +       /* Set pt_regs (r6) to NULL */
> > +
> >  .globl ftrace_call
> >  ftrace_call:
> >         bl      ftrace_stub
> > diff --git a/arch/powerpc/kernel/trace/ftrace_64_pg.S b/arch/powerpc/k=
ernel/trace/ftrace_64_pg.S
> > index 6708e24db0ab..a741448b1df9 100644
> > --- a/arch/powerpc/kernel/trace/ftrace_64_pg.S
> > +++ b/arch/powerpc/kernel/trace/ftrace_64_pg.S
> > @@ -22,6 +22,10 @@ _GLOBAL_TOC(ftrace_caller)
> >         std     r3, 128(r1)
> >         ld      r4, 16(r11)
> >         subi    r3, r3, MCOUNT_INSN_SIZE
> > +
> > +       /* Set ftrace_ops (r5) to the global variable function_trace_o=
p */
> > +       /* Set pt_regs (r6) to NULL */
>
> I'm guessing you are going to do the above here. If so, this looks corre=
ct.
>
> > +
> >  .globl ftrace_call
> >  ftrace_call:
> >         bl      ftrace_stub
> >
> > To add support for ftrace_ops to the powerpc architecture is only nece=
ssary
> > to fill the r5 and r6 registers before the call to ftrace_stub in all =
the
> > cases. The register r5 is a pointer to ftrace_ops struct and the regis=
ter
> > r6 is a pointer to pt_regs struct. These registers are the third and f=
ourth
> > parameters of a function with the following prototype. The first and s=
econd
> > ones are yet set.
>
> I guess you mean that the first and second ones are already set. But,
> yeah, you are on the correct path here!
>
> >
> > void func(unsigned long ip, unsigned long parent_ip,
> > 	  struct ftrace_ops *ops, struct pt_regs *regs);
> >
> > Am I in the right direction? or am I totally wrong?
>
> No, you don't look wrong. But the true test is to try it out :-)

Of course. I will do the commented work, I will test it and then I will se=
nd
a new patch.

> Don't forget to update ftrace_32.S as well.
>
>
> >
> > Thanks for your time and patience.
>
> My pleasure. Thanks for doing this. The more people that understand all
> this, the better!

Thanks for your guidance and advices.

> -- Steve

Regards,
Oscar Carter
