Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A12274969
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 21:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgIVTpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 15:45:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbgIVTpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 15:45:11 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99BE5238A1;
        Tue, 22 Sep 2020 19:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600803910;
        bh=tA8MmDdsznvvUpaNUlFhuy1kR5m9EsbeClJ1SsYWScE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=d8H1E695Gu/6np9d7kKWOPnK7Y+psySwubSEINTKXUvlljyh6CnmFSzY/ArkW2xPH
         k4yn7N9P8d9OItRJNEvoR13HOXURJeH7XO7KS3I868o4jCIgs5NbzOMWNKX1Ma1DBs
         tJ1+uYCldJfZgd1jRepZwlOGXpaIfi1gA/ncGrno=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200916161740.14173-4-krzk@kernel.org>
References: <20200916161740.14173-1-krzk@kernel.org> <20200916161740.14173-4-krzk@kernel.org>
Subject: Re: [PATCH 4/6] clk: mmp: pxa1928: drop unused 'clk' variable
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
Date:   Tue, 22 Sep 2020 12:45:09 -0700
Message-ID: <160080390943.310579.10285589771843324355@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2020-09-16 09:17:38)
> 'clk' is assigned but never read:
>=20
>   drivers/clk/mmp/clk-of-pxa1928.c: In function =E2=80=98pxa1928_pll_init=
=E2=80=99:
>   drivers/clk/mmp/clk-of-pxa1928.c:71:14: warning: variable =E2=80=98clk=
=E2=80=99 set but not used [-Wunused-but-set-variable]
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Applied to clk-next
