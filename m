Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6BB52F361C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405445AbhALQqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:46:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:39906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbhALQqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:46:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89F3123121;
        Tue, 12 Jan 2021 16:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610469970;
        bh=G8QgmioLPowngS9PnWyS0qJ4GW5plz/qHFNOJiaPmLM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=utv8poqFkjEP20anauzkLWewiDee9vsGsy6vyLsmr3EPv7IlXm1g/fNO0INTpvRm1
         v2PgImEiKX8ztyABczzpBOEhbzIyaJpAccHLb8IFEW20WPjtZQFRKzdvQh24GDVYXF
         QuOrbf+4HF22PlWuAsAGgo7uxImKpfLnfNIMp63kcHLBVpAqkMg0JoW9xDlto6ZL4f
         dr9likG3mnT/AFbPWPkR+C/qxNxQ4CLS9lsSaOTfi0RyVGFDEGYp/mFrN3GUXVI+tz
         CVbb5KMFAirL9ETDQiHejG2L/6L62nC5eHgxduPHFT6jesN0HpHTDuzM+nFwhw3rRt
         6dDhJZqR7ju3A==
Received: by mail-ej1-f42.google.com with SMTP id q22so4483952eja.2;
        Tue, 12 Jan 2021 08:46:10 -0800 (PST)
X-Gm-Message-State: AOAM531In9V2Fe9Og97hD4mrGgbzRtC/UyxxZD1MKOP5dKcnhoMtlN9M
        99GyN47oe4PUV0YDEhEDAh5roYNx7Rxx021nGA==
X-Google-Smtp-Source: ABdhPJwpatqtscFinSdtYUrvRElGEmeizOIFHtAttZVKAEASK6GUt12WCxKJxKuZKsgMiopOcpPvL1kPhiZ1kgVNx0g=
X-Received: by 2002:a17:906:ae43:: with SMTP id lf3mr3526825ejb.130.1610469968932;
 Tue, 12 Jan 2021 08:46:08 -0800 (PST)
MIME-Version: 1.0
References: <20210108121524.656872-1-qperret@google.com> <20210108121524.656872-16-qperret@google.com>
 <CAL_JsqLmzFWmTc=6JSRMofSEVRx9GCrwGxEsYog9dC16EMGdvQ@mail.gmail.com>
 <X/1xN2UxiUxkzAiN@google.com> <CAL_Jsq+5d+Ox_-m_Rd83R9xoZb6e2cxCNfbL8YPzKdwj=y0M8Q@mail.gmail.com>
 <X/2xlxx9Ucp4UZvL@google.com> <CAL_Jsq+o+t4YYXEW_nYqMsT4ubYJWe6Kdhu614RtrCqsHBtfLw@mail.gmail.com>
 <X/3LIGgx83XJ+U0F@google.com>
In-Reply-To: <X/3LIGgx83XJ+U0F@google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 12 Jan 2021 10:45:56 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+SeOrn4qFyFuPUmXdnM1oMNMLWLsDzrYgUt9Ts3hyoNg@mail.gmail.com>
Message-ID: <CAL_Jsq+SeOrn4qFyFuPUmXdnM1oMNMLWLsDzrYgUt9Ts3hyoNg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 15/26] of/fdt: Introduce early_init_dt_add_memory_hyp()
To:     Quentin Perret <qperret@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, android-kvm@google.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.cs.columbia.edu>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 10:15 AM Quentin Perret <qperret@google.com> wrote:
>
> On Tuesday 12 Jan 2021 at 09:53:36 (-0600), Rob Herring wrote:
> > On Tue, Jan 12, 2021 at 8:26 AM Quentin Perret <qperret@google.com> wrote:
> > >
> > > On Tuesday 12 Jan 2021 at 08:10:47 (-0600), Rob Herring wrote:
> > > > On Tue, Jan 12, 2021 at 3:51 AM Quentin Perret <qperret@google.com> wrote:
> > > > >
> > > > > On Monday 11 Jan 2021 at 08:45:10 (-0600), Rob Herring wrote:
> > > > > > On Fri, Jan 8, 2021 at 6:16 AM Quentin Perret <qperret@google.com> wrote:
> > > > > > >
> > > > > > > Introduce early_init_dt_add_memory_hyp() to allow KVM to conserve a copy
> > > > > > > of the memory regions parsed from DT. This will be needed in the context
> > > > > > > of the protected nVHE feature of KVM/arm64 where the code running at EL2
> > > > > > > will be cleanly separated from the host kernel during boot, and will
> > > > > > > need its own representation of memory.
> > > > > >
> > > > > > What happened to doing this with memblock?
> > > > >
> > > > > I gave it a go, but as mentioned in v1, I ran into issues for nomap
> > > > > regions. I want the hypervisor to know about these memory regions (it's
> > > > > possible some of those will be given to protected guests for instance)
> > > > > but these seem to be entirely removed from the memblocks when using DT:
> > > > >
> > > > > https://elixir.bootlin.com/linux/latest/source/drivers/of/fdt.c#L1153
> > > > >
> > > > > EFI appears to do things differently, though, as it 'just' uses
> > > > > memblock_mark_nomap() instead of actively removing the memblock. And that
> > > > > means I could actually use the memblock API for EFI, but I'd rather
> > > > > have a common solution. I tried to understand why things are done
> > > > > differently but couldn't find an answer and kept things simple and
> > > > > working for now.
> > > > >
> > > > > Is there a good reason for not using memblock_mark_nomap() with DT? If
> > > > > not, I'm happy to try that.
> > > >
> > > > There were 2 patches to do that, but it never got resolved. See here[1].
> > >
> > > Thanks. So the DT stuff predates the introduction of memblock_mark_nomap,
> > > that's why...
> > >
> > > By reading the discussions, [1] still looks a sensible patch on its own,
> > > independently from the issue Nicolas tried to solve. Any reason for not
> > > applying it?
> >
> > As I mentioned in the thread, same patch with 2 different reasons. So
> > I just wanted a better commit message covering both.
>
> Sorry if I'm being thick, but I'm not seeing it. How are they the same?
> IIUC, as per Nicolas' last reply, using memblock_mark_nomap() does not
> solve his issue with a broken DT. These 2 patches address two completely
> separate issues no?

Umm, yes you are right. But both are dealing with nomap. So someone
needs to sort out what the right thing to do here is. No one cared
enough to follow up in a year and a half.

Rob
