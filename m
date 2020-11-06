Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8619B2A94B9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 11:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgKFKve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 05:51:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:36910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbgKFKvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 05:51:33 -0500
Received: from localhost (otava-0257.koleje.cuni.cz [78.128.181.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F19420724;
        Fri,  6 Nov 2020 10:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604659893;
        bh=VRH0OOsTmug4IluCYlUGvOuQXo2JVTTtYzsTQcMKftI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DR5GjgYnxgYfNUy4hxBJ+GkFu3TNlmpO0aaYPkTbPYlxY0rr4ihwrVMNDTN2Ds1lO
         zjmit0mzO3nbNkk60AsmHKvxMhMqtY8XeVPwSkNIvGUwHsgdzGJviJ1Y0rhDaJqAXQ
         KSHS80Rm+ob1CkN8BWqPmpBGJJSb7/AosGPxF6DQ=
Date:   Fri, 6 Nov 2020 11:51:18 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Terry Zhou <bjzhou@marvell.com>,
        Konstantin Porotchkin <kostap@marvell.com>
Subject: Re: [PATCH] clk: mvebu: a3700: fix the XTAL MODE pin to MPP1_9
Message-ID: <20201106115118.43eab492@kernel.org>
In-Reply-To: <20201106100039.11385-1-pali@kernel.org>
References: <20201106100039.11385-1-pali@kernel.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also, this is how A3720 WTMI code and ATF determines XTAL clock rate.
No reason for kernel to do it differently.

Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>

On Fri,  6 Nov 2020 11:00:39 +0100
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> From: Terry Zhou <bjzhou@marvell.com>
>=20
> There is an error in the current code that the XTAL MODE
> pin was set to NB MPP1_31 which should be NB MPP1_9.
> The latch register of NB MPP1_9 has different offset of 0x8.
>=20
> Signed-off-by: Terry Zhou <bjzhou@marvell.com>
> [pali: Fix pin name in commit message]
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> Fixes: 7ea8250406a6 ("clk: mvebu: Add the xtal clock for Armada 3700 SoC")
> Cc: stable@vger.kernel.org
>=20
> ---
> This patch is present in Marvell SDK and also in Marvell's kernel fork:
> https://github.com/MarvellEmbeddedProcessors/linux-marvell/commit/80d4cec=
4cef8282e5ac3aaf98ce3e68fb299a134
>=20
> Konstantin Porotchkin wrote on Github that Gregory Clement was notified
> about this patch, but as this patch is still not in mainline kernel I'm
> sending it again for review.
>=20
> In original commit message (only in commit message, not code) was
> specified MPP9 pin on South Bridge, but correct is North Bridge.
> ---
>  drivers/clk/mvebu/armada-37xx-xtal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/clk/mvebu/armada-37xx-xtal.c b/drivers/clk/mvebu/arm=
ada-37xx-xtal.c
> index e9e306d4e9af..41271351cf1f 100644
> --- a/drivers/clk/mvebu/armada-37xx-xtal.c
> +++ b/drivers/clk/mvebu/armada-37xx-xtal.c
> @@ -13,8 +13,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> =20
> -#define NB_GPIO1_LATCH	0xC
> -#define XTAL_MODE	    BIT(31)
> +#define NB_GPIO1_LATCH	0x8
> +#define XTAL_MODE	    BIT(9)
> =20
>  static int armada_3700_xtal_clock_probe(struct platform_device *pdev)
>  {

