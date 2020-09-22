Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55115274965
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 21:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgIVToz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 15:44:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbgIVToz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 15:44:55 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96164221E8;
        Tue, 22 Sep 2020 19:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600803894;
        bh=eCsbf88+3hbsuxXMVeMDVUwgMkMeeFKQ3z+JXhLEwVE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Rm2gLHq9kTle5/dASc8C/0PKaf1LhGUKhvcDrN2UcXhp3wz9bFTuFVHfClyFwxQAf
         GANFc6EDVHY9Zpav0o2/tDjIyZ5gY0ujKpz7i1eF5bIbkNrzFlfBcFeqN9tJz7vF8e
         /INB+FP0R3ab+YrdnZDPvb6xR7j4QRQRx6EJUSak=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200916161740.14173-2-krzk@kernel.org>
References: <20200916161740.14173-1-krzk@kernel.org> <20200916161740.14173-2-krzk@kernel.org>
Subject: Re: [PATCH 2/6] clk: fixed: add missing kerneldoc
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        David Lechner <david@lechnology.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sekhar Nori <nsekhar@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Date:   Tue, 22 Sep 2020 12:44:53 -0700
Message-ID: <160080389349.310579.18222721785105717802@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2020-09-16 09:17:36)
> Add missing kerneldoc to fix compile warnings like:
>=20
>   drivers/clk/clk-fixed-factor.c:211: warning: Function parameter or memb=
er 'node' not described in 'of_fixed_factor_clk_setup'
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Applied to clk-next
