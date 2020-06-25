Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707792097F3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 02:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389593AbgFYAqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 20:46:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729175AbgFYAqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 20:46:22 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA1BB207DD;
        Thu, 25 Jun 2020 00:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593045981;
        bh=9mPmJlPF2yBtCBMPCg1yDpeuNGPFh99AjFXW2uMVD6I=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=l4IKIk6Wkd1PdnzMh+m9t8AkHxFEWfhtoyw0AD7yMuKvCte0+6irjuvJY511ZLMAj
         rKNgppC+GPtR/TZxEpa3J1LlU+jH9WQW642MLNCCqQ6u/hXYrrN8FZRQaXJrs5zCPO
         ToBmm7+B43Q6sOYYuhyI1miATOBPu2c4cLkvAwb4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <acdf820c2f78a25dd7480a0c018b8b387acd013e.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech> <acdf820c2f78a25dd7480a0c018b8b387acd013e.1592210452.git-series.maxime@cerno.tech>
Subject: Re: [PATCH v5 27/27] clk: bcm: rpi: Remove the quirks for the CPU clock
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
Date:   Wed, 24 Jun 2020 17:46:21 -0700
Message-ID: <159304598103.62212.4509416139021904668@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-06-15 01:41:07)
> The CPU clock has had so far a bunch of quirks to expose the clock tree
> properly, but since we reverted to exposing them through the MMIO driver,
> we can remove that code from the firmware driver.
>=20
> Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Applied to clk-next
