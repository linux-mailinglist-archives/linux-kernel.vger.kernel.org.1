Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9392D2DF22E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 00:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgLSXcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 18:32:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:32970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbgLSXcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 18:32:47 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608420727;
        bh=aXq1pdmQprdfyJhxJTO6m1zKtz+Id6CDhn6VsNL0pmw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=JF/lvGuaCYM5j2X1Wx1xkWl2xBi/QKuQG/+GqWcImJmHiDNESnRldfE5+v2AmqFzR
         Qqj8vOGgDjeYyHV26MtBXfS7/EIOEWRWd3wq8CI6ugNa3OJSNljlcnF/En8pT6Wx60
         Krvb0R708q6JLGde+7FyfjpdAY5n/kexeLhVr+5eTxNPsGCZIlZ+8HcQOVz5VT7Apg
         PQyjKti9HRCUJ1vQpiuDuUQSuoLT3X+ikwahbTAC1TxkgYsSyioI0py9AyJUbAY9LD
         l8TN5Pvqm8M1xbrtn8wa77ptOivBZykTa6zDeCsAhHsyltACeuD023/jn90eK11mBT
         4KmUSMG0NxL+Q==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1605800597-16720-9-git-send-email-claudiu.beznea@microchip.com>
References: <1605800597-16720-1-git-send-email-claudiu.beznea@microchip.com> <1605800597-16720-9-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v6 08/11] clk: at91: sama7g5: decrease lower limit for MCK0 rate
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mturquette@baylibre.com, nicolas.ferre@microchip.com,
        robh+dt@kernel.org
Date:   Sat, 19 Dec 2020 15:32:06 -0800
Message-ID: <160842072616.1580929.6874356393849040448@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2020-11-19 07:43:14)
> On SAMA7G5 CPU clock is changed at run-time by DVFS. Since MCK0 and
> CPU clock shares the same parent clock (CPUPLL clock) the MCK0 is
> also changed by DVFS to avoid over/under clocking of MCK0 consumers.
> The lower limit is changed to be able to set MCK0 accordingly by
> DVFS.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Applied to clk-next
