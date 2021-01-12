Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5652F263D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 03:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbhALCZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 21:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbhALCZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 21:25:20 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CC8C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 18:24:40 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id c12so451172pfo.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 18:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=SISj645y7U11lEUeP9Q8kOzNgAgaKxhl0Sm/tHsRwOw=;
        b=I/QcHr3p+8epebF2hlR7MJTWwLXRnjF+KdMOb1RfuRzSvzGn8wPPzz5r1MibNKE0eU
         k6brsVK3oFxYomsW4/H0GDlsvQ/MMpgzgbbnYV64S+HCtJBlfZZzykg9M4NuovsWWLvs
         7pmIt+MQeEs8A9cYm1tEf/pYYPiiTax0cQLss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=SISj645y7U11lEUeP9Q8kOzNgAgaKxhl0Sm/tHsRwOw=;
        b=rhSGNerRLaSSuqvFgLv0+abVKjmjtJDIulOXTdLIxbCuLUSunrnNIAG+w9mEcSL16k
         j7mYU+7kmO8lVkx9mrf77YGiY+GkF3NY7LbzcjNRcGtSg3old3yMUKQE97qZ0YYJhtft
         rTTDAE93+wDnCyGkMjHrifwfOotVV5dZIjvGHQs6kIpVUPi3AjnTNmA5ww3K+XZiQ0ef
         j7F60lMW9ZFAI/pfZJ0gBp9WJ5CNOvrjOj3hrjq2/JDpxGnHtxAHCihZkaMopogUDnT2
         fDNE4POtjzJtPo5x/Tcwg9AljBJ322Wp85g7C65vw9sDvG6ToPsWkKQkE1mLlTU1KwK7
         tA5g==
X-Gm-Message-State: AOAM530qGynF7V5v3KzLXF2uuxknDivtLO3NLxfnHLnQi4rCAKdTMcr7
        9KOhRxaW32apazH/mubozNht+Q==
X-Google-Smtp-Source: ABdhPJwS89WtkBJ16U183qhj3Lb3Ia6QIPD8/pWO/OmJ1nrO2lCKLXY7bSVKK0tls/7Xj0BGPRTm/w==
X-Received: by 2002:a63:cf43:: with SMTP id b3mr2308350pgj.387.1610418279511;
        Mon, 11 Jan 2021 18:24:39 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id x27sm999673pfr.122.2021.01.11.18.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 18:24:38 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210107154200.v4.2.Ibe7d7d53c5b4fe72c60de90111ff763b53f38dbb@changeid>
References: <20210107154200.v4.1.I025fb861cd5fa0ef5286b7dce514728e9df7ae74@changeid> <20210107154200.v4.2.Ibe7d7d53c5b4fe72c60de90111ff763b53f38dbb@changeid>
Subject: Re: [PATCH v4 2/2] Input: cros-ec-keyb - Expose function row physical map to userspace
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     dianders@chromium.org, Philip Chen <philipchen@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        Philip Chen <philipchen@chromium.org>,
        dmitry.torokhov@gmail.com
Date:   Mon, 11 Jan 2021 18:24:36 -0800
Message-ID: <161041827643.3661239.17919996906733477213@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Philip Chen (2021-01-07 15:42:09)
> The top-row keys in a keyboard usually have dual functionalities.
> E.g. A function key "F1" is also an action key "Browser back".
>=20
> Therefore, when an application receives an action key code from
> a top-row key press, the application needs to know how to correlate
> the action key code with the function key code and do the conversion
> whenever necessary.
>=20
> Since the userpace already knows the key scanlines (row/column)
> associated with a received key code. Essentially, the userspace only
> needs a mapping between the key row/column and the matching physical
> location in the top row.
>=20
> This patch enhances the cros-ec-keyb driver to create such a mapping
> and expose it to userspace in the form of a function-row-physmap
> attribute. The attribute would be a space separated ordered list of
> row/column codes, for the keys in the function row, in a left-to-right
> order.
>=20
> The attribute will only be present when the device has a custom design
> for the top-row keys.

Is it documented in Documentation/ABI/?

>=20
> Signed-off-by: Philip Chen <philipchen@chromium.org>
> ---
>=20
> Changes in v4:
> - replace sysfs_create_group() with devm_device_add_group()
> - remove an unused member in struct cros_ec_keyb
>=20
> Changes in v3:
> - parse `function-row-physmap` from DT earlier, when we probe
>   cros_ec_keyb, and then store the extracted info in struct cros_ec_keyb.
>=20
> Changes in v2:
> - create function-row-physmap file in sysfs by parsing
>   `function-row-physmap` property from DT
> - assume the device already has a correct keymap to reflect the custom
>   top-row keys (if they exist)
>=20
>  drivers/input/keyboard/cros_ec_keyb.c | 78 +++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
>=20
> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboa=
rd/cros_ec_keyb.c
> index b379ed7628781..75d1cb29734ce 100644
> --- a/drivers/input/keyboard/cros_ec_keyb.c
> +++ b/drivers/input/keyboard/cros_ec_keyb.c
> @@ -27,6 +27,8 @@
> =20
>  #include <asm/unaligned.h>
> =20
> +#define MAX_NUM_TOP_ROW_KEYS   15
> +

Ah, the binding could say max is 15 then.

>  /**
>   * struct cros_ec_keyb - Structure representing EC keyboard device
>   *
> @@ -42,6 +44,9 @@
>   * @idev: The input device for the matrix keys.
>   * @bs_idev: The input device for non-matrix buttons and switches (or NU=
LL).
>   * @notifier: interrupt event notifier for transport devices
> + * @function_row_physmap: An array of the encoded rows/columns for the t=
op
> + *                        row function keys, in an order from left to ri=
ght
> + * @num_function_row_keys: The number of top row keys in a custom keyboa=
rd
>   */
>  struct cros_ec_keyb {
>         unsigned int rows;
> @@ -58,6 +63,9 @@ struct cros_ec_keyb {
>         struct input_dev *idev;
>         struct input_dev *bs_idev;
>         struct notifier_block notifier;
> +
> +       u16 function_row_physmap[MAX_NUM_TOP_ROW_KEYS];
> +       u8 num_function_row_keys;

Why not size_t?

>  };
> =20
>  /**
> @@ -527,6 +535,8 @@ static int cros_ec_keyb_register_matrix(struct cros_e=
c_keyb *ckdev)
>         struct input_dev *idev;
>         const char *phys;
>         int err;
> +       u32 top_row_key_pos[MAX_NUM_TOP_ROW_KEYS] =3D {0};
> +       u8 i;
> =20
>         err =3D matrix_keypad_parse_properties(dev, &ckdev->rows, &ckdev-=
>cols);
>         if (err)
> @@ -578,6 +588,22 @@ static int cros_ec_keyb_register_matrix(struct cros_=
ec_keyb *ckdev)
>         ckdev->idev =3D idev;
>         cros_ec_keyb_compute_valid_keys(ckdev);
> =20
> +       if (of_property_read_variable_u32_array(dev->of_node,
> +                                               "function-row-physmap",
> +                                               top_row_key_pos,
> +                                               0,
> +                                               MAX_NUM_TOP_ROW_KEYS) > 0=
) {
> +               for (i =3D 0; i < MAX_NUM_TOP_ROW_KEYS; i++) {

Can we deindent this once with of_property_for_each_u32()?

> +                       if (!top_row_key_pos[i])
> +                               break;
> +                       ckdev->function_row_physmap[i] =3D MATRIX_SCAN_CO=
DE(
> +                                               KEY_ROW(top_row_key_pos[i=
]),
> +                                               KEY_COL(top_row_key_pos[i=
]),

And then have a local variable for top_row_key_pos[i] so this is
shorter.

> +                                               ckdev->row_shift);
> +               }
> +               ckdev->num_function_row_keys =3D i;
> +       }
> +
>         err =3D input_register_device(ckdev->idev);
>         if (err) {
>                 dev_err(dev, "cannot register input device\n");
> @@ -587,6 +613,52 @@ static int cros_ec_keyb_register_matrix(struct cros_=
ec_keyb *ckdev)
>         return 0;
>  }
> =20
> +static ssize_t function_row_physmap_show(struct device *dev,
> +                                        struct device_attribute *attr,
> +                                        char *buf)
> +{
> +       ssize_t size =3D 0;
> +       u8 i;

int i? Why u8? Surely the size of a local variable isn't important.

> +       struct cros_ec_keyb *ckdev =3D dev_get_drvdata(dev);
> +
> +       if (!ckdev->num_function_row_keys)
> +               return 0;
> +
> +       for (i =3D 0; i < ckdev->num_function_row_keys; i++)
> +               size +=3D scnprintf(buf + size, PAGE_SIZE - size, "%02X ",
> +                                 ckdev->function_row_physmap[i]);
> +       size +=3D scnprintf(buf + size, PAGE_SIZE - size, "\n");
> +
> +       return size;

I'd rather see

	ssize_t size =3D 0;
	int i;
	struct cros_ec_keyb *ckdev =3D dev_get_drvdata(dev);
	u16 *physmap =3D ckdev->function_row_physmap;
=09
	for (i =3D 0; i < ckdev->num_function_row_keys; i++)
		size +=3D scnprintf(buf + size, PAGE_SIZE - size,
				  "%s%02X", size ? " " : "", physmap[i]);

	if (size)
		size +=3D scnprintf(buf + size, PAGE_SIZE - size, "\n");

	return size;

And I wonder if hex_dump_to_buffer() works for this?
