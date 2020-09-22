Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E33274963
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 21:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgIVTot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 15:44:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726629AbgIVTot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 15:44:49 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33CE22158C;
        Tue, 22 Sep 2020 19:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600803889;
        bh=xs7bv/Pd+JV3TnTXUPub1y7MuEAXK2Fb6r/sDD3vBR8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=kfN5EJLuhxYmsZBcUfgCjCiKyYLjYzAj7x45+3VIuggVzJ+CeO8+GLQrRgetxqRZU
         mrGA7G5Ygs/Mqh8S/MAmSWu2+wMmHGYCnZya580aVAGIrL7fGTHsFs+fmY08eTQ3V/
         3iG8D93mao1OxuVLdbHo/uTnKzZQLWpv8psOI+x8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200916161740.14173-1-krzk@kernel.org>
References: <20200916161740.14173-1-krzk@kernel.org>
Subject: Re: [PATCH 1/6] clk: at91: drop unused at91sam9g45_pcr_layout
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
Date:   Tue, 22 Sep 2020 12:44:47 -0700
Message-ID: <160080388798.310579.16399250820022000410@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2020-09-16 09:17:35)
> The at91sam9g45_pcr_layout is not used so drop it to fix build warning:
>=20
>   drivers/clk/at91/at91sam9g45.c:49:36: warning:
>     'at91sam9g45_pcr_layout' defined but not used [-Wunused-const-variabl=
e=3D]
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Applied to clk-next
