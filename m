Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576452DCF8F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 11:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgLQKff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 05:35:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:54402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbgLQKfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 05:35:34 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608201294;
        bh=Q3aU7vUYIHArUOQwRTSWpDLIDm34aYBcv+dxJOR2E2Y=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=K4naa2Hpr9+7OdQ8Cg0RSkrixr4CdaUYf8nOhzteVVjTqgWAq/uz8pvEFVmIt9VuR
         fxe4aZtqk0G45DhwOIohfdlI8mECMSMCIgGVTLVbsG1OtNhl94vvbhHpJXz6IMdMvz
         s2P8dUeUHzxMKEUTpg7+7VEAEvD5Yjzr+7ZtZDRVWqvcrLEg3YWLL8cqjAwIKpITP5
         13lcPJTLiLn9/KAmdjgdbH5vhhvr8krdWJCPUM9OIUKRi9Q0dJ4ffh8C1CTBnl+wpx
         vG9kwBdJ0O3mtLK0zy2eTWXpLiJHU2ovnespUxIXaxfPP6RIteB3zRSDMdxZeE5bTg
         xSow81riVb12g==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1606887219-5854-1-git-send-email-victor.liu@nxp.com>
References: <1606887219-5854-1-git-send-email-victor.liu@nxp.com>
Subject: Re: [PATCH v2 0/4] Add some clocks support for i.MX8qxp DC0/MIPI-LVDS subsystems
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, robh+dt@kernel.org, aisheng.dong@nxp.com
To:     Liu Ying <victor.liu@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 17 Dec 2020 02:34:52 -0800
Message-ID: <160820129284.1580929.7280995076807082815@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Liu Ying (2020-12-01 21:33:35)
> This patch set adds some SCU clocks support for i.MX8qxp DC0/MIPI-LVDS
> subsystems.
>=20
> With this patch set, some basic clocks for i.MX8qxp LVDS displays can be =
got
> by drivers.
>=20
> v1->v2:
> * Drop LPCG clocks as they can be registered directly in an in-tree new
>   DT binding way.
> * Add DC0 bypass clocks support.
> * Correct the way to register DC0 display clocks.
> * Trivial tweak.

Looks OK to me. I assume Shawn will pick them up.

>=20
> Liu Ying (4):
>   clk: imx: clk-imx8qxp: Add SCU clocks support for DC0 PLL clocks
>   clk: imx: clk-imx8qxp: Add SCU clocks support for DC0 bypass clocks
>   clk: imx: clk-imx8qxp: Register DC0 display clocks with imx_clk_scu2()
>   clk: imx: clk-imx8qxp: Add some SCU clocks support for MIPI-LVDS
>     subsystems
>=20
>  drivers/clk/imx/clk-imx8qxp.c          | 26 ++++++++++++++++++++++++--
>  include/dt-bindings/clock/imx8-clock.h |  2 ++
>  2 files changed, 26 insertions(+), 2 deletions(-)
>=20
> --=20
> 2.7.4
>
