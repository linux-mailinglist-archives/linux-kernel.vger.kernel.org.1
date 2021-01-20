Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B002FDA0A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 20:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392720AbhATTuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 14:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392658AbhATTst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 14:48:49 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12370C061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 11:48:09 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id k132so13448580ybf.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 11:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z+VKdic9vQLplZ5dRDPFBsqTAKEx7zvAEih/IIGE3o4=;
        b=gqXXWU/DUfCRlZqg6VB4WrIPdIGgIy2FpoB64Tw6CtQ1jL1wrLFZqp3MrEbrMBYGiZ
         N4/i+WbY5NkRoGQ0TOQ8gSx1H/xButR/QyThA+B2Gz/O5XBV3DuftVSBSZBLeyg1OLU+
         UOnY3ZnpvA9fS2hSivgKSdxrfkTqrNLOncrFUlwoHemuKABuY67DntKltT3SJx0D9dWo
         /9pBl19rfoJS1N1WX6MM6xVcEDMYzyaqXAJ7Q6wXNhN/hh/u8nnQojbYlYlOdnqtABHz
         lhAfatORzVUNAHTBDkjRB1KD+A8zB99tvQ/Y4CW0lF2FN6Oz8vdPn1HEE/kgKprBbKFe
         sZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z+VKdic9vQLplZ5dRDPFBsqTAKEx7zvAEih/IIGE3o4=;
        b=ApxUIAkiUqzJ6X2Px/BV7+D5mE8PF1+IcdmEYoU+uCODqszYaV41rHq7Uo1yZ9qFct
         5E9Nhx8+wkohYoGvmmjiUs7VG9nh6goT2gT2lCtfgDHgpw++vSV3pjm7fFvfnnEYuC1s
         Gr+jyWfmJA9EpMjcjFHY52/F0ZLvHMvHS4MI69/CduMK629nuitlKwuWsswrVqPm3bTu
         pDFjF3zBDnzjPUMwTJt/FA5K+h7qhpOpKnYc3RdRwG6nghWVbNEb0yu8YZOf6UdzcvU/
         hJoRm5IqHWi+9eORwrBnxIMn4komiIaW4HhjrKHe6ecbCI9L0s+7nrbzOjTNi3ZnLFCT
         Kw9w==
X-Gm-Message-State: AOAM5335ks4k3ylowWTQlu/aUW6n8cueD6Pkam2IyoQYv6XplJS5XHok
        qukfV6TZOWlBIcCtAx5yWE6mGh8UTtDX7yvaq90Obg==
X-Google-Smtp-Source: ABdhPJy6lnzImOgxZ62zFBVY/BNYqrbN/QRRos+AWvRoeObCVMQxkr4MeX9zWJIX5eWD7W+mqvC8d3XxTrbOt6hpwoA=
X-Received: by 2002:a25:77d4:: with SMTP id s203mr17677961ybc.32.1611172088185;
 Wed, 20 Jan 2021 11:48:08 -0800 (PST)
MIME-Version: 1.0
References: <20210120105246.23218-1-michael@walle.cc> <CAL_JsqLSJCLtgPyAdKSqsy=JoHSLYef_0s-stTbiJ+VCq2qaSA@mail.gmail.com>
 <CAGETcx86HMo=gaDdXFyJ4QQ-pGXWzw2G0J=SjC-eq4K7B1zQHg@mail.gmail.com> <c3e35b90e173b15870a859fd7001a712@walle.cc>
In-Reply-To: <c3e35b90e173b15870a859fd7001a712@walle.cc>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 20 Jan 2021 11:47:31 -0800
Message-ID: <CAGETcx8eZRd1fJ3yuO_t2UXBFHObeNdv-c8oFH3mXw6zi=zOkQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: layerscape: convert to builtin_platform_driver()
To:     Michael Walle <michael@walle.cc>
Cc:     Rob Herring <robh@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 11:28 AM Michael Walle <michael@walle.cc> wrote:
>
> [RESEND, fat-fingered the buttons of my mail client and converted
> all CCs to BCCs :(]
>
> Am 2021-01-20 20:02, schrieb Saravana Kannan:
> > On Wed, Jan 20, 2021 at 6:24 AM Rob Herring <robh@kernel.org> wrote:
> >>
> >> On Wed, Jan 20, 2021 at 4:53 AM Michael Walle <michael@walle.cc>
> >> wrote:
> >> >
> >> > fw_devlink will defer the probe until all suppliers are ready. We can't
> >> > use builtin_platform_driver_probe() because it doesn't retry after probe
> >> > deferral. Convert it to builtin_platform_driver().
> >>
> >> If builtin_platform_driver_probe() doesn't work with fw_devlink, then
> >> shouldn't it be fixed or removed?
> >
> > I was actually thinking about this too. The problem with fixing
> > builtin_platform_driver_probe() to behave like
> > builtin_platform_driver() is that these probe functions could be
> > marked with __init. But there are also only 20 instances of
> > builtin_platform_driver_probe() in the kernel:
> > $ git grep ^builtin_platform_driver_probe | wc -l
> > 20
> >
> > So it might be easier to just fix them to not use
> > builtin_platform_driver_probe().
> >
> > Michael,
> >
> > Any chance you'd be willing to help me by converting all these to
> > builtin_platform_driver() and delete builtin_platform_driver_probe()?
>
> If it just moving the probe function to the _driver struct and
> remove the __init annotations. I could look into that.

Yup. That's pretty much it AFAICT.

builtin_platform_driver_probe() also makes sure the driver doesn't ask
for async probe, etc. But I doubt anyone is actually setting async
flags and still using builtin_platform_driver_probe().

-Saravana
