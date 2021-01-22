Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45B72FFA38
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 02:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbhAVBxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 20:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbhAVBx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 20:53:26 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FD7C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 17:52:46 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id b8so2330953plh.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 17:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vf1YWMphq7IfDQQZ2byHu6e71SFyteLzACu9Oza6zmY=;
        b=tb5wF3uXiUdTbE6BLyQLy5kvrs957kxDCHIzkbtPRzumfJR373zp+3Dzh3LUQJrxrr
         aqJggpQHp0JxZBOMJPoNzW9upIYVz38x+C+Osa8wigYdMjAnI1Sj6EgnArsY4+8xs9mm
         KIt6OeefkuC1IeslgLSi11/+dHA9h0L1RzkmZ3GAdrNbcVtTHT/NWekbU/1wkU9yZTRE
         9aX0TOg/xLP8SwgEhVeIqt4yXlaDb64VrKZpDQl0cPaMPBQ0D2Fxg9KU9CX2mDFzJ9AO
         ruflRRY7FdksdohDGZgiudasVbrM7YuzneEnFMxPamnmCZsjNzuYCtLd3aXA0NFPT5Nf
         Dzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vf1YWMphq7IfDQQZ2byHu6e71SFyteLzACu9Oza6zmY=;
        b=m8gn3PrWKWObaf6XlS7aFA2yxtWffAIqv1xG6/7XPjlSTmb5Ei6/6HfDMGmxphsjIO
         Ceqk2U4O80NB+n1KXwKWyTulR5RvU1BLYXRDjzPsNXagMPE2EpKhJILGOXQLnMHpOSmU
         CH8zh0iaWmsYzDUd6q/77bYkjei/+TR4p+hEHudjmkJ3OQM0Nu75iEfdQOiaEvO86rD6
         QYnM3qK2cwUfIujcyjEacrzICj2U9Blf3dibKQq2hb2Qox1/peXf5ix8KcdLDx3bvHxq
         n3/YTObSDhkUoHcr7NJZTxTRz+WgfecpNQ2PR4KuUuTRKynu/Cc1eQ7VP/jO2nZ+Dyzr
         Ig4A==
X-Gm-Message-State: AOAM532xfhy6aZtoXgQOxIobqMWmxk+He6p2TnoiWn1OwZ63yHI9jsus
        MaIEpbUEDt1cbTzHhMSa+u0FkTnC04e1CtzLcz6pBg==
X-Google-Smtp-Source: ABdhPJxmTUWx8uIcPZ3F6Um1ghqWYda9bzza9YgD/Mu07BxAsd1t4hHgtpjTvODP8ozFJUBkIYDbHvtv1DzUD9FXkIk=
X-Received: by 2002:a17:90a:9915:: with SMTP id b21mr2540454pjp.101.1611280365695;
 Thu, 21 Jan 2021 17:52:45 -0800 (PST)
MIME-Version: 1.0
References: <20210113061958.886723-1-morbo@google.com> <20210116094357.3620352-1-morbo@google.com>
 <CA+icZUUgTuD6fO_AZFs9KoRFS8FUmyhezvYeeoRX2dveG_ifDA@mail.gmail.com>
 <CAGG=3QXZTR_f9pKzAR=LrALmMzdDqsvWM_zrTXOb2PpiDGB-+A@mail.gmail.com>
 <CA+icZUWf05ek+DFsJNyBc-4cg0s6cVrn=rNJDyL4RJ6=fMO5NA@mail.gmail.com>
 <CA+icZUVD1AHaXYu4Ne8JhzmtMR5DReL4C=ZxKfA0hjLtbC79qQ@mail.gmail.com>
 <CA+icZUUTJbwmTYCDJhyRtif3BdsB_yzQ3bSdLR62EmttJf3Row@mail.gmail.com>
 <CA+icZUUfWR1v3GStn6t_6MYDmwTdJ_zDwBTe2jmQRg7aOA1Q2A@mail.gmail.com>
 <CA+icZUU-3i7Of71C6XaNmee7xD4y_DeoWJFvUHnMUyBaMN3Ywg@mail.gmail.com>
 <CA+icZUXmn15w=kSq2CZzQD5JggJw_9AEam=Sz13M0KpJ68MWZg@mail.gmail.com>
 <CA+icZUWUPCuLWCo=kuPr9YZ4-NZ3F8Fv1GzDXPbDevyWjaMrJg@mail.gmail.com>
 <CAGG=3QW+ayBzCxOusLyQ0-y5K5C_3hNXjara_pYOcxK8MseN9g@mail.gmail.com>
 <CA+icZUU1HihUFaEHzF69+01+Picg8aq6HAqHupxiRqyDGJ=Mpw@mail.gmail.com>
 <CA+icZUUuzA5JEXyVzKbVX+T3xeOdRAU6-mntbo+VwwTxqmN7LA@mail.gmail.com>
 <CAGG=3QWmOA+yM2GJF+cHUb7wUq6yiBpHasa-ry9OhAdvciDm6Q@mail.gmail.com>
 <CA+icZUVwbWDtGUzMEkitxYn2UvbZPnFTxfJyDOY46j6BTK0deQ@mail.gmail.com>
 <CA+icZUXa9wvSWe=21_gjAapoHpbgBmYzFpQjb=o_WRQgK+O4gA@mail.gmail.com>
 <CAGG=3QUcaY1wzJhBD4ZGhPSNPik-kL0PuoE1SJqkFJEM_mkGYA@mail.gmail.com>
 <CA+icZUU+OWW46CVq4Co-y7hckGjoV5bbqxS-G+HDqUDci_AzHw@mail.gmail.com>
 <CAKwvOdkOOjDo+zFFz_T63FphZn2Lg7MW8vd7qd-yS_eB_yYdmA@mail.gmail.com> <CA+icZUUWtKqEhaJSbbQomC+Mz+uRgkWu72vyxPbif0nG1Vvr3g@mail.gmail.com>
In-Reply-To: <CA+icZUUWtKqEhaJSbbQomC+Mz+uRgkWu72vyxPbif0nG1Vvr3g@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 21 Jan 2021 17:52:34 -0800
Message-ID: <CAKwvOdmKRzE8s1zrs4ApcJSn9SzCpGhaoFqqeKsn67SpH6OVgQ@mail.gmail.com>
Subject: Re: [PATCH v5] pgo: add clang's Profile Guided Optimization infrastructure
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Bill Wendling <morbo@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 5:49 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, Jan 22, 2021 at 2:43 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Wed, Jan 20, 2021 at 6:03 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > >
> > > On Mon, Jan 18, 2021 at 10:56 PM Bill Wendling <morbo@google.com> wrote:
> > > >
> > > > On Mon, Jan 18, 2021 at 9:26 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > > >
> > > > > On Mon, Jan 18, 2021 at 1:39 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > > > >
> > > > > > On Mon, Jan 18, 2021 at 3:32 AM Bill Wendling <morbo@google.com> wrote:
> > > > > > >
> > > > > > > On Sun, Jan 17, 2021 at 4:27 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > > > > > >
> > > > > > > > [ big snip ]
> > > > > > >
> > > > > > > [More snippage.]
> > > > > > >
> > > > > > > > [ CC Fangrui ]
> > > > > > > >
> > > > > > > > With the attached...
> > > > > > > >
> > > > > > > >    [PATCH v3] module: Ignore _GLOBAL_OFFSET_TABLE_ when warning for
> > > > > > > > undefined symbols
> > > > > > > >
> > > > > > > > ...I was finally able to boot into a rebuild PGO-optimized Linux-kernel.
> > > > > > > > For details see ClangBuiltLinux issue #1250 "Unknown symbol
> > > > > > > > _GLOBAL_OFFSET_TABLE_ loading kernel modules".
> > > > > > > >
> > > > > > > Thanks for confirming that this works with the above patch.
> > > > > > >
> > > > > > > > @ Bill Nick Sami Nathan
> > > > > > > >
> > > > > > > > 1, Can you say something of the impact passing "LLVM_IAS=1" to make?
> > > > > > >
> > > > > > > The integrated assembler and this option are more-or-less orthogonal
> > > > > > > to each other. One can still use the GNU assembler with PGO. If you're
> > > > > > > having an issue, it may be related to ClangBuiltLinux issue #1250.
> > > > > > >
> > > > > > > > 2. Can you please try Nick's DWARF v5 support patchset v5 and
> > > > > > > > CONFIG_DEBUG_INFO_DWARF5=y (see attachments)?
> > > > > > > >
> > > > > > > I know Nick did several tests with PGO. He may have looked into it
> > > > > > > already, but we can check.
> > > > > > >
> > > > > >
> > > > > > Reproducible.
> > > > > >
> > > > > > LLVM_IAS=1 + DWARF5 = Not bootable
> > > > > >
> > > > > > I will try:
> > > > > >
> > > > > > LLVM_IAS=1 + DWARF4
> > > > > >
> > > > >
> > > > > I was not able to boot into such a built Linux-kernel.
> > > > >
> > > > PGO will have no effect on debugging data. If this is an issue with
> > > > DWARF, then it's likely orthogonal to the PGO patch.
> > > >
> > > > > For me worked: DWARF2 and LLVM_IAS=1 *not* set.
> > > > >
> > > > > Of course, this could be an issue with my system's LLVM/Clang.
> > > > >
> > > > > Debian clang version
> > > > > 12.0.0-++20210115111113+45ef053bd709-1~exp1~20210115101809.3724
> > > > >
> > > > Please use the official clang 11.0.1 release
> > > > (https://releases.llvm.org/download.html), modifying the
> > > > kernel/pgo/Kconfig as I suggested above. The reason we specify clang
> > > > 12 for the minimal version is because of an issue that was recently
> > > > fixed.
> > > >
> > >
> > > I downgraded to clang-11.1.0-rc1.
> > > ( See attachment. )
> > >
> > > Doing the first build with PGO enabled plus DWARF5 and LLVM_IAS=1 works.
> > >
> > > But again after generating vmlinux.profdata and doing the PGO-rebuild
> > > - the resulting Linux-kernel does NOT boot in QEMU or on bare metal.
> > > With GNU/as I can boot.
> > >
> > > So this is independent of DWARF v4 or DWARF v5 (LLVM_IAS=1 and DWARF
> > > v2 is not allowed).
> > > There is something wrong (here) with passing LLVM_IAS=1 to make when
> > > doing the PGO-rebuild.
> > >
> > > Can someone please verify and confirm that the PGO-rebuild with
> > > LLVM_IAS=1 boots or boots not?
> >
> > I was able to build+boot with LLVM_IAS=1 on my personal laptop (no
> > dwarf 5, just mainline+v5).
> >
>
> To clarify:
>
> I can build a PGO-enabled Linux-kernel and boot it.
> Afterwards generate a vmlinux.profdata.
> In a next step: A rebuild without PGO-Kconfig disabled + LLVM_IAS=1
> does not boot.

Does the rebuild produce the hash warnings previously reported?

Can you send your .config for this?
-- 
Thanks,
~Nick Desaulniers
