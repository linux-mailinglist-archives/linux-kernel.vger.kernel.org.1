Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5192858FF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 09:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgJGHIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 03:08:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37139 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727033AbgJGHIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 03:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602054485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2emVL8rNfBMhk//RxZehtElMhUSqx0aMuZNVdSt+Tbg=;
        b=KJVxHGp3Pbos2n9/huRZxkhNaTHZqdMZTpECUD75EAeOtG2fqEG+3fA45aIy97R/KvkPFY
        UOx2NTT+j28R+3DfVyAe0GEwpL8w/UUs4XFN6x2KMKwLAZbX+On0QINEdACTBCPSuzJ7dc
        ndGweDuQMib/CmlU4eitNT6QIGmJZr0=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-CBGm5rJXPr6Ts-3uDnn9ow-1; Wed, 07 Oct 2020 03:08:04 -0400
X-MC-Unique: CBGm5rJXPr6Ts-3uDnn9ow-1
Received: by mail-oi1-f198.google.com with SMTP id k7so497559oif.22
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 00:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2emVL8rNfBMhk//RxZehtElMhUSqx0aMuZNVdSt+Tbg=;
        b=f341quV5G/jkTerVswPFCm9Y+FRxH58sRc/ZzCZr3o5lFusOMs1PkSabVSbXCvewa4
         /Ywo/we41hGwB78zvEfIchMaZdEL+OfesxhAUpT0pJfwSv8yR6m6GwCWor19bYGcSn8J
         4j3tfXNFEbYdJictwA36cFE0zz26LdgJvgCAPP/w7xGnejUe6bn2ei7TQDRk2JcA/vgw
         6SP9beg9v094coOCrLGy2C0UO+D8gw0Tgjs0hzUutu1bvvWUmatGPbdSEKAfnh+tMxLZ
         s/9C50XtvuigmFcXJ73edxTOaREndghhs8vx2lQVkzct7ajVoNFknLteN72+eu/8XEnl
         Nvhw==
X-Gm-Message-State: AOAM530IMaSLAgoriLQur6ABkGkcY3hAd9ErxAWaU7V00YwcTvhyCg8f
        pwF7tX46tbtnswyfcqtoYze6X6ksy/JWk0I8d20mlZVeJrGE8f92mPZjvDG83HlENDDWge4x7rr
        LsZkaPQaW1zqDd+kLIG/hxaTnsc2sMrWQRSxvSBj2
X-Received: by 2002:a9d:2c05:: with SMTP id f5mr1035021otb.183.1602054481586;
        Wed, 07 Oct 2020 00:08:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxqFM0VBANixBZ3iYM60Mb5DOwhruP3A6xZ3YIOrzcgRBSdi5vOD4F6c0tfloDw4HFQZkV45djnvn9PEsUyME=
X-Received: by 2002:a9d:2c05:: with SMTP id f5mr1034994otb.183.1602054481228;
 Wed, 07 Oct 2020 00:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200907134745.25732-1-chenzhou10@huawei.com> <e9b1b5db-a848-468e-6baf-2f7b4d658805@oracle.com>
 <20201005170937.GA14576@gaia> <CACi5LpMWUmP1df8fB8psJY_cNGHF9MNn+TNK4B4edaRHvOXxGQ@mail.gmail.com>
 <20201006180012.GB31946@C02TF0J2HF1T.local>
In-Reply-To: <20201006180012.GB31946@C02TF0J2HF1T.local>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Wed, 7 Oct 2020 12:37:49 +0530
Message-ID: <CACi5LpMmccLX9p0ZXnEbWHgn2LRrVSDQZF9zBGzfZySe3TvXEQ@mail.gmail.com>
Subject: Re: [PATCH v12 0/9] support reserving crashkernel above 4G on arm64 kdump
To:     Catalin Marinas <catalin.marinas@arm.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On Tue, Oct 6, 2020 at 11:30 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Mon, Oct 05, 2020 at 11:12:10PM +0530, Bhupesh Sharma wrote:
> > I think my earlier email with the test results on this series bounced
> > off the mailing list server (for some weird reason), but I still see
> > several issues with this patchset. I will add specific issues in the
> > review comments for each patch again, but overall, with a crashkernel
> > size of say 786M, I see the following issue:
> >
> > # cat /proc/cmdline
> > BOOT_IMAGE=(hd7,gpt2)/vmlinuz-5.9.0-rc7+ root=<..snip..> rd.lvm.lv=<..snip..> crashkernel=786M
> >
> > I see two regions of size 786M and 256M reserved in low and high
> > regions respectively, So we reserve a total of 1042M of memory, which
> > is an incorrect behaviour:
> >
> > # dmesg | grep -i crash
> > [    0.000000] Reserving 256MB of low memory at 2816MB for crashkernel (System low RAM: 768MB)
> > [    0.000000] Reserving 786MB of memory at 654158MB for crashkernel (System RAM: 130816MB)
> > [    0.000000] Kernel command line: BOOT_IMAGE=(hd2,gpt2)/vmlinuz-5.9.0-rc7+ root=/dev/mapper/rhel_ampere--hr330a--03-root ro rd.lvm.lv=rhel_ampere-hr330a-03/root rd.lvm.lv=rhel_ampere-hr330a-03/swap crashkernel=786M cma=1024M
> >
> > # cat /proc/iomem | grep -i crash
> >   b0000000-bfffffff : Crash kernel (low)
> >   bfcbe00000-bffcffffff : Crash kernel
>
> As Chen said, that's the intended behaviour and how x86 works. The
> requested 768M goes in the high range if there's not enough low memory
> and an additional buffer for swiotlb is allocated, hence the low 256M.

I understand, but why 256M (as low) for arm64? x86_64 setups usually
have more system memory available as compared to several commercially
available arm64 setups. So is the intent, just to keep the behavior
similar between arm64 and x86_64?

Should we have a CONFIG option / bootarg to help one select the max
'low_size'? Currently the ' low_size' value is calculated as:

    /*
         * two parts from kernel/dma/swiotlb.c:
         * -swiotlb size: user-specified with swiotlb= or default.
         *
         * -swiotlb overflow buffer: now hardcoded to 32k. We round it
         * to 8M for other buffers that may need to stay low too. Also
         * make sure we allocate enough extra low memory so that we
         * don't run out of DMA buffers for 32-bit devices.
         */
        low_size = max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);

Since many arm64 boards ship with swiotlb=0 (turned off) via kernel
bootargs, the low_size, still ends up being 256M in such cases,
whereas this 256M can be used for some other purposes - so should we
be limiting this to 64M and failing the crash kernel allocation
request (gracefully) otherwise?

> We could (as an additional patch), subtract the 256M from the high
> allocation so that you'd get a low 256M and a high 512M, not sure it's
> worth it. Note that with a "crashkernel=768M,high" option, you still get
> the additional low 256M, otherwise the crashkernel won't be able to
> boot as there's no memory in ZONE_DMA. In the explicit ",high" request
> case, I'm not sure subtracted the 256M is more intuitive.

> In 5.11, we also hope to fix the ZONE_DMA layout for non-RPi4 platforms
> to cover the entire 32-bit address space (i.e. identical to the current
> ZONE_DMA32).
>
> > IMO, we should test this feature more before including this in 5.11
>
> Definitely. That's one of the reasons we haven't queued it yet. So any
> help with testing here is appreciated.

Sure, I am running more checks on this series. I will be soon back
with more updates.

Regards,
Bhupesh

