Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2F42B3300
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 09:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgKOIoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 03:44:20 -0500
Received: from muru.com ([72.249.23.125]:48306 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbgKOInc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 03:43:32 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 1C11780A0;
        Sun, 15 Nov 2020 08:43:17 +0000 (UTC)
Date:   Sun, 15 Nov 2020 10:43:08 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        Laxminath Kasam <lkasam@codeaurora.org>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] mfd: cpcap: Fix interrupt regression with regmap
 clear_ack
Message-ID: <20201115084308.GY26857@atomide.com>
References: <20201111170613.46057-1-tony@atomide.com>
 <20201113102134.GI3718728@dell>
 <CAJ+vNU0T0qS282MU-FRy8zNLgjnvF=+-5k=XxxXhZw6k2cgASw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+vNU0T0qS282MU-FRy8zNLgjnvF=+-5k=XxxXhZw6k2cgASw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tim Harvey <tharvey@gateworks.com> [201113 22:07]:
> 3a6f0fb7b8eb ("regmap: irq: Add support to clear ack registers")
> appears to not only add the new clear_ack case it also attempts to
> resolve the long standing ack_invert issue with this change:
> 
> - ret = regmap_write(map, reg, data->status_buf[i]);
> + if (chip->ack_invert)
> +      ret = regmap_write(map, reg,
> +      ~data->status_buf[i]);
> + else
> +     ret = regmap_write(map, reg,
> +     data->status_buf[i]);

Yes that's what I noticed too. And that's why cpcap was working for
me with ack_invert and without it earlier.

> However, this still doesn't resolve the issue I have with my
> device/driver because it ends up writing 1's to all the other bits in
> the ack register which keeps my device's interrupt from de-asserting.
> Perhaps that's a strange behavior of my device that it allows you to
> 'set' interrupt source bits which causes the interrupt to stay
> asserted? I'm also wondering if my issue is that I currently have the
> interrupt registered as such:
> 
> ret = devm_regmap_add_irq_chip(dev, gsc->regmap, client->irq,
> IRQF_ONESHOT | IRQF_SHARED | IRQF_TRIGGER_FALLING, 0, &gsc_irq_chip,
> &irq_data);
> 
> Perhaps this should be IRQF_TRIGGER_LOW as the device will not
> de-assert its IRQ# until all source bits are cleared.

Yes could be. For cpcap, we have IRQ_TYPE_LEVEL_HIGH configured in the
motorola-cpcap-mapphone.dtsi file.

> Tony, I thought that your pcap issue was that it truly did not have an
> inverted ack and the fact that ack_invert did not work was why you
> never noticed any issue. If this is true I would think you would want
> to disable ack_invert but not necessarily enable clear_ack. Did your
> testing show it needed to toggle the ack to clear it?

Well I looked at the v3.0.8 Motorola Linux Android kernel, it actually
does clear_ack. So I'd rather keep the same logic as we have no proper
documentation for cpcap. I also confirmed still works without ack_invert
too while ack_invert now is broken. But using clear_ack now that we
have it working seems safer.

Regards,

Tony
