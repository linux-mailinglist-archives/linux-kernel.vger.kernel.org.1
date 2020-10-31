Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E392A12C0
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 02:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgJaBtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 21:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgJaBtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 21:49:25 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C79C0613D5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 18:49:23 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id s144so1861550vkb.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 18:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZPV/6ZjBRsY6KZRFVNPjP+7C/4GJI8B4fX6GI9U1bfY=;
        b=PzOU5zcQSwvi3EzbEIVtg/DDLYvsBmNveN2MNbLTY9mOYyUxQcT6gnk2XY50TSq+Mz
         3ZcJz1PeIpxCswbwjZlQlHFzrSksRfTGt1+j7WVq4oKwFdbbLh2Mxe6/Bq+E/XxJVT+p
         +Z7jFzxTvSthZYITChYtjD1+qY54ytXoGDKWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZPV/6ZjBRsY6KZRFVNPjP+7C/4GJI8B4fX6GI9U1bfY=;
        b=luW/i4cF+1fLaNQf6epz3A+Wgrykso67GrvcK8Jti79srWzuZhFFTM1QNR7AaoCa+u
         AWpDgm3lN06OOpwHw3oVyO5A6sh4yRfeTszSs0Fsi/IAVKkz4PqUxuEBRKPrwbejNXUy
         8q2e5Bt9flod9HEs6Evif+182F/cnneaSr6g/dc5XON/L6m5ziCW399FS3RYBllj85zU
         ePRDVWKh5CrWAWjQv0by7Zx313G2geiipeLENxND9rXQ77FoC+qywMyca0Zy6UDLSzs5
         enRf0KU2dXuBGYGL4gRsQddlGpmiZ1yGJ3cv01q2tqbXmLlsL+lKsqc0/m8luxHmf7NH
         /wHA==
X-Gm-Message-State: AOAM533+TRPYn5CnD3nv46UMqTVphcVcJE1tZZyYUZ2hdu94iTPxpex/
        /VipXVWM5DcXxF9JoxXsUjmPK1fQZuQ8Teh6G+GZ4Q==
X-Google-Smtp-Source: ABdhPJxBfKPPEJsrRFAmfTb4PERFWlWcbJtupKxWmgnrLFxU+/eLQiLlHLypOOh1LpMzphA/TROBecVMymzvZfkoUrI=
X-Received: by 2002:a1f:2e45:: with SMTP id u66mr2964184vku.9.1604108962735;
 Fri, 30 Oct 2020 18:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <20201022094152.17662-1-houlong.wei@mediatek.com>
In-Reply-To: <20201022094152.17662-1-houlong.wei@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Sat, 31 Oct 2020 09:49:11 +0800
Message-ID: <CANMq1KC0nDNRUGm8Y5Lw1nH1uecYx7FnG9sWY=Gg9RhisroafA@mail.gmail.com>
Subject: Re: [PATCH] soc: mediatek: cmdq: fixup possible timeout issue
To:     Houlong Wei <houlong.wei@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        CK HU <ck.hu@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        ginny.chen@mediatek.com,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the patch.

On Thu, Oct 22, 2020 at 5:44 PM Houlong Wei <houlong.wei@mediatek.com> wrote:
>
> Fixes: 576f1b4bc802 ("soc: mediatek: Add Mediatek CMDQ helper")

nit: This belongs right next to the Sob line, but I guess/hope
Matthias can help you fix that ,-)

>
> There may be possible timeout issue when lots of cmdq packets are
> flushed to the same cmdq client. The necessary modifications are as
> below.
> 1.Adjust the timer timeout period as client->timeout_ms * client->pkt_cnt.
> 2.Optimize the time to start the timer.
>

Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

> Signed-off-by: Houlong Wei <houlong.wei@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-cmdq-helper.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> index dc644cfb6419..31142c193527 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -350,7 +350,8 @@ static void cmdq_pkt_flush_async_cb(struct cmdq_cb_data data)
>                         del_timer(&client->timer);
>                 else
>                         mod_timer(&client->timer, jiffies +
> -                                 msecs_to_jiffies(client->timeout_ms));
> +                                 msecs_to_jiffies(client->timeout_ms *
> +                                                  client->pkt_cnt));
>                 spin_unlock_irqrestore(&client->lock, flags);
>         }
>
> @@ -379,9 +380,7 @@ int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
>
>         if (client->timeout_ms != CMDQ_NO_TIMEOUT) {
>                 spin_lock_irqsave(&client->lock, flags);
> -               if (client->pkt_cnt++ == 0)
> -                       mod_timer(&client->timer, jiffies +
> -                                 msecs_to_jiffies(client->timeout_ms));
> +               client->pkt_cnt++;
>                 spin_unlock_irqrestore(&client->lock, flags);
>         }
>
> @@ -391,6 +390,21 @@ int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
>         /* We can send next packet immediately, so just call txdone. */
>         mbox_client_txdone(client->chan, 0);
>
> +       if (client->timeout_ms != CMDQ_NO_TIMEOUT) {
> +               spin_lock_irqsave(&client->lock, flags);
> +               /*
> +                * GCE HW maybe execute too quickly and the callback function
> +                * may be invoked earlier. If this happens, pkt_cnt is reduced
> +                * by 1 in cmdq_pkt_flush_async_cb(). The timer is set only if
> +                * pkt_cnt is greater than 0.
> +                */
> +               if (client->pkt_cnt > 0)
> +                       mod_timer(&client->timer, jiffies +
> +                                 msecs_to_jiffies(client->timeout_ms *
> +                                                  client->pkt_cnt));
> +               spin_unlock_irqrestore(&client->lock, flags);
> +       }
> +
>         return 0;
>  }
>  EXPORT_SYMBOL(cmdq_pkt_flush_async);
> --
> 2.18.0
