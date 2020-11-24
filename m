Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8EF2C1A49
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 01:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbgKXAzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 19:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgKXAzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 19:55:42 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC57C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:55:41 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id m13so20132806ioq.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kVHPzIRwek8E3f7Sx26BG40H0alZuW716ApQdhgz6Iw=;
        b=N8kuw9EvqwIgGVWTR29b/Rl/2bss44iB/0TgMwyT1N0NZh4sBu+46M9TtGYGuWxyBY
         H3q+QwEgpCbJpJl9jNrnQrod75wA8elCoD5+7AR0IonZro764uw3wKzMsDPZ2jeasPh8
         DX5Z3TOUARxslaevqzGUx8lihh6f/WMSxMq1gGAPwUzDFrAL1vNt+hk05+BNXrsBNgyx
         lkwb906PQ7cczc05Qz1fZLReqwwrr8DS6+OfVIq1DJ097xOfPzzJQ+dM6exEMSr03jls
         WqRY3+lUSTA548y/cL9Kw4IZsIveV6OhEwvGo5BuYoOED+Rpkw0RBxrt8Qfp6odX5g0c
         FRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kVHPzIRwek8E3f7Sx26BG40H0alZuW716ApQdhgz6Iw=;
        b=kZQ2+CV/YyEfHXM9TLCsmQE4O9tA4HaY6PhotuZDsBoW0eFpdApKFNnRk2m/OCAl8/
         FTJ+ZAZ2sUTf3G/sFB28hQmr/8QbQPPRdz/rHxXNwJlT8uhglTHKhPxnPbySwh6gFBn6
         gMUuValP19LS723zzSb2njZAWYMXP9LNP5mt3tHUeVrXNDN2OH3DEGTRjX6Y11yOJyM6
         JjnU1cv3LCg5Wu5vDvDvDU5WR2NsWhhXTPHMyyYMiHvVwcrBQd5qLBY6fkUlGRZwJ82q
         tD5OXAAKHe45EeW0dlcr+79o588boUA7a5IAOQ5ksjO8WDenPtBzbmCUx+c/XKAHh0y0
         s/7w==
X-Gm-Message-State: AOAM530pmVkiK+cpZtWb8q1D53rzNtkw3s+va8jKyqS34vs5AszN7P4r
        wDQxqR2lJHPHT4y4xN+obgivGp4aGIoBkXrilEK/jQ==
X-Google-Smtp-Source: ABdhPJx8XuSzuFA3gwJRwNQZUxGR11tr21aduP0wprZd3IG5fPOzXI3BUYt+xJGGKYTwkwdINdrI5WAz36g6v816Aqc=
X-Received: by 2002:a5d:9284:: with SMTP id s4mr2024314iom.165.1606179340562;
 Mon, 23 Nov 2020 16:55:40 -0800 (PST)
MIME-Version: 1.0
References: <20201119010531.21083-1-s-anna@ti.com> <20201119010531.21083-4-s-anna@ti.com>
 <20201123235129.GA529235@xps15>
In-Reply-To: <20201123235129.GA529235@xps15>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 23 Nov 2020 17:55:27 -0700
Message-ID: <CANLsYkwztm1hwXMGO-7025YdaEk=ttLMVmM2A8hRYyyrWpR7fQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] remoteproc: k3-r5: Adjust TCM sizes in Split-mode on
 J7200 SoCs
To:     Suman Anna <s-anna@ti.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Nov 2020 at 16:51, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> Good afternoon Suman,
>
> On Wed, Nov 18, 2020 at 07:05:31PM -0600, Suman Anna wrote:
> > The J7200 SoCs have a revised R5FSS IP that adds a unique feature w.r.t
> > TCM sizing. Each R5F core in a cluster typically has 32 KB each of ATCM
> > and BTCM, with only the Core0 TCMs usable in LockStep mode. This revised
> > IP however doubles the total available TCM in LockStep mode by making the
> > Core1 TCM visible immediately after the corresponding Core0 TCM.
> >
> > The R5F DT nodes on the J7200 SoCs define double (64 KB) the normal TCM
> > size (32 KB) for R5F Core0 for each of ATCM and BTCM to represent the
> > above. This increased TCM memory is only usable in LockStep-mode, and
> > has to be adjusted to the normal 32 KB size in Split mode. Enhance the
> > TI K3 R5F remoteproc for this logic through a new function. The adjustment
> > is a no-op on prior SoCs and relies on the correct DTS node sizes in
> > LockStep-mode on applicable SoCs.
> >
> > Signed-off-by: Suman Anna <s-anna@ti.com>
> > ---
> >  drivers/remoteproc/ti_k3_r5_remoteproc.c | 43 ++++++++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >
> > diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> > index 66a32dcdd7d0..62b5a4c29456 100644
> > --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
> > +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> > @@ -71,9 +71,11 @@ enum cluster_mode {
> >
> >  /**
> >   * struct k3_r5_soc_data - match data to handle SoC variations
> > + * @tcm_is_double: flag to denote the larger unified TCMs in certain modes
> >   * @tcm_ecc_autoinit: flag to denote the auto-initialization of TCMs for ECC
> >   */
> >  struct k3_r5_soc_data {
> > +     bool tcm_is_double;
> >       bool tcm_ecc_autoinit;
> >  };
> >
> > @@ -886,6 +888,43 @@ static void k3_r5_reserved_mem_exit(struct k3_r5_rproc *kproc)
> >       of_reserved_mem_device_release(kproc->dev);
> >  }
> >
> > +/*
> > + * Each R5F core within a typical R5FSS instance has a total of 64 KB of TCMs,
> > + * split equally into two 32 KB banks between ATCM and BTCM. The TCMs from both
> > + * cores are usable in Split-mode, but only the Core0 TCMs can be used in
> > + * LockStep-mode. The newer revisions of the R5FSS IP maximizes these TCMs by
> > + * leveraging the Core1 TCMs as well in certain modes where they would have
> > + * otherwise been unusable (Eg: LockStep-mode on J7200 SoCs). This is done by
> > + * making a Core1 TCM visible immediately after the corresponding Core0 TCM.
> > + * The SoC memory map uses the larger 64 KB sizes for the Core0 TCMs, and the
> > + * dts representation reflects this increased size on supported SoCs. The Core0
> > + * TCM sizes therefore have to be adjusted to only half the original size in
> > + * Split mode.
> > + */
> > +static void k3_r5_adjust_tcm_sizes(struct k3_r5_rproc *kproc)
> > +{
> > +     struct k3_r5_cluster *cluster = kproc->cluster;
> > +     struct k3_r5_core *core = kproc->core;
> > +     struct device *cdev = core->dev;
> > +     struct k3_r5_core *core0;
> > +
> > +     if (cluster->mode == CLUSTER_MODE_LOCKSTEP ||
> > +         !cluster->soc_data->tcm_is_double)
> > +             return;
>
> Shouldn't this be:
>
>         if (cluster->mode == CLUSTER_MODE_SPLIT ||
>             !cluster->soc_data->tcm_is_double)
>                 return;
>
> If am wrong then I'm pretty sure other people will be confused and a comment is
> warranted.
>

Forget the above, I misread the context.  The memories are already set
to 64KB so there is nothing to do if in lockstep mode.

> > +
> > +     core0 = list_first_entry(&cluster->cores, struct k3_r5_core, elem);
> > +     if (core == core0) {
> > +             WARN_ON(core->mem[0].size != SZ_64K);
> > +             WARN_ON(core->mem[1].size != SZ_64K);
> > +
> > +             core->mem[0].size /= 2;
> > +             core->mem[1].size /= 2;
> > +
> > +             dev_dbg(cdev, "adjusted TCM sizes, ATCM = 0x%zx BTCM = 0x%zx\n",
> > +                     core->mem[0].size, core->mem[1].size);
> > +     }
> > +}
> > +
> >  static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
> >  {
> >       struct k3_r5_cluster *cluster = platform_get_drvdata(pdev);
> > @@ -933,6 +972,8 @@ static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
> >                       goto err_config;
> >               }
> >
> > +             k3_r5_adjust_tcm_sizes(kproc);
> > +
> >               ret = k3_r5_reserved_mem_init(kproc);
> >               if (ret) {
> >                       dev_err(dev, "reserved memory init failed, ret = %d\n",
> > @@ -1407,10 +1448,12 @@ static int k3_r5_probe(struct platform_device *pdev)
> >  }
> >
> >  static const struct k3_r5_soc_data am65_j721e_soc_data = {
> > +     .tcm_is_double = false,
> >       .tcm_ecc_autoinit = false,
> >  };
> >
> >  static const struct k3_r5_soc_data j7200_soc_data = {
> > +     .tcm_is_double = true,
> >       .tcm_ecc_autoinit = true,
>
> With the above and for the set:
>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>
> >  };
> >
> > --
> > 2.28.0
> >
