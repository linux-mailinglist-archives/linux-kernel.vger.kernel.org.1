Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC052C0CB4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 15:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbgKWODm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 09:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729204AbgKWODk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 09:03:40 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D43AC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 06:03:40 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id s13so17338263wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 06:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=vXp3Sxctq9VkObljnq0YBLK27eqIoDcu7q1uLV6sriI=;
        b=lYFt4ET27fdwgzZV6Gkc4ybnFVihvBTJaIa6rJ+vsitRg1hhECDLPMNrdpsgFQdmOV
         0PTTMUTD+GZaxQySyfd5XbbEFujkcJjieVRlxFDe2/cD7kUTHyl3x8+xjDTROhn/uE8j
         5szxCxVKimS4TgY7ddfjMuND/xhWdZtPeKnv22na0aqW4L7tpe3g64rtV9D4Mh6JmQGj
         uH3GPwVwP9bDxDOFnpKADgK3RvvxajRKflO4Jh6QR0VkwDZIhAEhr/F6hNFeQX96NQYR
         UFBgfSgnWtnabYKvAS52Dmla9BQ1+EtyRfZ5vPL1hctcZTHhwrfBLfz540p28PkzWkzz
         9DkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=vXp3Sxctq9VkObljnq0YBLK27eqIoDcu7q1uLV6sriI=;
        b=Awj39azSL8+lchouPezpi3WVEAz1ZFRJogw0mLMJl1p84qjx+o2CTBtjmrETlv/M0U
         eWeDRWpHogr/+UIXynIqCrVLV6eP2wvd+dJrR9HG7IrBPyTafOLOwqtGLtKmJHEPaXG9
         CKBK0YJtxOxULgd3HZr2qtoLA4AT/Vs7dJaq/gVhFD/R0IoOnCMQAAeIhr9GweuMiI0I
         M2XhZi93TzsBfaR5LY0mk/6/x+e/0TNkdSYFV4+gWerAoDOHpHWEJGQ84tUTLMVluj09
         Jrt02r4KBdNjSQGRCsC7M0fT+3sIevRKsI/+dp5oyRoHu6ylMyz7yjWNPtabNJjUjXKq
         KHbw==
X-Gm-Message-State: AOAM530mh3POXD+mlnExdqT9K7itECQ/utnFwRuKvt9dGxYDConRI9pK
        Ri0hYN+2vDKq8fAhKCrbbHj1iw==
X-Google-Smtp-Source: ABdhPJw3gonmwJioLtDDPdO6LRztyMyzSHRvtjQP+sbEh6Jcgi2gQk8QcqDyOUwDBlBkeT0oTnf5sQ==
X-Received: by 2002:a1c:f219:: with SMTP id s25mr7258057wmc.67.1606140219296;
        Mon, 23 Nov 2020 06:03:39 -0800 (PST)
Received: from localhost (253.35.17.109.rev.sfr.net. [109.17.35.253])
        by smtp.gmail.com with ESMTPSA id x4sm4284619wrv.81.2020.11.23.06.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 06:03:38 -0800 (PST)
References: <20201120094205.525228-1-maz@kernel.org>
 <20201120094205.525228-2-maz@kernel.org>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Marc Zyngier <maz@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        kernel-team@android.com, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/meson: dw-hdmi: Disable clocks on driver teardown
In-reply-to: <20201120094205.525228-2-maz@kernel.org>
Message-ID: <1jwnyc41c6.fsf@starbuckisacylon.baylibre.com>
Date:   Mon, 23 Nov 2020 15:03:37 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 20 Nov 2020 at 10:42, Marc Zyngier <maz@kernel.org> wrote:

> The HDMI driver request clocks early, but never disable them, leaving
> the clocks on even when the driver is removed.
>
> Fix it by slightly refactoring the clock code, and register a devm
> action that will eventually disable/unprepare the enabled clocks.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/gpu/drm/meson/meson_dw_hdmi.c | 43 ++++++++++++++++++---------
>  1 file changed, 29 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> index 7f8eea494147..29623b309cb1 100644
> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> @@ -145,8 +145,6 @@ struct meson_dw_hdmi {
>  	struct reset_control *hdmitx_apb;
>  	struct reset_control *hdmitx_ctrl;
>  	struct reset_control *hdmitx_phy;
> -	struct clk *hdmi_pclk;
> -	struct clk *venci_clk;
>  	struct regulator *hdmi_supply;
>  	u32 irq_stat;
>  	struct dw_hdmi *hdmi;
> @@ -946,6 +944,29 @@ static void meson_disable_regulator(void *data)
>  	regulator_disable(data);
>  }
>  
> +static void meson_disable_clk(void *data)
> +{
> +	clk_disable_unprepare(data);
> +}
> +
> +static int meson_enable_clk(struct device *dev, char *name)
> +{
> +	struct clk *clk;
> +	int ret;
> +
> +	clk = devm_clk_get(dev, name);
> +	if (IS_ERR(clk)) {
> +		dev_err(dev, "Unable to get %s pclk\n", name);
> +		return PTR_ERR(clk);
> +	}
> +
> +	ret = clk_prepare_enable(clk);
> +	if (!ret)
> +		ret = devm_add_action_or_reset(dev, meson_disable_clk,
> clk);

Thanks for fixing this Marc.

FYI, while it is fine to declare a function to disable the clocks, a quick
cast may avoid it

devm_add_action_or_reset(dev, (void(*)(void *))clk_disable_unprepare, clk);

> +
> +	return ret;
> +}
> +
>  static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
>  				void *data)
>  {
> @@ -1026,19 +1047,13 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
>  	if (IS_ERR(meson_dw_hdmi->hdmitx))
>  		return PTR_ERR(meson_dw_hdmi->hdmitx);
>  
> -	meson_dw_hdmi->hdmi_pclk = devm_clk_get(dev, "isfr");
> -	if (IS_ERR(meson_dw_hdmi->hdmi_pclk)) {
> -		dev_err(dev, "Unable to get HDMI pclk\n");
> -		return PTR_ERR(meson_dw_hdmi->hdmi_pclk);
> -	}
> -	clk_prepare_enable(meson_dw_hdmi->hdmi_pclk);
> +	ret = meson_enable_clk(dev, "isfr");
> +	if (ret)
> +		return ret;
>  
> -	meson_dw_hdmi->venci_clk = devm_clk_get(dev, "venci");
> -	if (IS_ERR(meson_dw_hdmi->venci_clk)) {
> -		dev_err(dev, "Unable to get venci clk\n");
> -		return PTR_ERR(meson_dw_hdmi->venci_clk);
> -	}
> -	clk_prepare_enable(meson_dw_hdmi->venci_clk);
> +	ret = meson_enable_clk(dev, "venci");
> +	if (ret)
> +		return ret;
>  
>  	dw_plat_data->regm = devm_regmap_init(dev, NULL, meson_dw_hdmi,
>  					      &meson_dw_hdmi_regmap_config);

