Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511632B0457
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 12:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgKLLur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 06:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbgKLLku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 06:40:50 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8FDC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 03:40:44 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id q3so5759249edr.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 03:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IIySD8jHl2ntyqnjJAOFKaUih7w1tKAQSN79AIHZfZo=;
        b=dqbKVY5k33G1WoYnR62WXmoVtTMoFzHvqgC1qm9WJiYf+SRL//ogYuYTKCSHCfwD8v
         a7l+KLPdbh7jqpOLH57Ay87ksd3xUMo5DFIYS9VyC9/zJyn0PubVWxXCzfjBibTZbaFE
         hUVfIYxPPdBT6KLHD6EyFFUnoeUGMUFkdKeoFwoCLQsoiDFZf7MZTRMrNjsqU7INwS1l
         IQ52TQxxBK/9l1hYB+e3ZvRNzJLYFz91+84FGYeT99Dh6mrwKXMQriLBFJdSjQEhTIy7
         VTFAJiGwiW5KBQ2Fpro3akfU4dVOzIir9L7Q6Zsdz0rCsFH/zjQudmBBBeABReILJLA3
         5jjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IIySD8jHl2ntyqnjJAOFKaUih7w1tKAQSN79AIHZfZo=;
        b=YFawlxcFJW9Mjiq9JEidACZr2oqUaXLNlg7xm6unt4po9MQ8ESmgpoloHADPqpV0Cd
         CfbWz6dFOS2TtKM6mBWLooUhDgtycqv/r7d+94h9OBONpSJsna3GMXsIaMyJtEHN6zJY
         UbtX1/FT0aG011V5mRSqDL8PwlBrJnDTzzTDOyfFWDlBGkY2Wifgy6Y9L0V7QIvLM6ux
         lg26kJ/LKzFJhmodqEPe0ow6IGNkDAxGkjV1V1qZQtFZOASpgCaoGHCiIawOCyYwqrn8
         hepYUSFWZZ5cJUuMzY1hm1usdQ6Mex6St6+SBQvAAN2KITrR9Q0pZA8s67FoaR8UwxBm
         kOhQ==
X-Gm-Message-State: AOAM530RkVIZNtBvNsl0q5XC5YDp7Y18lwxBZDNASEUQ+v9hRKYmMd0u
        s4Ljo+pHDqq7hISv8SPw3k+pqALO3tYD6GgGoxDOFvN1saQ3yw==
X-Google-Smtp-Source: ABdhPJxtq2C8/Sp32xjRsm7unrZdZ2HhAmdm7V9p1LI14Tk4zl6dE5puqEGBsiXHGyN6RLJc7tHoMPBJfCsWylIeQhg=
X-Received: by 2002:a50:ab15:: with SMTP id s21mr4635654edc.88.1605181243548;
 Thu, 12 Nov 2020 03:40:43 -0800 (PST)
MIME-Version: 1.0
References: <20201112084833.21842-1-vincent.stehle@laposte.net>
In-Reply-To: <20201112084833.21842-1-vincent.stehle@laposte.net>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 12 Nov 2020 12:40:32 +0100
Message-ID: <CAMpxmJWVSfZwukjWGMwBvPxcrWUeeMyyh+SpLAg6bNJdEiga7g@mail.gmail.com>
Subject: Re: [PATCH] net: ethernet: mtk-star-emac: return ok when xmit drops
To:     =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@laposte.net>
Cc:     netdev <netdev@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 12:35 PM Vincent Stehl=C3=A9
<vincent.stehle@laposte.net> wrote:
>
> The ndo_start_xmit() method must return NETDEV_TX_OK if the DMA mapping
> fails, after freeing the socket buffer.
> Fix the mtk_star_netdev_start_xmit() function accordingly.
>
> Fixes: 8c7bd5a454ff ("net: ethernet: mtk-star-emac: new driver")
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@laposte.net>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/net/ethernet/mediatek/mtk_star_emac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/mediatek/mtk_star_emac.c b/drivers/net/=
ethernet/mediatek/mtk_star_emac.c
> index 13250553263b5..e56a26f797f28 100644
> --- a/drivers/net/ethernet/mediatek/mtk_star_emac.c
> +++ b/drivers/net/ethernet/mediatek/mtk_star_emac.c
> @@ -1053,7 +1053,7 @@ static int mtk_star_netdev_start_xmit(struct sk_buf=
f *skb,
>  err_drop_packet:
>         dev_kfree_skb(skb);
>         ndev->stats.tx_dropped++;
> -       return NETDEV_TX_BUSY;
> +       return NETDEV_TX_OK;
>  }
>
>  /* Returns the number of bytes sent or a negative number on the first
> --
> 2.28.0
>

Good catch, thanks!

Acked-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
