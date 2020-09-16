Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4415826CA5D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgIPT5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:57:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727185AbgIPRfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:35:41 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90D6522454;
        Wed, 16 Sep 2020 15:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600269541;
        bh=+u+iBUStfXZhxVvTL45VF65DMw9+bO0zIH+FBH5vXD4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fTRddlD5h2LlrZOL/gjybkaLvAgL+rqttYVl27VTQEqEUymCoZrnfmORLURplV8WW
         nsKdRVP61glJpTy/239mpcACqI5PB+A7YrelAiVFI0XaqX9fs5NbV1n/tkjsxOoIN0
         +mF6WaE1yCS/hKgh8Mal1SUMQ43yRE4vSvCYxNYI=
Received: by mail-oo1-f46.google.com with SMTP id t3so1726976ook.8;
        Wed, 16 Sep 2020 08:19:01 -0700 (PDT)
X-Gm-Message-State: AOAM531SSkGylMpgA31vhCcAbRScXtkSl4hhvHFlX2fjmNud8G082bn2
        j6saiu/d4Ak8Vz12aqDACEPdJ9B/wuCltg7llA==
X-Google-Smtp-Source: ABdhPJz/b8TPDSJj3O7N75dIlJvA8pCiElwvjXPGobFsh05L01VXkrgeK9dm+p1I2RLMxv4sgzXP2/FylZGo+kLQZSI=
X-Received: by 2002:a4a:d306:: with SMTP id g6mr18164233oos.25.1600269540821;
 Wed, 16 Sep 2020 08:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200912125148.1271481-1-maz@kernel.org> <20200915211354.GA2469362@bogus>
 <cd0a52739dcb3b238a1c600d46cad711@kernel.org>
In-Reply-To: <cd0a52739dcb3b238a1c600d46cad711@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 16 Sep 2020 09:18:49 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+91WBF7VPkHQOAju5Hky=snNj44H3-xy9xM3hzN2N=2Q@mail.gmail.com>
Message-ID: <CAL_Jsq+91WBF7VPkHQOAju5Hky=snNj44H3-xy9xM3hzN2N=2Q@mail.gmail.com>
Subject: Re: [PATCH 0/6] irqchip: Hybrid probing
To:     Marc Zyngier <maz@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Frank Wunderlich <linux@fw-web.de>,
        John Stultz <john.stultz@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Hanks Chen <hanks.chen@mediatek.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 2:51 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-09-15 22:13, Rob Herring wrote:
> > On Sat, Sep 12, 2020 at 01:51:42PM +0100, Marc Zyngier wrote:
> >> A recent attempt at converting a couple of interrupt controllers from
> >> early probing to standard platform drivers have badly failed, as it
> >> became evident that although an interrupt controller can easily probe
> >> late, device drivers for the endpoints connected to it are rarely
> >> equipped to deal with probe deferral. Changes were swiftly reverted.
> >>
> >> However, there is some value in *optionally* enabling this, if only
> >> for development purposes, as there is otherwise a "chicken and egg"
> >> problem, and a few people (cc'd) are working on a potential solution.
> >>
> >> This short series enables the infrastructure for modular building
> >> whilst retaining the usual early probing for monolithic build, and
> >> introduces it to the three drivers that were previously made to probe
> >> as platform drivers.
> >
> > I hardly expected more OF_DECLARE macros when I opened this up. Given
> > desires to get rid of them, I don't think adding to it is the way
> > forward. That wrapping a platform driver around OF_DECLARE looks pretty
> > horrible IMO.
>
> Nobody said it was cute. It's a band aid that allows us to move from the
> status-quo that exists today. How would you propose we allow people to
> go and start "fixing" drivers if you don't give them the opportunity
> to even start trying?

Apply the reverted patches and start fixing the drivers.

> > I browsed some of the discussion around this. It didn't seem like it's
> > a large number of drivers that have to be fixed to defer probe
> > correctly. Am I missing something?
>
> Well, that was enough drivers for the two platforms that had it enabled
> to break horribly, without a way to go back to a working state. Do you
> find that acceptable? I don't.

I understand reverting for v5.9, that was the right choice. But
Mediatek had 3 drivers broken. Is there more to it than getting
EPROBE_DEFER handled correctly in those drivers?

> > I'd rather keep the pressure on getting fw_devlink on by default.
>
> So far, fw_devlink breaks everything under the sun, even without modular
> irqchips. Most of my systems fail to boot if I enable it. So yes, it
> really needs some work. And this series allows this work to happen.

I think we can do something more simple here. We just need to
instantiate the irqchip devices earlier to get them to probe first and
not cause deferrals. That's just a matter of calling
of_platform_device_create() in an earlier initcall (<=
arch_initcall_sync ('=' because of link order)). Then once dependent
drivers are all fixed, all that has to be done is rip out that
initcall and the default of_platform_populate call will create the
device instead.

Rob
