Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310862B530B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387998AbgKPUoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbgKPUoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:44:11 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7444EC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:44:11 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id t11so20094636edj.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u+jY18oo1UjFW/rWqk7bV9L7wooc4/HxkqEuV0hRX98=;
        b=KyPKzdTS+NAtkOGEePz+fWCRmjv85Yid1fV8bXkOI5aOLIuIn58HvqNgkOE82zSMel
         VYJoaHuRO/8OWvunb5Hj4K3anEvHdQnWd1PLjso4JmZ75hQC9J1QthFy4PNakc6Bo1rk
         MUQDQikApgXZh3Dwq68wZ5JN0pTL505TVUUt7f6BQWg2PviF3oeixEkVetolImg5oSJP
         9HGlD9fqIny0uUCEV3twNtI4uHFfTD+Xk8gBbD0cnOSpS9Hwr4GLfLErmZ73dzJdE50o
         ix3icZq79f7Iqtrv4676eewymCwZzk45Ukmb/dZbf89+rTKUrT74NTcQN6Cp5nEx5Rej
         CwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u+jY18oo1UjFW/rWqk7bV9L7wooc4/HxkqEuV0hRX98=;
        b=tnbq2ZgAlqcF5rUIc+pDExQeCI4VEJWWwY6WVTo5Ci3do3qHSCrNaxXdVfGYlQnfQo
         AbbTXmX/SUer5CVIxzP1a21GbSxjW4JK+qlALZX/qi+Doker3b5QrPZ+aFhXvrQqDDUh
         o49+nGPWjDdJir8d2F6g19ZgyFth3yb/qn9D0wSTCo3Ai+SST/5ACoRCdIekGlg7R1qZ
         VS0/7fh3htghkU+ujTZI23E+wd0Ftr5VojuaexfYypyc8eaExBaFVVLdmuaGRgOpnqgl
         iu0m0YqM1Gjb4gUK7rrriCJOXC6wb3yTDR1AKulMORY8E8Snw9K0+wptC6a18mi3dcRO
         TIRw==
X-Gm-Message-State: AOAM533u/Gu957WqFLVEr6wtV1KiQP5nnwPV8/TWQsi+uV439kur4w/B
        DTUnf0Al7lhIC+sXJ43rwFKEXLpswUMP9PVh6yF+Cf8qCLtQBP1z
X-Google-Smtp-Source: ABdhPJxpPNgECHViQR3sESmc1g8HLRYlZVYDPDlyYNOVu/QAzFR6EemE/9Cu2KTsnqJeEON2RlZce7XPmC8GauFejzQ=
X-Received: by 2002:a50:da4b:: with SMTP id a11mr17678317edk.109.1605559450133;
 Mon, 16 Nov 2020 12:44:10 -0800 (PST)
MIME-Version: 1.0
References: <20201111170613.46057-1-tony@atomide.com> <20201113102134.GI3718728@dell>
 <CAJ+vNU0T0qS282MU-FRy8zNLgjnvF=+-5k=XxxXhZw6k2cgASw@mail.gmail.com> <20201116185903.GD4739@sirena.org.uk>
In-Reply-To: <20201116185903.GD4739@sirena.org.uk>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Mon, 16 Nov 2020 12:43:57 -0800
Message-ID: <CAJ+vNU3Qrbd8bez+eiHaXrvntqpO_iDM0PSJN_RTAV5W6a7uOw@mail.gmail.com>
Subject: Re: [PATCH] mfd: cpcap: Fix interrupt regression with regmap clear_ack
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>,
        open list <linux-kernel@vger.kernel.org>,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        Laxminath Kasam <lkasam@codeaurora.org>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 10:59 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Nov 13, 2020 at 02:06:29PM -0800, Tim Harvey wrote:
>
> > asserted? I'm also wondering if my issue is that I currently have the
> > interrupt registered as such:
>
> > ret = devm_regmap_add_irq_chip(dev, gsc->regmap, client->irq,
> > IRQF_ONESHOT | IRQF_SHARED | IRQF_TRIGGER_FALLING, 0, &gsc_irq_chip,
> > &irq_data);
>
> > Perhaps this should be IRQF_TRIGGER_LOW as the device will not
> > de-assert its IRQ# until all source bits are cleared.
>
> That's clearly an active low interrupt, it will break things if it's
> registered as edge triggered.

Mark,

Agreed - I will post a fix for my driver that changes it to IRQF_TRIGGER_LOW

What are your thoughts regarding the issue of  regmap_irq_sync_unlock
ack_invert ack'ing by writing ~d->mask_buf[i] which ends up setting
all the other bits not trying to be awk'd? I would say that the device
allowing an interrupt status to be 'set' and keeping it from releasing
its IRQ is strange/broken for sure, but I'll need to work around it
somehow.

Best Regards,

Tim
