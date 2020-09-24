Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8053C277A1B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 22:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgIXUWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 16:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIXUWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 16:22:37 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBA1C0613CE;
        Thu, 24 Sep 2020 13:22:37 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id z19so295999lfr.4;
        Thu, 24 Sep 2020 13:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=brE6v+PgA6FJ2dU2AD140ORTA0itDZcq4xRrk6BKZMM=;
        b=DtyfFRVunusaNAXahnNWGweC32SHMmshwBPIJAKLPbmbKDKZqRbmsXpq9MwzHT2ZTL
         ECQ9ILRpREa9cJoWCjLrYnZpgoTaq3adkRZiBSzHGkmbJFK6A+hV2BFCDbYIXlmMsyLO
         nrpkXSgbEUJ25/HL1e8GbxY2Np21CiAjiqzKNWV8RozczEnwvJlit9EpdZsOClsECxYd
         NmxxqdebgGBYLW1y9tNc4YsJhOk+qyjKePTZ/+5WkDslH068i5RDrOSXZB2cfseiPwXi
         1XHpb61yiD5IqIwtSzPGctjyrvopYwIRhrsYa/g21mKtpXovNnBI+yaSK6Di1pctOSeu
         ry3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=brE6v+PgA6FJ2dU2AD140ORTA0itDZcq4xRrk6BKZMM=;
        b=r/oh/0mh8EpErym8KivYBJQWEOP3OvwI9Y6M/0mPXHcA8Vlfh4PcLa259xBGqUG5CD
         KDp5fC16WJTd5qsKYEG/DUWhtgAX9Ms6yEHKfkRgxfiKHi2ykD6a6dlbbQHErzFUJ14j
         QUyoV1OaC2qcraptQLAvXraYjO0IQih1VybqjrjcK+gnkRzOBr0kngpFYGJL7XMuCxjB
         4cwEy1VBUYzO6bfcG2yTkhXqn0kNs7loaA7NK9J6YQrI21Fr86SGULTi8XMxYE/Gnonz
         5w8pPDA+zBj90kjx6RUf+DrLbdHSHL21CCq+nbZKRe0NZ16Y6jpk+4QVKqRuKxzFsdhq
         rNAQ==
X-Gm-Message-State: AOAM532efeyvZUx3R+CfNxpdB05ghmJBZzDIoBTAslS9zOTVEDvIsmaL
        NJs3pOUFvtkUaf+DzuqdYQ7W/JmIXsMatM5sigo=
X-Google-Smtp-Source: ABdhPJyzsymEO5+8ArwUCaLPi7Z1BAU2Eh2QCjGHPncS54IsFCJ5uYytpqdEDWHlwytq1l/0Nzwk22meeaFRsJ1Xk0w=
X-Received: by 2002:ac2:4e92:: with SMTP id o18mr197010lfr.527.1600978955722;
 Thu, 24 Sep 2020 13:22:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200924200507.1175888-1-mr.nuke.me@gmail.com>
In-Reply-To: <20200924200507.1175888-1-mr.nuke.me@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 24 Sep 2020 17:22:23 -0300
Message-ID: <CAOMZO5B4S3JCVQAi-y=vKaQv3AF6eXronTkmG_DZs_ALtEHtgA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/bridge: sii902x: Enable I/O and core VCC supplies
 if present
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     DRI mailing list <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On Thu, Sep 24, 2020 at 5:16 PM Alexandru Gagniuc <mr.nuke.me@gmail.com> wrote:

> +       ret = regulator_enable(sii902x->cvcc12);
> +       if (ret < 0) {
> +               dev_err(dev, "Failed to enable cvcc12 supply: %d\n", ret);
> +               regulator_disable(sii902x->iovcc);
> +               return PTR_ERR(sii902x->cvcc12);

return ret;

>
>         ret = regmap_write(sii902x->regmap, SII902X_REG_TPI_RQB, 0x0);
> @@ -1012,11 +1052,11 @@ static int sii902x_probe(struct i2c_client *client,
>         regmap_read(sii902x->regmap, SII902X_INT_STATUS, &status);
>         regmap_write(sii902x->regmap, SII902X_INT_STATUS, status);
>
> -       if (client->irq > 0) {
> +       if (sii902x->i2c->irq > 0) {

Unrelated change.

>                 regmap_write(sii902x->regmap, SII902X_INT_ENABLE,
>                              SII902X_HOTPLUG_EVENT);
>
> -               ret = devm_request_threaded_irq(dev, client->irq, NULL,
> +               ret = devm_request_threaded_irq(dev, sii902x->i2c->irq, NULL,

 Unrelated change.
                                                 sii902x_interrupt,
>                                                 IRQF_ONESHOT, dev_name(dev),
>                                                 sii902x);
> @@ -1031,9 +1071,9 @@ static int sii902x_probe(struct i2c_client *client,
>
>         sii902x_audio_codec_init(sii902x, dev);
>
> -       i2c_set_clientdata(client, sii902x);
> +       i2c_set_clientdata(sii902x->i2c, sii902x);

Unrelated change.

> -       sii902x->i2cmux = i2c_mux_alloc(client->adapter, dev,
> +       sii902x->i2cmux = i2c_mux_alloc(sii902x->i2c->adapter, dev,

Unrelated change.
