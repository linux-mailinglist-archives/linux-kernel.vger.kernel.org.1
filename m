Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE6A2DF160
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 20:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgLSTyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 14:54:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:42210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727352AbgLSTyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 14:54:09 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608407609;
        bh=cMSOWDasM1z33PkRfN3gRqLapn0FiwyTd/SWdEA+rVg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hg/KWs/kVrIy0BhXsXmAtb/lFFmIcttvmrlgti+9a4qtSvTasHUC62Y+56jkWkiX4
         5CObgQM1T0zow8aaMzclLuj+YMCxmBPMamA75iaeNK5aCJvGppjWzEa96C7Zxezcpn
         ZmUZ9ky+ax0E22yaKHCa5Oe2/ZayZm7sY4gYY3Fv4+hFq+as7Qhi9jWUP0vv7YOjBR
         83lrKBQCJB43Vr2WI71V4RpHdsnp+JfIcS+dXSS8GctYmgaHL5vfvzidmw9eTSdqlV
         6d2PtzWvI+n2fIaHpZaVQL/qoa9vbcmpaXESRNcBVHgWVIn6f82iIFigSHu0HGPyoC
         3y5DZ0fuHWT8g==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1605800597-16720-3-git-send-email-claudiu.beznea@microchip.com>
References: <1605800597-16720-1-git-send-email-claudiu.beznea@microchip.com> <1605800597-16720-3-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v6 02/11] dt-bindings: clock: at91: add sama7g5 pll defines
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mturquette@baylibre.com, nicolas.ferre@microchip.com,
        robh+dt@kernel.org
Date:   Sat, 19 Dec 2020 11:53:27 -0800
Message-ID: <160840760792.1580929.2320471025783660892@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2020-11-19 07:43:08)
> From: Eugen Hristev <eugen.hristev@microchip.com>
>=20
> Add SAMA7G5 specific PLL defines to be referenced in a phandle as a
> PMC_TYPE_CORE clock.
>=20
> Suggested-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> [claudiu.beznea@microchip.com: adapt comit message, adapt sama7g5.c]
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Applied to clk-next
