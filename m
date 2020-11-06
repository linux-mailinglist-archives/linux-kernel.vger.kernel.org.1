Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765AA2A9081
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 08:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgKFHiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 02:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgKFHiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 02:38:00 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3C5C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 23:37:58 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id a20so261121ilk.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 23:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aQB4ocSHoyHmpaIbRxFj/zt6XeUHDR7wBHeEyE4bZfQ=;
        b=RTsENuCeCOpH73nAqLoeSA8PnD2zhQpcop4R++RTXBfDDPYpcj5zxao2ls+it7Jbbc
         LpSMJBNT9K/5TF5LylVK2+P26EjNPL4ZjGOH4ngNffiea15xSmo/RgBDj1zwhxQehnE7
         bAeKKD0dDcHV0XQg0465baqRrt8CeFC9dpK3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aQB4ocSHoyHmpaIbRxFj/zt6XeUHDR7wBHeEyE4bZfQ=;
        b=t/sthtuNNRrsR+J//1e20m+LczsxEQCiiZ8FsXgeNhk9PTaaxZtiR/dC9H1vzA54Aa
         Y32PjFJMAnaDcoE39tQ6VGB2thFlDUj5l6D5MQjvxTD1BGgRJWAqDqnVQE8gz6WvwvvO
         UO9Jc/G7pnYd47H5kSk2r1sb23jYjh0ZPE5JXJ8YKP29C8UjcxMHJrbY6VcToq3J+6af
         txSDC5hDZWY8RQ6FqPyaYm9tFhofLUaMFr2RTI5FS2cAw18j7HirgurefomPt2xoiydm
         I4aqt/ad3OR3OUIVabpd/+V3uFXQxfR1cyhlNTqIhGH9TsszTKB+kZNG08Wr+so0Ntty
         KeAA==
X-Gm-Message-State: AOAM531YCZeQZJ6ur70QCQqeZsGUmoVeHMbMBFx8TjvWVb+CK6CDgQHy
        kzHe3YNiw1V4dvQLnASPXEi9U34BFDUkVKoDJZ3t
X-Google-Smtp-Source: ABdhPJzim1SBWXT2HkwUxRQYC66JPOOSOS7b965ESES+ZyL8w7EM2XoU657RReCH3oyTptlRc3S7dz8Y3knO6Kjv4LA=
X-Received: by 2002:a92:6410:: with SMTP id y16mr510995ilb.126.1604648278164;
 Thu, 05 Nov 2020 23:37:58 -0800 (PST)
MIME-Version: 1.0
References: <20201028232759.1928479-1-atish.patra@wdc.com> <mhng-3a4619db-fe42-4ae0-a521-4032f23591ee@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-3a4619db-fe42-4ae0-a521-4032f23591ee@palmerdabbelt-glaptop1>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 5 Nov 2020 23:37:45 -0800
Message-ID: <CAOnJCUJUmzVon3BWH6Du08mpgLu_rHJEhdOkCXUK4N+ZftkCRw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Add Microchip PolarFire Soc Support
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Atish Patra <Atish.Patra@wdc.com>, devicetree@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>, Cyril.Jean@microchip.com,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Padmarao Begari <padmarao.begari@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 5, 2020 at 11:14 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Wed, 28 Oct 2020 16:27:56 PDT (-0700), Atish Patra wrote:
> > This series adds minimal support for Microchip Polar Fire Soc Icicle kit.
> > It is rebased on v5.10-rc1 and depends on clock support.
> > Only MMC and ethernet drivers are enabled via this series.
> > The idea here is to add the foundational patches so that other drivers
> > can be added to on top of this.
> >
> > This series has been tested on Qemu and Polar Fire Soc Icicle kit.
> > The following qemu series is necessary to test it on Qemu.
> >
> > The series can also be found at the following github repo.
> >
> > I noticed the latest version of mmc driver[2] hangs on the board with
> > the latest clock driver. That's why, I have tested with the old clock
> > driver available in the above github repo.
>
> OK, I guess that's why it's an RFC?
>

Yes. The latest clock/pcie driver did not work for me. I might have
missed something in DT.
The idea for RFC is so that anybody who wants to try the latest kernel
on a polarfire board
has a meaningful way to test it.

> > [1] https://lists.nongnu.org/archive/html/qemu-devel/2020-10/msg08582.html
> > [2] https://www.spinics.net/lists/devicetree/msg383626.html
>
> Looks like this one hasn't been merged yet.  IDK if something is broken with my
> mail client but I'm not seeing any github repos.  If this depends on
> not-yet-merged drivers then it's certainly RFC material, but aside from the DT
> stuff (which should be straight-forward) it seems fine to me.
>

I think it makes sense to take this series once the clock driver is
merged at least.

> Since you posted this an an RFC I'm going to assume you're going to re-spin it.
>

Yes. There are some feedbacks on DT which I will fix in v2.

> Thanks!
>
> >
> > Atish Patra (3):
> > RISC-V: Add Microchip PolarFire SoC kconfig option
> > RISC-V: Initial DTS for Microchip ICICLE board
> > RISC-V: Enable Microchip PolarFire ICICLE SoC
> >
> > arch/riscv/Kconfig.socs                       |   7 +
> > arch/riscv/boot/dts/Makefile                  |   1 +
> > arch/riscv/boot/dts/microchip/Makefile        |   2 +
> > .../microchip/microchip-icicle-kit-a000.dts   | 313 ++++++++++++++++++
> > arch/riscv/configs/defconfig                  |   4 +
> > 5 files changed, 327 insertions(+)
> > create mode 100644 arch/riscv/boot/dts/microchip/Makefile
> > create mode 100644 arch/riscv/boot/dts/microchip/microchip-icicle-kit-a000.dts
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
