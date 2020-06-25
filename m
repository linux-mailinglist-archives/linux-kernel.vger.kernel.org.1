Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C222097CE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 02:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389279AbgFYAnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 20:43:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388862AbgFYAm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 20:42:58 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AACA7207DD;
        Thu, 25 Jun 2020 00:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593045777;
        bh=eVp9tWQlzgqoCNiY2YM/qYEqSjzcQEgmoD76TAskP7M=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=QA7b31j/EYAvO3CyUqsr6OkAYnwgNp4jN5tCtpYEOowHwHMgbwlbkzpD6Gn8+SZVD
         l0PAbT28+LpOJ5pEtPP8U0BuqtgGJTLOdm/W0mju/U9Wg7jGe2vJS7mwtygZUNWuTt
         ylHlalK9H8r0hYuuLgZP2/shHFmRSM+07erPpLlk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <189407f54906d2b07c91de7a4eeb6d8c8934280f.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech> <189407f54906d2b07c91de7a4eeb6d8c8934280f.1592210452.git-series.maxime@cerno.tech>
Subject: Re: [PATCH v5 09/27] clk: bcm: rpi: Remove pllb_arm_lookup global pointer
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <maxime@cerno.tech>
To:     Maxime Ripard <maxime@cerno.tech>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Date:   Wed, 24 Jun 2020 17:42:57 -0700
Message-ID: <159304577703.62212.14971859361316987880@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-06-15 01:40:49)
> The pllb_arm_lookup pointer in the struct raspberrypi_clk is not used for
> anything but to store the returned pointer to clkdev_hw_create, and is not
> used anywhere else in the driver.
>=20
> Let's remove that global pointer from the structure.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: linux-clk@vger.kernel.org
> Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Applied to clk-next
