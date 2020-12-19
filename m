Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61ACB2DF237
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 00:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgLSXdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 18:33:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:33130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbgLSXdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 18:33:10 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608420738;
        bh=fhuWqdisHUtrXBng7/uwgTXKDBfdWM06wpkhdGxfQrg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=F6jQQAu0kILPt06Q/txMFbJq/PjWBkeIu+iN/fUgLpUIo1wYNDfWE18HwdLnBc5Xf
         Wu8AHiWJk8bgqh/UE1M7EkQt99Lv/m507oJinmzFnS7bgtf0/QkEiWxor5qSOSF0y9
         rd1v1NKmpcW5F0hbh+C2SXKcxuln9wT7CzN9KAAxRHiUigFpC8A+qxO/OLreC1cJiz
         E+yyWO/ODxpoYLbsP3nyMew1Ckjcnc9Q699+dTeomTpmx73q6TKWepJIKr3LB3T5+W
         gO2uZ39HsbENWxnUcBywcTTVmv1dKEKexDqO4ZVDvzwAogOdgRmO0caj+HXh9+Y8BH
         TcBlvesyGEdpw==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1605800597-16720-11-git-send-email-claudiu.beznea@microchip.com>
References: <1605800597-16720-1-git-send-email-claudiu.beznea@microchip.com> <1605800597-16720-11-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v6 10/11] clk: at91: clk-master: re-factor master clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mturquette@baylibre.com, nicolas.ferre@microchip.com,
        robh+dt@kernel.org
Date:   Sat, 19 Dec 2020 15:32:17 -0800
Message-ID: <160842073774.1580929.9863083080209979336@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2020-11-19 07:43:16)
> Re-factor master clock driver by splitting it into 2 clocks: prescaller
> and divider clocks. Based on registered clock flags the prescaler's rate
> could be changed at runtime. This is necessary for platforms supporting
> DVFS (e.g. SAMA7G5) where master clock could be changed at run-time.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Applied to clk-next
