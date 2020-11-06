Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E922A901B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 08:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgKFHOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 02:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgKFHOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 02:14:39 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00A2C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 23:14:37 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id g12so241544pgm.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 23:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=fq6B0QhUEt1eA8lH21dyI7mYJ3laRtZGR038F2jnq/k=;
        b=WUBH7LVinnQuGGBP47rJTYuOxdnAP7M8/rEGoe1S74EUauDWWggaKdYnMStOfE2vhk
         D5cPj4rH8coj/d+gqSHfg9YvUDkvpGxb7f0dSs0+6gjbJ5HWCN28MinH22Tkzjb6M8Ck
         sdIcnQGGmUpyDiZVAWMvJKapQlQx/pdiIgXNg8lVrhBJog4/liUlhgIPC7zaaiBj/NRx
         ACuifBa7TTm+g5nC9xGhEGJMsVIWMeyoBAP+sFOW4b8/1wnM/A9L2nEFeccet+I5TdzN
         8I0scs4bs9JDRP5UcdXW90jsM9RKw46Fo09khAn4RwNfOaIDaE+V8CvrIyE4S8YSX/qG
         LAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=fq6B0QhUEt1eA8lH21dyI7mYJ3laRtZGR038F2jnq/k=;
        b=YE0VkOQ076SunGM1vHzu39RjCWcwpAFyblnyebXKh5T1OWxesxNZHo4DosI5+QJCuy
         jgx4OH477kF/d9vH9yoLYS/FjlQkzIvAf7lFh7MojCdunvPLvYVC30/RwGO0GGdotxLj
         PoN+4TdM9UWjqdAkdQA6OnhpI7G3Q8TxkDD9lo7ez2bfBcK5vdgICSln2iBNv/5qxFgp
         WxRMfZkMmZVumYd9psMc7RH3C7hFfno0b3JHUDo97EVoo+vH4X+BAenQMdZWQ9DJ5j+O
         pi41bStR9XSieaHvsQI/vVrh7808c3pbXEy8Ybg4DHdGRCOq2tdhoKHzICfRFFyCtfDS
         NOPA==
X-Gm-Message-State: AOAM530w7k/uQAG61VWsj8tGsqBPzgzU5R/Lp364ARs7OppRx9h7uVWm
        EvLinhzrqTkwgr/fFYHM2Y9OVr83x0+irz2u
X-Google-Smtp-Source: ABdhPJzaXMxSt2eJmDQy9mNYgo4KQIbRfUfUgL7wVlPY7dfZiDFRssY3KbzHva6WyWPup1n8fBfnLA==
X-Received: by 2002:a17:90a:e643:: with SMTP id ep3mr1016533pjb.211.1604646877045;
        Thu, 05 Nov 2020 23:14:37 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 26sm601171pgm.92.2020.11.05.23.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 23:14:36 -0800 (PST)
Date:   Thu, 05 Nov 2020 23:14:36 -0800 (PST)
X-Google-Original-Date: Thu, 05 Nov 2020 23:14:23 PST (-0800)
Subject:     Re: [RFC PATCH 0/3] Add Microchip PolarFire Soc Support 
In-Reply-To: <20201028232759.1928479-1-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        aou@eecs.berkeley.edu, Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, robh+dt@kernel.org,
        padmarao.begari@microchip.com, daire.mcnamara@microchip.com,
        Cyril.Jean@microchip.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-3a4619db-fe42-4ae0-a521-4032f23591ee@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Oct 2020 16:27:56 PDT (-0700), Atish Patra wrote:
> This series adds minimal support for Microchip Polar Fire Soc Icicle kit.
> It is rebased on v5.10-rc1 and depends on clock support.
> Only MMC and ethernet drivers are enabled via this series.
> The idea here is to add the foundational patches so that other drivers
> can be added to on top of this.
>
> This series has been tested on Qemu and Polar Fire Soc Icicle kit.
> The following qemu series is necessary to test it on Qemu.
>
> The series can also be found at the following github repo.
>
> I noticed the latest version of mmc driver[2] hangs on the board with
> the latest clock driver. That's why, I have tested with the old clock
> driver available in the above github repo.

OK, I guess that's why it's an RFC?

> [1] https://lists.nongnu.org/archive/html/qemu-devel/2020-10/msg08582.html
> [2] https://www.spinics.net/lists/devicetree/msg383626.html

Looks like this one hasn't been merged yet.  IDK if something is broken with my
mail client but I'm not seeing any github repos.  If this depends on
not-yet-merged drivers then it's certainly RFC material, but aside from the DT
stuff (which should be straight-forward) it seems fine to me.

Since you posted this an an RFC I'm going to assume you're going to re-spin it.

Thanks!

>
> Atish Patra (3):
> RISC-V: Add Microchip PolarFire SoC kconfig option
> RISC-V: Initial DTS for Microchip ICICLE board
> RISC-V: Enable Microchip PolarFire ICICLE SoC
>
> arch/riscv/Kconfig.socs                       |   7 +
> arch/riscv/boot/dts/Makefile                  |   1 +
> arch/riscv/boot/dts/microchip/Makefile        |   2 +
> .../microchip/microchip-icicle-kit-a000.dts   | 313 ++++++++++++++++++
> arch/riscv/configs/defconfig                  |   4 +
> 5 files changed, 327 insertions(+)
> create mode 100644 arch/riscv/boot/dts/microchip/Makefile
> create mode 100644 arch/riscv/boot/dts/microchip/microchip-icicle-kit-a000.dts
