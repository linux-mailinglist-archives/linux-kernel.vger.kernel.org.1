Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89EE2DF236
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 00:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgLSXdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 18:33:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:33132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbgLSXdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 18:33:10 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608420744;
        bh=AIrLB/EpPI4OuvO2R1g4fHoDXK+M20zWF9MGctJjdXg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=UIt27qd7I/Sr4y7WD5fvXDSzBC9/tnDQkvnh3fo+Fm+/h1XXzatslFppRmAFVAXxC
         UD5OoGcxRb/BPxFdft/6sndUkyfYCthph7kAB2KqmRlrlepWkrrHSPvgynyx4W9ZS+
         ed5HbYlY/vXe7RfUbRoTN8q8Be1ZZXAas07sLfljOS2/VQbiUnAwXBOpAJRQbZWpnV
         ovbrlDPfSM7bNTZH77qe1XhvDsE863CwjQdGWb5sLc0ONwKDcBd2Q6dJCdMGof8YOF
         e/XTsLxHIQ6x1SII22mJMcgx4rwWxM+RHSqmhZC66m5yUEOsa7/XiDp4jt/DWfxjbu
         y39uZUKq0tveQ==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1605800597-16720-12-git-send-email-claudiu.beznea@microchip.com>
References: <1605800597-16720-1-git-send-email-claudiu.beznea@microchip.com> <1605800597-16720-12-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v6 11/11] clk: at91: sama7g5: register cpu clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mturquette@baylibre.com, nicolas.ferre@microchip.com,
        robh+dt@kernel.org
Date:   Sat, 19 Dec 2020 15:32:23 -0800
Message-ID: <160842074325.1580929.10681302638864273463@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2020-11-19 07:43:17)
> Register CPU clock as being the master clock prescaler. This would
> be used by DVFS. The block schema of SAMA7G5's PMC contains also a divider
> between master clock prescaler and CPU (PMC_CPU_RATIO.RATIO) but the
> frequencies supported by SAMA7G5 could be directly received from
> CPUPLL + master clock prescaler and the extra divider would do no work in
> case it would be enabled.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Applied to clk-next
