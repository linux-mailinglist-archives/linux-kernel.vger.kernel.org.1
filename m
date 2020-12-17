Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9FD2DCF57
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 11:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgLQKPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 05:15:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:47750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbgLQKPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 05:15:06 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608200065;
        bh=ozxZ6dxZmbFUVTMgivXPIwZxuBc4okdgQUn15Mxin2Q=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=BW7ao28soZBekex1gecvum8HLhayaBnoeFjBUpcIUrfXdz0hMOFdKRzkCHXEIsOOZ
         umcEjROyg/+BVIU6DaQFgMNB6RnATP0n9W/fQ4Jx8NBvZFF9wlNAOh+N8B3SOpDAxN
         BOPcBBPr4XLrSTzd4JG0/iRWNdv+KUyK24SIIRSA+Atbzkm4cxBdgRv/pM3Iy+FWc1
         KjVTvZFb/AgcDaXVMDxqcsRZn1ihupWrRVJVV0Cyc6dTGZPcliBnQ/sOJgm9tbqaQf
         zvBjk2rBSNl4c9miJPek6g2nsOcKM9C12q0Cjoli0CpgjhChAZnVufQ3ofmb5ssqrk
         r1sie8IyiNrkA==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201024154346.9589-1-pawel.mikolaj.chmiel@gmail.com>
References: <20201024154346.9589-1-pawel.mikolaj.chmiel@gmail.com>
Subject: Re: [PATCH] clk: exynos7: Mark aclk_fsys1_200 as critical
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     s.nawrocki@samsung.com, tomasz.figa@gmail.com,
        cw00.choi@samsung.com, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, pawel.mikolaj.chmiel@gmail.com
To:     pawel.mikolaj.chmiel@gmail.com, kgene@kernel.org, krzk@kernel.org,
        mturquette@baylibre.com
Date:   Thu, 17 Dec 2020 02:14:24 -0800
Message-ID: <160820006410.1580929.8444804722224099547@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure why this wasn't picked up in the samsung PR. Can you resend?

> diff --git a/drivers/clk/samsung/clk-exynos7.c b/drivers/clk/samsung/clk-=
exynos7.c
> index c1ff715e960c..1048d83f097b 100644
> --- a/drivers/clk/samsung/clk-exynos7.c
> +++ b/drivers/clk/samsung/clk-exynos7.c
> @@ -538,7 +538,8 @@ static const struct samsung_gate_clock top1_gate_clks=
[] __initconst =3D {
>                 ENABLE_ACLK_TOP13, 28, CLK_SET_RATE_PARENT |
>                 CLK_IS_CRITICAL, 0),
>         GATE(CLK_ACLK_FSYS1_200, "aclk_fsys1_200", "dout_aclk_fsys1_200",
> -               ENABLE_ACLK_TOP13, 24, CLK_SET_RATE_PARENT, 0),
> +               ENABLE_ACLK_TOP13, 24, CLK_SET_RATE_PARENT |
> +               CLK_IS_CRITICAL, 0),
> =20

Please put a comment in the code why a clk is critical.
