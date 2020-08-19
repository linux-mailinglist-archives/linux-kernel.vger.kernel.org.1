Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2278249343
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 05:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgHSDJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 23:09:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgHSDJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 23:09:29 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 303882065F;
        Wed, 19 Aug 2020 03:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597806569;
        bh=dIhySR/k16t4QbeFvM/+iC6A7uHOWR3lLBzVgDQjDZo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=WwY7F0fl7pTCdmoGsECtz6g6g8C4zUsn9TErj5VE0Z0kHKD/GY29uuajrxTI7eyPF
         A/g0FtPPoAnT5R/UXDTHyZOsi2EZusDDZF/ftysxcucvXRb2SxhbbCXlQpYr0K/VRh
         eSz2rXNbJPfSWqttwkOZAY+0qMYLqZo66q1dSUi4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200810044020.2063350-1-natechancellor@gmail.com>
References: <20200810044020.2063350-1-natechancellor@gmail.com>
Subject: Re: [PATCH] clk: rockchip: Fix initialization of mux_pll_src_4plls_p
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Date:   Tue, 18 Aug 2020 20:09:28 -0700
Message-ID: <159780656806.334488.9415034364202507585@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nathan Chancellor (2020-08-09 21:40:20)
> A new warning in Clang points out that the initialization of
> mux_pll_src_4plls_p appears incorrect:
>=20
> ../drivers/clk/rockchip/clk-rk3228.c:140:58: warning: suspicious
> concatenation of string literals in an array initialization; did you
> mean to separate the elements with a comma? [-Wstring-concatenation]
> PNAME(mux_pll_src_4plls_p)      =3D { "cpll", "gpll", "hdmiphy" "usb480m"=
 };
>                                                               ^
>                                                              ,
> ../drivers/clk/rockchip/clk-rk3228.c:140:48: note: place parentheses
> around the string literal to silence warning
> PNAME(mux_pll_src_4plls_p)      =3D { "cpll", "gpll", "hdmiphy" "usb480m"=
 };
>                                                     ^
> 1 warning generated.
>=20
> Given the name of the variable and the same variable name in rv1108, it
> seems that this should have been four distinct elements. Fix it up by
> adding the comma as suggested.
>=20
> Fixes: 307a2e9ac524 ("clk: rockchip: add clock controller for rk3228")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1123
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---

Applied to clk-fixes
