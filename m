Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152442312D5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 21:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732893AbgG1Th7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 15:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729838AbgG1Th6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 15:37:58 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4675C0619D2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 12:37:58 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a9so456582pjd.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 12:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=XvERaqFheH0HRUPOb8gs3iC+0Q5eyWBPoexQsxXgrJ4=;
        b=B952i8sjasHSiAKM9favYcPbSad3O4QOLiVT+vUDeBVL4e54NhZ3Af0zWfZ3qipUWh
         Bbe8OAlmQou7V5E7NaSGbiT/GpzA0GnIxQ4SOKyR1+WJCkiSyZj5q/wPCeHpHkkV0FOM
         AnzsKDfOh2C+2HNkfzQ5VJpxY4TGuSGsfmWV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=XvERaqFheH0HRUPOb8gs3iC+0Q5eyWBPoexQsxXgrJ4=;
        b=hiOzKI5e6cHhvS2piqGZTsZTHzWveK4l2lQgHWPX3scZVrIV79sTbP/6pTFXxu9iqB
         po4BiACTdO5iY90jAzqG4ATzMDdUt8kxnk6vhJssect7E1u3ZCcPIpEkFD1YNkTXPAHu
         qAfkGIXvpwZVb05ihYhz7aDLUEO667ZOA6dKuYK5hVnVI/XcFDyIyjEPqBZjlG8jd4aA
         EiWISNGJxS3pfFt+mOwu5Cu6hRLwQeJeCSQgFzITm1bjNna2qYXgLYrVss+wI/vAyilN
         scwSEoaLo8KjHpANp3oB4wsWDxcU5/aQTp9395ueoT7kqr2LDeqTJhAWmTPqTSmbHll7
         8peg==
X-Gm-Message-State: AOAM5321NEBgr57d7t3GUm9VB+pSL7CZl93G/t3uTEsojba16ndJgSWy
        +25PqCO7epQenOtzPkwdX2tPXw==
X-Google-Smtp-Source: ABdhPJx8Ozl0JiSmdLvPYl2ISDoCK9PBJEQjs0xYqc1jKnDf7w2sK1QD0gqDay8iUxq7nQTuGD9KyA==
X-Received: by 2002:a17:90a:22ab:: with SMTP id s40mr6376782pjc.117.1595965078315;
        Tue, 28 Jul 2020 12:37:58 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id b13sm9150898pgd.36.2020.07.28.12.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 12:37:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200728091057.8.I34c7a1bfca7fe3d607f8876ef9f10c22153556d2@changeid>
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid> <20200728151258.1222876-1-campello@chromium.org> <20200728091057.8.I34c7a1bfca7fe3d607f8876ef9f10c22153556d2@changeid>
Subject: Re: [PATCH 08/15] iio: sx9310: Use regmap_read_poll_timeout() for compensation
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
To:     Daniel Campello <campello@chromium.org>,
        LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 28 Jul 2020 12:37:56 -0700
Message-ID: <159596507657.1360974.12104693281408043672@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Campello (2020-07-28 08:12:51)
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx931=
0.c
> index 2465064971d0a7..3956fd679c6db9 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -810,22 +810,17 @@ static int sx9310_init_compensation(struct iio_dev =
*indio_dev)
>         if (ret < 0)
>                 return ret;
> =20
> -       for (i =3D 100; i >=3D 0; i--) {
> -               msleep(20);
> -               ret =3D regmap_read(data->regmap, SX9310_REG_STAT1, &val);
> -               if (ret < 0)
> -                       goto out;
> -               if (!(val & SX9310_COMPSTAT_MASK))
> -                       break;
> -       }
> -
> -       if (i < 0) {
> -               dev_err(&data->client->dev,
> -                       "initial compensation timed out: 0x%02x", val);
> -               ret =3D -ETIMEDOUT;
> +       ret =3D regmap_read_poll_timeout(data->regmap, SX9310_REG_STAT1, =
val,
> +                                      !(val & SX9310_REG_STAT1_COMPSTAT_=
MASK),
> +                                      20000, 2000000);
> +       if (ret) {
> +               if (ret =3D=3D -ETIMEDOUT)
> +                       dev_err(&data->client->dev,
> +                               "0x02 << 3l compensation timed out: 0x%02=
x",

What does 0x02 << 3l mean?

> +                               val);
> +               return ret;
>         }
>
