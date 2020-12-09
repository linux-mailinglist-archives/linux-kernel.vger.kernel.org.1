Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFFA2D4531
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 16:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbgLIPRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 10:17:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:36212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgLIPRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 10:17:17 -0500
X-Gm-Message-State: AOAM531RIST/S5aqf2kLsrs2Mzfq/6yLWpZpW0LofL5rpzqIDE5e+K+4
        59AYPAH/zWDf4tt3/5/Xnc11DV5G7X/dal+Mvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607526997;
        bh=lVUITqM3wBlLLCMwZfMJJE4f8P3aH4i3cxhdHeLKdwE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WslH8wEmlVpqaDl71ybxROkTosAnZP58mHbwXHmgn/KI38WaeTN8BA4JdV3C+xvMZ
         i8dJqxq4c8PUOBSMyxbpqx8/C7mXUlTwuHgkO5/2T8H1pF0jg44W5S/e0YTVLVPJ4W
         vKp/R/jS8Kc6l4iIpg1xEPhgGD1LRCe+vT4t98ZyYRG6aFZ7zuNyCL+Tjf8eieD7LR
         Dx29Fbf7NdBz9dNDzN3DvVPLjZr4ud8XY9X2E3/ylTSr2/ykw79GOgXsKahQC2ffT7
         bL4JPdHOOFOJNZBiXfDfl3g9NmZCFCmvvxNLATGJAPxF2okXj3vGzIy3ws+XBnLrns
         Y45NeBVWeVS9g==
X-Google-Smtp-Source: ABdhPJwKxFDtBsXbsk4rVRivDcq095HuspZwD+RLbGAZbMuQnyG4S281nM/2/1U0U35e2e5hS5J+PlmqXXWbfmPT88E=
X-Received: by 2002:adf:9567:: with SMTP id 94mr910638wrs.394.1607526995364;
 Wed, 09 Dec 2020 07:16:35 -0800 (PST)
MIME-Version: 1.0
References: <1607141728-17307-1-git-send-email-yongqiang.niu@mediatek.com>
 <1607141728-17307-5-git-send-email-yongqiang.niu@mediatek.com> <CANMq1KCX+iPXVg-xqVKBGNTfJty=cu+MQYaujjv4NgTd1C740A@mail.gmail.com>
In-Reply-To: <CANMq1KCX+iPXVg-xqVKBGNTfJty=cu+MQYaujjv4NgTd1C740A@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 9 Dec 2020 23:16:22 +0800
X-Gmail-Original-Message-ID: <CAAOTY__2CQ5mo6f0mXNHqcOg_xUCAd7LjkXS2OCf341Dm6rNCg@mail.gmail.com>
Message-ID: <CAAOTY__2CQ5mo6f0mXNHqcOg_xUCAd7LjkXS2OCf341Dm6rNCg@mail.gmail.com>
Subject: Re: [PATCH v1, 4/5] soc: mediatek: cmdq: add address shift in jump
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

Nicolas Boichat <drinkcat@chromium.org> =E6=96=BC 2020=E5=B9=B412=E6=9C=885=
=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=883:30=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Sat, Dec 5, 2020 at 12:16 PM Yongqiang Niu
> <yongqiang.niu@mediatek.com> wrote:
> >
> > Add address shift when compose jump instruction
> > to compatible with 35bit format.
>
> This looks reasonable, but task->cmdq->shift_pa is not new and was
> introduced as part of mt6779 GCE support.
>
> Do you want to add a Fixes tag?
> Fixes: 0858fde496f8 ("mailbox: cmdq: variablize address shift in platform=
")

Add this fixes tag, and move this patch out of this series because
this patch is related to all SoC whose shift_pa is not zero.

Regards,
Chun-Kuang.

>
> Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>
>
> >
> > Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > ---
> >  drivers/mailbox/mtk-cmdq-mailbox.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-c=
mdq-mailbox.c
> > index 1c01fe0..5ed39f8 100644
> > --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> > +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> > @@ -174,7 +174,8 @@ static void cmdq_task_insert_into_thread(struct cmd=
q_task *task)
> >         dma_sync_single_for_cpu(dev, prev_task->pa_base,
> >                                 prev_task->pkt->cmd_buf_size, DMA_TO_DE=
VICE);
> >         prev_task_base[CMDQ_NUM_CMD(prev_task->pkt) - 1] =3D
> > -               (u64)CMDQ_JUMP_BY_PA << 32 | task->pa_base;
> > +               (u64)CMDQ_JUMP_BY_PA << 32 |
> > +               (task->pa_base >> task->cmdq->shift_pa);
> >         dma_sync_single_for_device(dev, prev_task->pa_base,
> >                                    prev_task->pkt->cmd_buf_size, DMA_TO=
_DEVICE);
> >
> > --
> > 1.8.1.1.dirty
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
