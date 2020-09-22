Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F3F27496B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 21:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgIVTpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 15:45:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbgIVTpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 15:45:18 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE7892388B;
        Tue, 22 Sep 2020 19:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600803917;
        bh=smD2MG6rYBVA2ltBaZSXAPGB6fl0emwyxpPbDSkm+iE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Hc0HocffpZ4wcZpsf6IDMWNHDZtUl9filj/ZFa3dbv1yUsnW1NYZdRSc2rhkNwXwR
         YYyiR7UytWe+PCdEc4s3HjMr+Ag8US0XPZYXkeSCbY7zXfii9yYSOS0V+BVKf0Vejn
         l0WoEjH+Ilwsh4jVkHOPbowYqSDXimdf2I1nO9v0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200916161740.14173-5-krzk@kernel.org>
References: <20200916161740.14173-1-krzk@kernel.org> <20200916161740.14173-5-krzk@kernel.org>
Subject: Re: [PATCH 5/6] clk: si5341: drop unused 'err' variable
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
Date:   Tue, 22 Sep 2020 12:45:16 -0700
Message-ID: <160080391652.310579.3763272722855831158@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2020-09-16 09:17:39)
> 'err' is assigned but never read:
>=20
>   /drivers/clk/clk-si5341.c: In function =E2=80=98si5341_output_get_paren=
t=E2=80=99:
>   drivers/clk/clk-si5341.c:886:6: warning: variable =E2=80=98err=E2=80=99=
 set but not used [-Wunused-but-set-variable]
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Applied to clk-next
