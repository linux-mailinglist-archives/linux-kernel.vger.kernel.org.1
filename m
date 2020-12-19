Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD9C2DF225
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 00:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgLSXca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 18:32:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:32876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbgLSXc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 18:32:29 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608420709;
        bh=5yoqkI9fhDMuYeOnuHEQbw+uh68RXOBtwDqanl8AKrc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=mBsOGBCjw3L9QQNyDzi3COXvf+B5h9CmCYkoamRFYadikhcZRG+rpU2Vfw0Ns7pKc
         NPo2OyFI3Uc8zwcEaS3A67kUTvi7xusVNNne2ebx5YFjjccAwRCG1jkkH+jUcLlWwm
         upDJkKlfKROKJrSumT6ebjLEOG5sHxV7FP2wXYCQLwyCUM987kefHyckFgqdSrH5I9
         2d5eush6Lm7YUC8gV5Mc/HAAhbyJo1pIqyEQNvKeDvXzYetRcRmNthg4i89XpZNBHm
         A1W7LqtpGiV67PZP9LGeV10U3tGjgZ23N4cdvLBdyqvO8yZFfLjJ7Kp/eWaM55CZeg
         BAZ52IuCGS4Jg==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1605800597-16720-6-git-send-email-claudiu.beznea@microchip.com>
References: <1605800597-16720-1-git-send-email-claudiu.beznea@microchip.com> <1605800597-16720-6-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v6 05/11] clk: at91: sama7g5: add 5th divisor for mck0 layout and characteristics
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mturquette@baylibre.com, nicolas.ferre@microchip.com,
        robh+dt@kernel.org
Date:   Sat, 19 Dec 2020 15:31:47 -0800
Message-ID: <160842070764.1580929.11595392603440179777@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2020-11-19 07:43:11)
> From: Eugen Hristev <eugen.hristev@microchip.com>
>=20
> This SoC has the 5th divisor for the mck0 master clock.
> Adapt the characteristics accordingly.
>=20
> Reported-by: Mihai Sain <mihai.sain@microchip.com>
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Applied to clk-next
