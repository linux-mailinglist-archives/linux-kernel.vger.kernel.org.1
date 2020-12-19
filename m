Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC792DF231
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 00:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbgLSXcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 18:32:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:32988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbgLSXcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 18:32:53 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608420733;
        bh=X4Zq0vqVirpCpaFu11XQzqTFlzDdm7xo8elfSnZnYSI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=fXt6LWcHW3B8mjfUSqBwrTuYJ7nrCgHBd6P29AQX95QEdssRo8W+5l7bnAD8K3LpQ
         kSZVuwIz0Qmc8DxOLb1N92dq+WTbQ/bHlK/VYiLTVIG5VcLqW+0tGa2QtThwWZYonM
         vn/RYnocKwtU3+MfCSH2ajn8Zz8Cam0PdjlqQ3rxRyayz8IsNx9itc/3zhQT1uVjly
         69LFf8kp4b4P0g8VawIWsg/dc1Q23lNC6+hY8QfBbv0VT71rX7tpuHdfuQ/3oyZleg
         +ZwfhVDgsqy7/1bG7+1TkVbTjid6lsmfjS9pJOJAm3HWtA4JOWntIpBx5T5wLdtzEA
         ipMVVmUrQKVBw==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1605800597-16720-10-git-send-email-claudiu.beznea@microchip.com>
References: <1605800597-16720-1-git-send-email-claudiu.beznea@microchip.com> <1605800597-16720-10-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v6 09/11] clk: at91: sama7g5: do not allow cpu pll to go higher than 1GHz
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mturquette@baylibre.com, nicolas.ferre@microchip.com,
        robh+dt@kernel.org
Date:   Sat, 19 Dec 2020 15:32:11 -0800
Message-ID: <160842073181.1580929.17659902836214235882@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2020-11-19 07:43:15)
> Since CPU PLL feeds both CPU clock and MCK0, MCK0 cannot go higher
> than 200MHz and MCK0 maximum prescaller is 5 limit the CPU PLL at
> 1GHz to avoid MCK0 overclocking while CPU PLL is changed by DVFS.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Applied to clk-next
