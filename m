Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E16285843
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 07:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbgJGFvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 01:51:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgJGFvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 01:51:02 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF07A208C7;
        Wed,  7 Oct 2020 05:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602049861;
        bh=0Pn6APRQsa4HpVjf3rGUOYdtE8clqW/GJUxe6iTqV3I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fmR5aCHNJXJvqiU8VG6MlZZTo7JvqEdQuWGy4VItalPDsBNjtgW2h9lnhbDk6tP+B
         SIQu5gBARtSIY/GJ40obH23kY1FsWAalHTEORlXimqAySlcvBZLXxNO637CNRT1Ndk
         VT5Fi/JkY+D3xYD6w/TB8ImTGaRVnfHqaGZRWwU8=
Date:   Wed, 7 Oct 2020 14:50:57 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     Julien Grall <julien@xen.org>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org,
        Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
        takahiro.akashi@linaro.org, jgross@suse.com,
        boris.ostrovsky@oracle.com
Subject: Re: [PATCH] arm/arm64: xen: Fix to convert percpu address to gfn
 correctly
Message-Id: <20201007145057.81024d41dfd239628296d090@kernel.org>
In-Reply-To: <alpine.DEB.2.21.2010061040350.10908@sstabellini-ThinkPad-T480s>
References: <160190516028.40160.9733543991325671759.stgit@devnote2>
        <b205ec9c-c307-2b67-c43a-cf2a67179484@xen.org>
        <alpine.DEB.2.21.2010051526550.10908@sstabellini-ThinkPad-T480s>
        <20201006114058.b93839b1b8f35a470874572b@kernel.org>
        <alpine.DEB.2.21.2010061040350.10908@sstabellini-ThinkPad-T480s>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Oct 2020 10:56:52 -0700 (PDT)
Stefano Stabellini <sstabellini@kernel.org> wrote:

> On Tue, 6 Oct 2020, Masami Hiramatsu wrote:
> > On Mon, 5 Oct 2020 18:13:22 -0700 (PDT)
> > Stefano Stabellini <sstabellini@kernel.org> wrote:
> > 
> > > On Mon, 5 Oct 2020, Julien Grall wrote:
> > > > Hi Masami,
> > > > 
> > > > On 05/10/2020 14:39, Masami Hiramatsu wrote:
> > > > > Use per_cpu_ptr_to_phys() instead of virt_to_phys() for per-cpu
> > > > > address conversion.
> > > > > 
> > > > > In xen_starting_cpu(), per-cpu xen_vcpu_info address is converted
> > > > > to gfn by virt_to_gfn() macro. However, since the virt_to_gfn(v)
> > > > > assumes the given virtual address is in contiguous kernel memory
> > > > > area, it can not convert the per-cpu memory if it is allocated on
> > > > > vmalloc area (depends on CONFIG_SMP).
> > > > 
> > > > Are you sure about this? I have a .config with CONFIG_SMP=y where the per-cpu
> > > > region for CPU0 is allocated outside of vmalloc area.
> > > > 
> > > > However, I was able to trigger the bug as soon as CONFIG_NUMA_BALANCING was
> > > > enabled.
> > > 
> > > I cannot reproduce the issue with defconfig, but I can with Masami's
> > > kconfig.
> > > 
> > > If I disable just CONFIG_NUMA_BALANCING from Masami's kconfig, the
> > > problem still appears.
> > > 
> > > If I disable CONFIG_NUMA from Masami's kconfig, it works, which is
> > > strange because CONFIG_NUMA is enabled in defconfig, and defconfig
> > > works.
> > 
> > Hmm, strange, because when I disabled CONFIG_NUMA_BALANCING, the issue
> > disappeared.
> > 
> > --- config-5.9.0-rc4+   2020-10-06 11:36:20.620107129 +0900
> > +++ config-5.9.0-rc4+.buggy     2020-10-05 21:04:40.369936461 +0900
> > @@ -131,7 +131,8 @@
> >  CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
> >  CONFIG_CC_HAS_INT128=y
> >  CONFIG_ARCH_SUPPORTS_INT128=y
> > -# CONFIG_NUMA_BALANCING is not set
> > +CONFIG_NUMA_BALANCING=y
> > +CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
> >  CONFIG_CGROUPS=y
> >  CONFIG_PAGE_COUNTER=y
> >  CONFIG_MEMCG=y
> > 
> > So buggy config just enabled NUMA_BALANCING (and default enabled)
> 
> Yeah but both NUMA and NUMA_BALANCING are enabled in defconfig which
> works fine...
> 
> [...]
> 
> > > The fix is fine for me. I tested it and it works. We need to remove the
> > > "Fixes:" line from the commit message. Ideally, replacing it with a
> > > reference to what is the source of the problem.
> > 
> > OK, as I said, it seems commit 9a9ab3cc00dc ("xen/arm: SMP support") has
> > introduced the per-cpu code. So note it instead of Fixes tag.
> 
> ...and commit 9a9ab3cc00dc was already present in 5.8 which also works
> fine with your kconfig. Something else changed in 5.9 causing this
> breakage as a side effect. Commit 9a9ab3cc00dc is there since 2013, I
> think it is OK -- this patch is fixing something else.

Hmm, then it might be someone runs out the first chunk of percpu and
xen uses the 2nd chunk which is in vmalloc area. It is possible if the
other initcall functions uses alloc_percpu().

Maybe we can trace percpu chunk allocation function for both case.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
