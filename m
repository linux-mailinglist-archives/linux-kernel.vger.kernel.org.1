Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C037D21C121
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jul 2020 02:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgGKA0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 20:26:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbgGKA0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 20:26:48 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB6982078B;
        Sat, 11 Jul 2020 00:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594427208;
        bh=k3yKm/q13vgtDwU+/6cU4tH+X0uAEuUwaNvogC6Hk2U=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=b+hmiuKlAjhjYftyRiSU3RmWBHmGzCge2OMOgicfVTaTz8EcV5dOBhOwx6Xmr7mTC
         UdQFLeqWoH3C2ZeLt9U80qqogFKDNGPTuXgeU9OydPK62AhHzLsR5P84qzOaavTzm8
         bWXwRTi06qFLRBfLiiPLT42pYd6azJjfNPBZFlFU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1593588382-19049-2-git-send-email-wendell.lin@mediatek.com>
References: <1593588382-19049-1-git-send-email-wendell.lin@mediatek.com> <1593588382-19049-2-git-send-email-wendell.lin@mediatek.com>
Subject: Re: [PATCH 1/2] clk: Export clk_register_composite
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        mtk01761 <wendell.lin@mediatek.com>
Date:   Fri, 10 Jul 2020 17:26:47 -0700
Message-ID: <159442720733.1987609.12625915294903304595@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Wendell Lin (2020-07-01 00:26:21)
> clk_register_composite() will be used in mediatek's
> clock kernel module, so export it to GPL modules.
>=20
> Signed-off-by: Wendell Lin <wendell.lin@mediatek.com>
> ---
>  drivers/clk/clk-composite.c |    1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
> index 7376f57..fb5cb4a 100644
> --- a/drivers/clk/clk-composite.c
> +++ b/drivers/clk/clk-composite.c
> @@ -360,6 +360,7 @@ struct clk *clk_register_composite(struct device *dev=
, const char *name,
>                 return ERR_CAST(hw);
>         return hw->clk;
>  }
> +EXPORT_SYMBOL(clk_register_composite);

Should be EXPORT_SYMBOL_GPL()
