Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56EFF2F1356
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 14:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbhAKNHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 08:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbhAKNGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 08:06:33 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E99FC061795
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 05:05:53 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id s75so20040422oih.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 05:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=32AMbD7JqvqTfJOA6mRlZcATxY9GlJ290keV9DKYi+U=;
        b=vbavSgfTX5r4VBBQ1t8Rd07gUOcwgaEfa6MNLKd2ZpZVeAfq4hXNUIs04fPddsxEqf
         xEbYuZp6cuiwyB791fKV0/6sXkfJZXML0shJduwRXmw6LzB3SQgYa7TPL5i8fWIXUZ4v
         XKjic147rn8oinoh7mK2VVqxA5w/tpR1ZoUVSaf9OqHp7U4GOqyXT4TS/BXfOYLakJsA
         B3JHPxwQZtJsr06gslGh7g0pyT4dy3KHzSXbSV+yor/Y7W9P0B5IZ5cwnTd17AuUtfL0
         IniEfnbXREVDWK0mLq+BxhjdFpWdQYrPG9mPkXETHCsGPKscgIi6oPkzaeDoZRmiVonc
         n8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=32AMbD7JqvqTfJOA6mRlZcATxY9GlJ290keV9DKYi+U=;
        b=VfwJVgNhzNIYtVoH8vgVCnonXixOzlj1d49ev9EHPuFIbvRgQ5jmotyySu5wIyTVdX
         L4rF+lF0fG0kVPxuSQLBBznzFGejX4jG31LpduAMIcSJ30vZfvBw1D5EXfIfhjS76TcH
         vlXNzyfo02PPO6Mdie/UCskv3MsX7Czcp6jrGMx4WjZD92/zL7uylYPY/6JYyO9g23Mj
         K6ZeJeQ09CgN6N+qlalBsfzc3JNJCC7U9WsT8l20XvFuNTyAGWr+MePxv1OQ37zbAjAS
         dhkcpraChZXAy7DWWIT2kpeWdsSvfzmvZe8inbn++pE3EDbVHQIGhi9ZVxsEjsi+EQIJ
         JxcQ==
X-Gm-Message-State: AOAM530PICQ46dsoj2awh5btPDlsGc+P+wW9LC4N3NpBw9dT3XKZcxYH
        Mtr6MNP/FrfXyuILRN7LUBL+uggvMprLZSiJ9hA=
X-Google-Smtp-Source: ABdhPJzguLowuko/yV4hNw+yFJ+Sm5NdnIJqP1kdJJLYyr1yI3lUtDVXhN6ed6MvPjHm53SEwGDFTuDWE4dv0PUO0aE=
X-Received: by 2002:aca:c492:: with SMTP id u140mr9920851oif.51.1610370352601;
 Mon, 11 Jan 2021 05:05:52 -0800 (PST)
MIME-Version: 1.0
References: <20210111123518.30438-1-matthias.bgg@kernel.org>
In-Reply-To: <20210111123518.30438-1-matthias.bgg@kernel.org>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Mon, 11 Jan 2021 21:05:41 +0800
Message-ID: <CAE+NS35Br8jgLfii=VPjFx+m+9=a=EQKYyoQMAyd7Zdo0K6n+A@mail.gmail.com>
Subject: Re: [PATCH] mfd: mt6360: Fix MFD cell names and compatibles
To:     matthias.bgg@kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Gene Chen <gene_chen@richtek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Matthias Brugger <mbrugger@suse.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

This change exists in [PATCH v7 03/11] mfd: mt6360: Indicate sub-dev
compatible name by using "-".
Does patch v7 also merge together to mfd-next?

<matthias.bgg@kernel.org> =E6=96=BC 2021=E5=B9=B41=E6=9C=8811=E6=97=A5 =E9=
=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=888:35=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Matthias Brugger <mbrugger@suse.com>
>
> MFD cell names and compatibles use '_' instead of '-', which is common
> practice for names and the standard for DT compatibles.
> This will also fix the probing for the drivers already implemented
> (mt6360-adc and mt6360-tcpc).
>
> Fixes: 7edd363421da ("mfd: Add support for PMIC MT6360")
> Fixes: 1f4877218f7e ("iio: adc: mt6360: Add ADC driver for MT6360")
> Fixes: e1aefcdd394f ("usb typec: mt6360: Add support for mt6360 Type-C dr=
iver")
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>
> ---
>
>  drivers/mfd/mt6360-core.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
> index 4661c1b29a72..14e649ffe50f 100644
> --- a/drivers/mfd/mt6360-core.c
> +++ b/drivers/mfd/mt6360-core.c
> @@ -292,18 +292,18 @@ static const struct resource mt6360_ldo_resources[]=
 =3D {
>  };
>
>  static const struct mfd_cell mt6360_devs[] =3D {
> -       OF_MFD_CELL("mt6360_adc", mt6360_adc_resources,
> -                   NULL, 0, 0, "mediatek,mt6360_adc"),
> -       OF_MFD_CELL("mt6360_chg", mt6360_chg_resources,
> -                   NULL, 0, 0, "mediatek,mt6360_chg"),
> -       OF_MFD_CELL("mt6360_led", mt6360_led_resources,
> -                   NULL, 0, 0, "mediatek,mt6360_led"),
> -       OF_MFD_CELL("mt6360_pmic", mt6360_pmic_resources,
> -                   NULL, 0, 0, "mediatek,mt6360_pmic"),
> -       OF_MFD_CELL("mt6360_ldo", mt6360_ldo_resources,
> -                   NULL, 0, 0, "mediatek,mt6360_ldo"),
> -       OF_MFD_CELL("mt6360_tcpc", NULL,
> -                   NULL, 0, 0, "mediatek,mt6360_tcpc"),
> +       OF_MFD_CELL("mt6360-adc", mt6360_adc_resources,
> +                   NULL, 0, 0, "mediatek,mt6360-adc"),
> +       OF_MFD_CELL("mt6360-chg", mt6360_chg_resources,
> +                   NULL, 0, 0, "mediatek,mt6360-chg"),
> +       OF_MFD_CELL("mt6360-led", mt6360_led_resources,
> +                   NULL, 0, 0, "mediatek,mt6360-led"),
> +       OF_MFD_CELL("mt6360-pmic", mt6360_pmic_resources,
> +                   NULL, 0, 0, "mediatek,mt6360-pmic"),
> +       OF_MFD_CELL("mt6360-ldo", mt6360_ldo_resources,
> +                   NULL, 0, 0, "mediatek,mt6360-ldo"),
> +       OF_MFD_CELL("mt6360-tcpc", NULL,
> +                   NULL, 0, 0, "mediatek,mt6360-tcpc"),
>  };
>
>  static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] =3D {
> --
> 2.29.2
>
