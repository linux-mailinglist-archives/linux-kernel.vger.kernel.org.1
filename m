Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E472C680F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 15:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730892AbgK0Omq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 09:42:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:60474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730815AbgK0Omp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 09:42:45 -0500
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46CDB221EB
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 14:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606488164;
        bh=Pc3HE3oATSYy+RsR0Pk0wV7ktVprytMyLWTEFH8OE2o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=z3aqRElIHhZYMqUN2sSDvPkoxA7Wr5e8i6DzYvMaOZl1d0+MQSEXEKmcenxnJrpgC
         idbgOh2vJGiiESs7HS8JwjoEApbpEb0f10SxxquXXtQMupCYLE/VZmMRpg6fIo8ETx
         iWw6VK+x9A18iUuTS5FHj6VIn8uW64XKLcpXU1zo=
Received: by mail-ej1-f43.google.com with SMTP id o9so7960538ejg.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 06:42:44 -0800 (PST)
X-Gm-Message-State: AOAM533noiUbSwE9HGIi/O7VJ5NpkinjaxwvZpBdZ7EmOusQrnCU5y6V
        emPipilOTXbJBtIhBEAWX9YvcXhV75iyaYvReg==
X-Google-Smtp-Source: ABdhPJy3B4+ieegseYpYdbv8emgYc7YJ0kXS9vZFsnrl+9Ym2m9h6w0o8vNgOfmkImNkpWdk5Va4Bq+c2F+grPJBZ50=
X-Received: by 2002:a17:907:720e:: with SMTP id dr14mr8170327ejc.303.1606488162650;
 Fri, 27 Nov 2020 06:42:42 -0800 (PST)
MIME-Version: 1.0
References: <20201102000438.29225-1-chunkuang.hu@kernel.org>
 <CAAOTY_8c3WxPQ3igPojuF-3HbctQW0qiFM5GaqSuTDNcTSvvQA@mail.gmail.com> <4c00864c-a706-d73b-a8fb-e8e473db3f79@gmail.com>
In-Reply-To: <4c00864c-a706-d73b-a8fb-e8e473db3f79@gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 27 Nov 2020 22:42:31 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-0zVzJygKFDN9Y_5jZNsue5SDrQDm-9DViR=dSnk2gJw@mail.gmail.com>
Message-ID: <CAAOTY_-0zVzJygKFDN9Y_5jZNsue5SDrQDm-9DViR=dSnk2gJw@mail.gmail.com>
Subject: Re: [PATCH v2] soc / drm: mediatek: cmdq: Remove timeout handler in
 helper function
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
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

Matthias Brugger <matthias.bgg@gmail.com> =E6=96=BC 2020=E5=B9=B411=E6=9C=
=8827=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=888:40=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Hi Chun-Kuang,
>
> On 20/11/2020 00:46, Chun-Kuang Hu wrote:
> > Hi, Matthias:
> >
> > I've provided the example for why of this patch. How do you think
> > about this patch?
> >
>
> Patch looks good to me. If you want to take it through your tree you can =
add my
> Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
>
> Beware that you might need a stable tag for it, so that I can merge it in=
to my
> soc branch, in case there are more changes to cmdq-helper.

I would like this patch to go into your tree because this patch mainly
modify cmdq helper. Even though this patch is one of the series
"Mediatek DRM driver detect CMDQ execution timeout by vblank IRQ" [1],
I would wait for this patch get into mainline then send the next
patch.

Regards,
Chun-Kuang.

>
> Regards,
> Matthias
>
> > Regards,
> > Chun-Kuang.
> >
> > Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2020=E5=B9=B411=E6=9C=
=882=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=888:04=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >>
> >> For each client driver, its timeout handler need to dump hardware regi=
ster
> >> or its state machine information, and their way to detect timeout are
> >> also different, so remove timeout handler in helper function and
> >> let client driver implement its own timeout handler.
> >>
> >> Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> >> ---
> >> v1 is one patch in series "Mediatek DRM driver detect CMDQ execution
> >> timeout by vblank IRQ", but according to Jassi's suggestion [1], send
> >> each patch in different series.
> >>
> >> [2] is an example that different client has different way to calculate
> >> timeout. Some client driver care about each packet's execution time, b=
ut
> >> some client driver care about the total execution time for all packets=
.
> >>
> >> [1]
> >> https://patchwork.kernel.org/project/linux-mediatek/cover/202009272304=
22.11610-1-chunkuang.hu@kernel.org/
> >> [2]
> >> https://patchwork.kernel.org/project/linux-mediatek/patch/202010220941=
52.17662-1-houlong.wei@mediatek.com/
> >>
> >> Changes in v2:
> >> 1. Rebase onto Linux 5.10-rc1
> >> ---
> >>   drivers/gpu/drm/mediatek/mtk_drm_crtc.c |  3 +-
> >>   drivers/soc/mediatek/mtk-cmdq-helper.c  | 41 +----------------------=
--
> >>   include/linux/soc/mediatek/mtk-cmdq.h   | 10 +-----
> >>   3 files changed, 3 insertions(+), 51 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm=
/mediatek/mtk_drm_crtc.c
> >> index ac038572164d..4be5d1fccf2e 100644
> >> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> >> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> >> @@ -824,8 +824,7 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev=
,
> >>   #if IS_REACHABLE(CONFIG_MTK_CMDQ)
> >>          mtk_crtc->cmdq_client =3D
> >>                          cmdq_mbox_create(mtk_crtc->mmsys_dev,
> >> -                                        drm_crtc_index(&mtk_crtc->bas=
e),
> >> -                                        2000);
> >> +                                        drm_crtc_index(&mtk_crtc->bas=
e));
> >>          if (IS_ERR(mtk_crtc->cmdq_client)) {
> >>                  dev_dbg(dev, "mtk_crtc %d failed to create mailbox cl=
ient, writing register by CPU now\n",
> >>                          drm_crtc_index(&mtk_crtc->base));
> >> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/medi=
atek/mtk-cmdq-helper.c
> >> index 505651b0d715..280d3bd9f675 100644
> >> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> >> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> >> @@ -70,14 +70,7 @@ int cmdq_dev_get_client_reg(struct device *dev,
> >>   }
> >>   EXPORT_SYMBOL(cmdq_dev_get_client_reg);
> >>
> >> -static void cmdq_client_timeout(struct timer_list *t)
> >> -{
> >> -       struct cmdq_client *client =3D from_timer(client, t, timer);
> >> -
> >> -       dev_err(client->client.dev, "cmdq timeout!\n");
> >> -}
> >> -
> >> -struct cmdq_client *cmdq_mbox_create(struct device *dev, int index, u=
32 timeout)
> >> +struct cmdq_client *cmdq_mbox_create(struct device *dev, int index)
> >>   {
> >>          struct cmdq_client *client;
> >>
> >> @@ -85,12 +78,6 @@ struct cmdq_client *cmdq_mbox_create(struct device =
*dev, int index, u32 timeout)
> >>          if (!client)
> >>                  return (struct cmdq_client *)-ENOMEM;
> >>
> >> -       client->timeout_ms =3D timeout;
> >> -       if (timeout !=3D CMDQ_NO_TIMEOUT) {
> >> -               spin_lock_init(&client->lock);
> >> -               timer_setup(&client->timer, cmdq_client_timeout, 0);
> >> -       }
> >> -       client->pkt_cnt =3D 0;
> >>          client->client.dev =3D dev;
> >>          client->client.tx_block =3D false;
> >>          client->client.knows_txdone =3D true;
> >> @@ -112,11 +99,6 @@ EXPORT_SYMBOL(cmdq_mbox_create);
> >>
> >>   void cmdq_mbox_destroy(struct cmdq_client *client)
> >>   {
> >> -       if (client->timeout_ms !=3D CMDQ_NO_TIMEOUT) {
> >> -               spin_lock(&client->lock);
> >> -               del_timer_sync(&client->timer);
> >> -               spin_unlock(&client->lock);
> >> -       }
> >>          mbox_free_channel(client->chan);
> >>          kfree(client);
> >>   }
> >> @@ -449,18 +431,6 @@ static void cmdq_pkt_flush_async_cb(struct cmdq_c=
b_data data)
> >>          struct cmdq_task_cb *cb =3D &pkt->cb;
> >>          struct cmdq_client *client =3D (struct cmdq_client *)pkt->cl;
> >>
> >> -       if (client->timeout_ms !=3D CMDQ_NO_TIMEOUT) {
> >> -               unsigned long flags =3D 0;
> >> -
> >> -               spin_lock_irqsave(&client->lock, flags);
> >> -               if (--client->pkt_cnt =3D=3D 0)
> >> -                       del_timer(&client->timer);
> >> -               else
> >> -                       mod_timer(&client->timer, jiffies +
> >> -                                 msecs_to_jiffies(client->timeout_ms)=
);
> >> -               spin_unlock_irqrestore(&client->lock, flags);
> >> -       }
> >> -
> >>          dma_sync_single_for_cpu(client->chan->mbox->dev, pkt->pa_base=
,
> >>                                  pkt->cmd_buf_size, DMA_TO_DEVICE);
> >>          if (cb->cb) {
> >> @@ -473,7 +443,6 @@ int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmd=
q_async_flush_cb cb,
> >>                           void *data)
> >>   {
> >>          int err;
> >> -       unsigned long flags =3D 0;
> >>          struct cmdq_client *client =3D (struct cmdq_client *)pkt->cl;
> >>
> >>          pkt->cb.cb =3D cb;
> >> @@ -484,14 +453,6 @@ int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cm=
dq_async_flush_cb cb,
> >>          dma_sync_single_for_device(client->chan->mbox->dev, pkt->pa_b=
ase,
> >>                                     pkt->cmd_buf_size, DMA_TO_DEVICE);
> >>
> >> -       if (client->timeout_ms !=3D CMDQ_NO_TIMEOUT) {
> >> -               spin_lock_irqsave(&client->lock, flags);
> >> -               if (client->pkt_cnt++ =3D=3D 0)
> >> -                       mod_timer(&client->timer, jiffies +
> >> -                                 msecs_to_jiffies(client->timeout_ms)=
);
> >> -               spin_unlock_irqrestore(&client->lock, flags);
> >> -       }
> >> -
> >>          err =3D mbox_send_message(client->chan, pkt);
> >>          if (err < 0)
> >>                  return err;
> >> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc=
/mediatek/mtk-cmdq.h
> >> index 960704d75994..8e9996610978 100644
> >> --- a/include/linux/soc/mediatek/mtk-cmdq.h
> >> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> >> @@ -11,7 +11,6 @@
> >>   #include <linux/mailbox/mtk-cmdq-mailbox.h>
> >>   #include <linux/timer.h>
> >>
> >> -#define CMDQ_NO_TIMEOUT                0xffffffffu
> >>   #define CMDQ_ADDR_HIGH(addr)   ((u32)(((addr) >> 16) & GENMASK(31, 0=
)))
> >>   #define CMDQ_ADDR_LOW(addr)    ((u16)(addr) | BIT(1))
> >>
> >> @@ -24,12 +23,8 @@ struct cmdq_client_reg {
> >>   };
> >>
> >>   struct cmdq_client {
> >> -       spinlock_t lock;
> >> -       u32 pkt_cnt;
> >>          struct mbox_client client;
> >>          struct mbox_chan *chan;
> >> -       struct timer_list timer;
> >> -       u32 timeout_ms; /* in unit of microsecond */
> >>   };
> >>
> >>   /**
> >> @@ -51,13 +46,10 @@ int cmdq_dev_get_client_reg(struct device *dev,
> >>    * cmdq_mbox_create() - create CMDQ mailbox client and channel
> >>    * @dev:       device of CMDQ mailbox client
> >>    * @index:     index of CMDQ mailbox channel
> >> - * @timeout:   timeout of a pkt execution by GCE, in unit of microsec=
ond, set
> >> - *             CMDQ_NO_TIMEOUT if a timer is not used.
> >>    *
> >>    * Return: CMDQ mailbox client pointer
> >>    */
> >> -struct cmdq_client *cmdq_mbox_create(struct device *dev, int index,
> >> -                                    u32 timeout);
> >> +struct cmdq_client *cmdq_mbox_create(struct device *dev, int index);
> >>
> >>   /**
> >>    * cmdq_mbox_destroy() - destroy CMDQ mailbox client and channel
> >> --
> >> 2.17.1
> >>
