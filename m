Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC522ECF2C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 12:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbhAGLyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 06:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbhAGLyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 06:54:36 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132EEC0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 03:53:55 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id g20so9389054ejb.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 03:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rsynHIghsKQJZD4h8BVfrHuvAqsY9Wy0HaJluKpfM9g=;
        b=bk5+OqxV8PFErwByGFZcsM+4WQ8PA4hU1T7M0DvmIOY6tQ6Yu/dYBiBu+g2XPZE74j
         mbuuMFRSDYFQr/bjOQbYMsGxRvV9DqnkWUe8k242FYYZFjjG021m3hBTCIV3uBwxZI7t
         Y60aUvy9pWH4WomNPps2CR54rvJaYpNMflzERYp9fVkwLGRv+CmSG2JJWUzCsvQf30jQ
         av31jTEXZF+n7Mgu/G9e6lRAfwGiovCb2DeqbD5INHqhQTH9LQvHOmt8HW/PQefDvUpl
         XulYdrnpPrkPkck8BDH7brrvB37yFauigaP4Bfkl2nwY8WTiUevMVdnefZ/dNi77X/dC
         fQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rsynHIghsKQJZD4h8BVfrHuvAqsY9Wy0HaJluKpfM9g=;
        b=HInvHcHqkFJadJOkg/xLdDEQPjV1umehTZ9kvOHhfDuFRmBApcEZhpP5kOfpIYP2Aj
         33HwLjnrY7q/cGIaSPT3ubTnRxLVIyII12lCAJ53pcnPs5xCh4cYLGKm9LMVe8GXZddO
         E/fXTkbKim6Hdoo7DwF7tlIBIwU642ibRJV2WEELNsMKXTYaTYkymm1BmxSxEAA/VE6p
         GNUyujE9ovVfZQp0WVUREfv0d/+0DVnuEy2GYzKOCzWWReFBsmIzf5/yomcXjhTAe9KW
         VTqFHd1U3SgoSWkzJHmUJRE8exzZlpvQJ0NjtxV2+9XjUo9R8w13BEd5aORFDDAnfJMJ
         KuAA==
X-Gm-Message-State: AOAM531MejDfg/t8NagF8b91/GbUQ/qJsx9bxxFohffm0EqCKte1Cnmu
        zuEiQ2Vlf8LHPawyom5AUbnzskt/F1eB2Rllx9M=
X-Google-Smtp-Source: ABdhPJxygP96R8lHa0QaoZm28a6WxZv4bKPRA3JoNfBQjrt5Kybsf8eVehaXJhcm4oSYgkko648JS1uTPnGk5M4CvmI=
X-Received: by 2002:a17:906:52d9:: with SMTP id w25mr5874188ejn.504.1610020433833;
 Thu, 07 Jan 2021 03:53:53 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:906:f858:0:0:0:0 with HTTP; Thu, 7 Jan 2021 03:53:52
 -0800 (PST)
In-Reply-To: <1608022118-29993-1-git-send-email-yaohaidong369@gmail.com>
References: <1608022118-29993-1-git-send-email-yaohaidong369@gmail.com>
From:   haidong yao <yaohaidong369@gmail.com>
Date:   Thu, 7 Jan 2021 19:53:52 +0800
Message-ID: <CA+kUaCeebDNXi12-nNpw4i_auZbM+JQUC5uNhEzXxqa7=W4LnQ@mail.gmail.com>
Subject: Re: [PATCH] add chan->cl check in mbox_chan_received_data()
To:     jassisinghbrar@gmail.com, natechancellor@gmail.com,
        ndesaulniers@google.com, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, orsonzhai@gmail.com
Cc:     zhang.lyra@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jassi Brar

Thank you very much for your reply.

Look at the function sprd_mbox_outbox_isr .

Chan is !NULL.

chan->cl is NULL when the client driver not loaded, the controller
driver don't know the client driver loaded successfully, so, I do not
use mbox_free_channel.

Here,How do you know chan->cl is ok?

chan = &priv->chan[id];
mbox_chan_received_data(chan, (void *)msg);

static irqreturn_t sprd_mbox_outbox_isr(int irq, void *data)
{
        struct sprd_mbox_priv *priv = data;
        struct mbox_chan *chan;
        u32 fifo_sts, fifo_len, msg[2];
        int i, id;

        fifo_sts = readl(priv->outbox_base + SPRD_MBOX_FIFO_STS);

        fifo_len = sprd_mbox_get_fifo_len(priv, fifo_sts);
        if (!fifo_len) {
                dev_warn_ratelimited(priv->dev, "spurious outbox interrupt\n");
                return IRQ_NONE;
        }

        for (i = 0; i < fifo_len; i++) {
                msg[0] = readl(priv->outbox_base + SPRD_MBOX_MSG_LOW);
                msg[1] = readl(priv->outbox_base + SPRD_MBOX_MSG_HIGH);
                id = readl(priv->outbox_base + SPRD_MBOX_ID);

                chan = &priv->chan[id];
                mbox_chan_received_data(chan, (void *)msg);

                /* Trigger to update outbox FIFO pointer */
                writel(0x1, priv->outbox_base + SPRD_MBOX_TRIGGER);
        }

        /* Clear irq status after reading all message. */
        writel(SPRD_MBOX_IRQ_CLR, priv->outbox_base + SPRD_MBOX_IRQ_STS);

        return IRQ_HANDLED;
}


On Tue, Dec 15, 2020 at 2:48 AM Haidong Yao <yaohaidong369@gmail.com> wrote:

> --- a/drivers/mailbox/mailbox.c
> +++ b/drivers/mailbox/mailbox.c
> @@ -152,7 +152,7 @@ static enum hrtimer_restart txdone_hrtimer(struct hrtimer *hrtimer)
>  void mbox_chan_received_data(struct mbox_chan *chan, void *mssg)
>  {
>         /* No buffering the received data */
> -       if (chan->cl->rx_callback)
> +       if (chan->cl && chan->cl->rx_callback)
>                 chan->cl->rx_callback(chan->cl, mssg);
>  }
The proper fix is in the controller driver. Which should stop tx/rx
when the channel is freed.

thnx.



2020-12-15 16:48 GMT+08:00, Haidong Yao <yaohaidong369@gmail.com>:
> From: Haidong Yao <haidong.yao@unisoc.com>
>
> mailbox outbox irq is coming, but mbox_request_channel
> is not be registered, so cl->rx_callback is NULL.
>
> panic log:
> [    9.852090]c0  Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000020
> [    9.954634]c0  pstate: 60400089 (nZCv daIf +PAN -UAO)
> [    9.954651]c0  pc : mbox_chan_received_data+0x1c/0x88
> [    9.954666]c0  lr : sprd_mbox_outbox_isr+0x1d0/0x204 [sprd_mailbox]
> [    9.967439]c0  sp : ffffffc010003e10
> [    9.967443]c0  x29: ffffffc010003e20 x28: ffffffc011c2f6c0-
> [    9.984918]c0  x27: ffffffc010e92e08 x26: 0000000000000001-
> [   10.140344]c0  x25: 0000000000000378 x24: ffffff80f4064130-
> [   10.145880]c0  x23: 0000000000000001 x22: ffffffc0091072c7-
> [   10.151418]c0  x21: ffffffc009107212 x20: 0000000000000005-
> [   10.156957]c0  x19: ffffff80f4064080 x18: ffffffc010005038-
> [   10.162494]c0  x17: 0000000000000000 x16: ffffffc010e6f844-
> [   10.168033]c0  x15: ffffffc0117abac7 x14: 000000000000003f-
> [   10.173571]c0  x13: ffff0000ffffff00 x12: ffff0a01ffffff10-
> [   10.179110]c0  x11: 0000000000000001 x10: 00000000ffffffff-
> [   10.184649]c0  x9 : ffffff80f40644a8 x8 : c366877097809900-
> [   10.190187]c0  x7 : 207273695f786f62 x6 : ffffffc011d62231-
> [   10.195726]c0  x5 : 0000000000000034 x4 : 000000000000000c-
> [   10.201265]c0  x3 : ffffffc010e9842c x2 : 0000000000000001-
> [   10.206803]c0  x1 : ffffffc010003e40 x0 : 0000000000000000-
> [   10.212343]c0  Call trace:
> [   10.215029]c0   mbox_chan_received_data+0x1c/0x88
> [   10.219705]c0   sprd_mbox_outbox_isr+0x1d0/0x204 [sprd_mailbox]
> [   10.225590]c0   __handle_irq_event_percpu+0x164/0x358
> [   10.230604]c0   handle_irq_event+0x60/0xd8
> [   10.234675]c0   handle_fasteoi_irq+0x128/0x32c
> [   10.239086]c0   __handle_domain_irq+0xa0/0x100
> [   10.243502]c0   efi_header_end+0xb8/0x15c
> [   10.247478]c0   el1_irq+0x104/0x200
> [   10.250945]c0   cpuidle_enter_state+0x158/0x2d8
> [   10.255440]c0   cpuidle_enter+0x38/0x50
> [   10.259253]c0   do_idle.llvm.10091284334483161164+0x1a4/0x294
> [   10.264963]c0   cpu_startup_entry+0x24/0x28
> [   10.269120]c0   kernel_init+0x0/0x29c
> [   10.272752]c0   start_kernel+0x0/0x418
> [   10.276468]c0   start_kernel+0x3a0/0x418
> [   10.280371]c0  Code: f90013f3 910043fd aa0003e9 f9400800 (f9401008)-
> [   10.286684]c0  ---[ end trace b868997a960c667a ]---
>
> Signed-off-by: Haidong Yao <haidong.yao@unisoc.com>
> ---
>  drivers/mailbox/mailbox.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> index 3e7d4b20ab34..58697298a95f 100644
> --- a/drivers/mailbox/mailbox.c
> +++ b/drivers/mailbox/mailbox.c
> @@ -152,7 +152,7 @@ static enum hrtimer_restart txdone_hrtimer(struct
> hrtimer *hrtimer)
>  void mbox_chan_received_data(struct mbox_chan *chan, void *mssg)
>  {
>  	/* No buffering the received data */
> -	if (chan->cl->rx_callback)
> +	if (chan->cl && chan->cl->rx_callback)
>  		chan->cl->rx_callback(chan->cl, mssg);
>  }
>  EXPORT_SYMBOL_GPL(mbox_chan_received_data);
> --
> 2.28.0
>
>
