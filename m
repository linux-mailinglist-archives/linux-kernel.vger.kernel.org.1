Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 564DB272AD9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 17:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgIUP5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 11:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbgIUP5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 11:57:35 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2331C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 08:57:34 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w5so13345198wrp.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 08:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rV+uTyycQ4uZne22RmHzFxiH+0Ds9Mx5siEI6qK/6bI=;
        b=RPEtxyXyDi58KtsdARuWqawmo+qCfBYnwJLVg0dlvWn+vd65SkVrX7EbAd2peg3z/R
         bti6kPt+Lf2jmVQcHSWSOnFp+fseyFZ9a45iPamWXJ/QR8nLNc41WqMvsrbpo/Z/W0B+
         K4iaeUyvSFncf1tfBEsGiALTMom1mrVNOAQLXOsKxY5UZdA0llqAEUFmpuIBzAaqM+x4
         fk3O5Lq1m7fmT7E+Kak2pPk7j9EM4wml0W8IiVTJryOHIR34B6RELSPYFnYpznjGPVkU
         8tHtN8w4qXm4EwCYrF/zzyRPBAvPqYYp7TI8wo9taCMoF1m0PNhgn9SEvN3yNEDGHiiU
         1bJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rV+uTyycQ4uZne22RmHzFxiH+0Ds9Mx5siEI6qK/6bI=;
        b=AhTNO8shdOOWX8SIE22hld21VUDvXeLFqJOR5e/gc3VlP51Clsc+xyuEmCh/7dvYPY
         3XHE+JrttjYTyN7eNY7Eh5wqoe6NLjRT46GdIsJXN5/bgsZ5Zw9ffZqH9e2OIupHoyCT
         ChPwvlM5pA0KOLqS+7U3br1oyly7DNcC7XKazWkzmj5RtM+m+e8ODLCbM7ZT565fmEsZ
         graLmeUtSEMVh0uj+Q8bBrUUMZw8eElNQlUu6twnfvjcoOVPiO8GEF86DD0+6omPIkow
         wnMTNX8xFkVWjlQoRJP98f/yNyjzKhA/Pa3s2xSprOO1SibLAnjE9JgNElGccbiq6u3O
         tgtQ==
X-Gm-Message-State: AOAM530jchn1012kiSrOaFpUxshKVg6x5XUgWvPbPl9tZc9QE1tWBR0k
        NzmzBuTpWrr6j/KYJ2stxk4=
X-Google-Smtp-Source: ABdhPJwJEdexl0APKc/bPeAGxfC3a6NRx1A/zRDh+Oi557jf8x/J6okf2B+RQizgFdCVQnaIu2UA7A==
X-Received: by 2002:adf:f808:: with SMTP id s8mr454949wrp.268.1600703853465;
        Mon, 21 Sep 2020 08:57:33 -0700 (PDT)
Received: from ziggy.stardust ([213.195.113.201])
        by smtp.gmail.com with ESMTPSA id m23sm28461wmi.19.2020.09.21.08.57.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 08:57:32 -0700 (PDT)
Subject: Re: [PATCH] soc: mediatek: cmdq: Remove timeout handler in helper
 function
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
References: <20200920234216.16884-1-chunkuang.hu@kernel.org>
 <b10a2243-0831-5f04-d37c-a3c6944064ce@gmail.com>
 <CAAOTY_-yoU9w-wC_iG=pVkjD_9s57P9O7EWpmST-VXDcv_5QZg@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <6a57a118-dc98-fbcd-a4f6-67aac6ef1aeb@gmail.com>
Date:   Mon, 21 Sep 2020 17:57:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAAOTY_-yoU9w-wC_iG=pVkjD_9s57P9O7EWpmST-VXDcv_5QZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/09/2020 17:32, Chun-Kuang Hu wrote:
> Hi, Matthias:
> 
> Matthias Brugger <matthias.bgg@gmail.com> 於 2020年9月21日 週一 下午4:53寫道：
>>
>>
>>
>> On 21/09/2020 01:42, Chun-Kuang Hu wrote:
>>> For each client driver, its timeout handler need to dump hardware register
>>> or its state machine information, so remove timeout handler in helper
>>> function and let client driver implement its own timeout handler.
>>>
>>
>> I don't see the implementation of a client side handler. Did I miss something?
>> Would it make sense to instead add a callback to the handler in cmdq_mbox_create()?
> 
> According to the commit message, it make sense to add a callback to
> the handler in comq_mbox_create().
> But for DRM, I would like to check timeout in vblank irq because the
> register should be applied in vblank. (I have not implement this patch
> yet)
> What I want to say is that different client may have different way to
> detect timeout and different way to handle it.
> If you want, I would add DRM timeout handle patch with this patch, and
> modify commit message to include different way to detect timeout.
> 

I think that would help me to understand the whole picture.

Thanks a lot!
Matthias

> Regards,
> Chun-Kuang.
> 
>>
>> Regards,
>> Matthias
>>
>>> Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
>>> ---
>>>    drivers/gpu/drm/mediatek/mtk_drm_crtc.c |  3 +-
>>>    drivers/soc/mediatek/mtk-cmdq-helper.c  | 41 +------------------------
>>>    include/linux/soc/mediatek/mtk-cmdq.h   | 11 +------
>>>    3 files changed, 3 insertions(+), 52 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
>>> index 3fc5511330b9..cabeb7fea2be 100644
>>> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
>>> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
>>> @@ -824,8 +824,7 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
>>>    #if IS_REACHABLE(CONFIG_MTK_CMDQ)
>>>        mtk_crtc->cmdq_client =
>>>                        cmdq_mbox_create(mtk_crtc->mmsys_dev,
>>> -                                      drm_crtc_index(&mtk_crtc->base),
>>> -                                      2000);
>>> +                                      drm_crtc_index(&mtk_crtc->base));
>>>        if (IS_ERR(mtk_crtc->cmdq_client)) {
>>>                dev_dbg(dev, "mtk_crtc %d failed to create mailbox client, writing register by CPU now\n",
>>>                        drm_crtc_index(&mtk_crtc->base));
>>> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
>>> index dc644cfb6419..4f311f035b59 100644
>>> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
>>> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
>>> @@ -65,14 +65,7 @@ int cmdq_dev_get_client_reg(struct device *dev,
>>>    }
>>>    EXPORT_SYMBOL(cmdq_dev_get_client_reg);
>>>
>>> -static void cmdq_client_timeout(struct timer_list *t)
>>> -{
>>> -     struct cmdq_client *client = from_timer(client, t, timer);
>>> -
>>> -     dev_err(client->client.dev, "cmdq timeout!\n");
>>> -}
>>> -
>>> -struct cmdq_client *cmdq_mbox_create(struct device *dev, int index, u32 timeout)
>>> +struct cmdq_client *cmdq_mbox_create(struct device *dev, int index)
>>>    {
>>>        struct cmdq_client *client;
>>>
>>> @@ -80,12 +73,6 @@ struct cmdq_client *cmdq_mbox_create(struct device *dev, int index, u32 timeout)
>>>        if (!client)
>>>                return (struct cmdq_client *)-ENOMEM;
>>>
>>> -     client->timeout_ms = timeout;
>>> -     if (timeout != CMDQ_NO_TIMEOUT) {
>>> -             spin_lock_init(&client->lock);
>>> -             timer_setup(&client->timer, cmdq_client_timeout, 0);
>>> -     }
>>> -     client->pkt_cnt = 0;
>>>        client->client.dev = dev;
>>>        client->client.tx_block = false;
>>>        client->client.knows_txdone = true;
>>> @@ -107,11 +94,6 @@ EXPORT_SYMBOL(cmdq_mbox_create);
>>>
>>>    void cmdq_mbox_destroy(struct cmdq_client *client)
>>>    {
>>> -     if (client->timeout_ms != CMDQ_NO_TIMEOUT) {
>>> -             spin_lock(&client->lock);
>>> -             del_timer_sync(&client->timer);
>>> -             spin_unlock(&client->lock);
>>> -     }
>>>        mbox_free_channel(client->chan);
>>>        kfree(client);
>>>    }
>>> @@ -342,18 +324,6 @@ static void cmdq_pkt_flush_async_cb(struct cmdq_cb_data data)
>>>        struct cmdq_task_cb *cb = &pkt->cb;
>>>        struct cmdq_client *client = (struct cmdq_client *)pkt->cl;
>>>
>>> -     if (client->timeout_ms != CMDQ_NO_TIMEOUT) {
>>> -             unsigned long flags = 0;
>>> -
>>> -             spin_lock_irqsave(&client->lock, flags);
>>> -             if (--client->pkt_cnt == 0)
>>> -                     del_timer(&client->timer);
>>> -             else
>>> -                     mod_timer(&client->timer, jiffies +
>>> -                               msecs_to_jiffies(client->timeout_ms));
>>> -             spin_unlock_irqrestore(&client->lock, flags);
>>> -     }
>>> -
>>>        dma_sync_single_for_cpu(client->chan->mbox->dev, pkt->pa_base,
>>>                                pkt->cmd_buf_size, DMA_TO_DEVICE);
>>>        if (cb->cb) {
>>> @@ -366,7 +336,6 @@ int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
>>>                         void *data)
>>>    {
>>>        int err;
>>> -     unsigned long flags = 0;
>>>        struct cmdq_client *client = (struct cmdq_client *)pkt->cl;
>>>
>>>        pkt->cb.cb = cb;
>>> @@ -377,14 +346,6 @@ int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
>>>        dma_sync_single_for_device(client->chan->mbox->dev, pkt->pa_base,
>>>                                   pkt->cmd_buf_size, DMA_TO_DEVICE);
>>>
>>> -     if (client->timeout_ms != CMDQ_NO_TIMEOUT) {
>>> -             spin_lock_irqsave(&client->lock, flags);
>>> -             if (client->pkt_cnt++ == 0)
>>> -                     mod_timer(&client->timer, jiffies +
>>> -                               msecs_to_jiffies(client->timeout_ms));
>>> -             spin_unlock_irqrestore(&client->lock, flags);
>>> -     }
>>> -
>>>        err = mbox_send_message(client->chan, pkt);
>>>        if (err < 0)
>>>                return err;
>>> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
>>> index 2249ecaf77e4..175bd89f46f8 100644
>>> --- a/include/linux/soc/mediatek/mtk-cmdq.h
>>> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
>>> @@ -11,8 +11,6 @@
>>>    #include <linux/mailbox/mtk-cmdq-mailbox.h>
>>>    #include <linux/timer.h>
>>>
>>> -#define CMDQ_NO_TIMEOUT              0xffffffffu
>>> -
>>>    struct cmdq_pkt;
>>>
>>>    struct cmdq_client_reg {
>>> @@ -22,12 +20,8 @@ struct cmdq_client_reg {
>>>    };
>>>
>>>    struct cmdq_client {
>>> -     spinlock_t lock;
>>> -     u32 pkt_cnt;
>>>        struct mbox_client client;
>>>        struct mbox_chan *chan;
>>> -     struct timer_list timer;
>>> -     u32 timeout_ms; /* in unit of microsecond */
>>>    };
>>>
>>>    /**
>>> @@ -49,13 +43,10 @@ int cmdq_dev_get_client_reg(struct device *dev,
>>>     * cmdq_mbox_create() - create CMDQ mailbox client and channel
>>>     * @dev:    device of CMDQ mailbox client
>>>     * @index:  index of CMDQ mailbox channel
>>> - * @timeout: timeout of a pkt execution by GCE, in unit of microsecond, set
>>> - *           CMDQ_NO_TIMEOUT if a timer is not used.
>>>     *
>>>     * Return: CMDQ mailbox client pointer
>>>     */
>>> -struct cmdq_client *cmdq_mbox_create(struct device *dev, int index,
>>> -                                  u32 timeout);
>>> +struct cmdq_client *cmdq_mbox_create(struct device *dev, int index);
>>>
>>>    /**
>>>     * cmdq_mbox_destroy() - destroy CMDQ mailbox client and channel
>>>
