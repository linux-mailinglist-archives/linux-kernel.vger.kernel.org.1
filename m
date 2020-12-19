Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75762DF22A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 00:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgLSXcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 18:32:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:32940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbgLSXcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 18:32:42 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608420721;
        bh=pXvdni6S512f1amzlbECUY8HvDk7LqbA1LaQccn+s1A=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=IvJHz5mW1enfmrxSVKrtAHNydyq8Va33+2RSj4vzqI7giITVAhnJp4TTNf8N7H0ZB
         Vx0d4dbrCb3gb+0ea0YkFIMFtvWikS1qEuOya1rwhWrcjw/v3/y5npOKSnNW7bw/Bg
         jgFcuqfvfqp3Wk8X522mHiJ50qJ0kt8H8+k/gD6Tq78+xjh2NBHDlZ2LH0fZVS/PRD
         gdjR08NvNYk4FVrWcua1z6alZH+cbXceDuki4Eg0xdDOhZNY7RIPjtwrLAX9NjqyXQ
         BXNdFJoF3N9mlojRWGXCGTsDxkmx4v73fYnoCaKFOzaihTVf1GQpRaFVbkM6NWMUPD
         MVTUYanMGSHcQ==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1605800597-16720-8-git-send-email-claudiu.beznea@microchip.com>
References: <1605800597-16720-1-git-send-email-claudiu.beznea@microchip.com> <1605800597-16720-8-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v6 07/11] clk: at91: sama7g5: remove mck0 from parent list of other clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mturquette@baylibre.com, nicolas.ferre@microchip.com,
        robh+dt@kernel.org
Date:   Sat, 19 Dec 2020 15:32:00 -0800
Message-ID: <160842072044.1580929.2455585631289363373@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2020-11-19 07:43:13)
> MCK0 is changed at runtime by DVFS. Due to this, since not all IPs
> are glitch free aware at MCK0 changes, remove MCK0 from parent list
> of other clocks (e.g. generic clock, programmable/system clock, MCKX).
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Applied to clk-next
