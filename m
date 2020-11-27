Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396012C6D4F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 23:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732251AbgK0Wm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 17:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732196AbgK0WhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 17:37:16 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BBFC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 14:37:16 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id r3so7063707wrt.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 14:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J6isdyaoDKNLCs72ckrMB3Q+oTgGT/3bWUzglydc71I=;
        b=vFwSJlkinseOyE4PUUdNJy8djkzs0MzDEYLZM//idCF9eecCCF6ax7DjRpAPNoSnvT
         98ID3UtO6Jcz05p5PJBj/seC2Dv1R4iPqtzlePkSgIpdNQXO883FDXmX3ZLuGtQ32Q8h
         dLKXeSWwVXTyWsp9wOPc5CZCbZkvwzCDoVWYTqbp9VpkIH8L7JG2PCJ23yp/aiyPdIG3
         l/VtsdzNUWzcAt7aDNnEM/vDakos+LG1iPCbvViqZnGtHIYM0ne7khZkP8MsBbOLNbIX
         LiArdZ9J1acBsnRoK9ydpxz8MM1FYesG1HiFfI8DQiGIfNpAGk0ptXghyLbMOWdhTEG6
         B+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J6isdyaoDKNLCs72ckrMB3Q+oTgGT/3bWUzglydc71I=;
        b=pL13fCa9S19o3Ld9LQUGblhioFlmxQsL2DNNBSRYEPEuDd6KkXwfIWKy9SviZeCg3L
         P7F6ZpkzxOogLtrtn6+0w3eG5ePl7wid4aQ5aCkxp3COHps9QoGR23ZuaOEOekBs5ovP
         MD+j2Ghwvujk9R6pnbxpRW3Qr0LjI54Ay78v6D2CcJR2MREnl4Y8ZHQRliMrWOsQ3kcW
         3L4eqI8+kQh9zv1qs1KOcJomtCURHDdqvzW572vTMfMIOLI5MU5h1mVoglYBYaweWphW
         PkFOPpdiMVjIkJRYgg+ZB4s8ultJIfbIUc7cI6o0JqHwfE3CBp32mVY4mKfd/ZjjziXG
         d+Cg==
X-Gm-Message-State: AOAM530G/E5HeOMsL66djuZNL9/Z/4XOh24nY8Db57QyrmU9HbZTW+RJ
        Wfz2s1pA3Tbi+i/+T4JO8MI=
X-Google-Smtp-Source: ABdhPJxW1Sgz6O7gAdRkblvOrhEvl1AfC/kh0EulNKNm7xx5KcIaRjwAwJEJUxMv83F02DQ3hv++gw==
X-Received: by 2002:a5d:50c6:: with SMTP id f6mr13550208wrt.150.1606516635058;
        Fri, 27 Nov 2020 14:37:15 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id l11sm14076075wmh.46.2020.11.27.14.37.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 14:37:14 -0800 (PST)
Subject: Re: [PATCH v2] soc / drm: mediatek: cmdq: Remove timeout handler in
 helper function
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20201102000438.29225-1-chunkuang.hu@kernel.org>
 <CAAOTY_8c3WxPQ3igPojuF-3HbctQW0qiFM5GaqSuTDNcTSvvQA@mail.gmail.com>
 <4c00864c-a706-d73b-a8fb-e8e473db3f79@gmail.com>
 <CAAOTY_-0zVzJygKFDN9Y_5jZNsue5SDrQDm-9DViR=dSnk2gJw@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <8311d145-74b0-a716-3845-c92b34a2ba0e@gmail.com>
Date:   Fri, 27 Nov 2020 23:37:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CAAOTY_-0zVzJygKFDN9Y_5jZNsue5SDrQDm-9DViR=dSnk2gJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/11/2020 15:42, Chun-Kuang Hu wrote:
> Hi, Matthias:
> 
> Matthias Brugger <matthias.bgg@gmail.com> 於 2020年11月27日 週五 下午8:40寫道：
>>
>> Hi Chun-Kuang,
>>
>> On 20/11/2020 00:46, Chun-Kuang Hu wrote:
>>> Hi, Matthias:
>>>
>>> I've provided the example for why of this patch. How do you think
>>> about this patch?
>>>
>>
>> Patch looks good to me. If you want to take it through your tree you can add my
>> Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
>>
>> Beware that you might need a stable tag for it, so that I can merge it into my
>> soc branch, in case there are more changes to cmdq-helper.
> 
> I would like this patch to go into your tree because this patch mainly
> modify cmdq helper. Even though this patch is one of the series
> "Mediatek DRM driver detect CMDQ execution timeout by vblank IRQ" [1],
> I would wait for this patch get into mainline then send the next
> patch.
> 

Applied to v5.10-next/soc

Thanks!

> Regards,
> Chun-Kuang.
> 
>>
>> Regards,
>> Matthias
>>
>>> Regards,
>>> Chun-Kuang.
>>>
>>> Chun-Kuang Hu <chunkuang.hu@kernel.org> 於 2020年11月2日 週一 上午8:04寫道：
>>>>
>>>> For each client driver, its timeout handler need to dump hardware register
>>>> or its state machine information, and their way to detect timeout are
>>>> also different, so remove timeout handler in helper function and
>>>> let client driver implement its own timeout handler.
>>>>
>>>> Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
>>>> ---
>>>> v1 is one patch in series "Mediatek DRM driver detect CMDQ execution
>>>> timeout by vblank IRQ", but according to Jassi's suggestion [1], send
>>>> each patch in different series.
>>>>
>>>> [2] is an example that different client has different way to calculate
>>>> timeout. Some client driver care about each packet's execution time, but
>>>> some client driver care about the total execution time for all packets.
>>>>
>>>> [1]
>>>> https://patchwork.kernel.org/project/linux-mediatek/cover/20200927230422.11610-1-chunkuang.hu@kernel.org/
>>>> [2]
>>>> https://patchwork.kernel.org/project/linux-mediatek/patch/20201022094152.17662-1-houlong.wei@mediatek.com/
>>>>
>>>> Changes in v2:
>>>> 1. Rebase onto Linux 5.10-rc1
>>>> ---
>>>>    drivers/gpu/drm/mediatek/mtk_drm_crtc.c |  3 +-
>>>>    drivers/soc/mediatek/mtk-cmdq-helper.c  | 41 +------------------------
>>>>    include/linux/soc/mediatek/mtk-cmdq.h   | 10 +-----
>>>>    3 files changed, 3 insertions(+), 51 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
>>>> index ac038572164d..4be5d1fccf2e 100644
>>>> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
>>>> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
>>>> @@ -824,8 +824,7 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
>>>>    #if IS_REACHABLE(CONFIG_MTK_CMDQ)
>>>>           mtk_crtc->cmdq_client =
>>>>                           cmdq_mbox_create(mtk_crtc->mmsys_dev,
>>>> -                                        drm_crtc_index(&mtk_crtc->base),
>>>> -                                        2000);
>>>> +                                        drm_crtc_index(&mtk_crtc->base));
>>>>           if (IS_ERR(mtk_crtc->cmdq_client)) {
>>>>                   dev_dbg(dev, "mtk_crtc %d failed to create mailbox client, writing register by CPU now\n",
>>>>                           drm_crtc_index(&mtk_crtc->base));
>>>> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
>>>> index 505651b0d715..280d3bd9f675 100644
>>>> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
>>>> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
>>>> @@ -70,14 +70,7 @@ int cmdq_dev_get_client_reg(struct device *dev,
>>>>    }
>>>>    EXPORT_SYMBOL(cmdq_dev_get_client_reg);
>>>>
>>>> -static void cmdq_client_timeout(struct timer_list *t)
>>>> -{
>>>> -       struct cmdq_client *client = from_timer(client, t, timer);
>>>> -
>>>> -       dev_err(client->client.dev, "cmdq timeout!\n");
>>>> -}
>>>> -
>>>> -struct cmdq_client *cmdq_mbox_create(struct device *dev, int index, u32 timeout)
>>>> +struct cmdq_client *cmdq_mbox_create(struct device *dev, int index)
>>>>    {
>>>>           struct cmdq_client *client;
>>>>
>>>> @@ -85,12 +78,6 @@ struct cmdq_client *cmdq_mbox_create(struct device *dev, int index, u32 timeout)
>>>>           if (!client)
>>>>                   return (struct cmdq_client *)-ENOMEM;
>>>>
>>>> -       client->timeout_ms = timeout;
>>>> -       if (timeout != CMDQ_NO_TIMEOUT) {
>>>> -               spin_lock_init(&client->lock);
>>>> -               timer_setup(&client->timer, cmdq_client_timeout, 0);
>>>> -       }
>>>> -       client->pkt_cnt = 0;
>>>>           client->client.dev = dev;
>>>>           client->client.tx_block = false;
>>>>           client->client.knows_txdone = true;
>>>> @@ -112,11 +99,6 @@ EXPORT_SYMBOL(cmdq_mbox_create);
>>>>
>>>>    void cmdq_mbox_destroy(struct cmdq_client *client)
>>>>    {
>>>> -       if (client->timeout_ms != CMDQ_NO_TIMEOUT) {
>>>> -               spin_lock(&client->lock);
>>>> -               del_timer_sync(&client->timer);
>>>> -               spin_unlock(&client->lock);
>>>> -       }
>>>>           mbox_free_channel(client->chan);
>>>>           kfree(client);
>>>>    }
>>>> @@ -449,18 +431,6 @@ static void cmdq_pkt_flush_async_cb(struct cmdq_cb_data data)
>>>>           struct cmdq_task_cb *cb = &pkt->cb;
>>>>           struct cmdq_client *client = (struct cmdq_client *)pkt->cl;
>>>>
>>>> -       if (client->timeout_ms != CMDQ_NO_TIMEOUT) {
>>>> -               unsigned long flags = 0;
>>>> -
>>>> -               spin_lock_irqsave(&client->lock, flags);
>>>> -               if (--client->pkt_cnt == 0)
>>>> -                       del_timer(&client->timer);
>>>> -               else
>>>> -                       mod_timer(&client->timer, jiffies +
>>>> -                                 msecs_to_jiffies(client->timeout_ms));
>>>> -               spin_unlock_irqrestore(&client->lock, flags);
>>>> -       }
>>>> -
>>>>           dma_sync_single_for_cpu(client->chan->mbox->dev, pkt->pa_base,
>>>>                                   pkt->cmd_buf_size, DMA_TO_DEVICE);
>>>>           if (cb->cb) {
>>>> @@ -473,7 +443,6 @@ int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
>>>>                            void *data)
>>>>    {
>>>>           int err;
>>>> -       unsigned long flags = 0;
>>>>           struct cmdq_client *client = (struct cmdq_client *)pkt->cl;
>>>>
>>>>           pkt->cb.cb = cb;
>>>> @@ -484,14 +453,6 @@ int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
>>>>           dma_sync_single_for_device(client->chan->mbox->dev, pkt->pa_base,
>>>>                                      pkt->cmd_buf_size, DMA_TO_DEVICE);
>>>>
>>>> -       if (client->timeout_ms != CMDQ_NO_TIMEOUT) {
>>>> -               spin_lock_irqsave(&client->lock, flags);
>>>> -               if (client->pkt_cnt++ == 0)
>>>> -                       mod_timer(&client->timer, jiffies +
>>>> -                                 msecs_to_jiffies(client->timeout_ms));
>>>> -               spin_unlock_irqrestore(&client->lock, flags);
>>>> -       }
>>>> -
>>>>           err = mbox_send_message(client->chan, pkt);
>>>>           if (err < 0)
>>>>                   return err;
>>>> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
>>>> index 960704d75994..8e9996610978 100644
>>>> --- a/include/linux/soc/mediatek/mtk-cmdq.h
>>>> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
>>>> @@ -11,7 +11,6 @@
>>>>    #include <linux/mailbox/mtk-cmdq-mailbox.h>
>>>>    #include <linux/timer.h>
>>>>
>>>> -#define CMDQ_NO_TIMEOUT                0xffffffffu
>>>>    #define CMDQ_ADDR_HIGH(addr)   ((u32)(((addr) >> 16) & GENMASK(31, 0)))
>>>>    #define CMDQ_ADDR_LOW(addr)    ((u16)(addr) | BIT(1))
>>>>
>>>> @@ -24,12 +23,8 @@ struct cmdq_client_reg {
>>>>    };
>>>>
>>>>    struct cmdq_client {
>>>> -       spinlock_t lock;
>>>> -       u32 pkt_cnt;
>>>>           struct mbox_client client;
>>>>           struct mbox_chan *chan;
>>>> -       struct timer_list timer;
>>>> -       u32 timeout_ms; /* in unit of microsecond */
>>>>    };
>>>>
>>>>    /**
>>>> @@ -51,13 +46,10 @@ int cmdq_dev_get_client_reg(struct device *dev,
>>>>     * cmdq_mbox_create() - create CMDQ mailbox client and channel
>>>>     * @dev:       device of CMDQ mailbox client
>>>>     * @index:     index of CMDQ mailbox channel
>>>> - * @timeout:   timeout of a pkt execution by GCE, in unit of microsecond, set
>>>> - *             CMDQ_NO_TIMEOUT if a timer is not used.
>>>>     *
>>>>     * Return: CMDQ mailbox client pointer
>>>>     */
>>>> -struct cmdq_client *cmdq_mbox_create(struct device *dev, int index,
>>>> -                                    u32 timeout);
>>>> +struct cmdq_client *cmdq_mbox_create(struct device *dev, int index);
>>>>
>>>>    /**
>>>>     * cmdq_mbox_destroy() - destroy CMDQ mailbox client and channel
>>>> --
>>>> 2.17.1
>>>>
