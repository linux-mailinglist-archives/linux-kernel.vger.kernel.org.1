Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA4D2820C4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 05:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgJCD0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 23:26:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgJCD0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 23:26:18 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47F7A20719
        for <linux-kernel@vger.kernel.org>; Sat,  3 Oct 2020 03:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601695577;
        bh=CBE60R04Ssh2X4r5oUkkDdZCifZI6pr2boyjVftGq04=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JYzuV6AlipFT9jR0QccHNBWhs+sWE/CY4+1YHGm7YJQy2byk5AdKePh9hbM7BKIcL
         LADPIBysqb2spD9KAib5bcNy0WE5/M8TeeJssN17ryj3IRqT/BwilY6iUdl/aStxY/
         BxsjjhPhX/t/cjHRDe7YLp1TD1VxFdxqyfSwvVFU=
Received: by mail-ej1-f51.google.com with SMTP id a3so4417712ejy.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 20:26:17 -0700 (PDT)
X-Gm-Message-State: AOAM53185vHURyHLyEUMbZZUMLXXo/uVUoE1B8FbYsN3uBHi7wVUZzl2
        AaA2BM/rikIBi7BcJDd8zDDcFAqR/oEb7qGTZA==
X-Google-Smtp-Source: ABdhPJyVT37Ny80mPGlIZPTaykVZw3A0gTf5M2DLK3vsvTWIDBjG6hSjhM5Hie0HqnCRjpNoKC1wpuzkQUpYZezZs38=
X-Received: by 2002:a17:906:158f:: with SMTP id k15mr187553ejd.310.1601695575882;
 Fri, 02 Oct 2020 20:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200827182507.4938-1-krzk@kernel.org>
In-Reply-To: <20200827182507.4938-1-krzk@kernel.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 3 Oct 2020 11:26:05 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9jC2CMws-xoRgLmcHY=4f1EbLaFRkjAPsC18rrWn12jQ@mail.gmail.com>
Message-ID: <CAAOTY_9jC2CMws-xoRgLmcHY=4f1EbLaFRkjAPsC18rrWn12jQ@mail.gmail.com>
Subject: Re: [PATCH v3] mailbox: mediatek: Fix handling of platform_get_irq() error
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>, HS Liao <hs.liao@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Frank Wunderlich <frank-w@public-files.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski <krzk@kernel.org> =E6=96=BC 2020=E5=B9=B48=E6=9C=8828=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=882:25=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> platform_get_irq() returns -ERRNO on error.  In such case casting to u32
> and comparing to 0 would pass the check.
>

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

> Fixes: 623a6143a845 ("mailbox: mediatek: Add Mediatek CMDQ driver")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> ---
>
> Changes since v2:
> 1. Fix subject.
>
> Changes since v1:
> 1. Correct u32->int,
> 2. Fix left-over '!'.
> ---
>  drivers/mailbox/mtk-cmdq-mailbox.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmd=
q-mailbox.c
> index 484d4438cd83..5665b6ea8119 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -69,7 +69,7 @@ struct cmdq_task {
>  struct cmdq {
>         struct mbox_controller  mbox;
>         void __iomem            *base;
> -       u32                     irq;
> +       int                     irq;
>         u32                     thread_nr;
>         u32                     irq_mask;
>         struct cmdq_thread      *thread;
> @@ -525,10 +525,8 @@ static int cmdq_probe(struct platform_device *pdev)
>         }
>
>         cmdq->irq =3D platform_get_irq(pdev, 0);
> -       if (!cmdq->irq) {
> -               dev_err(dev, "failed to get irq\n");
> -               return -EINVAL;
> -       }
> +       if (cmdq->irq < 0)
> +               return cmdq->irq;
>
>         plat_data =3D (struct gce_plat *)of_device_get_match_data(dev);
>         if (!plat_data) {
> --
> 2.17.1
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
