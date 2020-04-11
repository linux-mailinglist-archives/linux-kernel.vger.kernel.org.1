Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4E81A4D81
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Apr 2020 04:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgDKC11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 22:27:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbgDKC11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 22:27:27 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 004E0206A1;
        Sat, 11 Apr 2020 02:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586572047;
        bh=HUi2hrUBSigypj7OLb4O+ntBuDmB4tsP4LR2Q8kzRy8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=p74Y9fw4spXP8pf4T5VF32/bLgWuuZPiqXJ+qwE6TdU3spWHWZoocPJZCScu098NO
         mdzxubA+o7uu/V75cIWSMbkFN8o6UIgFacDnbNELRUcunPHJiZoPFA9aV7E7Z/fX0x
         osRc40ASzj49v7Fz/0J96Bm8nLJO7F0FQJIkLfNs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAAfSe-s=dZe=6y7UH8CBcddL1BKoLOAvi24RekgdmVv0StxTTA@mail.gmail.com>
References: <20200408160044.2550437-1-arnd@arndb.de> <CABOV4+UocLs3jLi7-vTi8muiFqACVdxH7Td8=U1ABveLnmyCuw@mail.gmail.com> <CA+nhYX0H-czfJ6Kg+FK7X2=hHQK185UOLGoPdEP3nqWQWcA+bg@mail.gmail.com> <CAAfSe-s=dZe=6y7UH8CBcddL1BKoLOAvi24RekgdmVv0StxTTA@mail.gmail.com>
Subject: Re: [PATCH] [RFC] clk: sprd: fix compile-testing
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Orson Zhai <orson.zhai@unisoc.com>,
        Android Kernel Team <kernel-team@android.com>
To:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Sandeep Patil <sspatil@android.com>
Date:   Fri, 10 Apr 2020 19:27:26 -0700
Message-ID: <158657204622.199533.16589832598336244320@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chunyan Zhang (2020-04-09 20:45:16)
> We see this broken because I shouldn't leave clk Makefile a tristate
> compile [1] after changing ARCH_SPRD to be tristate.
>=20
> If we will make ARCH_SPRD tristate-able in the future and you all
> aggree that, I would like to do it now, and pay more attention to
> Makefiles and dependencies.
>=20
> I can also make a change like below:
>=20
> diff --git a/drivers/clk/sprd/Kconfig b/drivers/clk/sprd/Kconfig
> index e18c80fbe804..9f7d9d8899a5 100644
> --- a/drivers/clk/sprd/Kconfig
> +++ b/drivers/clk/sprd/Kconfig
> @@ -2,6 +2,7 @@
>  config SPRD_COMMON_CLK
>         tristate "Clock support for Spreadtrum SoCs"
>         depends on ARCH_SPRD || COMPILE_TEST
> +       depends on m || ARCH_SPRD !=3D m
>         default ARCH_SPRD
>         select REGMAP_MMIO
>=20
> Arnd, Stephen, Sandeep, what do you think? Does that make sense?

Sorry, doesn't make any sense to me. The ARCH_FOO configs for various
platforms are intended to be used to limit the configuration space of
various other Kconfig symbols for the code that only matters to those
platforms. The usage of depends and default is correct here already. The
ARCH_FOO configs should always be bool. Any code bloat problems seen by
config symbols enabling because they're 'default ARCH_FOO' can be
resolved by explicitly disabling those configs.
