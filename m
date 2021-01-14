Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7822F59B9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 05:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbhANEB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 23:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbhANEBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 23:01:25 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E065C061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 20:00:45 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id n4so8625719iow.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 20:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bUNuOV0lkiudcY9ujl7cqtrWI85/vQQ/w9o9Luh5OXQ=;
        b=OyQLLjSoCSU30wkyILOqVYSYkdZDAE4iZo8dV3fBtK5svrkgBBBgZmaVaqCebhQSH1
         cyM55Uf4fD3dLEUbr3bJWJQrGkPjfWhGtJYT2OZ7CkIc0n/jbsRxn88nHoCO96rXe6Gc
         Tk5/LNCtj5fW3Z+iUC98dk8iw02tynmkneYLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bUNuOV0lkiudcY9ujl7cqtrWI85/vQQ/w9o9Luh5OXQ=;
        b=R/ovbNzrgbmqOKzi8SKop48SBjXLifNstJGh6DesU0hchm5PhYjFqkNYodhsH4IWkz
         g+wSms4+9yhYD20WK7OLB8DiUK+Z5slQBkGvygIxvd8FyahK83Tbcujtypxe6pMUF2eH
         XEVBZPWodHeo4p2Kml3Fedd44x3qlO8Fp95PppCHgG/0AV1Vsm+wldS3BZE5EN5plF47
         iZxPVWohVyMV2fZkhoAskgOEpYafcGp6cD52LzAUv0ydAv2Sx4KthNiFtosVmKEOSzmO
         kJGaGH16To/cgNHuWjILbBbbWfB69DRzJyFLX5/77T7lHXNlVfLSaop8h4vWsnaiqhdN
         5JuA==
X-Gm-Message-State: AOAM53013AEtj9qzTlHpA+pEXxvSSEmoxRtRXX3X3dN6w+AU8hnVfzKa
        X7SimOrLk6sbsiM6dqANfjc6OoQ9gR7qozilZPj7+jq3hUkkWw==
X-Google-Smtp-Source: ABdhPJzS29RiRBDqwb/rarGXe1c4kC+vlN7yf5p4zUPTQq2hFVDngTqGgKMqxe28CgKZvSlbJRyEG4WM0CtLOO2tzMc=
X-Received: by 2002:a05:6638:138e:: with SMTP id w14mr4937766jad.98.1610596844255;
 Wed, 13 Jan 2021 20:00:44 -0800 (PST)
MIME-Version: 1.0
References: <20210113213012.67643-1-enric.balletbo@collabora.com>
In-Reply-To: <20210113213012.67643-1-enric.balletbo@collabora.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 14 Jan 2021 12:00:18 +0800
Message-ID: <CAJMQK-gvKaiHNWxzq3+NDnoN8kd2u26e6WKZqX=R9dc+aB5xFw@mail.gmail.com>
Subject: Re: [PATCH] soc: mediatek: pm-domains: Don't print an error if child
 domain is deferred
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 5:30 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Child domains can be deferred by the core because one of its resources
> is not available yet, in such case, it will print an error, but
> later it will succeed to probe. Fix that using the dev_err_probe()
> function so it only prints an error on a real error.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>
>  drivers/soc/mediatek/mtk-pm-domains.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> index ae255aa7b1a9..8055fb019ba6 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.c
> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> @@ -480,8 +480,8 @@ static int scpsys_add_subdomain(struct scpsys *scpsys, struct device_node *paren
>
>                 child_pd = scpsys_add_one_domain(scpsys, child);
>                 if (IS_ERR(child_pd)) {
> -                       ret = PTR_ERR(child_pd);
> -                       dev_err(scpsys->dev, "%pOF: failed to get child domain id\n", child);
> +                       dev_err_probe(scpsys->dev, PTR_ERR(child_pd),
> +                                     "%pOF: failed to get child domain id\n", child);
>                         goto err_put_node;
>                 }
>
> --
> 2.29.2
>
