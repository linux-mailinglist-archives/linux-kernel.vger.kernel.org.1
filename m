Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99CC5272A34
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 17:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgIUPdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 11:33:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:51274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbgIUPdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 11:33:01 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE73320B1F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 15:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600702381;
        bh=XgvreTIegO9PQ1JbfNWcxgBOlI1x3VJ4uK1RYcLAP1c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JsWXRfsQEPo5azIR4zeKFCT/DlMVtGyeGWDZjLOlGbF/s66Gzln9RQyNL1smhlBN9
         Sp19ZTeMDyePT5V49h+AIKZXazFo8JtL1+UNl1ISxYBY1cq7gIn6vVuf5mtPtNECGB
         O4bpOuMRlqnP4p7uQBBNGinOGlU0xT2ho89vQMkw=
Received: by mail-ed1-f43.google.com with SMTP id ay8so13219621edb.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 08:33:00 -0700 (PDT)
X-Gm-Message-State: AOAM531gop8NeA58I1auNc36R7IAoHbPpTl7uaBsRqT1u8IJOAsOM2Hm
        MBlGWaU7fNcRV4h29m5W6Q1vr5ZorGqUq6HoZg==
X-Google-Smtp-Source: ABdhPJyoy9yFvJog4uzSzu089oIWbajJPIsu1X0qzloQHfne/KLlcCwIBcVfCQ0jAbGnq4fC9ESo3FB1hW6Q2pxPHIQ=
X-Received: by 2002:aa7:dcd2:: with SMTP id w18mr231332edu.288.1600702379203;
 Mon, 21 Sep 2020 08:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200920234216.16884-1-chunkuang.hu@kernel.org> <b10a2243-0831-5f04-d37c-a3c6944064ce@gmail.com>
In-Reply-To: <b10a2243-0831-5f04-d37c-a3c6944064ce@gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 21 Sep 2020 23:32:47 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-yoU9w-wC_iG=pVkjD_9s57P9O7EWpmST-VXDcv_5QZg@mail.gmail.com>
Message-ID: <CAAOTY_-yoU9w-wC_iG=pVkjD_9s57P9O7EWpmST-VXDcv_5QZg@mail.gmail.com>
Subject: Re: [PATCH] soc: mediatek: cmdq: Remove timeout handler in helper function
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Matthias:

Matthias Brugger <matthias.bgg@gmail.com> =E6=96=BC 2020=E5=B9=B49=E6=9C=88=
21=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=884:53=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
>
>
> On 21/09/2020 01:42, Chun-Kuang Hu wrote:
> > For each client driver, its timeout handler need to dump hardware regis=
ter
> > or its state machine information, so remove timeout handler in helper
> > function and let client driver implement its own timeout handler.
> >
>
> I don't see the implementation of a client side handler. Did I miss somet=
hing?
> Would it make sense to instead add a callback to the handler in cmdq_mbox=
_create()?

According to the commit message, it make sense to add a callback to
the handler in comq_mbox_create().
But for DRM, I would like to check timeout in vblank irq because the
register should be applied in vblank. (I have not implement this patch
yet)
What I want to say is that different client may have different way to
detect timeout and different way to handle it.
If you want, I would add DRM timeout handle patch with this patch, and
modify commit message to include different way to detect timeout.

Regards,
Chun-Kuang.

>
> Regards,
> Matthias
>
> > Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > ---
> >   drivers/gpu/drm/mediatek/mtk_drm_crtc.c |  3 +-
> >   drivers/soc/mediatek/mtk-cmdq-helper.c  | 41 +-----------------------=
-
> >   include/linux/soc/mediatek/mtk-cmdq.h   | 11 +------
> >   3 files changed, 3 insertions(+), 52 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/=
mediatek/mtk_drm_crtc.c
> > index 3fc5511330b9..cabeb7fea2be 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > @@ -824,8 +824,7 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
> >   #if IS_REACHABLE(CONFIG_MTK_CMDQ)
> >       mtk_crtc->cmdq_client =3D
> >                       cmdq_mbox_create(mtk_crtc->mmsys_dev,
> > -                                      drm_crtc_index(&mtk_crtc->base),
> > -                                      2000);
> > +                                      drm_crtc_index(&mtk_crtc->base))=
;
> >       if (IS_ERR(mtk_crtc->cmdq_client)) {
> >               dev_dbg(dev, "mtk_crtc %d failed to create mailbox client=
, writing register by CPU now\n",
> >                       drm_crtc_index(&mtk_crtc->base));
> > diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/media=
tek/mtk-cmdq-helper.c
> > index dc644cfb6419..4f311f035b59 100644
> > --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> > +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> > @@ -65,14 +65,7 @@ int cmdq_dev_get_client_reg(struct device *dev,
> >   }
> >   EXPORT_SYMBOL(cmdq_dev_get_client_reg);
> >
> > -static void cmdq_client_timeout(struct timer_list *t)
> > -{
> > -     struct cmdq_client *client =3D from_timer(client, t, timer);
> > -
> > -     dev_err(client->client.dev, "cmdq timeout!\n");
> > -}
> > -
> > -struct cmdq_client *cmdq_mbox_create(struct device *dev, int index, u3=
2 timeout)
> > +struct cmdq_client *cmdq_mbox_create(struct device *dev, int index)
> >   {
> >       struct cmdq_client *client;
> >
> > @@ -80,12 +73,6 @@ struct cmdq_client *cmdq_mbox_create(struct device *=
dev, int index, u32 timeout)
> >       if (!client)
> >               return (struct cmdq_client *)-ENOMEM;
> >
> > -     client->timeout_ms =3D timeout;
> > -     if (timeout !=3D CMDQ_NO_TIMEOUT) {
> > -             spin_lock_init(&client->lock);
> > -             timer_setup(&client->timer, cmdq_client_timeout, 0);
> > -     }
> > -     client->pkt_cnt =3D 0;
> >       client->client.dev =3D dev;
> >       client->client.tx_block =3D false;
> >       client->client.knows_txdone =3D true;
> > @@ -107,11 +94,6 @@ EXPORT_SYMBOL(cmdq_mbox_create);
> >
> >   void cmdq_mbox_destroy(struct cmdq_client *client)
> >   {
> > -     if (client->timeout_ms !=3D CMDQ_NO_TIMEOUT) {
> > -             spin_lock(&client->lock);
> > -             del_timer_sync(&client->timer);
> > -             spin_unlock(&client->lock);
> > -     }
> >       mbox_free_channel(client->chan);
> >       kfree(client);
> >   }
> > @@ -342,18 +324,6 @@ static void cmdq_pkt_flush_async_cb(struct cmdq_cb=
_data data)
> >       struct cmdq_task_cb *cb =3D &pkt->cb;
> >       struct cmdq_client *client =3D (struct cmdq_client *)pkt->cl;
> >
> > -     if (client->timeout_ms !=3D CMDQ_NO_TIMEOUT) {
> > -             unsigned long flags =3D 0;
> > -
> > -             spin_lock_irqsave(&client->lock, flags);
> > -             if (--client->pkt_cnt =3D=3D 0)
> > -                     del_timer(&client->timer);
> > -             else
> > -                     mod_timer(&client->timer, jiffies +
> > -                               msecs_to_jiffies(client->timeout_ms));
> > -             spin_unlock_irqrestore(&client->lock, flags);
> > -     }
> > -
> >       dma_sync_single_for_cpu(client->chan->mbox->dev, pkt->pa_base,
> >                               pkt->cmd_buf_size, DMA_TO_DEVICE);
> >       if (cb->cb) {
> > @@ -366,7 +336,6 @@ int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq=
_async_flush_cb cb,
> >                        void *data)
> >   {
> >       int err;
> > -     unsigned long flags =3D 0;
> >       struct cmdq_client *client =3D (struct cmdq_client *)pkt->cl;
> >
> >       pkt->cb.cb =3D cb;
> > @@ -377,14 +346,6 @@ int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmd=
q_async_flush_cb cb,
> >       dma_sync_single_for_device(client->chan->mbox->dev, pkt->pa_base,
> >                                  pkt->cmd_buf_size, DMA_TO_DEVICE);
> >
> > -     if (client->timeout_ms !=3D CMDQ_NO_TIMEOUT) {
> > -             spin_lock_irqsave(&client->lock, flags);
> > -             if (client->pkt_cnt++ =3D=3D 0)
> > -                     mod_timer(&client->timer, jiffies +
> > -                               msecs_to_jiffies(client->timeout_ms));
> > -             spin_unlock_irqrestore(&client->lock, flags);
> > -     }
> > -
> >       err =3D mbox_send_message(client->chan, pkt);
> >       if (err < 0)
> >               return err;
> > diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/=
mediatek/mtk-cmdq.h
> > index 2249ecaf77e4..175bd89f46f8 100644
> > --- a/include/linux/soc/mediatek/mtk-cmdq.h
> > +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> > @@ -11,8 +11,6 @@
> >   #include <linux/mailbox/mtk-cmdq-mailbox.h>
> >   #include <linux/timer.h>
> >
> > -#define CMDQ_NO_TIMEOUT              0xffffffffu
> > -
> >   struct cmdq_pkt;
> >
> >   struct cmdq_client_reg {
> > @@ -22,12 +20,8 @@ struct cmdq_client_reg {
> >   };
> >
> >   struct cmdq_client {
> > -     spinlock_t lock;
> > -     u32 pkt_cnt;
> >       struct mbox_client client;
> >       struct mbox_chan *chan;
> > -     struct timer_list timer;
> > -     u32 timeout_ms; /* in unit of microsecond */
> >   };
> >
> >   /**
> > @@ -49,13 +43,10 @@ int cmdq_dev_get_client_reg(struct device *dev,
> >    * cmdq_mbox_create() - create CMDQ mailbox client and channel
> >    * @dev:    device of CMDQ mailbox client
> >    * @index:  index of CMDQ mailbox channel
> > - * @timeout: timeout of a pkt execution by GCE, in unit of microsecond=
, set
> > - *           CMDQ_NO_TIMEOUT if a timer is not used.
> >    *
> >    * Return: CMDQ mailbox client pointer
> >    */
> > -struct cmdq_client *cmdq_mbox_create(struct device *dev, int index,
> > -                                  u32 timeout);
> > +struct cmdq_client *cmdq_mbox_create(struct device *dev, int index);
> >
> >   /**
> >    * cmdq_mbox_destroy() - destroy CMDQ mailbox client and channel
> >
