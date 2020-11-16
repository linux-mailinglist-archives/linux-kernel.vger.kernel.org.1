Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B142B5326
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732370AbgKPUqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbgKPUp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:45:59 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB50C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:45:57 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id cw8so26318088ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dvUrg5Zh0UEFbygo+JzGqXqPd98elkDzA+GD+7uqXPw=;
        b=UsgbXWnOVpQ4AX5dsuP0tQ8z36bYrAwTd6GRC7eOqCmEaVx5hYM53fLCLVi+zXTROf
         772mz/16WtSa+OGdbcGHONiW5Bfo3aDYjC6BYXEG0kLM7S5ROigrPwhDPw2uHV+gi5v9
         GPa8m3IcYyU7e0gpF4xbxL+yyuWoyKlscXw6pcTGB0YQq1Yvfb6DoZ68Ck+UvHgPrDrK
         8N0JzC9gq6gh3CkN2tKIUkkicBpRglpXVskLYyG4GQz2PwC/hGkISj1MwU5INkXbrn3x
         ar7FO5ye3csgPQwrm/QudAADORCY5QK50yZ8Vg6/3ICMVg7FOBAjFnRTdYGv2XeRd7Uv
         0SAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dvUrg5Zh0UEFbygo+JzGqXqPd98elkDzA+GD+7uqXPw=;
        b=DoEVSBYZzh9MS2LCz6fFWSmQJWTrg8+hj0g97vxS7XsKfm5BYlRj2klzrLp9+PNXBR
         kNQoh8Zg1B1RFEPiacqBL1uEG9eV6o8Mvy7aEInt8X0fn5xm+wqscK6ikmf4kqfIoB6u
         9KFmHVPozzShpeG6XKRYM3QgJ3zQITeCk8cFde9MfKPTHidU+E4Xs00X6ZyFWF8Crml3
         dF7y463v7P5VuRZGAMaIDkX5BOBnKo4vItpZUBbxHyT88Vqm1MC1DojCnytb2nT35mSh
         QaLv8ueVKXhokGqK2DaMeYkbc5EExrzSr5qk66Rkbn/QW05UoXpkOfajdR46jOMH7CfQ
         +n0Q==
X-Gm-Message-State: AOAM533GwefYC2W44serUtUvk1yecFwmj9uSYhqOsUwww5chlQI9oqNW
        Ti49xiN7fcTTgoeKkqnhvGVKGYPvBwCbHQagQ4KObg==
X-Google-Smtp-Source: ABdhPJxex93cumlrDtp4XyMNfF2vWQfwsBvEUrga0Ut8M5eJJWY96tVKhAq72e4IbNmJhkFVhwEg+8f32MVSq+m5kvk=
X-Received: by 2002:a17:906:1f92:: with SMTP id t18mr16953669ejr.539.1605559556477;
 Mon, 16 Nov 2020 12:45:56 -0800 (PST)
MIME-Version: 1.0
References: <20201111170613.46057-1-tony@atomide.com> <20201113102134.GI3718728@dell>
 <CAJ+vNU0T0qS282MU-FRy8zNLgjnvF=+-5k=XxxXhZw6k2cgASw@mail.gmail.com> <20201115084308.GY26857@atomide.com>
In-Reply-To: <20201115084308.GY26857@atomide.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Mon, 16 Nov 2020 12:45:43 -0800
Message-ID: <CAJ+vNU3uuX1TB+uKQ_YMseA2kJHLGf2Z6SECTwn_M==Gf2=-AQ@mail.gmail.com>
Subject: Re: [PATCH] mfd: cpcap: Fix interrupt regression with regmap clear_ack
To:     Tony Lindgren <tony@atomide.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        Laxminath Kasam <lkasam@codeaurora.org>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 15, 2020 at 12:43 AM Tony Lindgren <tony@atomide.com> wrote:
>
> * Tim Harvey <tharvey@gateworks.com> [201113 22:07]:
> > 3a6f0fb7b8eb ("regmap: irq: Add support to clear ack registers")
> > appears to not only add the new clear_ack case it also attempts to
> > resolve the long standing ack_invert issue with this change:
> >
> > - ret = regmap_write(map, reg, data->status_buf[i]);
> > + if (chip->ack_invert)
> > +      ret = regmap_write(map, reg,
> > +      ~data->status_buf[i]);
> > + else
> > +     ret = regmap_write(map, reg,
> > +     data->status_buf[i]);
>
> Yes that's what I noticed too. And that's why cpcap was working for
> me with ack_invert and without it earlier.
>
> > However, this still doesn't resolve the issue I have with my
> > device/driver because it ends up writing 1's to all the other bits in
> > the ack register which keeps my device's interrupt from de-asserting.
> > Perhaps that's a strange behavior of my device that it allows you to
> > 'set' interrupt source bits which causes the interrupt to stay
> > asserted? I'm also wondering if my issue is that I currently have the
> > interrupt registered as such:
> >
> > ret = devm_regmap_add_irq_chip(dev, gsc->regmap, client->irq,
> > IRQF_ONESHOT | IRQF_SHARED | IRQF_TRIGGER_FALLING, 0, &gsc_irq_chip,
> > &irq_data);
> >
> > Perhaps this should be IRQF_TRIGGER_LOW as the device will not
> > de-assert its IRQ# until all source bits are cleared.
>
> Yes could be. For cpcap, we have IRQ_TYPE_LEVEL_HIGH configured in the
> motorola-cpcap-mapphone.dtsi file.
>
> > Tony, I thought that your pcap issue was that it truly did not have an
> > inverted ack and the fact that ack_invert did not work was why you
> > never noticed any issue. If this is true I would think you would want
> > to disable ack_invert but not necessarily enable clear_ack. Did your
> > testing show it needed to toggle the ack to clear it?
>
> Well I looked at the v3.0.8 Motorola Linux Android kernel, it actually
> does clear_ack. So I'd rather keep the same logic as we have no proper
> documentation for cpcap. I also confirmed still works without ack_invert
> too while ack_invert now is broken. But using clear_ack now that we
> have it working seems safer.
>
> Regards,
>
> Tony

Tony,

Ok - sounds like the right thing for your device.

Reviewed-By: Tim Harvey <tharvey@gateworks.com>

Tim
