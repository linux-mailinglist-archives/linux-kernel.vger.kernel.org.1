Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7837F2F32EE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 15:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731791AbhALO1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 09:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbhALO1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 09:27:16 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AB1C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 06:26:36 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id t30so2728118wrb.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 06:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gqO1yWp5AB3IJei1IjrvC2R1TL1BEuYE5TsVy5/Jxdk=;
        b=Iy3BYVD4JYi00Y+paAwHAKEJherb8Av77liX/FvqkRZWzDoitM0Q4XSnJqs1MUl4Bm
         1G8CdVBIgQpBavCB0wJCuUqC3s343Qs5oaeGjQxkZgZN5sawE8xU7zgFHvG75x8EJ3Ap
         X3vC5k7XDCaOEsfK9sEmWHKxOLmW9XBCjSsCjEXOb2OVLHFGeUdslzfX0nm8mJruMeaf
         nh3z5xM8wwyS2BoFDnxlKeW2yq8t5SGrve88rD3UKhJL9RAQTTwf4LAReqBvY4XmEywi
         wUrPjW0fDWtuBFPiKl1upHvt9FFv7Asn4fitWBvSBi/fbJlG2ZjDCmvJWTRMdR03I8Jl
         sd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gqO1yWp5AB3IJei1IjrvC2R1TL1BEuYE5TsVy5/Jxdk=;
        b=AeTy4FbDUJabepO/hymeC/pbAL3c3UIWSGdEnaG8mL+I+XFNdfBhNGLjjkhpTqGHCW
         nC39X4Rp5QpleIBGKsWv517kiCUJlmDmuifdcgIcuBtOLh951rXQ64ydxPuT3tkriLG+
         6Zs/qXmCGphyhesCR5Q+qO9BL/qydjHfljCOGB387S8pdpWp2h2iv2nbUpgmIQm0Aamf
         38UvBh4UsPTAGvFT3ldEQXuuyJ+PYYX8yPNJ+WLXZy44DtaiYx4A2WTpc54Zttzv0eed
         woP0ATTzbBrGumzz7Wq2NtYFphXVh5Rx/uIGddjjv8ViMr87gxGjrIZ6xqjn01SRKSB4
         Zhzw==
X-Gm-Message-State: AOAM533QklVo/opSkrRYwk3Nx3ctzXKd7/W3l+tb/z7+Wz6RB+lRFNCZ
        PodUa2/wlVArsUhYQNyt+vtnWA==
X-Google-Smtp-Source: ABdhPJxHs8mZH4ZmQL7/Q5htecGGqFW8DO80hTSW2T6i4qYeHxgL0Nc7/eIL/3kWJM+E9MAnFTEHDA==
X-Received: by 2002:adf:ea04:: with SMTP id q4mr4592027wrm.195.1610461594673;
        Tue, 12 Jan 2021 06:26:34 -0800 (PST)
Received: from google.com (49.222.77.34.bc.googleusercontent.com. [34.77.222.49])
        by smtp.gmail.com with ESMTPSA id k10sm4764541wrq.38.2021.01.12.06.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 06:26:34 -0800 (PST)
Date:   Tue, 12 Jan 2021 14:26:31 +0000
From:   Quentin Perret <qperret@google.com>
To:     Rob Herring <robh+dt@kernel.org>
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
Subject: Re: [RFC PATCH v2 15/26] of/fdt: Introduce
 early_init_dt_add_memory_hyp()
Message-ID: <X/2xlxx9Ucp4UZvL@google.com>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-16-qperret@google.com>
 <CAL_JsqLmzFWmTc=6JSRMofSEVRx9GCrwGxEsYog9dC16EMGdvQ@mail.gmail.com>
 <X/1xN2UxiUxkzAiN@google.com>
 <CAL_Jsq+5d+Ox_-m_Rd83R9xoZb6e2cxCNfbL8YPzKdwj=y0M8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+5d+Ox_-m_Rd83R9xoZb6e2cxCNfbL8YPzKdwj=y0M8Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 Jan 2021 at 08:10:47 (-0600), Rob Herring wrote:
> On Tue, Jan 12, 2021 at 3:51 AM Quentin Perret <qperret@google.com> wrote:
> >
> > On Monday 11 Jan 2021 at 08:45:10 (-0600), Rob Herring wrote:
> > > On Fri, Jan 8, 2021 at 6:16 AM Quentin Perret <qperret@google.com> wrote:
> > > >
> > > > Introduce early_init_dt_add_memory_hyp() to allow KVM to conserve a copy
> > > > of the memory regions parsed from DT. This will be needed in the context
> > > > of the protected nVHE feature of KVM/arm64 where the code running at EL2
> > > > will be cleanly separated from the host kernel during boot, and will
> > > > need its own representation of memory.
> > >
> > > What happened to doing this with memblock?
> >
> > I gave it a go, but as mentioned in v1, I ran into issues for nomap
> > regions. I want the hypervisor to know about these memory regions (it's
> > possible some of those will be given to protected guests for instance)
> > but these seem to be entirely removed from the memblocks when using DT:
> >
> > https://elixir.bootlin.com/linux/latest/source/drivers/of/fdt.c#L1153
> >
> > EFI appears to do things differently, though, as it 'just' uses
> > memblock_mark_nomap() instead of actively removing the memblock. And that
> > means I could actually use the memblock API for EFI, but I'd rather
> > have a common solution. I tried to understand why things are done
> > differently but couldn't find an answer and kept things simple and
> > working for now.
> >
> > Is there a good reason for not using memblock_mark_nomap() with DT? If
> > not, I'm happy to try that.
> 
> There were 2 patches to do that, but it never got resolved. See here[1].

Thanks. So the DT stuff predates the introduction of memblock_mark_nomap,
that's why...

By reading the discussions, [1] still looks a sensible patch on its own,
independently from the issue Nicolas tried to solve. Any reason for not
applying it?

I'll try to rework my series on top and see how that goes.

Thanks,
Quentin

[1] https://lore.kernel.org/linux-devicetree/1562920284-18638-1-git-send-email-karahmed@amazon.de/
