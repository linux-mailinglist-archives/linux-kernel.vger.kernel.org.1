Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69816294084
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 18:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394646AbgJTQ3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 12:29:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394635AbgJTQ3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 12:29:34 -0400
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E51502224A;
        Tue, 20 Oct 2020 16:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603211374;
        bh=OHP1tMqID19X7UU9IUun0CuON3T03c1VaM82iG1v6ks=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=jcrXKFOGOmUOHMZ5KcKqJldWFUQ3eQ6cHe63k4F1hi5gWi89wYWhb9evrmCYxKUQu
         QujQ00VopIUqTySava2bnlsuRV21RDptzC1/AwREiauWe201DjQdqDhTN5zmwkh/Jd
         Bqq/7WBzjleGJKXCZOibdrRWaMXUWUp8XA4qCQFg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1602753944-30757-1-git-send-email-abel.vesa@nxp.com>
References: <1602753944-30757-1-git-send-email-abel.vesa@nxp.com>
Subject: Re: [PATCH] clk: imx8mq: Fix usdhc parents order
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Mike Turquette <mturquette@baylibre.com>,
        Peng Fan <peng.fan@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Date:   Tue, 20 Oct 2020 09:29:32 -0700
Message-ID: <160321137259.884498.8601611844123685455@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2020-10-15 02:25:44)
> According to the latest RM (see Table 5-1. Clock Root Table),
> both usdhc root clocks have the parent order as follows:
>=20
> 000 - 25M_REF_CLK
> 001 - SYSTEM_PLL1_DIV2
> 010 - SYSTEM_PLL1_CLK
> 011 - SYSTEM_PLL2_DIV2
> 100 - SYSTEM_PLL3_CLK
> 101 - SYSTEM_PLL1_DIV3
> 110 - AUDIO_PLL2_CLK
> 111 - SYSTEM_PLL1_DIV8
>=20
> So the audio_pll2_out and sys3_pll_out have to be swapped.
>=20
> Fixes: b80522040cd3 ("clk: imx: Add clock driver for i.MX8MQ CCM")
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Reported-by: Cosmin Stefan Stoica <cosmin.stoica@nxp.com>
> ---

Applied to clk-next
