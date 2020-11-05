Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93C82A75BD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 03:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388424AbgKECq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 21:46:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:57466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729344AbgKECq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 21:46:58 -0500
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBCD3207BB;
        Thu,  5 Nov 2020 02:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604544417;
        bh=latL1K3uBvpZ46MD7GD39fenbWIQylUyOF7tssY/na8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=j7k7a3BCXdmFXHRjEkR+nUanUPG7bBo8AypRT5JyDONuCrMXCS19mzAnkj9RB1PBC
         P4eXA7A7niOzVfeozB1wQpzCz6Lon0EUbNuzCZ/a5MNa1N0rDYxR5e713uuVc9By2d
         GY98O/1xDeBXuh6zPDsVIG7SS9N6NG8Q7IWhJa/4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <691e24d1c45a4b56b57ce1e02a04268c4253a77d.1602838910.git.zong.li@sifive.com>
References: <cover.1602838910.git.zong.li@sifive.com> <691e24d1c45a4b56b57ce1e02a04268c4253a77d.1602838910.git.zong.li@sifive.com>
Subject: Re: [PATCH 2/4] clk: sifive: Use common name for prci configuration
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Zong Li <zong.li@sifive.com>
To:     Zong Li <zong.li@sifive.com>, aou@eecs.berkeley.edu,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com, yash.shah@sifive.com
Date:   Wed, 04 Nov 2020 18:46:56 -0800
Message-ID: <160454441626.3965362.17922436443029310228@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Zong Li (2020-10-16 02:18:24)
> Use generic name CLK_SIFIVE_PRCI instead of CLK_SIFIVE_FU540_PRCI. This
> patch is prepared for fu740 support.
>=20
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---

Looks ok but needs an ack from riscv maintainers to go through clk
tree. I was worried it would break defconfigs but it seems that the arch
selects the config so this should be OK, right?

>  arch/riscv/Kconfig.socs     | 2 +-
>  drivers/clk/sifive/Kconfig  | 6 +++---
>  drivers/clk/sifive/Makefile | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 8a55f6156661..3284d5c291be 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -5,7 +5,7 @@ config SOC_SIFIVE
>         select SERIAL_SIFIVE if TTY
>         select SERIAL_SIFIVE_CONSOLE if TTY
>         select CLK_SIFIVE
> -       select CLK_SIFIVE_FU540_PRCI
> +       select CLK_SIFIVE_PRCI
>         select SIFIVE_PLIC
>         help
>           This enables support for SiFive SoC platform hardware.
