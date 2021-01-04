Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A132E943D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 12:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbhADLny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 06:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbhADLny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 06:43:54 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B49FC061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 03:43:13 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id dk8so27068106edb.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 03:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=YJMXYPP+Zpc8fAzHM+tOsE5l9dX3cXSxu+6LXuQVQIY=;
        b=P5ZpcTTEIS6JO3tLdGP1J8WCi7VGcCDBePpY9T78KseCTeXZgQk/rHpdAWH3wCgIJ1
         InUe6Fo0SvE7hskI0Aeyuu3A7yo68PPKJ2EkIix99qXQAxdA5Kni1u5B5jHHBI6KMFxS
         fyIkG5/ctTqUZpjJ7r8HvuDuw441eqBot+kdH7D0dJQXL8jeOV9MmDFU38l0yUTHzloq
         F6vH0wbvSiYcuAYbrq/homLDEAC6D/0fgpv9WKqzlwDxaYPspnXaXbreaQgS8sfYHo/m
         g4Er8PyeQpoZ6t5YZW0VFHsgcUFaI/6r2VpZt1W5vBgA5YQgnd2dmD02s7Sn1Iknpkpq
         LnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=YJMXYPP+Zpc8fAzHM+tOsE5l9dX3cXSxu+6LXuQVQIY=;
        b=YFxcdNuZS3rZ0T5d9LZLcjYA74snXPqrZRRskRKXwz12/TKFqeJ4uytkzPi4NvyNmG
         jHKuIWJR9/T9pzenWcP6O7RglvEsvfuhlE+qrYpbnYfqhC7dyL+0e13O+m5CV6kf1E7u
         47Dy5nB2yXoLf/trLuBEa1j7uwrlNacIjBPWIxQkqbRbBYZLRsjhlswMn0pidDqmk6LL
         HftdOo6DenlhwIqtAo9LpCvejfaXudiFCEMrxlKrPq9WCPVvEfHUkBvfkVA4Zb3xW6Nb
         zqiJSC/PF5GnoIAGou5MdLnpCpFyU53qzmKV8laOJcaXec+ticATlcIQ4n7/EWMyqM0v
         It/w==
X-Gm-Message-State: AOAM533zR4eP1Zvu4r67FrRtXbafnpbZ1BsljZyvXbKyD8UhE4jqc7Sn
        LF0iiP3n+dx9W5T5CGzS48I9Ew==
X-Google-Smtp-Source: ABdhPJzJZBo2eMXhVWesKa5PqRsTKXztqcgpvKwHFN+xiQ1Vt6luAU/jDR0cjkwoLG6zGogqOwHIQA==
X-Received: by 2002:a50:cd9c:: with SMTP id p28mr68774887edi.83.1609760592341;
        Mon, 04 Jan 2021 03:43:12 -0800 (PST)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id s15sm15294357eja.36.2021.01.04.03.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 03:43:11 -0800 (PST)
References: <20201226121556.975418-1-martin.blumenstingl@googlemail.com>
 <20201226121556.975418-2-martin.blumenstingl@googlemail.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] clk: meson: clk-pll: fix initializing the old rate
 (fallback) for a PLL
In-reply-to: <20201226121556.975418-2-martin.blumenstingl@googlemail.com>
Message-ID: <1j35zhx700.fsf@starbuckisacylon.baylibre.com>
Date:   Mon, 04 Jan 2021 12:43:11 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat 26 Dec 2020 at 13:15, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> The "rate" parameter in meson_clk_pll_set_rate() contains the new rate.
> Retrieve the old rate with clk_hw_get_rate() so we don't inifinitely try
> to switch from the new rate to the same ratte again.

Small typo above fixed while applying


>
> Fixes: 7a29a869434e8b ("clk: meson: Add support for Meson clock controller")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/clk/meson/clk-pll.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
> index b17a13e9337c..9404609b5ebf 100644
> --- a/drivers/clk/meson/clk-pll.c
> +++ b/drivers/clk/meson/clk-pll.c
> @@ -371,7 +371,7 @@ static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
>  	if (parent_rate == 0 || rate == 0)
>  		return -EINVAL;
>  
> -	old_rate = rate;
> +	old_rate = clk_hw_get_rate(hw);
>  
>  	ret = meson_clk_get_pll_settings(rate, parent_rate, &m, &n, pll);
>  	if (ret)

