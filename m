Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A476F2DF3DF
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 06:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgLTFbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 00:31:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:41252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbgLTFbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 00:31:10 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608442230;
        bh=Qdp7EFwkVoAyU8h9N+P7QV/Zm+mzSlLdhJZueQ/2kCc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=sN5VYnuFYQUKtsSck81JTIJ0Q+DmZr9EJ9WoDQ/TCXhktxDUGF2a0BpekviXPmfQX
         nZ1fP4BiU7+DOrRfhd4bowztoqdt4faaE3TD6skhMuJv1LhDwA7IJ0nnigA9cOFxGu
         Y2IdIkzwV0CN8IhhCWLthxxE9sYXyZYB4GUbiA3IANHR8kKcvVe13FI1HkZOZdcZJt
         euwikrbgMa15eokDlvOZH1QuYXGsrLhHB3Gg9z8SqARK5HaJFKJm3I+GNrukQEMsDj
         uA4GWfUfzaWHJLVRFlwgqwX2A2Z6J0Whwz9DVZO48IGpPA0ZywNCCwyFct1yaZTA5w
         E8OQ2FhSh9vJQ==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <160842266128.1580929.15786525540819499647@swboyd.mtv.corp.google.com>
References: <20201202123446.21902-1-info@metux.net> <160842266128.1580929.15786525540819499647@swboyd.mtv.corp.google.com>
Subject: Re: [PATCH v3] drivers: clk: make gpio-gated clock support optional
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, matthias.bgg@gmail.com,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Date:   Sat, 19 Dec 2020 21:30:28 -0800
Message-ID: <160844222880.1580929.12780984836660049815@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-12-19 16:04:21)
> Quoting Enrico Weigelt, metux IT consult (2020-12-02 04:34:46)
> > The gpio-gate-clock / gpio-mux-clock driver isn't used much,
> > just by a few ARM SoCs, so there's no need to always include
> > it unconditionally.
> >=20
> > Thus make it optional, but keep it enabled by default.
> >=20
> > changes v3: default to y when gpiolib enabled
> >             fix depends on gpiolib to uppercase
> >=20
> > changes v2: added missing dependency on gpiolib
> >=20
> > Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> > ---
>=20
> Applied to clk-next

And now reverted

In file included from include/linux/device.h:32:0,
                 from drivers/clk/clk-gpio.c:17:
include/linux/device/driver.h:290:1: warning: data definition has no type o=
r storage class
 device_initcall(__driver##_init);
 ^
include/linux/platform_device.h:258:2: note: in expansion of macro 'builtin=
_driver'
  builtin_driver(__platform_driver, platform_driver_register)
  ^~~~~~~~~~~~~~
drivers/clk/clk-gpio.c:249:1: note: in expansion of macro 'builtin_platform=
_driver'
 builtin_platform_driver(gpio_clk_driver);
 ^~~~~~~~~~~~~~~~~~~~~~~
include/linux/device/driver.h:290:1: error: type defaults to 'int' in decla=
ration of 'device_initcall' [-Werror=3Dimplicit-int]
 device_initcall(__driver##_init);
 ^
include/linux/platform_device.h:258:2: note: in expansion of macro 'builtin=
_driver'
  builtin_driver(__platform_driver, platform_driver_register)
  ^~~~~~~~~~~~~~
drivers/clk/clk-gpio.c:249:1: note: in expansion of macro 'builtin_platform=
_driver'
 builtin_platform_driver(gpio_clk_driver);
 ^~~~~~~~~~~~~~~~~~~~~~~
drivers/clk/clk-gpio.c:249:1: warning: parameter names (without types) in f=
unction declaration
In file included from include/linux/device.h:32:0,
                 from drivers/clk/clk-gpio.c:17:
drivers/clk/clk-gpio.c:249:25: warning: 'gpio_clk_driver_init' defined but =
not used [-Wunused-function]
 builtin_platform_driver(gpio_clk_driver);
                         ^
include/linux/device/driver.h:286:19: note: in definition of macro 'builtin=
_driver'
 static int __init __driver##_init(void) \
                   ^~~~~~~~
drivers/clk/clk-gpio.c:249:1: note: in expansion of macro 'builtin_platform=
_driver'
 builtin_platform_driver(gpio_clk_driver);
 ^~~~~~~~~~~~~~~~~~~~~~~

It looks like it needs to be a bool Kconfig to match how it used to be.
A module would be interesting, but would require more changes
presumably, like getting rid of builtin_platform_driver() and replacing
it with module_platform_driver().
