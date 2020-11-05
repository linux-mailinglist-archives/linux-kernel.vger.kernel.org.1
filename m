Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCCBE2A74BA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 02:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388232AbgKEBNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 20:13:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:57418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731555AbgKEBNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 20:13:17 -0500
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37659206E3;
        Thu,  5 Nov 2020 01:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604538797;
        bh=nDs/XUZsMOA7BPJs2Yb+bGJS/RE8TFQlqr9c30H7QgY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=mDSC6pJuuMkxcuNLYmHVSiMcxoYc7n/BErsnoHwxRcyjD5Pl/NMgAmxeklzxw0x1d
         F4tcA3ra56Mbct8+U3XWdspRANgULxV3t5LdzPRH98qyLnMj82nEjNretYfJzy+I11
         IEW6gptBACyC5OLYs63EdTvP7YdRUC3YNM8SOPmM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1604229834-25594-1-git-send-email-peng.fan@nxp.com>
References: <1604229834-25594-1-git-send-email-peng.fan@nxp.com>
Subject: Re: [PATCH V3] clk: imx8m: fix bus critical clk registration
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
To:     abel.vesa@nxp.com, festevam@gmail.com, peng.fan@nxp.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Date:   Wed, 04 Nov 2020 17:13:15 -0800
Message-ID: <160453879574.3965362.14789600439446175918@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting peng.fan@nxp.com (2020-11-01 03:23:54)
> From: Peng Fan <peng.fan@nxp.com>
>=20
> noc/axi/ahb are bus clk, not peripheral clk.
> Since peripheral clk has a limitation that for peripheral clock slice,
> IP clock slices must be stopped to change the clock source.
>=20
> However if the bus clk is marked as critical clk peripheral, the
> assigned clock parent operation will fail.
>=20
> So we added CLK_SET_PARENT_GATE flag to avoid glitch.
>=20
> And add imx8m_clk_hw_composite_bus_critical for bus critical clock usage
>=20
> Fixes: 936c383673b9e ("clk: imx: fix composite peripheral flags")
> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
> Reported-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Applied to clk-fixes
