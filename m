Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29EE827AB19
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 11:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgI1Jr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 05:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbgI1Jr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 05:47:27 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BDCC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 02:47:27 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w5so531451wrp.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 02:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=aBaJ7/GSUfwYoA9TO9qsxTcOvSw2SWgHX/gC4K79Bt4=;
        b=dVIQN+f+DCKVNjTLbL7o7s6+EZqkCS0G96fLUO9iTFd9PXBVjqxXiHnouor1t8Mlf2
         yMOMb9HmqQSXMrsWoFSUVZTnP6M6CXNFuLJR1EjLtVfp8dMnaX07gDimkOMEGDL2rdtv
         Fo67JbRt2cXalKZajjrYmDZiopA30ERhpObv7m3lu/PQ1Rkitodi0Rzk8ya22Xn5tjAj
         Ku+KbFkDY2DmHQ+O5ggUF0NWJhxIwQDXSgV2KSHyrymQNeOX22Mzt2nRShQtZjLoFWVf
         wfIm0hHAWKMTWVtGgrO82cvWCTXJv5qZfRORzqkrq/NLCS6vxqvuzVHqXot67aopvpjI
         YlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=aBaJ7/GSUfwYoA9TO9qsxTcOvSw2SWgHX/gC4K79Bt4=;
        b=Zmx1Xcq14Q2wBJY3tVES09I+sEbMINd4PhyyNjfE8PSoP8tdcVbjr+FfvurV+/br9Y
         eTsdpj3rKfopvr7K3NwW3JEZrTG4kfX5tXKBHJ46gcvzW8QSsKe1ASm3MIY8Buhe+kFC
         gwnZN/MkWmSZ5aj7euxVB+LicI5gorDGRTAAFnHQQp1f/wodlcMCRikBJD9/tUcwcp0R
         5/P8DOTQ9+D+fh/Q8B6oTr0TSPMnQz/cBc0qgLLhWrOaq3NzJIuAa+0R7ziZrHMaG/12
         Tc9rzPFg/B7QeTe4a5KmEG/ubTmoo100Npe+IzGnCkUeZmduzkIVcXtQ0uy0g9N9CiqL
         nwCA==
X-Gm-Message-State: AOAM5311KkXiBe+LE48oJjUdNVWeCQMPjh3aE/n2HZe7bKtRQVCzmwmR
        xgxS5v4NF3XfobPcFKBfPHGLQA==
X-Google-Smtp-Source: ABdhPJw5raJ0t+x3PQZ3zFLLcp8nFJ3FIYCEkjcE9P11x12LwaPsW8P5ucUS+pbqywKxXyInI/nWEg==
X-Received: by 2002:adf:c64e:: with SMTP id u14mr672332wrg.373.1601286446068;
        Mon, 28 Sep 2020 02:47:26 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id t1sm515386wmi.16.2020.09.28.02.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 02:47:25 -0700 (PDT)
References: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr> <1601233948-11629-11-git-send-email-Julia.Lawall@inria.fr>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Joe Perches <joe@perches.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-janitors@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/18] clk: meson: use semicolons rather than commas to separate statements
In-reply-to: <1601233948-11629-11-git-send-email-Julia.Lawall@inria.fr>
Date:   Mon, 28 Sep 2020 11:47:24 +0200
Message-ID: <1j1rimjkr7.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun 27 Sep 2020 at 21:12, Julia Lawall <Julia.Lawall@inria.fr> wrote:

Hi Stephen,

Do you want to take all the clock related patches directly ?


> Replace commas with semicolons.  What is done is essentially described by
> the following Coccinelle semantic patch (http://coccinelle.lip6.fr/):
>
> // <smpl>
> @@ expression e1,e2; @@
> e1
> -,
> +;
> e2
> ... when any
> // </smpl>
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>
> ---
>  drivers/clk/meson/meson-aoclk.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/meson/meson-aoclk.c b/drivers/clk/meson/meson-aoclk.c
> index bf8bea675d24..3a6d84cd6601 100644
> --- a/drivers/clk/meson/meson-aoclk.c
> +++ b/drivers/clk/meson/meson-aoclk.c
> @@ -57,7 +57,7 @@ int meson_aoclkc_probe(struct platform_device *pdev)
>  	rstc->data = data;
>  	rstc->regmap = regmap;
>  	rstc->reset.ops = &meson_aoclk_reset_ops;
> -	rstc->reset.nr_resets = data->num_reset,
> +	rstc->reset.nr_resets = data->num_reset;
>  	rstc->reset.of_node = dev->of_node;
>  	ret = devm_reset_controller_register(dev, &rstc->reset);
>  	if (ret) {

