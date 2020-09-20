Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3F52717CE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 22:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgITUTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 16:19:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:47344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgITUTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 16:19:51 -0400
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EDA120874
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 20:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600633190;
        bh=tEYZWaBgSpMov9mzVr3tGK3tHnfa7SQH05Xon68mJR4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ovAyCNeeUSd3NZnEeh5eCA9mpVIaA8QFF7tGlC3YpLtwcdzFtMF3Rt544ERHqox7N
         fQ7yvB1Q0nRvaxpjBqMEM3lITWhcLqBshrgNgZ7XYU5WT8FO/ZVzXPIGthP4Sic2XW
         p3aLGnx29ctbCW6oomdHtiFO/iQ2Zohb6jWpntOs=
Received: by mail-ed1-f44.google.com with SMTP id g4so10940311edk.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 13:19:50 -0700 (PDT)
X-Gm-Message-State: AOAM530Fcpfi6/src+iJ2rBAFQL1ZZ7NLnoUFO2PGtENGbGVhZPRdJi4
        KbnTvbQLG62rRKyZOSWK0OOUEEc7mh4ETPfuqoo=
X-Google-Smtp-Source: ABdhPJxFz7US67oDidXdHLkxA0kibKoSZu7zgANW15rRIppXBC+z7UsnV7Li7qTAXWzW+XsS6Q/uhd8uyMQN56dLbow=
X-Received: by 2002:aa7:da16:: with SMTP id r22mr50413600eds.132.1600633188982;
 Sun, 20 Sep 2020 13:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200910140415.1132266-1-yanaijie@huawei.com>
In-Reply-To: <20200910140415.1132266-1-yanaijie@huawei.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Sun, 20 Sep 2020 22:19:37 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcsrL2T9EmiSnOhrC5Lh+ZM=nY4Go52cVDv1S6wxn5DHQ@mail.gmail.com>
Message-ID: <CAJKOXPcsrL2T9EmiSnOhrC5Lh+ZM=nY4Go52cVDv1S6wxn5DHQ@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: dpio: remove set but not used 'addr_cena'
To:     Jason Yan <yanaijie@huawei.com>
Cc:     Roy.Pledge@nxp.com, leoyang.li@nxp.com, youri.querry_1@nxp.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        Hulk Robot <hulkci@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Sep 2020 at 16:57, Jason Yan <yanaijie@huawei.com> wrote:
>
> This addresses the following gcc warning with "make W=3D1":
>
> drivers/soc/fsl/dpio/qbman-portal.c: In function
> =E2=80=98qbman_swp_enqueue_multiple_direct=E2=80=99:
> drivers/soc/fsl/dpio/qbman-portal.c:650:11: warning: variable
> =E2=80=98addr_cena=E2=80=99 set but not used [-Wunused-but-set-variable]
>   650 |  uint64_t addr_cena;
>       |           ^~~~~~~~~
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

This was already reported:
Reported-by: kernel test robot <lkp@intel.com>
https://lkml.org/lkml/2020/6/12/290

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

> ---
>  drivers/soc/fsl/dpio/qbman-portal.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/soc/fsl/dpio/qbman-portal.c b/drivers/soc/fsl/dpio/q=
bman-portal.c
> index 0ab85bfb116f..659b4a570d5b 100644
> --- a/drivers/soc/fsl/dpio/qbman-portal.c
> +++ b/drivers/soc/fsl/dpio/qbman-portal.c
> @@ -647,7 +647,6 @@ int qbman_swp_enqueue_multiple_direct(struct qbman_sw=
p *s,
>         const uint32_t *cl =3D (uint32_t *)d;
>         uint32_t eqcr_ci, eqcr_pi, half_mask, full_mask;
>         int i, num_enqueued =3D 0;
> -       uint64_t addr_cena;
>
>         spin_lock(&s->access_spinlock);
>         half_mask =3D (s->eqcr.pi_ci_mask>>1);
> @@ -701,7 +700,6 @@ int qbman_swp_enqueue_multiple_direct(struct qbman_sw=
p *s,
>
>         /* Flush all the cacheline without load/store in between */
>         eqcr_pi =3D s->eqcr.pi;
> -       addr_cena =3D (size_t)s->addr_cena;
>         for (i =3D 0; i < num_enqueued; i++)
>                 eqcr_pi++;
>         s->eqcr.pi =3D eqcr_pi & full_mask;
> --
> 2.25.4
>
