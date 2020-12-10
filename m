Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A332D58ED
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 12:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733060AbgLJLHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 06:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730172AbgLJLHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 06:07:18 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD637C0613CF;
        Thu, 10 Dec 2020 03:06:37 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id a16so4333721ybh.5;
        Thu, 10 Dec 2020 03:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ETGSMY6awNXPXPJo5cOg9EbQ8Jdr01cRs6yp25MZwq4=;
        b=CEUoIrXzXOfWzXkhrhgG4vM6yIbY5CUSJlpFuQhAg5ptSMGwa1BQYNQ+ZRmvrcddpl
         A5aBXDOuu4LVlk2ZPoiJJHBKvULxZf3hwBz6Cgbm+y/E6ZbvrmNG69esnTt78RoX9wcr
         xr3EHyggFRodZCQbnudjL71WPq0w7OjadyqUPpwN0Z9hI1DExi6twGG1CrhEFAOUA7zR
         gFZY0mbcXV9UcCBv42CmbMPD86CqVVDLqC6M1JRX5NmCeigwekfkvbxCutl6xa2XdqP0
         MG5J5KWGgiq70KU7nB5tBoocydlp1lZtw5trZDzaxybp/BL08jqn+S4hQ7MmbdYvY8zB
         JhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ETGSMY6awNXPXPJo5cOg9EbQ8Jdr01cRs6yp25MZwq4=;
        b=kWttCNktsyOY1eFaIL/W+YBGydxuI/P1DrpYyGuDK2054QYyc7i/uAUD9y+67HssKB
         DC/L/Dr/myEOjnHxLINxjPEdEj4WqGTEKYDdqvOdE0l1kDmOyHoN+UrBLtmw/DWdnP7R
         m2oSnJCgMz+fskyojo6RVjohn69tBd+rQpOMS0sGSVqa6mDAoKlkSkYBi9BZqceuQ0l/
         5qRe9u22NEZxhznx1CiNgTfooTHEsLoyI6GYsPV1yUnXyWuAaICoAZF2U0gcPxVsjA6Q
         /IaK3nmF/x8d0XJkNiBzufqMGTRYsztlGXhxw1bQvRUpSLYH58HzxbJUaaT1BpoTwWvY
         uRUA==
X-Gm-Message-State: AOAM533v7MJY5ZmcjrFGMgmKIi59MO0Qax1z7O78DMp4pJTL74vnyirS
        QpHorOAWJGUyM6DCiBu97rXnOquZMyjALAmVSQELN9R0
X-Google-Smtp-Source: ABdhPJyUHpmghvFm6Cre6IHt0eY0oQI7lbjRspYTn+O1XN7rgEwvLPWvYc1jGSRyf2hoesxTlyH4AVRtUf7f/f1rej0=
X-Received: by 2002:a25:690b:: with SMTP id e11mr9980504ybc.314.1607598397208;
 Thu, 10 Dec 2020 03:06:37 -0800 (PST)
MIME-Version: 1.0
References: <20201204085835.2406541-1-atish.patra@wdc.com> <20201204085835.2406541-4-atish.patra@wdc.com>
In-Reply-To: <20201204085835.2406541-4-atish.patra@wdc.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Thu, 10 Dec 2020 19:06:12 +0800
Message-ID: <CAEUhbmU4hrVRGs30oE=GK42NUwpgOtnDXWRcE76xdxmC-z25qA@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] RISC-V: Initial DTS for Microchip ICICLE board
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        Bin Meng <bin.meng@windriver.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>, Ivan.Griffin@microchip.com,
        Cyril.Jean@microchip.com,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor.Dooley@microchip.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 4, 2020 at 5:05 PM Atish Patra <atish.patra@wdc.com> wrote:
>
> Add initial DTS for Microchip ICICLE board having only
> essential devices (clocks, sdhci, ethernet, serial, etc).
> The device tree is based on the U-Boot patch.
>
> https://patchwork.ozlabs.org/project/uboot/patch/20201110103414.10142-6-padmarao.begari@microchip.com/

There is a newer version of U-Boot patch. Probably needs to sync again.

>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/boot/dts/Makefile                  |   1 +
>  arch/riscv/boot/dts/microchip/Makefile        |   2 +
>  .../microchip/microchip-mpfs-icicle-kit.dts   |  72 ++++
>  .../boot/dts/microchip/microchip-mpfs.dtsi    | 331 ++++++++++++++++++
>  4 files changed, 406 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/microchip/Makefile
>  create mode 100644 arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
>  create mode 100644 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
>

Regards,
Bin
