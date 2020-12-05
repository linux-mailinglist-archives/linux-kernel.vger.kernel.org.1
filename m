Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C752CF9CC
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 06:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgLEFl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 00:41:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:58654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbgLEFlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 00:41:55 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607146875;
        bh=BwVWvt9ye7Jk3XfjRUdb103S0m5tQzkQt0ncHbWSo3Q=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ZZDSHLrMV99D2VnkOq6BAZCUi9eWfOq6qeewSuFdWLQIy09cIhjlCJK1J8sij75EF
         T23oPGXfsMbkhfmMqNfMFVis3SkEb4NZWqfsmiMT21NGTluogV7gSks/KGiqYxTY+4
         NRnEqKYP51oKHWjrWxvQAL7MQIgE1dYWUc9QADSWN+4PKhoau2SC69vCl9cKVASuVq
         o3mCWOppBRsUM1V4njp2LTWWKGPZmFFdEQGOayI5sS5LItVmIbWz17xJNTS1gydXcx
         Bd653PV/YTbPWO5Rtd1/Qi0Ta7grsnu7/UGMFGR1GvGfpkhQpKW7xSvJc9lF4U6qH6
         FSYXznxTSVL0Q==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201203230756.1481397-1-arnd@kernel.org>
References: <20201203230756.1481397-1-arnd@kernel.org>
Subject: Re: [PATCH] clk: imx: fix build failure on i.MX SCU clk
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Anson Huang <Anson.Huang@nxp.com>, Arnd Bergmann <arnd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Date:   Fri, 04 Dec 2020 21:41:13 -0800
Message-ID: <160714687371.1580929.2544289342352742335@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arnd Bergmann (2020-12-03 15:07:52)
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> When CONFIG_MXC_CLK_SCU is enabled, but CONFIG_CLK_IMX8QXP is not,
> the kernel fails to link with:
>=20
> aarch64-linux-ld: no input files
> make[5]: *** [scripts/Makefile.build:434: drivers/clk/imx/clk-imx-scu.o] =
Error 1
> aarch64-linux-ld: no input files
> make[5]: *** [scripts/Makefile.build:434: drivers/clk/imx/clk-imx-lpcg-sc=
u.o] Error 1
>=20
> The only sensible configuration at the moment is to have both mean
> the same thing, so make hide the first one to avoid broken
> configurations.
>=20
> Fixes: e0d0d4d86c76 ("clk: imx8qxp: Support building i.MX8QXP clock drive=
r as module")
> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Dong sent something similar at
https://lore.kernel.org/r/20201130084624.21113-1-aisheng.dong@nxp.com
