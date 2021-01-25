Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A0530236F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 11:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbhAYJ6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 04:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbhAYJzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:55:45 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E05C061797
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 01:54:31 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id w1so17049253ejf.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 01:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Zw2A4PmvGkvIaOPO4dltHemY15Z5MRMPTYZpSlWL5ig=;
        b=P56geHz/m9MZR1rZNqhwIn95s08AwDEtQX7IKuC0E40EwAbRv+kbvo7ADTroAht4+a
         2r4QPvru6E5fiz9eRgXRmtkMSM+4kyyVZxCmb9M9C8yjgxj/IOlBoohyIuNAiWMB5RKS
         A36hp7sdPv8eeitP7NWU+z+FS31a0EONA/9oyxB9pqehNScwZM4kbkzPZhk0ISv/2V4e
         qJbWGbDqBuBcV69DKX8cM2e4oSHosLKHYtq//HnOhIQKd4Iac/aL/TYjVBGCxQGB814v
         0CNpZd3U/1FQKhVVjm0SM9bNd+fVkjYdTcJZkxA1FoLFTcglVP8NUUlhWBRabId0elwY
         e64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Zw2A4PmvGkvIaOPO4dltHemY15Z5MRMPTYZpSlWL5ig=;
        b=Wak/uPpnabKaRjCM22/foM17j6T4S+TngccoaX5NNGDtkP+VusvwM2a9O/8l4oO0lS
         dMHg6RH+QzskWFFKMvKmXcYc+2jAge5KUZK01mnNqj66uybHzrrZVrihoChqV/Ga5uVL
         +31Zlq18G3K1DAWnmxpG2va1YmEPlPf8cm7yD6q9UhL/YmOePISc2Ehlsoi2EnpdsYGu
         FQei2Er48FH4GhIlh1wTu9jgG17+P3t8GBuC5O8F9wyQWF1DEzIkLXuBVYHq8nE0CwWg
         k2h2CuCrUOM4xHPJRZ1LQD8NTFzWL9ySDMmKkEOCWgvhVnAJyYuCQbtO1X7NlsVSegJg
         jYEA==
X-Gm-Message-State: AOAM531NaAvbJuyRzXQFY/Fjy+3WFiqZV00JKwZ8D4lc4EyEuQHui09C
        qhAw3eKiNIm78IjpPTH+fHdQUULy3ZSdQbc8Dgs=
X-Google-Smtp-Source: ABdhPJxSbZl/+QtoQ5yDbuOpa19YWGNkQ+ht+c77LU7fTBxuFHQ8Ed82RBQQ95Syo2PWSzIwmPf7VcbmuyfqIpon90c=
X-Received: by 2002:a17:906:c05a:: with SMTP id bm26mr851981ejb.288.1611568470606;
 Mon, 25 Jan 2021 01:54:30 -0800 (PST)
MIME-Version: 1.0
References: <4c2e79d4fa96befdc9a6c59c3ff27b0a34f9fb56.camel@googlemail.com>
 <1611222152.1561.5.camel@googlemail.com> <3753ba4c92fda75e646ccf629bb95e9d692ddbdb.camel@googlemail.com>
In-Reply-To: <3753ba4c92fda75e646ccf629bb95e9d692ddbdb.camel@googlemail.com>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Mon, 25 Jan 2021 10:54:19 +0100
Message-ID: <CABkfQAE6FiAi09uFWDEzZr-GTwZJ9NY9NBPMJe=s1jN-Mc6yBA@mail.gmail.com>
Subject: Re: [PATCH] regulator: pf8x00: set ramp_delay for bucks
To:     chf.fritz@googlemail.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun. 25 janv. 2021 =C3=A0 10:27, Christoph Fritz
<chf.fritz@googlemail.com> a =C3=A9crit :
>
> This patch sets ramp_delay for bucks to the max value given by the
> datasheet.
>
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> ---
>  drivers/regulator/pf8x00-regulator.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/regulator/pf8x00-regulator.c b/drivers/regulator/pf8=
x00-regulator.c
> index 1e5582d73405..edf5c88bf43e 100644
> --- a/drivers/regulator/pf8x00-regulator.c
> +++ b/drivers/regulator/pf8x00-regulator.c
> @@ -351,6 +351,7 @@ static const struct regulator_ops pf8x00_vsnvs_ops =
=3D {
>                         .type =3D REGULATOR_VOLTAGE,              \
>                         .id =3D PF8X00_BUCK ## _id,               \
>                         .owner =3D THIS_MODULE,                   \
> +                       .ramp_delay =3D 19000,                    \
>                         .linear_ranges =3D pf8x00_sw1_to_6_voltages, \
>                         .n_linear_ranges =3D \
>                                 ARRAY_SIZE(pf8x00_sw1_to_6_voltages), \
> @@ -381,6 +382,7 @@ static const struct regulator_ops pf8x00_vsnvs_ops =
=3D {
>                         .type =3D REGULATOR_VOLTAGE,              \
>                         .id =3D PF8X00_BUCK7,             \
>                         .owner =3D THIS_MODULE,                   \
> +                       .ramp_delay =3D 19000,                    \
>                         .volt_table =3D voltages,                 \
>                         .vsel_reg =3D (base) + SW_RUN_VOLT,       \
>                         .vsel_mask =3D 0xff,                      \
> --
> 2.29.2
>
>
 Reviewed-by: Adrien Grassein <adrien.grassein@gmail.com>


Thanks,
