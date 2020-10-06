Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79777284366
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 02:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgJFAfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 20:35:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:60568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbgJFAfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 20:35:40 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F7542074A;
        Tue,  6 Oct 2020 00:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601944539;
        bh=z2WQFganH31foJ4iNkkZl1ET6PM+YBNa0ZXpQ29c990=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gP6hRbcXwksMMPfdO5nHFfAIPOS215+uHEf5VJBxMftLDwB3ZDXjvm6esBt0GKZ/Y
         dCtB97jae3fCDhNz1wYhhfUU+F2HYEI/d5udzJs+kL2CiN5DpYFG3ypw1gdEIC9cLW
         +GSU4C0+YfYR32k9LfqTlQgTzXHa3/QYW5pzDKRE=
Date:   Tue, 6 Oct 2020 09:35:36 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Julien Grall <julien@xen.org>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
        takahiro.akashi@linaro.org
Subject: Re: [PATCH] arm/arm64: xen: Fix to convert percpu address to gfn
 correctly
Message-Id: <20201006093536.5f7ad9e1bc3e2fea2494c229@kernel.org>
In-Reply-To: <b205ec9c-c307-2b67-c43a-cf2a67179484@xen.org>
References: <160190516028.40160.9733543991325671759.stgit@devnote2>
        <b205ec9c-c307-2b67-c43a-cf2a67179484@xen.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Oct 2020 19:18:47 +0100
Julien Grall <julien@xen.org> wrote:

> Hi Masami,
> 
> On 05/10/2020 14:39, Masami Hiramatsu wrote:
> > Use per_cpu_ptr_to_phys() instead of virt_to_phys() for per-cpu
> > address conversion.
> > 
> > In xen_starting_cpu(), per-cpu xen_vcpu_info address is converted
> > to gfn by virt_to_gfn() macro. However, since the virt_to_gfn(v)
> > assumes the given virtual address is in contiguous kernel memory
> > area, it can not convert the per-cpu memory if it is allocated on
> > vmalloc area (depends on CONFIG_SMP).
> 
> Are you sure about this? I have a .config with CONFIG_SMP=y where the 
> per-cpu region for CPU0 is allocated outside of vmalloc area.
> 
> However, I was able to trigger the bug as soon as CONFIG_NUMA_BALANCING 
> was enabled.

OK, I've confirmed that this depends on CONFIG_NUMA_BALANCING instead
of CONFIG_SMP. I'll update the comment.

> 
> [...]
> 
> > Fixes: 250c9af3d831 ("arm/xen: Add support for 64KB page granularity")
> 
> FWIW, I think the bug was already present before 250c9af3d831.

Hm, it seems commit 9a9ab3cc00dc ("xen/arm: SMP support") has introduced
the per-cpu code.

Thank you,

> 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >   arch/arm/xen/enlighten.c |    2 +-
> >   include/xen/arm/page.h   |    3 +++
> >   2 files changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> > index e93145d72c26..a6ab3689b2f4 100644
> > --- a/arch/arm/xen/enlighten.c
> > +++ b/arch/arm/xen/enlighten.c
> > @@ -150,7 +150,7 @@ static int xen_starting_cpu(unsigned int cpu)
> >   	pr_info("Xen: initializing cpu%d\n", cpu);
> >   	vcpup = per_cpu_ptr(xen_vcpu_info, cpu);
> >   
> > -	info.mfn = virt_to_gfn(vcpup);
> > +	info.mfn = percpu_to_gfn(vcpup);
> >   	info.offset = xen_offset_in_page(vcpup);
> >   
> >   	err = HYPERVISOR_vcpu_op(VCPUOP_register_vcpu_info, xen_vcpu_nr(cpu),
> > diff --git a/include/xen/arm/page.h b/include/xen/arm/page.h
> > index 39df751d0dc4..ac1b65470563 100644
> > --- a/include/xen/arm/page.h
> > +++ b/include/xen/arm/page.h
> > @@ -83,6 +83,9 @@ static inline unsigned long bfn_to_pfn(unsigned long bfn)
> >   	})
> >   #define gfn_to_virt(m)		(__va(gfn_to_pfn(m) << XEN_PAGE_SHIFT))
> >   
> > +#define percpu_to_gfn(v)	\
> > +	(pfn_to_gfn(per_cpu_ptr_to_phys(v) >> XEN_PAGE_SHIFT))
> > +
> >   /* Only used in PV code. But ARM guests are always HVM. */
> >   static inline xmaddr_t arbitrary_virt_to_machine(void *vaddr)
> >   {
> > 
> 
> Cheers,
> 
> -- 
> Julien Grall


-- 
Masami Hiramatsu <mhiramat@kernel.org>
