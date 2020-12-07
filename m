Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A942D1CAC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgLGWDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:03:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:49984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbgLGWDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:03:06 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607378545;
        bh=wNTk0gEVGVMlU4rzzTg6vknJYhnzgpdkDAJ6+uYsIPs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=YbDhmbVsWFdrfYzCvILqGonxrMBaAVB/sSqWD8TzYjs/QCDKs4UF1ce6mntEgEaSL
         hRFFC4v5g8Co06UTTDvYX5W9+wh4WSvA0BcmZq3BDs6WoHafnkcEEltzQq2Uu04AhB
         lZUFQYiTwwUfWrg2TqfpehTaE8+93mSJNc7hTIQkZabmaQEfXrJ0Xopzsv3JIuTHIz
         BExQ7R36sm1d8If6FvsgkNfZUZNhMdnQeUY5BLk7f61DMLFLIadYJ7Ki1sl5xK9dD7
         JSnETkJNZb2UnYW0KUyWkY1uPT662N2elWKNKPENzlOQq1OML7NunJPvUVGIjHI+gu
         kRY8A9LAAlccw==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201110154750.3285411-1-geert+renesas@glider.be>
References: <20201110154750.3285411-1-geert+renesas@glider.be>
Subject: Re: [PATCH v2] clk: qoriq: Add platform dependencies
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Mon, 07 Dec 2020 14:02:23 -0800
Message-ID: <160737854354.1580929.10822609640978673509@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Geert Uytterhoeven (2020-11-10 07:47:50)
> The Freescale QorIQ clock controller is only present on Freescale E500MC
> and Layerscape SoCs.  Add platform dependencies to the CLK_QORIQ config
> symbol, to avoid asking the user about it when configuring a kernel
> without E500MC or Layerscape support.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Li Yang <leoyang.li@nxp.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next
