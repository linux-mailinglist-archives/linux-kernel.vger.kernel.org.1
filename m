Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9B61E39D1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 09:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgE0HDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 03:03:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbgE0HDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 03:03:19 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47E85207CB;
        Wed, 27 May 2020 07:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590562998;
        bh=LhwzZ24hfZZZERXjwv0SCDky3MmpIWrKK1ViT7H5PAk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=tSeNvf8xROTQJAx1K3QWz2fmLTWCWIDKHQBVpNUyMIf1kjPdgTkhUpLSlmpmTQvYu
         Cu3XCk/RAU33/h8rJ5ZQSZj4PzzuEurNELuVWI1nFF5+WmhTej4Zn7qgx0wpldILyq
         2XNUQdrpZewLdaclffsYXC0o9+OKgz6AfJr34His=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1a25b4f079dcdc669d4b29d3658ef0b72be2651e.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech> <1a25b4f079dcdc669d4b29d3658ef0b72be2651e.1587742492.git-series.maxime@cerno.tech>
Subject: Re: [PATCH v2 20/91] clk: bcm: rpi: Discover the firmware clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
To:     Eric Anholt <eric@anholt.net>, Maxime Ripard <maxime@cerno.tech>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Date:   Wed, 27 May 2020 00:03:17 -0700
Message-ID: <159056299757.88029.2814367530440231587@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-04-24 08:34:01)
> The RaspberryPi4 firmware actually exposes more clocks than are currently
> handled by the driver and we will need to change some of them directly
> based on the pixel rate for the display related clocks, or the load for t=
he
> GPU.
>=20
> This rate change can have a number of side-effects, including adjusting t=
he
> various PLL voltages or the PLL parents. The firmware will also update
> those clocks by itself for example if the SoC runs too hot.
>=20
> In order to make Linux play as nice as possible with those constraints, it
> makes sense to rely on the firmware clocks as much as possible.
>=20
> Fortunately,t he firmware has an interface to discover the clocks it

Fortunately, the

> exposes.
>=20
> Let's use it to discover, register the clocks in the clocks framework and
> then expose them through the device tree for consumers to use them.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
