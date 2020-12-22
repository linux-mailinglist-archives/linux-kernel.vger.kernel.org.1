Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A402E0F39
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 21:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgLVUPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 15:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgLVUPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 15:15:19 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F9DC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 12:14:39 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id t8so13090449iov.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 12:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7zOf6F8ODgFcmacS9f6DCdrzJfrVz8BP88T2NFPCiVA=;
        b=cXF3QvfttDRIq6gJ4Wz3ZKQqCIAXSUZcQeXRHzebIehV4HKBFNWVNn6z1Ou6En9XWC
         pObVsIyeBEPxjyG0GERA2gzo+/ZsKhyr/3waLfWia8Uv4rjS210W9rXrPc+7hhfGEifD
         L0U/GtfZjNVxyBmr9EIZev92P+plFUGWBzWEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7zOf6F8ODgFcmacS9f6DCdrzJfrVz8BP88T2NFPCiVA=;
        b=ly92p4iAodQfr/8Y58Swa5CoF3yTfIF9bDOcttq4s3ZASCJQhQ6YZbCVJnFrCrahiA
         Rzh8GgC/m+eZZPZZHKDPJqea+m+v7xl/0PwW12Vi6JoW1Wm120xWM5bPMeCGqPb3CRRO
         3uexFkU2rjX7XGyXFG7ERf4liSDjdd15YC8RZ6lVe/vfdHiuEXVCsxU1VIfWm3Gnvsjq
         CpFBDBXQGW/YhrtdmNYo8E29SSnWdjsZfkYuIDgRXWFDQ8Ei2gPRo6Ufh1d9F+whHEAB
         iR80bCvLqe6JhouzXUH/VpTuwAGB6wTL78af9FufFs1IkseqU+Tkog09OlM+KxvVsWil
         t7Vw==
X-Gm-Message-State: AOAM5310g25viRmGZCmtAM4d9lpUkxvrCNhDY3+7lpXJqakephJb7nqL
        qyIszh82bN62RbcCrR0BTpiz0dgZ3ZJ0sKJYyEGC
X-Google-Smtp-Source: ABdhPJyUHJf84Lg2qSP3jMdGstvvHuPcN2/TySq54r/xcVNXu2cRD3MFNmcm4v52z1nN7Jo4djZ2OMIE3EEPlyzUtEI=
X-Received: by 2002:a6b:b74e:: with SMTP id h75mr19143399iof.0.1608668078357;
 Tue, 22 Dec 2020 12:14:38 -0800 (PST)
MIME-Version: 1.0
References: <20201204085835.2406541-1-atish.patra@wdc.com> <mhng-2a16d74b-c896-4ad0-9d02-87b3b09ee3be@palmerdabbelt-glaptop>
In-Reply-To: <mhng-2a16d74b-c896-4ad0-9d02-87b3b09ee3be@palmerdabbelt-glaptop>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 22 Dec 2020 12:14:27 -0800
Message-ID: <CAOnJCUJ5UK3Do=uC0R2DVMNt6HmoJHKB1XXr8MkoeBYNzQHZrw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Add Microchip PolarFire Soc Support
To:     Daire McNamara <daire.mcnamara@microchip.com>
Cc:     Atish Patra <Atish.Patra@wdc.com>,
        devicetree <devicetree@vger.kernel.org>,
        Conor.Dooley@microchip.com, Anup Patel <Anup.Patel@wdc.com>,
        Cyril.Jean@microchip.com, Bin Meng <bin.meng@windriver.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Ivan.Griffin@microchip.com,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 7:19 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Fri, 04 Dec 2020 00:58:30 PST (-0800), Atish Patra wrote:
> > This series adds minimal support for Microchip Polar Fire Soc Icicle kit.
> > It is rebased on v5.10-rc6 and depends on clock support.
> > Only MMC and ethernet drivers are enabled via this series.
> > The idea here is to add the foundational patches so that other drivers
> > can be added to on top of this. The device tree may change based on
> > feedback on bindings of individual driver support patches.
> >
> > This series has been tested on Qemu and Polar Fire Soc Icicle kit.
> > The following qemu series is necessary to test it on Qemu.
> >
> > The series can also be found at.
> > https://github.com/atishp04/linux/tree/polarfire_support_upstream_v3
> >
> > I noticed the latest version of mmc driver[2] hangs on the board with
> > the latest clock driver. That's why, I have tested with the old clock
> > driver available in the above github repo.
>
> IIRC the previous version was an RFC, but this is a PATCH.  I'd be generally
> happy to take it on for-next, but I don't want to merge something that doesn't
> boot and that I don't have any way to fix (I don't have one of the boards yet).
>

Fair enough. We can wait for clock patches to be merged before merging
this series.

> > [1] https://lists.nongnu.org/archive/html/qemu-devel/2020-10/msg08582.html
> > [2] https://www.spinics.net/lists/devicetree/msg383626.html
> >
> > Changes from v2->v3:
> > 1. Fixed a typo in dt binding.
> > 2. Included MAINTAINERS entry for PolarFire SoC.
> > 3. Improved the dts file by using lowercase clock names and keeping phy
> >    details in board specific dts file.
> >
> > Changes from v1->v2:
> > 1. Modified the DT to match the device tree in U-Boot.
> > 2. Added both eMMC & SDcard entries in DT. However, SD card is only enabled
> >    as it allows larger storage option for linux distros.
> >
> > Atish Patra (4):
> > RISC-V: Add Microchip PolarFire SoC kconfig option
> > dt-bindings: riscv: microchip: Add YAML documentation for the
> > PolarFire SoC
> > RISC-V: Initial DTS for Microchip ICICLE board
> > RISC-V: Enable Microchip PolarFire ICICLE SoC
> >
> > Conor Dooley (1):
> > MAINTAINERS: add microchip polarfire soc support
> >
> > .../devicetree/bindings/riscv/microchip.yaml  |  28 ++
> > MAINTAINERS                                   |   8 +
> > arch/riscv/Kconfig.socs                       |   7 +
> > arch/riscv/boot/dts/Makefile                  |   1 +
> > arch/riscv/boot/dts/microchip/Makefile        |   2 +
> > .../microchip/microchip-mpfs-icicle-kit.dts   |  72 ++++
> > .../boot/dts/microchip/microchip-mpfs.dtsi    | 331 ++++++++++++++++++
> > arch/riscv/configs/defconfig                  |   4 +
> > 8 files changed, 453 insertions(+)
> > create mode 100644 Documentation/devicetree/bindings/riscv/microchip.yaml
> > create mode 100644 arch/riscv/boot/dts/microchip/Makefile
> > create mode 100644 arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
> > create mode 100644 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

@Daire McNamara Do you have a v2 of the clock patch series that works
with the latest upstream.

-- 
Regards,
Atish
