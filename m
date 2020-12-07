Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE4B2D1CA3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgLGWBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:01:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:49742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbgLGWBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:01:47 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607378466;
        bh=MyZsntriOs2xIJSIQtKA6EcMk9KIBhcld1afvraAx/s=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Lqhb67XKu2C7RLpCppC0Exy3HKCtbgc8kUsI02RtORhhumkicx6HkmifJkcnDa0Wj
         hSoMVkIrs9Vbios693SmqNnJwmegERrlafuUi5dQv2XfQKMINEzSjF8DBEuMJxzlcQ
         EGStqvZZUX88kKYzcgTiVNzGZ5z2qy36W/EdUp8qXJ1fIcKzhH0/sW+IJ32UQNFN+w
         rYDOwuzw9qw7dVlGU/mvSKsXBNEXg+KYU7l1E8VNLW6tNIsqTZMjtyUyd0FqRklSuo
         UIxd8ddxGtLkSHe6M+NCS9k/NszMBaKWLrRPkUpgHb7q+my0hOrWPo2s70HBxo01+T
         Rqo+UTxVOlXDA==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201110155117.3286247-1-geert+renesas@glider.be>
References: <20201110155117.3286247-1-geert+renesas@glider.be>
Subject: Re: [PATCH resend v2] xtensa: Replace <linux/clk-provider.h> by <linux/of_clk.h>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-xtensa@linux-xtensa.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To:     Chris Zankel <chris@zankel.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Max Filippov <jcmvbkbc@gmail.com>
Date:   Mon, 07 Dec 2020 14:01:05 -0800
Message-ID: <160737846524.1580929.13295930706090189807@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Geert Uytterhoeven (2020-11-10 07:51:17)
> The Xtensa time code is not a clock provider, and just needs to call
> of_clk_init().
>=20
> Hence it can include <linux/of_clk.h> instead of <linux/clk-provider.h>.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> Acked-by: Max Filippov <jcmvbkbc@gmail.com>
> ---

Applied to clk-next
