Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46CE322089C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 11:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730628AbgGOJXd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Jul 2020 05:23:33 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:44318 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729672AbgGOJXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:23:32 -0400
Received: by mail-ej1-f66.google.com with SMTP id ga4so1412653ejb.11;
        Wed, 15 Jul 2020 02:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZjUBYbCAhkMSlEf1D1VjAPqeltcV9sJtDSHasy83UmE=;
        b=ifhmI0N3dDcqPL5TV9oj7Fn/Ncit4UO5XhbPfngAIS6+iqRO24OiAwnNgtn/zE8NUY
         j8Hg+gHHY/bM7JW9RE3ZQt26K5/NHS0ad98VOlezrPEonNKSahoWvgBem+FvzGALj3YT
         WhZ3Ox9yP5hUmOq7igQdnhM4PPzamlQHkWtI1uHL0jW7gq+RbSizcOg0Ry7Rt++AbfE/
         bEqxn/VLjFkZVq5tKttVh2JWSU5lfzMgu6rDR2Rqm3u8VuCTFl+y9az/6EE+tK2K3Bas
         AWSPNvosU0iPKG5vxkm4SXVwGhksgFxOmbgHeWUgtMnf5zxrXOAGE3fhmKJCVFgVVS5Y
         IjBw==
X-Gm-Message-State: AOAM532ZH17tBj/pejpWkjEfw4259RZujdIitkEv1U5vtu/TjTPZ8cXW
        2uBlhyaAhnMZrqWdodbZ3au9IHYw7LQxq6intFY=
X-Google-Smtp-Source: ABdhPJwHOldqQmuodyxBvCRakrk0jEwP5N4dmKqXxJKGDLmt+HF2VeypeRx/68egPxFW5FOpqzMnanzIOz45zNrQOwk=
X-Received: by 2002:a17:906:a44:: with SMTP id x4mr8965528ejf.193.1594805010582;
 Wed, 15 Jul 2020 02:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200713032143.21362-1-vulab@iscas.ac.cn>
In-Reply-To: <20200713032143.21362-1-vulab@iscas.ac.cn>
From:   Barry Song <baohua@kernel.org>
Date:   Wed, 15 Jul 2020 21:23:20 +1200
Message-ID: <CAGsJ_4z4QfmFxu=+8QgKz4qSSob+2K+EO5hukPjhgPYkvEuJmw@mail.gmail.com>
Subject: Re: [PATCH] clk: clk-atlas6: fix return value check in atlas6_clk_init()
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xu Wang <vulab@iscas.ac.cn> 于2020年7月13日周一 下午3:27写道：
>
> In case of error, the function clk_register() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check
> should be replaced with IS_ERR().
>
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>

Acked-by: Barry Song <baohua@kernel.org>

> ---
>  drivers/clk/sirf/clk-atlas6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/sirf/clk-atlas6.c b/drivers/clk/sirf/clk-atlas6.c
> index c84d5bab7ac2..b95483bb6a5e 100644
> --- a/drivers/clk/sirf/clk-atlas6.c
> +++ b/drivers/clk/sirf/clk-atlas6.c
> @@ -135,7 +135,7 @@ static void __init atlas6_clk_init(struct device_node *np)
>
>         for (i = pll1; i < maxclk; i++) {
>                 atlas6_clks[i] = clk_register(NULL, atlas6_clk_hw_array[i]);
> -               BUG_ON(!atlas6_clks[i]);
> +               BUG_ON(IS_ERR(atlas6_clks[i]));
>         }
>         clk_register_clkdev(atlas6_clks[cpu], NULL, "cpu");
>         clk_register_clkdev(atlas6_clks[io],  NULL, "io");
> --
> 2.17.1
>
