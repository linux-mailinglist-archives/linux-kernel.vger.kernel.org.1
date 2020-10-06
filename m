Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8AF2284484
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 06:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgJFELx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 00:11:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgJFELx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 00:11:53 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE5EF208A9;
        Tue,  6 Oct 2020 04:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601957512;
        bh=eX8rve6HxwI2nYREP/V5u420GCVH7dLvjYOErIjpC2k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TSZDzh1NqvIKkuuXh23GCAVV4bbk8DDnoE8f7FdveBiMASMNiLefK8vV1MaBkpnFY
         BFiZ0Ef0IPKDHiuGlEjSEhlScxIjuTX+2NfG9iVWwgWpw9988CfF+AIqQNk5+vOaWU
         RewyZePi8kttZp0dUeL8zT/Ly1Fce4l7skSyNQ7o=
Date:   Tue, 6 Oct 2020 13:11:48 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org,
        Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
        takahiro.akashi@linaro.org, jgross@suse.com,
        boris.ostrovsky@oracle.com
Subject: Re: [PATCH] arm/arm64: xen: Fix to convert percpu address to gfn
 correctly
Message-Id: <20201006131148.1f7b63b688eae7b1e0eb2228@kernel.org>
In-Reply-To: <20201006114058.b93839b1b8f35a470874572b@kernel.org>
References: <160190516028.40160.9733543991325671759.stgit@devnote2>
        <b205ec9c-c307-2b67-c43a-cf2a67179484@xen.org>
        <alpine.DEB.2.21.2010051526550.10908@sstabellini-ThinkPad-T480s>
        <20201006114058.b93839b1b8f35a470874572b@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Oct 2020 11:40:58 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Mon, 5 Oct 2020 18:13:22 -0700 (PDT)
> Stefano Stabellini <sstabellini@kernel.org> wrote:
> 
> > On Mon, 5 Oct 2020, Julien Grall wrote:
> > > Hi Masami,
> > > 
> > > On 05/10/2020 14:39, Masami Hiramatsu wrote:
> > > > Use per_cpu_ptr_to_phys() instead of virt_to_phys() for per-cpu
> > > > address conversion.
> > > > 
> > > > In xen_starting_cpu(), per-cpu xen_vcpu_info address is converted
> > > > to gfn by virt_to_gfn() macro. However, since the virt_to_gfn(v)
> > > > assumes the given virtual address is in contiguous kernel memory
> > > > area, it can not convert the per-cpu memory if it is allocated on
> > > > vmalloc area (depends on CONFIG_SMP).
> > > 
> > > Are you sure about this? I have a .config with CONFIG_SMP=y where the per-cpu
> > > region for CPU0 is allocated outside of vmalloc area.
> > > 
> > > However, I was able to trigger the bug as soon as CONFIG_NUMA_BALANCING was
> > > enabled.
> > 
> > I cannot reproduce the issue with defconfig, but I can with Masami's
> > kconfig.
> > 
> > If I disable just CONFIG_NUMA_BALANCING from Masami's kconfig, the
> > problem still appears.
> > 
> > If I disable CONFIG_NUMA from Masami's kconfig, it works, which is
> > strange because CONFIG_NUMA is enabled in defconfig, and defconfig
> > works.
> 
> Hmm, strange, because when I disabled CONFIG_NUMA_BALANCING, the issue
> disappeared.

Ah, OK. It depends on NUMA. On arm64, CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK
is enabled if CONFIG_NUMA=y.

Since per-cpu first chunk has been allocated by memblock if the
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK is enabled(See
pcpu_embed_first_chunk()), when the kernel allocate the xen_vcpu_info
on the first chunk, it will be in the linear address space.
However, if we disable CONFIG_NUMA, it will be on vmalloc page.

And if the first chunk has been filled up before initializing xen,
the xen_vcpu_info will be allocated on the 2nd chunk which is has been
allocated by the backend allocator (kernel memory or vmalloc, depends
on CONFIG_SMP).

So anyway we have to check it carefully with a special function, which is
per_cpu_ptr_to_phys(). 

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
