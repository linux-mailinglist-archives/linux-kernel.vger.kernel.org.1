Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B484E2A821F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 16:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731287AbgKEPXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 10:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731263AbgKEPXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 10:23:08 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843A7C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 07:23:06 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id i21so1454653qka.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 07:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1SxuLZqP7expcmyIeWKucvYuGkstgspzMuDDrhMmksY=;
        b=QgkcEaYbFwTbauWuAVLqGTRxvWi76twgcpDbNcMEkx8DmTQPUhNPmJTCJnGwcitJZ+
         EcvTydCY9JAEc0P8ZsX8G4IO4KlR5W//1ksdtn7VPaN0RNh3NYcVSnEaXXQgJb94Wwij
         RtwwcVVTXOiXvAtpie6fdSsuT/TNr9UEs2EOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1SxuLZqP7expcmyIeWKucvYuGkstgspzMuDDrhMmksY=;
        b=rcNUXPxcgpmW22w9OgjxhFn2GczR4CeiOaznVKTQYjt2d/2LUH9387DG7AOr9OBS9P
         mgiIaAPnOCPTHrz1fRfzPhEaHHozXM+9Wc/zi3EPiJyX5+Mslx4yIzqTjnOleHKLqwFp
         XdAvPYCSmhsA3KTCYSkwycIsM1WuTyHX5vFqRurkZ2mBqFaGc2KayJOhs11F+pkE9DBV
         z4HfnPlgxQJuOG4N5U15M0fZnHZOB3lTpaV+SKAk96XdT5R6BINTPX5dtsSt4npPv6Av
         Il3r6YuIK6cBN+M2zkV7H/Mzkw1HNXvV3mDWB226fFhbmLVTRd6pxlphezRy3G8ZS5c8
         WjQg==
X-Gm-Message-State: AOAM5327xFrrujMW1UgAyUBnkwyXDlArThX8/jaWJ5DsUSZ3jYnyy5Hz
        DcUmqSF+gn3guQ4rIuNWMhjLx5Z7Vej0urQkZaZEsw==
X-Google-Smtp-Source: ABdhPJxR5v810eCnN+xy4FPc5ORemteS4sufWGdQhxFtZCEDINdix51Ym1Hs+vbSKWGg17A+984EwIkolOj+XlVlAug=
X-Received: by 2002:a37:7687:: with SMTP id r129mr1781089qkc.54.1604589785561;
 Thu, 05 Nov 2020 07:23:05 -0800 (PST)
MIME-Version: 1.0
References: <20201019141008.871177-1-daniel@0x0f.com> <20201019141008.871177-4-daniel@0x0f.com>
 <CACRpkdZNr6sDqJhg3KcX0bCbcd8fh2gXFYbS1r2H2Sq+vGqjUw@mail.gmail.com> <3fd04aeb5047d8059ddecc1eda19c2e4@kernel.org>
In-Reply-To: <3fd04aeb5047d8059ddecc1eda19c2e4@kernel.org>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Fri, 6 Nov 2020 00:23:52 +0900
Message-ID: <CAFr9PX=vxCCQgCWe9FPb6Z=0=a48HwGOfM_uOG3SqGN9VSYQUA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] gpio: msc313: MStar MSC313 GPIO driver
To:     Marc Zyngier <maz@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Thu, 5 Nov 2020 at 21:08, Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-11-05 09:40, Linus Walleij wrote:
> > On Mon, Oct 19, 2020 at 4:10 PM Daniel Palmer <daniel@0x0f.com> wrote:
>
> [...]
>
> >> +/* The parent interrupt controller needs the GIC interrupt type set
> >> to GIC_SPI
> >> + * so we need to provide the fwspec. Essentially
> >> gpiochip_populate_parent_fwspec_twocell
> >> + * that puts GIC_SPI into the first cell.
> >> + */
>
> nit: comment style.

I've fixed these and some other bits for the v3.
I've held off on pushing that until the rest of it seemed right.

> >> +static void *msc313_gpio_populate_parent_fwspec(struct gpio_chip *gc,
> >> +                                            unsigned int
> >> parent_hwirq,
> >> +                                            unsigned int parent_type)
> >> +{
> >> +       struct irq_fwspec *fwspec;
> >> +
> >> +       fwspec = kmalloc(sizeof(*fwspec), GFP_KERNEL);
> >> +       if (!fwspec)
> >> +               return NULL;
> >> +
> >> +       fwspec->fwnode = gc->irq.parent_domain->fwnode;
> >> +       fwspec->param_count = 3;
> >> +       fwspec->param[0] = GIC_SPI;
> >> +       fwspec->param[1] = parent_hwirq;
> >> +       fwspec->param[2] = parent_type;
> >> +
> >> +       return fwspec;
> >> +}
> >
> > Clever. Looping in Marc Z so he can say if this looks allright to him.
>
> Yup, this looks correct. However, looking at the bit of the patch that
> isn't quoted here, I see that msc313_gpio_irqchip doesn't have a
> .irq_set_affinity callback. Is this system UP only?

What is in mainline right now is UP only but there are chips with a
second cortex A7 that I have working in my tree.
So I will add that in for v3 if I can work out what I should actually
do there. :)

Thanks,

Daniel
