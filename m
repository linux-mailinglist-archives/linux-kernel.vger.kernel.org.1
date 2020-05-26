Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F051D3E1D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 21:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgENT5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 15:57:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbgENT5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 15:57:02 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36C582065C;
        Thu, 14 May 2020 19:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589486222;
        bh=C/+YxVONmo+tUkptpggjBFrGTVjyBlH6x7GRA78NA0g=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=N5ZAkhS5i5T86+/L2ju96XLl79Zr6Fr/am7EqOrJUuL97fVAixFEjDMwxzyJEhFAd
         5rVOTCFibTVVMyRqulXjWmFaOtHvPM0QdSE4t97qm2+aolAHfTUO+xGEoGNLwI3Sjq
         n7BPaLTaWmWqVtqi69w6RJpnt0oTROWQaE9nztpU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200409064416.83340-7-sboyd@kernel.org>
References: <20200409064416.83340-1-sboyd@kernel.org> <20200409064416.83340-7-sboyd@kernel.org>
Subject: Re: [PATCH v2 06/10] mmc: meson-mx-sdio: Depend on OF_ADDRESS and not just OF
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        kbuild test robot <lkp@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Thu, 14 May 2020 12:57:01 -0700
Message-ID: <158948622160.215346.5960875378129873700@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-04-08 23:44:12)
> Making COMMON_CLK a visible option causes the sparc allyesconfig to fail
> to build like so:
>=20
>    sparc64-linux-ld: drivers/mmc/host/meson-mx-sdio.o: in function `meson=
_mx_mmc_remove':
>    meson-mx-sdio.c:(.text+0x70): undefined reference to `of_platform_devi=
ce_destroy'
>    sparc64-linux-ld: drivers/mmc/host/meson-mx-sdio.o: in function `meson=
_mx_mmc_probe':
>    meson-mx-sdio.c:(.text+0x9e4): undefined reference to `of_platform_dev=
ice_create'
>    sparc64-linux-ld: meson-mx-sdio.c:(.text+0xdd4): undefined reference t=
o `of_platform_device_destroy'
>=20
> This is because the implementation of of_platform_device_destroy() is
> inside an #ifdef CONFIG_OF_ADDRESS section of drivers/of/platform.c.
> This driver already depends on OF being enabled, so let's tighten that
> constrain a little more so that it depends on OF_ADDRESS instead. This
> way we won't try to build this driver on platforms that don't have this
> function.
>=20
> Reported-by: kbuild test robot <lkp@intel.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next
