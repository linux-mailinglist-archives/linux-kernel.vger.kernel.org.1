Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF112CFA42
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 08:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgLEHbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 02:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgLEHbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 02:31:23 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503F0C0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 23:30:37 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id s85so4620316vsc.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 23:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PVl4mPVWUd46XCRZhLi+cr8uHjV2Z7jL+fg9NKg+71M=;
        b=edNOUVq1cViNXg/pK/xleKw22hUhic5MPStTYjmTnNbv6cJPTLcYUGVIbO4j8F1Rwt
         +wAkFzgwazwvbS0T5M2ifmb+D8ndT+wHnhthjt6FyAg2MSfJwEpJ2bEDmWnfVDU4TkAF
         bh6jee8qRJQLxC8G5NP98H7QAA87eRixtY044=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PVl4mPVWUd46XCRZhLi+cr8uHjV2Z7jL+fg9NKg+71M=;
        b=eRrDND1zy//8xVQxMfAW9dpcAXjDpvvYkrusja+O0VeEUEb7DZg9TIofueXnF5faXb
         BMtubjz44d9TAX7jJw2BkECR56e9skz4q5lf7TKC4/eGSjUvHa/KQDTXomA/nB8+obTW
         0Xz0BcFnO8IwTqC4gZdkWBpEuKbm78G1HtJWbZcqGoEAYDZLtALSlCs2AJVVqYsVVPOJ
         vUSIL6knMPD29+Y/U5HQREdu/cY7L/wvxMkMyWijJE3SSiP2t7HwgYnERvpwX6Besdby
         aZJ/myaJJMml+54IKj1VfwLs7p6doobRVkhYl+0MLOHj0L0umzS4lCyaeVcE+kUV36Ro
         66KA==
X-Gm-Message-State: AOAM5314pXIKpNTTeCUaFxJvZGskdrAmpkhSZhENTAcLJah3+PCrgh3W
        ooZOULnTBD/7M/Iu5+/L8xCkmKXRdt6kGxFm6LtmAQ==
X-Google-Smtp-Source: ABdhPJzXvqDzLe1ZMwTemW7PNInHdQEHH3HkYidK1l7D2zd1eYtLyFTuqpYjAg6WH/cbCWE4eSurnelP7EVha8x8nbo=
X-Received: by 2002:a67:ff03:: with SMTP id v3mr6924809vsp.48.1607153436299;
 Fri, 04 Dec 2020 23:30:36 -0800 (PST)
MIME-Version: 1.0
References: <1607141728-17307-1-git-send-email-yongqiang.niu@mediatek.com> <1607141728-17307-5-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1607141728-17307-5-git-send-email-yongqiang.niu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Sat, 5 Dec 2020 15:30:25 +0800
Message-ID: <CANMq1KCX+iPXVg-xqVKBGNTfJty=cu+MQYaujjv4NgTd1C740A@mail.gmail.com>
Subject: Re: [PATCH v1, 4/5] soc: mediatek: cmdq: add address shift in jump
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 5, 2020 at 12:16 PM Yongqiang Niu
<yongqiang.niu@mediatek.com> wrote:
>
> Add address shift when compose jump instruction
> to compatible with 35bit format.

This looks reasonable, but task->cmdq->shift_pa is not new and was
introduced as part of mt6779 GCE support.

Do you want to add a Fixes tag?
Fixes: 0858fde496f8 ("mailbox: cmdq: variablize address shift in platform")

Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/mailbox/mtk-cmdq-mailbox.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
> index 1c01fe0..5ed39f8 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -174,7 +174,8 @@ static void cmdq_task_insert_into_thread(struct cmdq_task *task)
>         dma_sync_single_for_cpu(dev, prev_task->pa_base,
>                                 prev_task->pkt->cmd_buf_size, DMA_TO_DEVICE);
>         prev_task_base[CMDQ_NUM_CMD(prev_task->pkt) - 1] =
> -               (u64)CMDQ_JUMP_BY_PA << 32 | task->pa_base;
> +               (u64)CMDQ_JUMP_BY_PA << 32 |
> +               (task->pa_base >> task->cmdq->shift_pa);
>         dma_sync_single_for_device(dev, prev_task->pa_base,
>                                    prev_task->pkt->cmd_buf_size, DMA_TO_DEVICE);
>
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
