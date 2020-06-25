Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7C72097DB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 02:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389405AbgFYApE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 20:45:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388987AbgFYApB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 20:45:01 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 621B4207DD;
        Thu, 25 Jun 2020 00:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593045901;
        bh=YD3YYR+iajUHHt6vDxaXq7qFR40kc8HXKi2ii27jXLs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Y/KZZzKzKDCqDZLRz3WiaaoDM/5JyZH64Mk+OV6BAkPky9EKimjOZFl834eqC4QBG
         Ey+cRjkKgZ0VHjlqErAi9HH5RYe42A4qQL2QcmOH0GhVWfldPNU7lTcoHC+76pslmP
         IepkSaIvC2H+0G9x6l814lnvPJLDX35xm6w2j6d8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e23c37961b97b027e21efa3b818578970f88527a.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech> <e23c37961b97b027e21efa3b818578970f88527a.1592210452.git-series.maxime@cerno.tech>
Subject: Re: [PATCH v5 14/27] clk: bcm: rpi: Add clock id to data
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
Date:   Wed, 24 Jun 2020 17:45:00 -0700
Message-ID: <159304590078.62212.13471332170418330569@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-06-15 01:40:54)
> The driver has really only supported one clock so far and has hardcoded t=
he
> ID used in communications with the firmware in all the functions
> implementing the clock framework hooks. Let's store that in the clock data
> structure so that we can support more clocks later on.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: linux-clk@vger.kernel.org
> Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Applied to clk-next
