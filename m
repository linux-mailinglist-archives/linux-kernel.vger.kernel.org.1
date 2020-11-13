Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B3D2B2664
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 22:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgKMVSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 16:18:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:38884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgKMVSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 16:18:03 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FCC22224F
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 21:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605302282;
        bh=+7uZtyFfxiXEKVeQpv6/pLLMrZ72mbGmk7V7tEh5Ik4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=v18FNRh88oFNkC3hGUlYiBhQi0B+DtQepqj4ak0eZpuVaUc9cJiJ6v+tQvyi2rCCe
         hOHQi6MDq3Lxwz+RcO33RTwdEC/dgufdb+4cu/BFsE1R9Yy9dSuV0Zs2OTE97Y+v1M
         UlMo0Awdfyk5f9wOd4uVES19HcaT0kqoQ8huMTwk=
Received: by mail-ot1-f53.google.com with SMTP id n11so10239661ota.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 13:18:02 -0800 (PST)
X-Gm-Message-State: AOAM530LgvXVsI3daHBvi60B6LfHoBqmV2tOfb70nMyGmcCFUDcjm2/c
        zEmStAvKm2cNfegcOKGqwRK8gVtdTm5IwO1zkw==
X-Google-Smtp-Source: ABdhPJyqj1mFM0zw1XJGVp42TNzwu1QB00J1epcSQbwxSk/CM+uigzVdtqh7OKVnHAtNVeo9Dbbra6RqTYUv5WR6LCA=
X-Received: by 2002:a05:6830:2259:: with SMTP id t25mr3033613otd.192.1605302281605;
 Fri, 13 Nov 2020 13:18:01 -0800 (PST)
MIME-Version: 1.0
References: <20201113205233.827493-1-rkir@google.com> <20201113210730.GA1992396@bogus>
 <CAOGAQeq29S06+6M58qF0e4ivjzkZDg4+M7ffSK+FapbgmCBrLQ@mail.gmail.com>
In-Reply-To: <CAOGAQeq29S06+6M58qF0e4ivjzkZDg4+M7ffSK+FapbgmCBrLQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 13 Nov 2020 15:17:50 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+QjQxDh3_KDhgE_2A6DjA+gSyvknjrVfRFLMLz-p_M9A@mail.gmail.com>
Message-ID: <CAL_Jsq+QjQxDh3_KDhgE_2A6DjA+gSyvknjrVfRFLMLz-p_M9A@mail.gmail.com>
Subject: Re: [PATCH] drivers: rtc: retire RTC_DRV_GOLDFISH
To:     Roman Kiryanov <rkir@google.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Lingfeng Yang <lfy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 3:13 PM Roman Kiryanov <rkir@google.com> wrote:
>
> Hi Rob, thank you for looking into this.
>
> On Fri, Nov 13, 2020 at 1:07 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Nov 13, 2020 at 12:52:33PM -0800, rkir@google.com wrote:
> > > From: Roman Kiryanov <rkir@google.com>
> > >
> > > The only user of RTC_DRV_GOLDFISH is
> > > the MIPS flavor of Android Studio Emulator
> > > (goldfish) which should be also retired.
> > >
> > > Signed-off-by: Roman Kiryanov <rkir@google.com>
> > > ---
> > >  arch/riscv/Kconfig.socs    |   1 -
> > >  drivers/rtc/Kconfig        |  10 --
> > >  drivers/rtc/Makefile       |   1 -
> > >  drivers/rtc/rtc-goldfish.c | 216 -------------------------------------
> > >  4 files changed, 228 deletions(-)
> > >  delete mode 100644 drivers/rtc/rtc-goldfish.c
> >
> > What about the binding and MAINTAINERS?
>
> My bad, I will update those files too.

Though the binding is still used in arch/mips/generic/board-ranchu.c
and arch/mips/boot/dts/loongson/loongson64v_4core_virtio.dts. The
latter was just added recently, so maybe premature to remove things?

Rob
