Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30352F32B0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 15:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbhALOLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 09:11:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:50312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbhALOLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 09:11:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5CD02311D;
        Tue, 12 Jan 2021 14:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610460660;
        bh=ENjvy0Q+qTvAHdvM+Qmza6RORATL3UTnpgk5t6Fv8PI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mphXnHHH/En5/hD5AimJ8saRejozTzE62sfESXc7Y2zl3e1De2wZO1IfoMwXpCkFY
         De5L2nsnW3OXvxQdhWQiCnf39axqCTxl2sAyVR1XemnW6F2q4XY+FMm0HON9Mrlc+p
         MMognZH2hB6+nF76s6yHRfk3sGjc+wdF3VlsXGF4G7535aJpjSDzwLAdQnXmEoITg3
         +G9VPlEZBR9TbFJqySq6K24M8jj8wDCg058Ke8iUgtXaeZQzbFguFImH3kChDwPsEE
         GwpZ3+juOsZbsVJV/PKK49oESCsOP8aBsjKL3peEvgSbTcz1+Nv1KANaZ0Yuo4Qsod
         am+Nkrsc5HimA==
Received: by mail-ej1-f50.google.com with SMTP id w1so3666966ejf.11;
        Tue, 12 Jan 2021 06:10:59 -0800 (PST)
X-Gm-Message-State: AOAM532kBUT4YRsq8YvydJixmCI7EgnmayaDoq0LN0P760GnFahhnKyH
        NuZwearITMCFk7CW/3AGM+2YkNnUYLjO+Yz8Gg==
X-Google-Smtp-Source: ABdhPJx6WBuO0b55qgrKmXulVdShGTlUCuYQZf9Q+loZi3a9rgL14J1g8duqmSuDSOBd2TTPv+EqXRc4W6wxFsUnUP4=
X-Received: by 2002:a17:906:d784:: with SMTP id pj4mr3277745ejb.360.1610460658215;
 Tue, 12 Jan 2021 06:10:58 -0800 (PST)
MIME-Version: 1.0
References: <20210108121524.656872-1-qperret@google.com> <20210108121524.656872-16-qperret@google.com>
 <CAL_JsqLmzFWmTc=6JSRMofSEVRx9GCrwGxEsYog9dC16EMGdvQ@mail.gmail.com> <X/1xN2UxiUxkzAiN@google.com>
In-Reply-To: <X/1xN2UxiUxkzAiN@google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 12 Jan 2021 08:10:47 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+5d+Ox_-m_Rd83R9xoZb6e2cxCNfbL8YPzKdwj=y0M8Q@mail.gmail.com>
Message-ID: <CAL_Jsq+5d+Ox_-m_Rd83R9xoZb6e2cxCNfbL8YPzKdwj=y0M8Q@mail.gmail.com>
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

On Tue, Jan 12, 2021 at 3:51 AM Quentin Perret <qperret@google.com> wrote:
>
> On Monday 11 Jan 2021 at 08:45:10 (-0600), Rob Herring wrote:
> > On Fri, Jan 8, 2021 at 6:16 AM Quentin Perret <qperret@google.com> wrote:
> > >
> > > Introduce early_init_dt_add_memory_hyp() to allow KVM to conserve a copy
> > > of the memory regions parsed from DT. This will be needed in the context
> > > of the protected nVHE feature of KVM/arm64 where the code running at EL2
> > > will be cleanly separated from the host kernel during boot, and will
> > > need its own representation of memory.
> >
> > What happened to doing this with memblock?
>
> I gave it a go, but as mentioned in v1, I ran into issues for nomap
> regions. I want the hypervisor to know about these memory regions (it's
> possible some of those will be given to protected guests for instance)
> but these seem to be entirely removed from the memblocks when using DT:
>
> https://elixir.bootlin.com/linux/latest/source/drivers/of/fdt.c#L1153
>
> EFI appears to do things differently, though, as it 'just' uses
> memblock_mark_nomap() instead of actively removing the memblock. And that
> means I could actually use the memblock API for EFI, but I'd rather
> have a common solution. I tried to understand why things are done
> differently but couldn't find an answer and kept things simple and
> working for now.
>
> Is there a good reason for not using memblock_mark_nomap() with DT? If
> not, I'm happy to try that.

There were 2 patches to do that, but it never got resolved. See here[1].

Rob

[1] https://lore.kernel.org/linux-devicetree/?q=s%3Ano-map
