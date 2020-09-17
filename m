Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3BC926D87B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 12:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgIQKKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 06:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbgIQKKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 06:10:08 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF42C061756
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 03:10:07 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id o8so2426087ejb.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 03:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=04WngnQ0jFkRbt43U2XgSIOKzRq0Sv9eq28pqM57V98=;
        b=1Y3onGh9sya70Zj5ROGYqM0vDIhG4Pml5qhYfxy8YUxodW4UyPXuWfE/5qvPW18y0G
         RsCoULWffDaThKdKHgV+HTshDZ76MBK1aNpTI/wJSVJT07+//6anf7CuheYFg56aKYGw
         bui1WW6rC7/1DHCi7LCOhxD5lqFdGhQaSRO+y9neK0mYMG0lTmyEMGgELYPpzU4HDDH2
         R3faJ4NB2MbBMe01Gnya+Z4mLbSxarcksrAe47iJArFWde/7tMEwGOWnlAXKFwAA6/lc
         +QsP8F6ezv0foahLyTK0ZRf82TXdj960eZvjztPyUV2eEpInVwBH9ZmvQGzsyDh2k1dD
         52ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=04WngnQ0jFkRbt43U2XgSIOKzRq0Sv9eq28pqM57V98=;
        b=OOFt7Na4yooGNJuqpbZjcJwtOL34Z8WapNNdviU0GWyf/UXMWsKOLCjM8er5tdcp+A
         j8+1fTv6IqMbHiYAFMBj8flBn1Z4EeP4GeFLVJmQfhGO8r84yQVKJfJTSztXqreBcYhn
         1v5fM/QBAFyv2J6nr6T91FyTHSqNrLVoZ++hnji0t43rLqzYATFEGsiaDjb9AT/SveGk
         tYryARF0hM3+afe4v3/twxdjz1Y0X49gb2JA0fHSMTrx95CpqpJwIRLD7vfNZxNWgOB/
         +uiBfJueI5Hysv3GMPQ48jGPYAcHDQRWp0KrsUmWi3SDhP+HLCMj3Fxg6WUgCYUKaPCF
         aq3w==
X-Gm-Message-State: AOAM530CpUbNMTOb0b/7AFpAR7PtdqVCV5emeXftyHV3cIEfd5SELtnn
        G1MDIoeC2RdWFRarmztBHPTl8yp9bi8zPruitQDM8A==
X-Google-Smtp-Source: ABdhPJxdb1PMRdnzgj842p+yq28ULJU3QGXnN/dhAo9RWsiz8goGZ+9Bi/ZDVoXn/zlS2GMz9d9ggFcKkxLuvSaAscM=
X-Received: by 2002:a17:906:f11:: with SMTP id z17mr30847115eji.88.1600337406050;
 Thu, 17 Sep 2020 03:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200916231650.11484-1-marek.behun@nic.cz> <20200916231650.11484-5-marek.behun@nic.cz>
In-Reply-To: <20200916231650.11484-5-marek.behun@nic.cz>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 17 Sep 2020 12:09:55 +0200
Message-ID: <CAMpxmJVC7J3awjDWVC49JaBQVrqiubG7Nz761FAv=zdXe_6Reg@mail.gmail.com>
Subject: Re: [PATCH leds v1 04/10] leds: max77650: use struct led_init_data
 when registering
To:     =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>
Cc:     Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 1:16 AM Marek Beh=C3=BAn <marek.behun@nic.cz> wrote=
:
>
> By using struct led_init_data when registering we do not need to parse
> `label` DT property nor `linux,default-trigger` property.
>
> Previously if the `label` DT property was not present, the code composed
> name for the LED in the form
>   "max77650::"
> For backwards compatibility we therefore set
>   init_data->default_label =3D ":";
> so that the LED will not get a different name if `label` property is not
> present.
>
> Signed-off-by: Marek Beh=C3=BAn <marek.behun@nic.cz>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/leds/leds-max77650.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/leds/leds-max77650.c b/drivers/leds/leds-max77650.c
> index a0d4b725c9178..1eeac56b00146 100644
> --- a/drivers/leds/leds-max77650.c
> +++ b/drivers/leds/leds-max77650.c
> @@ -66,7 +66,6 @@ static int max77650_led_probe(struct platform_device *p=
dev)
>         struct max77650_led *leds, *led;
>         struct device *dev;
>         struct regmap *map;
> -       const char *label;
>         int rv, num_leds;
>         u32 reg;
>
> @@ -86,6 +85,8 @@ static int max77650_led_probe(struct platform_device *p=
dev)
>                 return -ENODEV;
>
>         device_for_each_child_node(dev, child) {
> +               struct led_init_data init_data =3D {};
> +
>                 rv =3D fwnode_property_read_u32(child, "reg", &reg);
>                 if (rv || reg >=3D MAX77650_LED_NUM_LEDS) {
>                         rv =3D -EINVAL;
> @@ -99,22 +100,13 @@ static int max77650_led_probe(struct platform_device=
 *pdev)
>                 led->cdev.brightness_set_blocking =3D max77650_led_bright=
ness_set;
>                 led->cdev.max_brightness =3D MAX77650_LED_MAX_BRIGHTNESS;
>
> -               rv =3D fwnode_property_read_string(child, "label", &label=
);
> -               if (rv) {
> -                       led->cdev.name =3D "max77650::";
> -               } else {
> -                       led->cdev.name =3D devm_kasprintf(dev, GFP_KERNEL=
,
> -                                                       "max77650:%s", la=
bel);
> -                       if (!led->cdev.name) {
> -                               rv =3D -ENOMEM;
> -                               goto err_node_put;
> -                       }
> -               }
> -
> -               fwnode_property_read_string(child, "linux,default-trigger=
",
> -                                           &led->cdev.default_trigger);
> +               init_data.fwnode =3D child;
> +               init_data.devicename =3D "max77650";
> +               /* for backwards compatibility if `label` is not present =
*/
> +               init_data.default_label =3D ":";
>
> -               rv =3D devm_led_classdev_register(dev, &led->cdev);
> +               rv =3D devm_led_classdev_register_ext(dev, &led->cdev,
> +                                                   &init_data);
>                 if (rv)
>                         goto err_node_put;
>
> --
> 2.26.2
>

I don't know this new API very well but looks good to me.

Acked-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
