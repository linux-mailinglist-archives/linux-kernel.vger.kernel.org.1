Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D06126FBE0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 13:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgIRL5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 07:57:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbgIRL5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 07:57:10 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7F662100A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 11:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600430229;
        bh=V54wrBnmpNUu8QyNU3a/ZBi18LV1JMIHDtLqr1Z7Ktg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NXn+xNPA06Qg7a3JljbEx7trfKB9UAzYsGH6XI8viPneTk+I9yvPThDNuQoMu7WFr
         b4f8PhmhZtVjjWwYLLC/Wl2I6dX4CPaL08lODnwbyqgEWMrjutGQu/M5idkQFAIeRZ
         7zPImb5qnonHl2sbL+3l/qrYsrNHdGdQor8dcjYw=
Received: by mail-ot1-f41.google.com with SMTP id q21so5101920ota.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 04:57:09 -0700 (PDT)
X-Gm-Message-State: AOAM533zahoKmsaSraTXo7Zxq4/3hU6TZjMDwc0zLpZyZKHEKKWhYMOw
        yoJMfABurAiJjX/bxRREtU9zlQKoI2UL7sKqvow=
X-Google-Smtp-Source: ABdhPJzBQ9JbxrhzFshdG0IRj0syZIVi3e8ZDXv2u/HG8Nb8HAC9vSFKCNmvuQnj8RxAWtEaIvnbVLcMe8o50U16+2o=
X-Received: by 2002:a9d:6250:: with SMTP id i16mr24057873otk.77.1600430229158;
 Fri, 18 Sep 2020 04:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200918033312.ddfpibgfylfjpex2@amazon.com> <20200918110745.GD6335@gaia>
In-Reply-To: <20200918110745.GD6335@gaia>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 18 Sep 2020 14:56:57 +0300
X-Gmail-Original-Message-ID: <CAMj1kXGy7vNHu9sTw7e69qwc6L2_BFYzUG++5UJdrWs+-173EA@mail.gmail.com>
Message-ID: <CAMj1kXGy7vNHu9sTw7e69qwc6L2_BFYzUG++5UJdrWs+-173EA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: Enable PCI write-combine resources under sysfs
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Clint Sbisa <csbisa@amazon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Sep 2020 at 14:08, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Fri, Sep 18, 2020 at 03:33:12AM +0000, Clint Sbisa wrote:
> > This change exposes write-combine mappings under sysfs for
> > prefetchable PCI resources on arm64.
> >
> > Originally, the usage of "write combine" here was driven by the x86
> > definition of write combine. This definition is specific to x86 and
> > does not generalize to other architectures. However, the usage of WC
> > has mutated to "write combine" semantics, which is implemented
> > differently on each arch.
> >
> > Generally, prefetchable BARs are accepted to allow speculative
> > accesses, write combining, and re-ordering-- from the PCI perspective,
> > this means there are no read side effects. (This contradicts the PCI
> > spec which allows prefetchable BARs to have read side effects, but
> > this definition is ill-advised as it is impossible to meet.) On x86,
> > prefetchable BARs are mapped as WC as originally defined (with some
> > conditionals on arch features). On arm64, WC is taken to mean normal
> > non-cacheable memory.
> >
> > In practice, write combine semantics are used to minimize write
> > operations. A common usage of this is minimizing PCI TLPs which can
> > significantly improve performance with PCI devices. In order to
> > provide the same benefits to userspace, we need to allow userspace to
> > map prefetchable BARs with write combine semantics. The resourceX_wc
> > mapping is used today by userspace programs and libraries.
> >
> > While this model is flawed as "write combine" is very ill-defined, it
> > is already used by multiple non-x86 archs to expose write combine
> > semantics to user space. We enable this on arm64 to give userspace on
> > arm64 an equivalent mechanism for utilizing write combining with PCI
> > devices.
> >
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Jason Gunthorpe <jgg@nvidia.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Signed-off-by: Clint Sbisa <csbisa@amazon.com>
>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>
