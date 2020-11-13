Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B4A2B27D2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgKMWHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgKMWHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:07:10 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB0DC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:07:09 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id w13so15846031eju.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WHgDS1WAQspB6V0nGrfu2cT1r9SxrLr9+qter6LC/Ls=;
        b=qARBkX6G6fZfMLU1as/c9jaILurp9y5lphRlOujJ80EtUrZOJljKlu9yMzXgn+CrB8
         j+YYgXyE3x6c4bHv4exQ5i0W84sqRuPnCrNJZQkQtT0nZ5bFEp/ZuMHCzomtegEaXEXQ
         wZ77wk1vVUBFkiP2Rz5E2QUriV4WP9t9740Zvdx6ZdvFO6Ul7pblrUV7vTK+u9nBKGH6
         QidhYmSrCbg2o/N//iM3KRTgECu0QSBivpbwkdgGEncTXGWTufUeO3dnsGFZBeaUgdmF
         3IBAWj8201nQnEbxGgkqhyscdHT8vP7+8nIB9gQx/Y/hxSdHM682jVkVMv8MiSP5GrDD
         Tcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WHgDS1WAQspB6V0nGrfu2cT1r9SxrLr9+qter6LC/Ls=;
        b=GqV3pIb/rCRyC349r/xgvFat1XCs9/YArRB3Uzp+M5AfeGqK0iKfU8w4y0XyXBwNxi
         VS8oItGWuY4H8KFbpfPBScu6F/L0ha7627qyvO4r9+FuPGJY+YKroJYE63G+uoW9pEkR
         0eXLP43KuVaCnHg54Rs8mMn8nvQ5jehe0uJwsGgswW1fmWyvuYSsd3bLeT1kuD/jBEYO
         ndrL1FnS+LYSY1Bt3hfm112xLYWtwXxsmSHNdO7zq0Q0LYeEnEb3zaXrxCq3kgVq2MV4
         W4uEjiE52SR9yeL8hYehbptOhbrOB+hdw89BRpY2UqNE0Fn9Uq1L6LP4ATShfKE1O7TN
         XrXw==
X-Gm-Message-State: AOAM533xVkHN8hXCVFP3r462wMiqGV+3JgeapgO0ytpK6XcbbMDVSmzl
        nBCC83kwrGgjuh4DfDg89ZsIY3rEBmOi8G5LxKSftg==
X-Google-Smtp-Source: ABdhPJzngK4Y1rNUx05lXS0F1//sRGz0VgD+rLtq1KXv5KPhyrqTPN0WMSet3A0/Ih67SYnptCk3qe/cOuwfR9Q63Vs=
X-Received: by 2002:a17:906:e53:: with SMTP id q19mr4240894eji.254.1605305228554;
 Fri, 13 Nov 2020 14:07:08 -0800 (PST)
MIME-Version: 1.0
References: <20201111170613.46057-1-tony@atomide.com> <20201113102134.GI3718728@dell>
In-Reply-To: <20201113102134.GI3718728@dell>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Fri, 13 Nov 2020 14:06:29 -0800
Message-ID: <CAJ+vNU0T0qS282MU-FRy8zNLgjnvF=+-5k=XxxXhZw6k2cgASw@mail.gmail.com>
Subject: Re: [PATCH] mfd: cpcap: Fix interrupt regression with regmap clear_ack
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Tony Lindgren <tony@atomide.com>,
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

On Fri, Nov 13, 2020 at 2:21 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Wed, 11 Nov 2020, Tony Lindgren wrote:
>
> > With commit 3a6f0fb7b8eb ("regmap: irq: Add support to clear ack
> > registers"), the cpcap interrupts are no longer getting acked properly
> > leading to a very unresponsive device with CPUs fully loaded spinning
> > in the threaded IRQ handlers.
> >
> > To me it looks like the clear_ack commit above actually fixed a long
> > standing bug in regmap_irq_thread() where we unconditionally acked the
> > interrupts earlier without considering ack_invert. And the issue with
> > cpcap started happening as we now also consider ack_invert.
> >
> > Tim Harvey <tharvey@gateworks.com> tried to fix this issue earlier with
> > "[PATCH v2] regmap: irq: fix ack-invert", but the reading of the ack
> > register was considered unnecessary for just ack_invert, and we did not
> > have clear_ack available yet. As the cpcap irqs worked both with and
> > without ack_invert earlier because of the unconditional ack, the
> > problem remained hidden until now.
> >
> > Also, looks like the earlier v3.0.8 based Motorola Android Linux kernel
> > does clear_ack style read-clear-write with "ireg_val & ~mreg_val" instead
> > of just ack_invert style write. So let's switch cpcap to use clear_ack
> > to fix the issue.
> >
> > Fixes: 3a6f0fb7b8eb ("regmap: irq: Add support to clear ack registers")
> > Cc: Carl Philipp Klemm <philipp@uvos.xyz>
> > Cc: Laxminath Kasam <lkasam@codeaurora.org>
> > Cc: Merlijn Wajer <merlijn@wizzup.org>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Sebastian Reichel <sre@kernel.org>
> > Cc: Tim Harvey <tharvey@gateworks.com>
>
> It would be nice to have you review this Tim.
>

Tony / Lee,

Thanks for keeping me in the loop on this. I still haven't properly
resolved the issue with my device/driver interrupts
(drivers/mfd/gateworks_gsc.c) which requires ack_invert (writing 0 to
clearing interrupt bits).

3a6f0fb7b8eb ("regmap: irq: Add support to clear ack registers")
appears to not only add the new clear_ack case it also attempts to
resolve the long standing ack_invert issue with this change:

- ret = regmap_write(map, reg, data->status_buf[i]);
+ if (chip->ack_invert)
+      ret = regmap_write(map, reg,
+      ~data->status_buf[i]);
+ else
+     ret = regmap_write(map, reg,
+     data->status_buf[i]);

However, this still doesn't resolve the issue I have with my
device/driver because it ends up writing 1's to all the other bits in
the ack register which keeps my device's interrupt from de-asserting.
Perhaps that's a strange behavior of my device that it allows you to
'set' interrupt source bits which causes the interrupt to stay
asserted? I'm also wondering if my issue is that I currently have the
interrupt registered as such:

ret = devm_regmap_add_irq_chip(dev, gsc->regmap, client->irq,
IRQF_ONESHOT | IRQF_SHARED | IRQF_TRIGGER_FALLING, 0, &gsc_irq_chip,
&irq_data);

Perhaps this should be IRQF_TRIGGER_LOW as the device will not
de-assert its IRQ# until all source bits are cleared.

Tony, I thought that your pcap issue was that it truly did not have an
inverted ack and the fact that ack_invert did not work was why you
never noticed any issue. If this is true I would think you would want
to disable ack_invert but not necessarily enable clear_ack. Did your
testing show it needed to toggle the ack to clear it?

Best Regards,

Tim
