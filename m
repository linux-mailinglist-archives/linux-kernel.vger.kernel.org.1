Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F7F2F0437
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 00:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbhAIXAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 18:00:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:46104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbhAIXAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 18:00:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D80D238E8
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 22:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610233184;
        bh=fnoMgybr+1G8nuwpGXS+MC2Rlg+Qkb5sQs6b/Ft7L/8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cbsV4BqtD6w0gO5iPcgjgMz7uF/CVhwf5IientYpv2WVOdJPOSS8Rd7saou2Rp06H
         20373RonIDE7vNkJkPkN3vCC0jkUbwgPFQvJ1mS5Z2YP8m6qEWo1ut8qXSZE4JgGOs
         wwHboK8O7R3MkRA3wkP82cp8B7QZH0iX6JOZ20YTHcNZ9WnD++0wu9YieoIyr0/buY
         PXaasg9VanpmG0PwZXufzxTcQgQPpdPTKlwnng934zLLvBPFyjruCbBGGUqDrZW80r
         RWuiXe+LZ5ztLsPpkvzY7fA+jwtRgqkPMhQYFlC5S33B2ZoRVkA3wzHoi8zm3aZdFT
         CIhyzkDt2MBsA==
Received: by mail-ed1-f51.google.com with SMTP id y24so14922995edt.10
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 14:59:44 -0800 (PST)
X-Gm-Message-State: AOAM530jopB6nV64LN+ak1JYkPmC7ZuIPqd81vg8WPojx2SdyXAI3WsX
        9ZsV/tNmgP386b28cRxw92zqgxPIb9Q4UBa3Yw==
X-Google-Smtp-Source: ABdhPJzg/pGerCaQWoQQQmH4uyvNLs23kMnBDhHhKxh3kBiwEEtWRcupfoLlQtwoM6WHVeOmHlY13STveFAlYY4+9P0=
X-Received: by 2002:a05:6402:3048:: with SMTP id bu8mr9553978edb.49.1610233182880;
 Sat, 09 Jan 2021 14:59:42 -0800 (PST)
MIME-Version: 1.0
References: <20201202235856.7652-1-chunkuang.hu@kernel.org>
In-Reply-To: <20201202235856.7652-1-chunkuang.hu@kernel.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 10 Jan 2021 06:59:30 +0800
X-Gmail-Original-Message-ID: <CAAOTY__p4C0ctXuOFu42-9HaTrGnOef-Sg47pyC0Uk7yN5406w@mail.gmail.com>
Message-ID: <CAAOTY__p4C0ctXuOFu42-9HaTrGnOef-Sg47pyC0Uk7yN5406w@mail.gmail.com>
Subject: Re: [PATCH] soc: mediatek: cmdq: Remove cmdq_pkt_flush()
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Matthias:

Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2020=E5=B9=B412=E6=9C=883=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=887:59=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> rx_callback is a standard mailbox callback mechanism and could
> cover the function of proprietary cmdq_task_cb, so it is better
> to use the standard one instead of the proprietary one. But
> register rx_callback should before mbox_request_channel(),
> so remove cmdq_pkt_flush() and let client driver implement
> its own synchronous flush.

How do you think about this patch? This patch is derived from [1]
according to Jassi's suggestion [2].

[1] https://patchwork.kernel.org/project/linux-mediatek/patch/2020092723042=
2.11610-3-chunkuang.hu@kernel.org/
[2] https://patchwork.kernel.org/project/linux-mediatek/cover/2020092723042=
2.11610-1-chunkuang.hu@kernel.org/

Regards,
Chun-Kuang.

>
> Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> ---
>  drivers/soc/mediatek/mtk-cmdq-helper.c | 32 --------------------------
>  include/linux/soc/mediatek/mtk-cmdq.h  | 12 ----------
>  2 files changed, 44 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediate=
k/mtk-cmdq-helper.c
> index 505651b0d715..fd3bc39538a1 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -502,36 +502,4 @@ int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_=
async_flush_cb cb,
>  }
>  EXPORT_SYMBOL(cmdq_pkt_flush_async);
>
> -struct cmdq_flush_completion {
> -       struct completion cmplt;
> -       bool err;
> -};
> -
> -static void cmdq_pkt_flush_cb(struct cmdq_cb_data data)
> -{
> -       struct cmdq_flush_completion *cmplt;
> -
> -       cmplt =3D (struct cmdq_flush_completion *)data.data;
> -       if (data.sta !=3D CMDQ_CB_NORMAL)
> -               cmplt->err =3D true;
> -       else
> -               cmplt->err =3D false;
> -       complete(&cmplt->cmplt);
> -}
> -
> -int cmdq_pkt_flush(struct cmdq_pkt *pkt)
> -{
> -       struct cmdq_flush_completion cmplt;
> -       int err;
> -
> -       init_completion(&cmplt.cmplt);
> -       err =3D cmdq_pkt_flush_async(pkt, cmdq_pkt_flush_cb, &cmplt);
> -       if (err < 0)
> -               return err;
> -       wait_for_completion(&cmplt.cmplt);
> -
> -       return cmplt.err ? -EFAULT : 0;
> -}
> -EXPORT_SYMBOL(cmdq_pkt_flush);
> -
>  MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/me=
diatek/mtk-cmdq.h
> index 960704d75994..2c6aa84c0e80 100644
> --- a/include/linux/soc/mediatek/mtk-cmdq.h
> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> @@ -288,16 +288,4 @@ int cmdq_pkt_finalize(struct cmdq_pkt *pkt);
>  int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
>                          void *data);
>
> -/**
> - * cmdq_pkt_flush() - trigger CMDQ to execute the CMDQ packet
> - * @pkt:       the CMDQ packet
> - *
> - * Return: 0 for success; else the error code is returned
> - *
> - * Trigger CMDQ to execute the CMDQ packet. Note that this is a
> - * synchronous flush function. When the function returned, the recorded
> - * commands have been done.
> - */
> -int cmdq_pkt_flush(struct cmdq_pkt *pkt);
> -
>  #endif /* __MTK_CMDQ_H__ */
> --
> 2.17.1
>
