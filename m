Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774F12B0143
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 09:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgKLIhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 03:37:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22491 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726419AbgKLIhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 03:37:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605170222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4rbM80lc2QHuCaufuKXk42IV+QKxU+fnFTQm9bwNqVY=;
        b=aB44OfD7Nd9igdjEi00bk4h/tSXS81AquYOlGgZvh8+835LwpkZ2aYnV4p8/HPnQfw3zUM
        TJVQcvNNNMreq1uNuYdP+oTCV5eudLKmIhOAJjgKEmUFEXrgVWilErMWRFhXYPsVrDGW0p
        4ktJ8IUZcrdLSflN7XWLjLo3a2SsVpc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-DC-gKL_APRCgSIVLLOv0LQ-1; Thu, 12 Nov 2020 03:36:58 -0500
X-MC-Unique: DC-gKL_APRCgSIVLLOv0LQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7C0E64157;
        Thu, 12 Nov 2020 08:36:55 +0000 (UTC)
Received: from localhost (ovpn-12-196.pek2.redhat.com [10.72.12.196])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 04AB15DA82;
        Thu, 12 Nov 2020 08:36:48 +0000 (UTC)
Date:   Thu, 12 Nov 2020 16:36:45 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     chenzhou <chenzhou10@huawei.com>, tglx@linutronix.de,
        mingo@redhat.com, dyoung@redhat.com, catalin.marinas@arm.com,
        will@kernel.org, corbet@lwn.net, John.P.donnelly@oracle.com,
        bhsharma@redhat.com, prabhakar.pkin@gmail.com,
        wangkefeng.wang@huawei.com, arnd@arndb.de,
        linux-doc@vger.kernel.org, xiexiuqi@huawei.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, horms@verge.net.au, james.morse@arm.com,
        linux-arm-kernel@lists.infradead.org, huawei.libin@huawei.com,
        guohanjun@huawei.com, nsaenzjulienne@suse.de
Subject: Re: [PATCH v13 6/8] arm64: kdump: reimplement crashkernel=X
Message-ID: <20201112083645.GL8486@MiWiFi-R3L-srv>
References: <20201031074437.168008-1-chenzhou10@huawei.com>
 <20201031074437.168008-7-chenzhou10@huawei.com>
 <20201111015926.GD24747@MiWiFi-R3L-srv>
 <23389389-2855-50fd-25b7-4f7d4246bf0c@huawei.com>
 <20201111135448.GF8486@MiWiFi-R3L-srv>
 <20201112082509.GL4758@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112082509.GL4758@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/20 at 10:25am, Mike Rapoport wrote:
> On Wed, Nov 11, 2020 at 09:54:48PM +0800, Baoquan He wrote:
> > On 11/11/20 at 09:27pm, chenzhou wrote:
> > > Hi Baoquan,
> > ...
> > > >>  #ifdef CONFIG_CRASH_DUMP
> > > >>  static int __init early_init_dt_scan_elfcorehdr(unsigned long node,
> > > >> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > > >> index 1c0f3e02f731..c55cee290bbb 100644
> > > >> --- a/arch/arm64/mm/mmu.c
> > > >> +++ b/arch/arm64/mm/mmu.c
> > > >> @@ -488,6 +488,10 @@ static void __init map_mem(pgd_t *pgdp)
> > > >>  	 */
> > > >>  	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
> > > >>  #ifdef CONFIG_KEXEC_CORE
> > > >> +	if (crashk_low_res.end)
> > > >> +		memblock_mark_nomap(crashk_low_res.start,
> > > >> +				    resource_size(&crashk_low_res));
> > > >> +
> > > >>  	if (crashk_res.end)
> > > >>  		memblock_mark_nomap(crashk_res.start,
> > > >>  				    resource_size(&crashk_res));
> > > >> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > > >> index d39892bdb9ae..cdef7d8c91a6 100644
> > > >> --- a/kernel/crash_core.c
> > > >> +++ b/kernel/crash_core.c
> > > >> @@ -321,7 +321,7 @@ int __init parse_crashkernel_low(char *cmdline,
> > > >>  
> > > >>  int __init reserve_crashkernel_low(void)
> > > >>  {
> > > >> -#ifdef CONFIG_X86_64
> > > >> +#if defined(CONFIG_X86_64) || defined(CONFIG_ARM64)
> > > > Not very sure if a CONFIG_64BIT checking is better.
> > > If doing like this, there may be some compiling errors for other 64-bit kernel, such as mips.
> > > >
> > > >>  	unsigned long long base, low_base = 0, low_size = 0;
> > > >>  	unsigned long low_mem_limit;
> > > >>  	int ret;
> > > >> @@ -362,12 +362,14 @@ int __init reserve_crashkernel_low(void)
> > > >>  
> > > >>  	crashk_low_res.start = low_base;
> > > >>  	crashk_low_res.end   = low_base + low_size - 1;
> > > >> +#ifdef CONFIG_X86_64
> > > >>  	insert_resource(&iomem_resource, &crashk_low_res);
> > > >> +#endif
> > > >>  #endif
> > > >>  	return 0;
> > > >>  }
> > > >>  
> > > >> -#ifdef CONFIG_X86
> > > >> +#if defined(CONFIG_X86) || defined(CONFIG_ARM64)
> > > > Should we make this weak default so that we can remove the ARCH config?
> > > The same as above, some arch may not support kdump, in that case,  compiling errors occur.
> > 
> > OK, not sure if other people have better idea, oterwise, we can leave with it. 
> > Thanks for telling.
> 
> I think it would be better to have CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL
> in arch/Kconfig and select this by X86 and ARM64.
> 
> Since reserve_crashkernel() implementations are quite similart on other
> architectures as well, we can have more users of this later.

Yes, this sounds like a nice way.

