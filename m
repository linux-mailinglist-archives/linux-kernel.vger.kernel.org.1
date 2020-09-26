Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AA3279650
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 04:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbgIZCur convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 25 Sep 2020 22:50:47 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37592 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgIZCuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 22:50:46 -0400
Received: by mail-ed1-f67.google.com with SMTP id n22so4467346edt.4;
        Fri, 25 Sep 2020 19:50:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4+5/tjL8muHqPuujhCRn3oXHZAmk1SML4ZsfnMZowuQ=;
        b=qXXYbzS+rsF1LY6MnlTffVxt5OujC25+8CLF+HbN3OaGFt4ILcxt/G378u0PHIys12
         zrttFhjFo/bTLFKlxlVkxOqIjyWz/sGqJ7qBtTeOtzAGpZ2MGYj7WoL83gG8ZFZZDMOK
         8Wds0oMUfVR1UrRbVfEx69gK6b94KiSNB4KAP1fNmRKbWe0CVAHCQWw4nsCxCxkgmYXf
         oe9lK1O2plI0R1q0qNntgBxDHx0LNOcdmQzaKg90hIUbK1DJVpYhnESsAIe5Kaf4TR1G
         kJsMlbWDHO+kJGZYb6vIOseTlvgavHko4MkvDHr9fiIwPbao0X/RHmI9KM5XCWO1yvQf
         dUPw==
X-Gm-Message-State: AOAM531mBRXj9+WbG+YOLPdxkEc7lQ5Hr5cqd290Pv9rbx42rXoS4x3a
        xhKOww6tK41XCTGU+Z069KQ9hW/A2+DCsT2sg1A=
X-Google-Smtp-Source: ABdhPJwJBGMVCDRt23d6l7mV0iR2aIzSxgVdw1BVJOf3Ol0L92b+zxDRpNBVAQ2z1QKTvT3tApbtq0nJoIEeUGwAIpc=
X-Received: by 2002:a50:d65e:: with SMTP id c30mr4597188edj.57.1601088644811;
 Fri, 25 Sep 2020 19:50:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200921034522.9077-1-vulab@iscas.ac.cn>
In-Reply-To: <20200921034522.9077-1-vulab@iscas.ac.cn>
From:   Barry Song <baohua@kernel.org>
Date:   Sat, 26 Sep 2020 14:50:32 +1200
Message-ID: <CAGsJ_4w89Un_howPcfH2jKi1WBsXzQWimdYoW2gOjCf9K23Pyg@mail.gmail.com>
Subject: Re: [PATCH] clk: clk-prima2: fix return value check in prima2_clk_init()
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xu Wang <vulab@iscas.ac.cn> 于2020年9月21日周一 下午3:45写道：
>
> In case of error, the function clk_register() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check
> should be replaced with IS_ERR().
>
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>


Acked-by: Barry Song <baohua@kernel.org>

Thanks

> ---
>  drivers/clk/sirf/clk-prima2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/sirf/clk-prima2.c b/drivers/clk/sirf/clk-prima2.c
> index 45dcbc9e0302..d17b345f4d2d 100644
> --- a/drivers/clk/sirf/clk-prima2.c
> +++ b/drivers/clk/sirf/clk-prima2.c
> @@ -134,7 +134,7 @@ static void __init prima2_clk_init(struct device_node *np)
>
>         for (i = pll1; i < maxclk; i++) {
>                 prima2_clks[i] = clk_register(NULL, prima2_clk_hw_array[i]);
> -               BUG_ON(!prima2_clks[i]);
> +               BUG_ON(IS_ERR(prima2_clks[i]));
>         }
>         clk_register_clkdev(prima2_clks[cpu], NULL, "cpu");
>         clk_register_clkdev(prima2_clks[io],  NULL, "io");
> --
> 2.17.1
>
