Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740E02DF170
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 20:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgLSTyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 14:54:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:42422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727856AbgLSTyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 14:54:40 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608407628;
        bh=5yoqkI9fhDMuYeOnuHEQbw+uh68RXOBtwDqanl8AKrc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=l/TirsqEUZ3GSqIslwlcsalLwgTeCTa7mCbImn+2IVf1bFRi+AXlkQ9h7fa68F6SM
         i2x6tUejRWIfmmKFy5iK8EXtlkxGloQwMK6OHoa2UGa9hO2PubUBg6NxDshjOX0tpV
         OLMTqfb9ocZec7l2PiFbUA+UsJPkrwmJ6kD27DtaBGA4PQzCS3cPsHKEQvNh2ibcbF
         ha8zcw668qVViOU/ey3EIPzCBXd14kcEOewy6rGkqH224elpmS4qfhK4PXxqch+/Z3
         B374FitdySUsmLM8n7NUPsrC3pewJiEmC7zeNqM7omnlcWMcm/SsR7ZGiqf6pHC2F9
         zXO/hzRCq0s1A==
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
Date:   Sat, 19 Dec 2020 11:53:46 -0800
Message-ID: <160840762680.1580929.5437501377794696803@swboyd.mtv.corp.google.com>
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
