Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD0C2CFA45
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 08:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgLEHgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 02:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgLEHgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 02:36:03 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A69FC0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 23:35:23 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id j140so4615980vsd.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 23:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wvz8/c+BmSxUPKOte4ILOvp/ZC9OehDDCPuA6tvG3S0=;
        b=K6t+x0wUD6+gcBEHcRnqOjge0qLsOpeU+IBfjcKm+7goKFfXsNIOkfQe0ErdBiwZcC
         c//ry1RZv65MdRb0PK4XbJop3klQOQtVNGlgu1RUTXdz2BYyINxYkP6fddxtxO8EFY+X
         F2Ng/U0DCbKXiLr5Mtz5iAszjD8PFTKCgf0do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wvz8/c+BmSxUPKOte4ILOvp/ZC9OehDDCPuA6tvG3S0=;
        b=MglX9YMuUjW52rDFxZB8XKqTA8Hiyi3l6xGEzDMOMsxU/tkGa9hQi/C+unNMbgstG+
         N/R8HzCtD9RrSZR4B+AMdGTLgc/czVRslwqTKo8CFwDDgVBknQ9F1InHd5F0UAZQeC/k
         tJ2kBand6Q75N2DngRyHV7k69fNrSi+bjue8CrbRrvJlEqDx3QN6v21NCrR535SEU7cw
         LBLIpLuABTJKTaCJ0cK9hRzIytrOVR9jUuP8ldWTBUpHN/rXw0f+xswQwJVOIpfKz7Pk
         JRWJRmBiQe2jg7UHvSzQ/5flrAP5ywwkgC6LF0gcg8o7x4ToMmhT/yqL/irX9wXXYKu1
         1Awg==
X-Gm-Message-State: AOAM530uD5vUusVNF32OToApPGknP98no8zyCYT24Pmi6YYnBIQg//ZY
        RY7WqK4ZYwj/2G0UMxTI5uCTzVYcty1VCK5awLoKmw==
X-Google-Smtp-Source: ABdhPJwFwcxNs/rUWeL3nHnAVJay+557ujsyjsp13A68iO7wBKwVvs3THM35jPvHbDdVlcyYdOJrr67dWMqlB0pidgw=
X-Received: by 2002:a05:6102:3234:: with SMTP id x20mr7358436vsf.21.1607153722309;
 Fri, 04 Dec 2020 23:35:22 -0800 (PST)
MIME-Version: 1.0
References: <1607141728-17307-1-git-send-email-yongqiang.niu@mediatek.com> <1607141728-17307-4-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1607141728-17307-4-git-send-email-yongqiang.niu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Sat, 5 Dec 2020 15:35:11 +0800
Message-ID: <CANMq1KDWwfijinZq0b8BVqvYBj1fOHFpfMPLbzj0JR8z9LKypw@mail.gmail.com>
Subject: Re: [PATCH v1, 3/5] mailbox: mediatek: add control_by_sw private data
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 5, 2020 at 12:18 PM Yongqiang Niu
<yongqiang.niu@mediatek.com> wrote:
>
> add control_by_sw private data

Can you describe in a bit more details what this means?

>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/mailbox/mtk-cmdq-mailbox.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
> index 5665b6e..1c01fe0 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -36,6 +36,8 @@
>  #define CMDQ_THR_WAIT_TOKEN            0x30
>  #define CMDQ_THR_PRIORITY              0x40
>
> +#define GCE_GCTL_VALUE                 0x48
> +
>  #define CMDQ_THR_ACTIVE_SLOT_CYCLES    0x3200
>  #define CMDQ_THR_ENABLED               0x1
>  #define CMDQ_THR_DISABLED              0x0
> @@ -76,11 +78,13 @@ struct cmdq {
>         struct clk              *clock;
>         bool                    suspended;
>         u8                      shift_pa;
> +       bool                    control_by_sw;
>  };
>
>  struct gce_plat {
>         u32 thread_nr;
>         u8 shift;
> +       bool control_by_sw;
>  };
>
>  u8 cmdq_get_shift_pa(struct mbox_chan *chan)
> @@ -121,6 +125,8 @@ static void cmdq_init(struct cmdq *cmdq)
>         int i;
>
>         WARN_ON(clk_enable(cmdq->clock) < 0);
> +       if (cmdq->control_by_sw)
> +               writel(0x7, cmdq->base + GCE_GCTL_VALUE);

What is 0x7? Define a macro for these bits?

>         writel(CMDQ_THR_ACTIVE_SLOT_CYCLES, cmdq->base + CMDQ_THR_SLOT_CYCLES);
>         for (i = 0; i <= CMDQ_MAX_EVENT; i++)
>                 writel(i, cmdq->base + CMDQ_SYNC_TOKEN_UPDATE);
> @@ -536,6 +542,7 @@ static int cmdq_probe(struct platform_device *pdev)
>
>         cmdq->thread_nr = plat_data->thread_nr;
>         cmdq->shift_pa = plat_data->shift;
> +       cmdq->control_by_sw = plat_data->control_by_sw;
>         cmdq->irq_mask = GENMASK(cmdq->thread_nr - 1, 0);
>         err = devm_request_irq(dev, cmdq->irq, cmdq_irq_handler, IRQF_SHARED,
>                                "mtk_cmdq", cmdq);
> --
> 1.8.1.1.dirty
>
