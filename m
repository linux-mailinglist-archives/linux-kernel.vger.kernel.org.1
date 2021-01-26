Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF413040D7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405982AbhAZOs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405881AbhAZOsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:48:08 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E4AC061D73
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 06:47:28 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id e18so1705038lja.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 06:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NSov9hCAZmBO4f5IqjzRfZw8GiUqBpiKDFVieekbDjQ=;
        b=XTzDRCOtBTWBSE3rewHEzJrNlvVeSIhNA5fbCfyK9IVdizTEaqec2Jtz7smGsVOFhr
         MGp6EPKN4EftzMuKXxYIRfwdMsCW7R3SZHwYVlXZTXsc8netYQbJFeW1zHaWf4LTYfcI
         VpSAYwinvUj29oPYsTojeXQuqiWjkLlZv9eciwpPy9Nprj8Br8ioQWrVzwWk3Ye6eEdc
         dh5DBUCu8Qad8BZvxhMqs8a+DL4OuVDNxDn7JDw3jQarZ9iJsNgsJLd3/PjcNBuAurKv
         mg2zQyvt+QbEyAiCOyKE6poVvzlw3nIysmCZjLL8iGX7VYNkO8nYvBwwJKQUpH7jXpXo
         jeAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NSov9hCAZmBO4f5IqjzRfZw8GiUqBpiKDFVieekbDjQ=;
        b=Zr1FmJMkC0zJaMAJkkLi9YWAuUVV+VbJYZjzS/RCOFPlhApEzoUFoM+xYLfCbVSIk2
         T4Y/OWUNIHbxPDXfCy7yeD0W/WOpydV6+ut7pJUG2T8dWjc9qSgC9xDoPae1QkJuITA0
         6NT7vbxWXh0Ou7KKKdByxgZ515fbqMANTZFp32PmnRfK8CM0xNiIB8/JYyJ/9bhhOSvT
         mU5wxNErR/8Ng5cMvTgG5HxftFOEnESGdPG4IBHhcnlnX9KCUiWC2tjq3fQzdUcikYQO
         Zd9Y09uEiitNxA6QIJP8ivvIav255yu/gA6xi193pky+UbDCnFfg6NuQdFK0OPo7Dwnp
         Dbyw==
X-Gm-Message-State: AOAM533RO3Q5wcH2d88+nVeGc5RDrI68fIAvzMTJy5AvHPsLtbTvYudz
        6Dpl1YgPiMbWFdZyU9OiQHiH0AALD/Zb9EM+VKrPJA==
X-Google-Smtp-Source: ABdhPJw8hdQrVaqBGeCLGaRM3DlKvQ/5Mw07r+te2YaR5i4prOqwouxQgGsOT1+3HdIfrvpQQdvZEAfrsaB7XSvfBY8=
X-Received: by 2002:a2e:8ec3:: with SMTP id e3mr2958932ljl.467.1611672446814;
 Tue, 26 Jan 2021 06:47:26 -0800 (PST)
MIME-Version: 1.0
References: <20210125182219.213214-1-angelogioacchino.delregno@somainline.org>
In-Reply-To: <20210125182219.213214-1-angelogioacchino.delregno@somainline.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 Jan 2021 15:47:15 +0100
Message-ID: <CACRpkdZWX6iacZxhBaeboAgy0HbvesuVBBMLxaCPLASfGbRURA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] pinctrl: Add driver for Awinic AW9523/B I2C GPIO Expander
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, phone-devel@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 7:22 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@somainline.org> wrote:

> The Awinic AW9523(B) is a multi-function I2C gpio expander in a
> TQFN-24L package, featuring PWM (max 37mA per pin, or total max
> power 3.2Watts) for LED driving capability.
>
> It has two ports with 8 pins per port (for a total of 16 pins),
> configurable as either PWM with 1/256 stepping or GPIO input/output,
> 1.8V logic input; each GPIO can be configured as input or output
> independently from each other.
>
> This IC also has an internal interrupt controller, which is capable
> of generating an interrupt for each GPIO, depending on the
> configuration, and will raise an interrupt on the INTN pin to
> advertise this to an external interrupt controller.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
(...)
> +static int aw9523_gpio_irq_type(struct irq_data *d, unsigned int type)
> +{
> +       switch (type) {
> +       case IRQ_TYPE_NONE:
> +       case IRQ_TYPE_EDGE_BOTH:
> +               return 0;
> +       default:
> +               return -EINVAL;
> +       };
> +}

This looks better.

> +static int aw9523_init_irq(struct aw9523 *awi, int irq)
> +{
(...)
> +       gpioirq = &awi->gpio.irq;
> +       gpioirq->chip = irqchip;
> +       gpioirq->parent_handler = NULL;
> +       gpioirq->num_parents = 0;
> +       gpioirq->parents = NULL;
> +       gpioirq->default_type = IRQ_TYPE_LEVEL_MASK;

This looks wrong. IRQ_TYPE_EDGE_BOTH?

Yours,
Linus Walleij
