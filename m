Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82867271E5D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 10:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgIUIxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 04:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgIUIxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 04:53:01 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06518C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 01:53:00 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l9so11709714wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 01:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S8TzIVCvzrpPRT+dmZ1UCIXHD5Lpd2XCS5GDDCZq6bA=;
        b=lqiL+EqhXAT6a43P1usTLWNIjuq36Vf3uJMduTXUaS6xBYsIC5kyGOYImV3h1620AX
         tNbZNGP+L9ftdz4uAFOgzntT11z9nJbSVlI3CqizIFMCh5A4BC5SC5MLPMTXfVc8nyzE
         n/vjrxDSfHCYaZ2ppQ6Y8W1+3NURkabzGXDlG4IbR5CEEwTZdWdeVgLF/UAeYDDEjPMZ
         XlPk2e30A5VacaWQSKuePRZgy6ueLeNsP0EuqkGB0hK3vxOhh1hQP55yZr+voMVbLOWW
         yI2oOE3oHTesuzU+3FrPZ4s0s3ivJpwmrvGk5YqfBtgpqpWRG5111V5D6FZrRoXUk3en
         AC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S8TzIVCvzrpPRT+dmZ1UCIXHD5Lpd2XCS5GDDCZq6bA=;
        b=NzC5yR9s9gk2PwNfYQ8qVc4OAG4ZS6simm5d9v6RVodGxdKOOjWj+gA23wHUXbasrc
         10n0SQX7FDIhMYjiQpJnBDEYOgbVF9kYgp/cRhozhxMkfJELCxJ9nLGVj5JdxChHPoNd
         RHbcJAMTD5ERrevbtPsukS0exz7A4HV9oKxeQm/yt663VKsErCG4J3IQZwQ4K6YzkluI
         rfF2po5aTagjLdPd5NVw7cMB1GitZLpsnU6bSNaj1x5lrleckYQvxIT4LqYNaxGZ0u/d
         gKZLf1/p9AR9+gDs83a7GO/nuIS7WkGnNy1cBVwCeyUNKfMF7VGI/Z+xcgY0IvJtNfxH
         gGpg==
X-Gm-Message-State: AOAM533hQfUCGfWwyRhQrMvFwLUUasjhqB1k1mXiWSTyBjpEOhXZRVlw
        R1gdln3GlBUAKB7M1YkhlbY=
X-Google-Smtp-Source: ABdhPJxja1wH7LWilkbIBgU9FCw3fTF8cQo8sJQa8JhNB3Q6qY50Rdpv+RNy2baO36yI7U0I3pRSkQ==
X-Received: by 2002:a1c:bbd7:: with SMTP id l206mr30813629wmf.185.1600678379509;
        Mon, 21 Sep 2020 01:52:59 -0700 (PDT)
Received: from ziggy.stardust ([213.195.113.201])
        by smtp.gmail.com with ESMTPSA id i15sm19557732wrb.91.2020.09.21.01.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 01:52:58 -0700 (PDT)
Subject: Re: [PATCH] soc: mediatek: cmdq: Remove timeout handler in helper
 function
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org
References: <20200920234216.16884-1-chunkuang.hu@kernel.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <b10a2243-0831-5f04-d37c-a3c6944064ce@gmail.com>
Date:   Mon, 21 Sep 2020 10:52:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200920234216.16884-1-chunkuang.hu@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/09/2020 01:42, Chun-Kuang Hu wrote:
> For each client driver, its timeout handler need to dump hardware register
> or its state machine information, so remove timeout handler in helper
> function and let client driver implement its own timeout handler.
> 

I don't see the implementation of a client side handler. Did I miss something?
Would it make sense to instead add a callback to the handler in cmdq_mbox_create()?

Regards,
Matthias

> Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> ---
>   drivers/gpu/drm/mediatek/mtk_drm_crtc.c |  3 +-
>   drivers/soc/mediatek/mtk-cmdq-helper.c  | 41 +------------------------
>   include/linux/soc/mediatek/mtk-cmdq.h   | 11 +------
>   3 files changed, 3 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> index 3fc5511330b9..cabeb7fea2be 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -824,8 +824,7 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
>   #if IS_REACHABLE(CONFIG_MTK_CMDQ)
>   	mtk_crtc->cmdq_client =
>   			cmdq_mbox_create(mtk_crtc->mmsys_dev,
> -					 drm_crtc_index(&mtk_crtc->base),
> -					 2000);
> +					 drm_crtc_index(&mtk_crtc->base));
>   	if (IS_ERR(mtk_crtc->cmdq_client)) {
>   		dev_dbg(dev, "mtk_crtc %d failed to create mailbox client, writing register by CPU now\n",
>   			drm_crtc_index(&mtk_crtc->base));
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> index dc644cfb6419..4f311f035b59 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -65,14 +65,7 @@ int cmdq_dev_get_client_reg(struct device *dev,
>   }
>   EXPORT_SYMBOL(cmdq_dev_get_client_reg);
>   
> -static void cmdq_client_timeout(struct timer_list *t)
> -{
> -	struct cmdq_client *client = from_timer(client, t, timer);
> -
> -	dev_err(client->client.dev, "cmdq timeout!\n");
> -}
> -
> -struct cmdq_client *cmdq_mbox_create(struct device *dev, int index, u32 timeout)
> +struct cmdq_client *cmdq_mbox_create(struct device *dev, int index)
>   {
>   	struct cmdq_client *client;
>   
> @@ -80,12 +73,6 @@ struct cmdq_client *cmdq_mbox_create(struct device *dev, int index, u32 timeout)
>   	if (!client)
>   		return (struct cmdq_client *)-ENOMEM;
>   
> -	client->timeout_ms = timeout;
> -	if (timeout != CMDQ_NO_TIMEOUT) {
> -		spin_lock_init(&client->lock);
> -		timer_setup(&client->timer, cmdq_client_timeout, 0);
> -	}
> -	client->pkt_cnt = 0;
>   	client->client.dev = dev;
>   	client->client.tx_block = false;
>   	client->client.knows_txdone = true;
> @@ -107,11 +94,6 @@ EXPORT_SYMBOL(cmdq_mbox_create);
>   
>   void cmdq_mbox_destroy(struct cmdq_client *client)
>   {
> -	if (client->timeout_ms != CMDQ_NO_TIMEOUT) {
> -		spin_lock(&client->lock);
> -		del_timer_sync(&client->timer);
> -		spin_unlock(&client->lock);
> -	}
>   	mbox_free_channel(client->chan);
>   	kfree(client);
>   }
> @@ -342,18 +324,6 @@ static void cmdq_pkt_flush_async_cb(struct cmdq_cb_data data)
>   	struct cmdq_task_cb *cb = &pkt->cb;
>   	struct cmdq_client *client = (struct cmdq_client *)pkt->cl;
>   
> -	if (client->timeout_ms != CMDQ_NO_TIMEOUT) {
> -		unsigned long flags = 0;
> -
> -		spin_lock_irqsave(&client->lock, flags);
> -		if (--client->pkt_cnt == 0)
> -			del_timer(&client->timer);
> -		else
> -			mod_timer(&client->timer, jiffies +
> -				  msecs_to_jiffies(client->timeout_ms));
> -		spin_unlock_irqrestore(&client->lock, flags);
> -	}
> -
>   	dma_sync_single_for_cpu(client->chan->mbox->dev, pkt->pa_base,
>   				pkt->cmd_buf_size, DMA_TO_DEVICE);
>   	if (cb->cb) {
> @@ -366,7 +336,6 @@ int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
>   			 void *data)
>   {
>   	int err;
> -	unsigned long flags = 0;
>   	struct cmdq_client *client = (struct cmdq_client *)pkt->cl;
>   
>   	pkt->cb.cb = cb;
> @@ -377,14 +346,6 @@ int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
>   	dma_sync_single_for_device(client->chan->mbox->dev, pkt->pa_base,
>   				   pkt->cmd_buf_size, DMA_TO_DEVICE);
>   
> -	if (client->timeout_ms != CMDQ_NO_TIMEOUT) {
> -		spin_lock_irqsave(&client->lock, flags);
> -		if (client->pkt_cnt++ == 0)
> -			mod_timer(&client->timer, jiffies +
> -				  msecs_to_jiffies(client->timeout_ms));
> -		spin_unlock_irqrestore(&client->lock, flags);
> -	}
> -
>   	err = mbox_send_message(client->chan, pkt);
>   	if (err < 0)
>   		return err;
> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
> index 2249ecaf77e4..175bd89f46f8 100644
> --- a/include/linux/soc/mediatek/mtk-cmdq.h
> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> @@ -11,8 +11,6 @@
>   #include <linux/mailbox/mtk-cmdq-mailbox.h>
>   #include <linux/timer.h>
>   
> -#define CMDQ_NO_TIMEOUT		0xffffffffu
> -
>   struct cmdq_pkt;
>   
>   struct cmdq_client_reg {
> @@ -22,12 +20,8 @@ struct cmdq_client_reg {
>   };
>   
>   struct cmdq_client {
> -	spinlock_t lock;
> -	u32 pkt_cnt;
>   	struct mbox_client client;
>   	struct mbox_chan *chan;
> -	struct timer_list timer;
> -	u32 timeout_ms; /* in unit of microsecond */
>   };
>   
>   /**
> @@ -49,13 +43,10 @@ int cmdq_dev_get_client_reg(struct device *dev,
>    * cmdq_mbox_create() - create CMDQ mailbox client and channel
>    * @dev:	device of CMDQ mailbox client
>    * @index:	index of CMDQ mailbox channel
> - * @timeout:	timeout of a pkt execution by GCE, in unit of microsecond, set
> - *		CMDQ_NO_TIMEOUT if a timer is not used.
>    *
>    * Return: CMDQ mailbox client pointer
>    */
> -struct cmdq_client *cmdq_mbox_create(struct device *dev, int index,
> -				     u32 timeout);
> +struct cmdq_client *cmdq_mbox_create(struct device *dev, int index);
>   
>   /**
>    * cmdq_mbox_destroy() - destroy CMDQ mailbox client and channel
> 
