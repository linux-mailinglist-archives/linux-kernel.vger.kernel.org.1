Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5DA2A2297
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 01:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbgKBAob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 19:44:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:43552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727333AbgKBAoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 19:44:30 -0500
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C973222273
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 00:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604277870;
        bh=KaiRQcVGa2tJ5Os4qhu+MrURan2Yqg+O/vf3Vf6r8s8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GQx/7dTfbZIc7nbb5piys34SR6dIcocJeeXnq/6g5wzMj/K3PpuW14+vOeY8VJ5FG
         oKaLG9iLzD4xpKKNwjhfxWeNAiDxuRTMalNKpajsfEXBU9uGd6azINpR+Bgcon6SKX
         M8BB9dNf8CbxP/Hu8Zf0WbRO4Z54dPS9HBt5pEOg=
Received: by mail-ej1-f46.google.com with SMTP id w13so3112794eju.13
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 16:44:29 -0800 (PST)
X-Gm-Message-State: AOAM532Zfc118Koxoh175r+EUObbyzKs/G9IqOidf9rfL0pnhSIixWIX
        LYTjDDFBEGtEsg/TpQy2jPJZ/aKu5eYYHpzzpw==
X-Google-Smtp-Source: ABdhPJwGZn1L0J2z44IZ7UtfYj6caCXaAHlZNLx7AoHZzD3yaqaIFQpMruMolz2btjWEYWDaJVAPiBvKcCD32EssBOo=
X-Received: by 2002:a17:906:3e49:: with SMTP id t9mr3688121eji.75.1604277868412;
 Sun, 01 Nov 2020 16:44:28 -0800 (PST)
MIME-Version: 1.0
References: <20201022094152.17662-1-houlong.wei@mediatek.com>
In-Reply-To: <20201022094152.17662-1-houlong.wei@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 2 Nov 2020 08:44:16 +0800
X-Gmail-Original-Message-ID: <CAAOTY_95Y9Jfq3FmhVa6QG7DdTWOOuekpvQj9OuRZ6GjHnVTKQ@mail.gmail.com>
Message-ID: <CAAOTY_95Y9Jfq3FmhVa6QG7DdTWOOuekpvQj9OuRZ6GjHnVTKQ@mail.gmail.com>
Subject: Re: [PATCH] soc: mediatek: cmdq: fixup possible timeout issue
To:     Houlong Wei <houlong.wei@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK HU <ck.hu@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ginny.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Houlong:

Houlong Wei <houlong.wei@mediatek.com> =E6=96=BC 2020=E5=B9=B410=E6=9C=8822=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=885:55=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Fixes: 576f1b4bc802 ("soc: mediatek: Add Mediatek CMDQ helper")
>
> There may be possible timeout issue when lots of cmdq packets are
> flushed to the same cmdq client. The necessary modifications are as
> below.
> 1.Adjust the timer timeout period as client->timeout_ms * client->pkt_cnt=
.
> 2.Optimize the time to start the timer.
>
> Signed-off-by: Houlong Wei <houlong.wei@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-cmdq-helper.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediate=
k/mtk-cmdq-helper.c
> index dc644cfb6419..31142c193527 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -350,7 +350,8 @@ static void cmdq_pkt_flush_async_cb(struct cmdq_cb_da=
ta data)
>                         del_timer(&client->timer);
>                 else
>                         mod_timer(&client->timer, jiffies +
> -                                 msecs_to_jiffies(client->timeout_ms));
> +                                 msecs_to_jiffies(client->timeout_ms *
> +                                                  client->pkt_cnt));
>                 spin_unlock_irqrestore(&client->lock, flags);
>         }
>
> @@ -379,9 +380,7 @@ int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_a=
sync_flush_cb cb,
>
>         if (client->timeout_ms !=3D CMDQ_NO_TIMEOUT) {
>                 spin_lock_irqsave(&client->lock, flags);
> -               if (client->pkt_cnt++ =3D=3D 0)
> -                       mod_timer(&client->timer, jiffies +
> -                                 msecs_to_jiffies(client->timeout_ms));
> +               client->pkt_cnt++;
>                 spin_unlock_irqrestore(&client->lock, flags);
>         }
>
> @@ -391,6 +390,21 @@ int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_=
async_flush_cb cb,
>         /* We can send next packet immediately, so just call txdone. */
>         mbox_client_txdone(client->chan, 0);
>
> +       if (client->timeout_ms !=3D CMDQ_NO_TIMEOUT) {
> +               spin_lock_irqsave(&client->lock, flags);
> +               /*
> +                * GCE HW maybe execute too quickly and the callback func=
tion
> +                * may be invoked earlier. If this happens, pkt_cnt is re=
duced
> +                * by 1 in cmdq_pkt_flush_async_cb(). The timer is set on=
ly if
> +                * pkt_cnt is greater than 0.
> +                */
> +               if (client->pkt_cnt > 0)
> +                       mod_timer(&client->timer, jiffies +
> +                                 msecs_to_jiffies(client->timeout_ms *
> +                                                  client->pkt_cnt));

I think for some client, it care about execution time of one packet,
but some client care about total execution time of all packets, so we
should let client driver implement its own timeout handler and remove
handler in cmdq helper [1].

[1] https://patchwork.kernel.org/project/linux-mediatek/patch/2020110200043=
8.29225-1-chunkuang.hu@kernel.org/

Regards,
Chun-Kuang.

> +               spin_unlock_irqrestore(&client->lock, flags);
> +       }
> +
>         return 0;
>  }
>  EXPORT_SYMBOL(cmdq_pkt_flush_async);
> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
