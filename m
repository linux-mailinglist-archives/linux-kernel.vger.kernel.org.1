Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A75D9299283
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1736309AbgJZQdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:33:25 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54049 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1421312AbgJZQdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:33:24 -0400
Received: by mail-wm1-f67.google.com with SMTP id d78so12314986wmd.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 09:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=/lQRM2+EAb+jKRJafntJPMlzMeoOKfJANas/j8SJLN4=;
        b=e/I0HscW2QgWc5e2sSX9P9394/GMnjHxQzVKqbxpXS0yQNJgP5oMXIXyZELYT2JzT7
         /zH6+cn3Uvi6aBylxRweBESwO5QSHZDpYlx2Ba20Uha95pmp22BxEcmArfwiAiWCcabV
         9V63eoEtrRPg6WukH0OlQNvqmKxD5FVWjuB9oJhdkWo+z9pOv3XccJVVyEBiho+mFJDA
         94BY7C7W04ufQ39cbsIv+c/0H59wnNDwX4cXXetaFT/MbylnPG3ndSAwN8kXQr08QrIH
         P2BdAAu7NWWSYjex5WlaMWNrtgPEC4GbeMYI0GpWiyIpxEn5ZlrK9zIz7V+L7lJgnWIW
         N/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=/lQRM2+EAb+jKRJafntJPMlzMeoOKfJANas/j8SJLN4=;
        b=XqPAZD+Qf95wvyNndTc9lb66tMyYCPf024EMPRUDxNG2GRDGEsvSYHqYfQWEL6bAwr
         qULWivkkCM+n4GASuwT1b1FrWVPM4UDuaBH1CTAO95AfCOccIjJN+iFwsTqNj3llnJNv
         X08kS8BGBqK80Tgu5FY69hBARQWAFHamt3xNLNMc7vgrAin7Ykny1lpJgODSrw3euO1p
         7UNWybwo2P3kDXi+tzgza2/tWBTh/VS4fFYMKsp4dR0cG2ZRkmfuPA2i4Wi9jTGZUAtF
         dIlWdCNE9zINd5A6FZypU+KhqGqBXwOGrLGXr7s3jdn0BlChyGqfOzu5yWsuhqbMxi9W
         rsKw==
X-Gm-Message-State: AOAM531nn04GnF1OpSX/FEoaO4QiXmGzxQArqzwZxbpe/YShFVONUsJl
        f18o6ScbWkTEPYKhOldm8ECo6w==
X-Google-Smtp-Source: ABdhPJyreI18jIz7IrPx9Nt27h0Xuo9pf/2DbqlqowWOvewXDYrAULqhjkoLwyDCkT1sfcHYa7Oc4Q==
X-Received: by 2002:a1c:e354:: with SMTP id a81mr16520015wmh.101.1603730002576;
        Mon, 26 Oct 2020 09:33:22 -0700 (PDT)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id m8sm22620877wrw.17.2020.10.26.09.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 09:33:22 -0700 (PDT)
References: <20201026161411.3708639-1-arnd@kernel.org>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mike Turquette <mturquette@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@codeaurora.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] clk: define to_clk_regmap() as inline function
In-reply-to: <20201026161411.3708639-1-arnd@kernel.org>
Date:   Mon, 26 Oct 2020 17:33:21 +0100
Message-ID: <1ja6w9j6b2.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 26 Oct 2020 at 17:13, Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> Nesting container_of() causes warnings with W=2, which is
> annoying if it happens in headers and fills the build log
> like:
>
> In file included from drivers/clk/qcom/clk-alpha-pll.c:6:
> drivers/clk/qcom/clk-alpha-pll.c: In function 'clk_alpha_pll_hwfsm_enable':
> include/linux/kernel.h:852:8: warning: declaration of '__mptr' shadows a previous local [-Wshadow]
>   852 |  void *__mptr = (void *)(ptr);     \
>       |        ^~~~~~
> drivers/clk/qcom/clk-alpha-pll.c:155:31: note: in expansion of macro 'container_of'
>   155 | #define to_clk_alpha_pll(_hw) container_of(to_clk_regmap(_hw), \
>       |                               ^~~~~~~~~~~~
> drivers/clk/qcom/clk-regmap.h:27:28: note: in expansion of macro 'container_of'
>    27 | #define to_clk_regmap(_hw) container_of(_hw, struct clk_regmap, hw)
>       |                            ^~~~~~~~~~~~
> drivers/clk/qcom/clk-alpha-pll.c:155:44: note: in expansion of macro 'to_clk_regmap'
>   155 | #define to_clk_alpha_pll(_hw) container_of(to_clk_regmap(_hw), \
>       |                                            ^~~~~~~~~~~~~
> drivers/clk/qcom/clk-alpha-pll.c:254:30: note: in expansion of macro 'to_clk_alpha_pll'
>   254 |  struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
>       |                              ^~~~~~~~~~~~~~~~
> include/linux/kernel.h:852:8: note: shadowed declaration is here
>   852 |  void *__mptr = (void *)(ptr);     \
>       |        ^~~~~~
>
> Redefine two copies of the to_clk_regmap() macro as inline functions
> to avoid a lot of these.
>
> Fixes: ea11dda9e091 ("clk: meson: add regmap clocks")
> Fixes: 085d7a455444 ("clk: qcom: Add a regmap type clock struct")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Jerome Brunet <jbrunet@baylibre.com>

> ---
>  drivers/clk/meson/clk-regmap.h | 5 ++++-
>  drivers/clk/qcom/clk-regmap.h  | 6 +++++-
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/meson/clk-regmap.h b/drivers/clk/meson/clk-regmap.h
> index c4a39604cffd..e365312da54e 100644
> --- a/drivers/clk/meson/clk-regmap.h
> +++ b/drivers/clk/meson/clk-regmap.h
> @@ -26,7 +26,10 @@ struct clk_regmap {
>  	void		*data;
>  };
>  
> -#define to_clk_regmap(_hw) container_of(_hw, struct clk_regmap, hw)
> +static inline struct clk_regmap *to_clk_regmap(struct clk_hw *hw)
> +{
> +	return container_of(hw, struct clk_regmap, hw);
> +}
>  
>  /**
>   * struct clk_regmap_gate_data - regmap backed gate specific data
> diff --git a/drivers/clk/qcom/clk-regmap.h b/drivers/clk/qcom/clk-regmap.h
> index 6cfc1bccb255..14ec659a3a77 100644
> --- a/drivers/clk/qcom/clk-regmap.h
> +++ b/drivers/clk/qcom/clk-regmap.h
> @@ -24,7 +24,11 @@ struct clk_regmap {
>  	unsigned int enable_mask;
>  	bool enable_is_inverted;
>  };
> -#define to_clk_regmap(_hw) container_of(_hw, struct clk_regmap, hw)
> +
> +static inline struct clk_regmap *to_clk_regmap(struct clk_hw *hw)
> +{
> +	return container_of(hw, struct clk_regmap, hw);
> +}
>  
>  int clk_is_enabled_regmap(struct clk_hw *hw);
>  int clk_enable_regmap(struct clk_hw *hw);

