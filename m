Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA9025A841
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 11:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgIBJEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 05:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbgIBJEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 05:04:04 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7180FC061245
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 02:04:04 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id o184so2186020vsc.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 02:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hFnfq76GlnsUYLxeV0fKqnYc2qmykFYSJOcJXdU/GGk=;
        b=N0KHXRDtwYgxVI4n0o099cYfeLkcI4F7PipVrxLx0iYnKFfBhKor9MYqScRo5TyAbK
         rV4KCiPzj2lt4a3gg2qucLoNE57VSPmACia+ffSBqz7/DGBHgfRbcclvWl09zsAHllDq
         GO7AGWM5jyTOwqUP4gUF5qtUPvXUCHp4434AYzgEQdZCLPbRtImYmg13LihPzeC+/1br
         PwZzDfr/O+ubvpD/LEWEoKocxSm9drxEQM+tB7XVHS/ytNH26cuRFe4URiXue8deNKdq
         cahqc04wc7/PAnFAbgEm5vcUtOUAyYyQAqN2c7MAloeaIGTkACYLdKz/KHv39nDDo45E
         yXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hFnfq76GlnsUYLxeV0fKqnYc2qmykFYSJOcJXdU/GGk=;
        b=IPHSx8Opjy/nxD9xldGRIivTMINAtMiY4weHJsoED951Cjs+gAIO9qbpLytcX4vFwJ
         6rF8eyFrzAhsF+u/PNnlA7VyEGlHhVYslcCum9j9kMVflCqG8DZ8vfCS071CQvBLU3cB
         5iLNpS/QSbFD5JHjMasBjb24/Luf2SEYsrl+ZjjQPIcGPPDhej8p7bmr4Zlu29HDcxWM
         66GhmSgDIPFJMRAZR9PLNw0tUMFaGNxBDIbGbQfFpT/lvFZ8AijsXvA0poDDmdbN6nHm
         mA0wJicQgbQjDW5XIaAd3A1cmXQ9GVMMsKuEi5wGoOLfvuZm6k5bcSvl9AnAk6XXLeuO
         nD1w==
X-Gm-Message-State: AOAM531uBkHvPEv6aw7KUJISZoBZWnsxwjnqJNGBZ6tUu1ifCJAEB+9F
        cFYlzlvpYEtabnZ2duTaGAmgGNlfW4hxVbBeld+54Q==
X-Google-Smtp-Source: ABdhPJxvNkCHqkXeW6+ncgi9B+yO4U+7Pipy1zHbUW8fR1FyXHaqe/R4OuugY6ftNvPRbMGxAdOqpJOUH7HNDNC0i9M=
X-Received: by 2002:a67:b44a:: with SMTP id c10mr4492088vsm.35.1599037443576;
 Wed, 02 Sep 2020 02:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200901085004.2512-1-matthias.schiffer@ew.tq-group.com> <20200901085004.2512-2-matthias.schiffer@ew.tq-group.com>
In-Reply-To: <20200901085004.2512-2-matthias.schiffer@ew.tq-group.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 2 Sep 2020 11:03:27 +0200
Message-ID: <CAPDyKFoMcxxm5=tNmn8b9xU+xRYUchz5pXOMZQUed8gR9G-Hrw@mail.gmail.com>
Subject: Re: [PATCH mmc-next v4 2/2] mmc: allow setting slot index via device
 tree alias
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Sep 2020 at 10:50, Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:
>
> As with GPIO, UART and others, allow specifying the device index via the
> aliases node in the device tree.
>
> On embedded devices, there is often a combination of removable (e.g.
> SD card) and non-removable MMC devices (e.g. eMMC).
> Therefore the index might change depending on
>
> * host of removable device
> * removable card present or not
>
> This makes it difficult to hardcode the root device, if it is on the
> non-removable device. E.g. if SD card is present eMMC will be mmcblk1,
> if SD card is not present at boot, eMMC will be mmcblk0.
>
> Alternative solutions like PARTUUIDs do not cover the case where multiple
> mmcblk devices contain the same image. This is a common issue on devices
> that can boot both from eMMC (for regular boot) and SD cards (as a
> temporary boot medium for development). When a firmware image is
> installed to eMMC after a test boot via SD card, there will be no
> reliable way to refer to a specific device using (PART)UUIDs oder
> LABELs.
>
> The demand for this feature has led to multiple attempts to implement
> it, dating back at least to 2012 (see
> https://www.spinics.net/lists/linux-mmc/msg26586.html for a previous
> discussion from 2014).
>
> All indices defined in the aliases node will be reserved for use by the
> respective MMC device, moving the indices of devices that don't have an
> alias up into the non-reserved range. If the aliases node is not found,
> the driver will act as before.
>
> This is a rebased and cleaned up version of
> https://www.spinics.net/lists/linux-mmc/msg26588.html .
>
> Based-on-patch-by: Sascha Hauer <s.hauer@pengutronix.de>
> Link: https://lkml.org/lkml/2020/8/5/194
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> v4:
> - minor adjustments to commit message
>
> v3:
> - remove unneeded mmcblock changes
> - remove most helper functions to simplify code
> - extended commit message
>
> v2:
> - fix missing symbols for modular mmcblock
>
>
>
>  drivers/mmc/core/host.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index c8fae6611b73..96b2ca1f1b06 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -376,6 +376,20 @@ int mmc_of_parse_voltage(struct device_node *np, u32 *mask)
>  }
>  EXPORT_SYMBOL(mmc_of_parse_voltage);
>
> +/**
> + * mmc_first_nonreserved_index() - get the first index that is not reserved
> + */
> +static int mmc_first_nonreserved_index(void)
> +{
> +       int max;
> +
> +       max = of_alias_get_highest_id("mmc");
> +       if (max < 0)
> +               return 0;
> +
> +       return max + 1;
> +}
> +
>  /**
>   *     mmc_alloc_host - initialise the per-host structure.
>   *     @extra: sizeof private data structure
> @@ -387,6 +401,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>  {
>         int err;
>         struct mmc_host *host;
> +       int alias_id, min_idx, max_idx;
>
>         host = kzalloc(sizeof(struct mmc_host) + extra, GFP_KERNEL);
>         if (!host)
> @@ -395,7 +410,16 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>         /* scanning will be enabled when we're ready */
>         host->rescan_disable = 1;
>
> -       err = ida_simple_get(&mmc_host_ida, 0, 0, GFP_KERNEL);
> +       alias_id = of_alias_get_id(dev->of_node, "mmc");
> +       if (alias_id >= 0) {
> +               min_idx = alias_id;
> +               max_idx = alias_id + 1;
> +       } else {
> +               min_idx = mmc_first_nonreserved_index();
> +               max_idx = 0;
> +       }
> +
> +       err = ida_simple_get(&mmc_host_ida, min_idx, max_idx, GFP_KERNEL);
>         if (err < 0) {
>                 kfree(host);
>                 return NULL;
> --
> 2.17.1
>
