Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16F5286477
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 18:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgJGQd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 12:33:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbgJGQd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 12:33:27 -0400
Received: from gaia (unknown [95.149.105.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 092952064E;
        Wed,  7 Oct 2020 16:33:21 +0000 (UTC)
Date:   Wed, 7 Oct 2020 17:33:19 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     John Donnelly <john.p.donnelly@oracle.com>,
        Chen Zhou <chenzhou10@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        RuiRui Yang <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Prabhakar Kushwaha <prabhakar.pkin@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, nsaenzjulienne@suse.de,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kexec mailing list <kexec@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        guohanjun@huawei.com, xiexiuqi@huawei.com, huawei.libin@huawei.com,
        wangkefeng.wang@huawei.com
Subject: Re: [PATCH v12 0/9] support reserving crashkernel above 4G on arm64
 kdump
Message-ID: <20201007163319.GS3462@gaia>
References: <20200907134745.25732-1-chenzhou10@huawei.com>
 <e9b1b5db-a848-468e-6baf-2f7b4d658805@oracle.com>
 <20201005170937.GA14576@gaia>
 <CACi5LpMWUmP1df8fB8psJY_cNGHF9MNn+TNK4B4edaRHvOXxGQ@mail.gmail.com>
 <20201006180012.GB31946@C02TF0J2HF1T.local>
 <CACi5LpMmccLX9p0ZXnEbWHgn2LRrVSDQZF9zBGzfZySe3TvXEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACi5LpMmccLX9p0ZXnEbWHgn2LRrVSDQZF9zBGzfZySe3TvXEQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 12:37:49PM +0530, Bhupesh Sharma wrote:
> On Tue, Oct 6, 2020 at 11:30 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Mon, Oct 05, 2020 at 11:12:10PM +0530, Bhupesh Sharma wrote:
> > > I think my earlier email with the test results on this series bounced
> > > off the mailing list server (for some weird reason), but I still see
> > > several issues with this patchset. I will add specific issues in the
> > > review comments for each patch again, but overall, with a crashkernel
> > > size of say 786M, I see the following issue:
> > >
> > > # cat /proc/cmdline
> > > BOOT_IMAGE=(hd7,gpt2)/vmlinuz-5.9.0-rc7+ root=<..snip..> rd.lvm.lv=<..snip..> crashkernel=786M
> > >
> > > I see two regions of size 786M and 256M reserved in low and high
> > > regions respectively, So we reserve a total of 1042M of memory, which
> > > is an incorrect behaviour:
> > >
> > > # dmesg | grep -i crash
> > > [    0.000000] Reserving 256MB of low memory at 2816MB for crashkernel (System low RAM: 768MB)
> > > [    0.000000] Reserving 786MB of memory at 654158MB for crashkernel (System RAM: 130816MB)
> > > [    0.000000] Kernel command line: BOOT_IMAGE=(hd2,gpt2)/vmlinuz-5.9.0-rc7+ root=/dev/mapper/rhel_ampere--hr330a--03-root ro rd.lvm.lv=rhel_ampere-hr330a-03/root rd.lvm.lv=rhel_ampere-hr330a-03/swap crashkernel=786M cma=1024M
> > >
> > > # cat /proc/iomem | grep -i crash
> > >   b0000000-bfffffff : Crash kernel (low)
> > >   bfcbe00000-bffcffffff : Crash kernel
> >
> > As Chen said, that's the intended behaviour and how x86 works. The
> > requested 768M goes in the high range if there's not enough low memory
> > and an additional buffer for swiotlb is allocated, hence the low 256M.
> 
> I understand, but why 256M (as low) for arm64? x86_64 setups usually
> have more system memory available as compared to several commercially
> available arm64 setups. So is the intent, just to keep the behavior
> similar between arm64 and x86_64?

Similar in the sense of the fallback to high memory and some low memory
allocation but the amounts can vary per architecture.

> Should we have a CONFIG option / bootarg to help one select the max
> 'low_size'? Currently the ' low_size' value is calculated as:
> 
>     /*
>          * two parts from kernel/dma/swiotlb.c:
>          * -swiotlb size: user-specified with swiotlb= or default.
>          *
>          * -swiotlb overflow buffer: now hardcoded to 32k. We round it
>          * to 8M for other buffers that may need to stay low too. Also
>          * make sure we allocate enough extra low memory so that we
>          * don't run out of DMA buffers for 32-bit devices.
>          */
>         low_size = max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);
> 
> Since many arm64 boards ship with swiotlb=0 (turned off) via kernel
> bootargs, the low_size, still ends up being 256M in such cases,
> whereas this 256M can be used for some other purposes - so should we
> be limiting this to 64M and failing the crash kernel allocation
> request (gracefully) otherwise?

I think it makes sense to set a low_size = 0 if
swiotlb_size_or_default() is 0. The assumption would be that if the main
kernel doesn't need an swiotlb, the crashdump one wouldn't need it
either. But this probably needs the ZONE_DMA for non-RPi4 platforms
addressed as well (expanded to the whole ZONE_DMA32).

-- 
Catalin
