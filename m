Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8E52B30CA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 21:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgKNUym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 15:54:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:35548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgKNUyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 15:54:41 -0500
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D31022409;
        Sat, 14 Nov 2020 20:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605387281;
        bh=AAWlZMqfOMFE0lUdVK1+7DgEtt8dUhPOyBL3cidS0JM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Hzz86fKa+mzDR3nLAnM1IIe2bjf05OqzPzOItt/RgTxaTFbsVvzaF01Z60gbpufE8
         Ti01F62ZPumBUz8Ir+giZtOhPuUFZOebZ9kX0hK45DOsyX6tIzzy/jlJ16cRPp5tZ0
         acaDY8C7Ih2SULdGtwwE/8ro7tP+8Y/0udqKd+cM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201021162147.563655-3-jbrunet@baylibre.com>
References: <20201021162147.563655-1-jbrunet@baylibre.com> <20201021162147.563655-3-jbrunet@baylibre.com>
Subject: Re: [PATCH v2 2/3] clk: add api to get clk consumer from clk_hw
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 14 Nov 2020 12:54:40 -0800
Message-ID: <160538728023.60232.13014253270340960379@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2020-10-21 09:21:46)
> clk_register() is deprecated. Using 'clk' member of struct clk_hw is
> discouraged. With this constraint, it is difficult for driver to
> register clocks using the clk_hw API and then use the clock with
> the consumer API
>=20
> This adds a simple helper, clk_hw_get_clk(), to get a struct clk from
> a struct clk_hw. Like other clk_get() variant, each call to this helper
> must be balanced with a call to clk_put(). To make life easier on the
> consumers, a memory managed version is provided as well.
>=20
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

Applied to clk-next
