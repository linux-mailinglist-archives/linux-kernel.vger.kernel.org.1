Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130F82DF165
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 20:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbgLSTyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 14:54:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:42178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727427AbgLSTx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 14:53:59 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608407598;
        bh=lXCGxiM/qJDKfqji1XsPLsDPRrxzfe8IUiSd0E578sw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Hlv+M+4ah132W755ydBX8YHs8P5MAEF9lp9QMGzRFe74Hlxp3T54SCj/DOHyhyL4l
         5U57hWzfPI+Xdenynoh9z0/ez0Z56DgzOpDXdI0oiMFtk0m3NamcVwYhV/PwQYVPCF
         r5OEGM0ZKDeNgirX4FJ8GVIUcEWjWAky3Wf2njhhHk63PRwCSTOl7pdjZcZStgcX3V
         tuwLL0kgk7wjlKuj+zexSRFnwD6QbYhn4a7uwRCH58iuLNF6PHaEtXm9SKX3MM0N4C
         7iF9uC/SVZuf1cj7beG0BEmZVj+h750DsUPpTvVjzLyIZhHDtCtbc/c3MJGS13A361
         S0p8R6IZNYkhA==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1605800597-16720-2-git-send-email-claudiu.beznea@microchip.com>
References: <1605800597-16720-1-git-send-email-claudiu.beznea@microchip.com> <1605800597-16720-2-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v6 01/11] clk: at91: sama7g5: fix compilation error
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mturquette@baylibre.com, nicolas.ferre@microchip.com,
        robh+dt@kernel.org
Date:   Sat, 19 Dec 2020 11:53:17 -0800
Message-ID: <160840759753.1580929.18297042693846426933@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2020-11-19 07:43:07)
> pmc_data_allocate() has been changed. pmc_data_free() was removed.
> Adapt the code taking this into consideration. With this the programmable
> clocks were also saved in sama7g5_pmc so that they could be later
> referenced.
>=20
> Fixes: cb783bbbcf54 ("clk: at91: sama7g5: add clock support for sama7g5")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> Tested-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---

Applied to clk-next
