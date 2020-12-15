Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A120B2DAE32
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 14:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbgLONn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 08:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbgLONnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 08:43:14 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8469C0617A7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 05:42:33 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id r24so10951727vsg.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 05:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WdtyYhINVIP0zj4hUblQtYm+d83mIC5y4bO6fsIgws4=;
        b=C/RgTTl9KMhfhdhqZl9UbJevCVbwaNYQgtvwTG+fXTyFmB6V2/sys/PtcEKz+1Oy4O
         p3GSJKsust/Icf+LPbYr3T+jLpXLVEF8rug3mXG2q9goAHNClsaujDImUyJFUlTwWR7q
         VtyutBiwjXkLgHwiW1N9bmLQtkEKT0weRm398=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WdtyYhINVIP0zj4hUblQtYm+d83mIC5y4bO6fsIgws4=;
        b=G6qHk8CPIBodZ1WGHhXIW4pfl2TsEObhCeS1nwkBOHC15G5LYDhsoekcOHrbUL2/9X
         O2mFlPwnxtYLoEBshpsnrg7toj2XyKr81fmNVN9bBuNvAQqhBqZQ+kiy22YidX2OOgoo
         p57yEEoz4lN/E4JHyWZVKlCOFeILoSipb/sSCwkdEaJ2OmqgElevSOWbVmZqqnYJn5zL
         mKODBAAy3qw/r80WCpBJ6PmCyCT2Egh4Vydn8u6d4mJ9T6Gsuil2N1uU0tUutZ2axDCN
         oxZmG5VJM/bpG+TkQudnJg7FFpWmZo4kkpSGjsdRch8NM3bneQLsgPTCeXOfGSGXolXS
         NEjg==
X-Gm-Message-State: AOAM533GdsQHXfBYAQscjHmj/x6hXoygEu7fAlKrrH9K5fKSPfoOZsFY
        +NFLOR6J2FECm71MtJECfhnoNzyse9JcmYZ65osbYg==
X-Google-Smtp-Source: ABdhPJxv7M8JgVQKp38gzV7gwW3jUYVRPuREIp84PvUJ8p1GCQQ6BumzGfT66kHqi5Xu7tZP47OxnxOJibawlusR1MI=
X-Received: by 2002:a67:ff03:: with SMTP id v3mr26709138vsp.48.1608039752973;
 Tue, 15 Dec 2020 05:42:32 -0800 (PST)
MIME-Version: 1.0
References: <1607746317-4696-1-git-send-email-yongqiang.niu@mediatek.com> <1607746317-4696-15-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1607746317-4696-15-git-send-email-yongqiang.niu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 15 Dec 2020 21:42:22 +0800
Message-ID: <CANMq1KBu4Ft49CUgGMxYdsv6ymWzVWK+eNBhn1t+oEN0ZwP0YA@mail.gmail.com>
Subject: Re: [PATCH v2, 14/17] soc: mediatek: mmsys: Use function call for
 setting mmsys ovl mout register
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 12, 2020 at 12:13 PM Yongqiang Niu
<yongqiang.niu@mediatek.com> wrote:
>
> Use function call for setting mmsys ovl mout register
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/soc/mediatek/mmsys/mtk-mmsys.c | 18 ++++++++++++++++++
>  include/linux/soc/mediatek/mtk-mmsys.h |  3 +++
>  2 files changed, 21 insertions(+)
>
> diff --git a/drivers/soc/mediatek/mmsys/mtk-mmsys.c b/drivers/soc/mediatek/mmsys/mtk-mmsys.c
> index cb76e64..2558b42 100644
> --- a/drivers/soc/mediatek/mmsys/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mmsys/mtk-mmsys.c
> @@ -78,6 +78,15 @@ void mtk_mmsys_ddp_connect(struct device *dev,
>                 reg = readl_relaxed(mmsys->regs + addr) | value;
>                 writel_relaxed(reg, mmsys->regs + addr);
>         }
> +
> +       if (!funcs->ovl_mout_en)
> +               return;
> +
> +       value = funcs->ovl_mout_en(cur, next, &addr);
> +       if (value) {
> +               reg = readl_relaxed(mmsys->regs + addr) | value;
> +               writel_relaxed(reg, mmsys->regs + addr);
> +       }

This is technically correct, but I'm afraid this may become and issue
later if we have another function like ovl_mout_en.

So maybe it's better to do:
if (funcs->ovl_mout_en) {
  value = funcs->ovl_mout_en(cur, next, &addr);
  ...
}

Or another option: Create a new function
static unsigned int mtk_mmsys_ovl_mout_en(...) {
   if (!funcs->ovl_mout_en)
      return 0;
}

and call that, following the same pattern as
mtk_mmsys_ddp_mout_en/mtk_mmsys_ddp_sel_in?

>  }
>  EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_connect);
>
> @@ -103,6 +112,15 @@ void mtk_mmsys_ddp_disconnect(struct device *dev,
>                 reg = readl_relaxed(mmsys->regs + addr) & ~value;
>                 writel_relaxed(reg, mmsys->regs + addr);
>         }
> +
> +       if (!funcs->ovl_mout_en)
> +               return;
> +
> +       value = funcs->ovl_mout_en(cur, next, &addr);
> +       if (value) {
> +               reg = readl_relaxed(mmsys->regs + addr) & ~value;
> +               writel_relaxed(reg, mmsys->regs + addr);
> +       }
>  }
>  EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_disconnect);
>
> diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/mediatek/mtk-mmsys.h
> index aa4f60e..220203d 100644
> --- a/include/linux/soc/mediatek/mtk-mmsys.h
> +++ b/include/linux/soc/mediatek/mtk-mmsys.h
> @@ -49,6 +49,9 @@ struct mtk_mmsys_conn_funcs {
>         u32 (*mout_en)(enum mtk_ddp_comp_id cur,
>                        enum mtk_ddp_comp_id next,
>                        unsigned int *addr);
> +       u32 (*ovl_mout_en)(enum mtk_ddp_comp_id cur,
> +                          enum mtk_ddp_comp_id next,
> +                          unsigned int *addr);
>         u32 (*sel_in)(enum mtk_ddp_comp_id cur,
>                       enum mtk_ddp_comp_id next,
>                       unsigned int *addr);
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
