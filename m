Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBC72F095C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 20:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbhAJTfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 14:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbhAJTfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 14:35:53 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA30FC06179F
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 11:35:12 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id m10so1232094lji.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 11:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I52KVXRoRWFS2xNuCU7qX07YCV30BYynTAgvK65w47Y=;
        b=et1XkaMavR3Kce8/efo37RhnUGmzWg+sVQi824OfRYkwwwKFEOEJge1k0p9oh38A95
         2nvHjNnvKieqfblT4P1iFKj050qgYyVNfNYM7Vs7Qpaj1hL+1gU3MKBLJrt5VYld2lgQ
         Y9ySV4YzAYu8WT3nHbbCwY37TOmsmZyxU6fqlLA8C/LQC8bnvFyAaiU5FdzmWru7SOY9
         htzFYs52udpNP8JciP4o3u5uDXETgiCqEJs+HPK99uU1rHHRlLdaQpdYUUrohL9MvN6m
         ymBMyFmXNDg6rHtX/K+z9BeWNLD2cXorThk9OxnxCYZbDHTJVpYo+TkFeHHatWFugyWb
         KAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I52KVXRoRWFS2xNuCU7qX07YCV30BYynTAgvK65w47Y=;
        b=Fs9ruaNRXEhC5LrqU6vOTNm+Uw7hRn/qvm7joFZ7l9IawvToFxb6DF3RqMazYn501Y
         caZ4v5Nf6eHrQHJkEGJqjYDxq5Fs7qnlBYt49KnAY4WEjHQwAhxKMhRRAtgoCKM0d+bf
         R1+OEURyyN98d1FMHAJ5f45LlWdN7hRzDpptAhEL+sKwMM0EXll7JdF9Hp0B++pXA2rl
         ROUIdGSv/+jLvxbBSCD8sAUVZ9MyUpjk9VyvfZABopXH5UVpZiZW4xNGim3VNJ/56Quh
         GsyRHNKLoJhe4chvfCx5DQw7vBVfiLZDOHi/gEplIS5mUPThS+LSbdI5mOScqxgoY5cB
         5h5g==
X-Gm-Message-State: AOAM532WCdxSHo1qYG6XIym1COtFq3NyYOOavS/7S7Xuz6qipmraP4Z/
        Szebn/KYe9bA3e1CZ1aHPGxNp1bnw07w/Jc9FmxEmQ==
X-Google-Smtp-Source: ABdhPJyV0+I3TSxXiainTzHb4F0+/RU6U5onC7zlRc56humnIx8ItDkCN/DWSBdUQhyalpv+uHUyQDPKQavccEBA4nI=
X-Received: by 2002:a05:651c:205b:: with SMTP id t27mr6154964ljo.368.1610307311065;
 Sun, 10 Jan 2021 11:35:11 -0800 (PST)
MIME-Version: 1.0
References: <20210109140204.151340-1-angelogioacchino.delregno@somainline.org>
 <20210109140204.151340-2-angelogioacchino.delregno@somainline.org>
 <CACRpkdbETKnhgR2-T+s3ChY4v-C5ErdPEp2WcMSZHzJ=O-fHig@mail.gmail.com>
 <111b918d-2b43-be81-2dbf-e984750b0ef7@somainline.org> <CACRpkdZXgN91jKBDvf=P5_6ObOaacQa2PGL3-jP1gBW__ZyOaA@mail.gmail.com>
 <744125a7-ffb6-a3f5-70cb-2ab48fcf31b8@somainline.org>
In-Reply-To: <744125a7-ffb6-a3f5-70cb-2ab48fcf31b8@somainline.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 10 Jan 2021 20:35:00 +0100
Message-ID: <CACRpkdYmVpEZMruu3UcqiGr2q7xSdTQKmwnu7eq2-MPJte8ATA@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: Add driver for Awinic AW9523/B I2C GPIO Expander
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     Mark Brown <broonie@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, phone-devel@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 10, 2021 at 3:32 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@somainline.org> wrote:

> So, I've retried some basic usage of the regcache, relevant snippets here:
> static bool aw9523_volatile_reg(struct device *dev, unsigned int reg)
> {
>
>         return reg == AW9523_REG_IN_STATE(0) ||
>                reg == AW9523_REG_IN_STATE(AW9523_PINS_PER_PORT) ||
>                reg == AW9523_REG_CHIPID;
> }
(...)
> Since REG_IN_STATE is used to read the GPIO input level, it's not
> cacheable,

Fair enough.

> then CHIPID was set as not cacheable for safety: that may be
> avoided, but that may make no sense.. since it's a one-time readout for
> init putposes, it'd be useless to keep it cached.

I guess.

> Then, the set_bit/clear_bit in aw9523_irq_mask(), aw9523_irq_unmask were
> replaced with calls to regmap_update_bits_async, example:
>
>         regmap_update_bits_async(awi->regmap,
>                                  AW9523_REG_INTR_DIS(d->hwirq),
>                                  BIT(n), BIT(n));
>
> Where of course the value is either BIT(n) or 0 for mask and unmask
> respectively.
> Also, the bus_sync_unlock callback was changed as follows:
>
> static void aw9523_irq_bus_sync_unlock(struct irq_data *d)
>
> {
>       struct aw9523 *awi = gpiochip_get_data(irq_data_get_irq_chip_data(d));
>       regcache_mark_dirty(awi->regmap);
>       regcache_sync_region(awi->regmap, AW9523_REG_INTR_DIS(0),
>                            AW9523_REG_INTR_DIS(AW9523_PINS_PER_PORT));
>        mutex_unlock(&awi->irq->lock);
(...)
> One of the biggest / oddest issues that I get when trying to use
> regcache is that I'm getting badbadbad scheduling while atomic warnings
> all over and I don't get why, since regcache_default_sync is just
> calling _regmap_write, which is exactly what (non _prefix) regmap_write
> also calls...

OK that is the real problem to solve then.

> As a reference, this is one out of "many" (as you can imagine) stacktraces:
>
> <3>[    1.061428] BUG: scheduling while atomic: kworker/3:1/119/0x00000000
(...)
> <4>[    1.063134]  wait_for_completion_timeout+0x8c/0x110
> <4>[    1.063257]  qup_i2c_wait_for_complete.isra.18+0x1c/0x80
> <4>[    1.063429]  qup_i2c_xfer_v2_msg+0x2d4/0x3f0
> <4>[    1.063543]  qup_i2c_xfer_v2+0x290/0xa28
> <4>[    1.063652]  __i2c_transfer+0x16c/0x380
> <4>[    1.063798]  i2c_transfer+0x5c/0x138
> <4>[    1.063903]  i2c_transfer_buffer_flags+0x58/0x80
> <4>[    1.064060]  regmap_i2c_write+0x1c/0x50
> <4>[    1.064168]  _regmap_raw_write_impl+0x35c/0x688
> <4>[    1.064285]  _regmap_bus_raw_write+0x64/0x80
> <4>[    1.064440]  _regmap_write+0x58/0xa8
> <4>[    1.064545]  regcache_default_sync+0xcc/0x1a0
> <4>[    1.064660]  regcache_sync_region+0xdc/0xe8
> <4>[    1.064811]  aw9523_irq_bus_sync_unlock+0x30/0x48
> <4>[    1.064931]  __setup_irq+0x798/0x890
> <4>[    1.065034]  request_threaded_irq+0xe0/0x198
> <4>[    1.065188]  devm_request_threaded_irq+0x78/0xf8
> <4>[    1.065311]  gpio_keyboard_probe+0x2a8/0x468

scheduling while atomic happens when this trace gets called with interrupts
disabled, usually because someone has taken a spinlock.

Looking in __setup_irq() it looks safe.

I would turn on lock debugging (lockdep) and see if I can find it that way.

Yours,
Linus Walleij
