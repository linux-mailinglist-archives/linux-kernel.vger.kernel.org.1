Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6202FDE2F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 01:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbhAUAwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 19:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728929AbhAUAA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 19:00:28 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD77C0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 15:59:03 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id y4so369781ybn.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 15:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bjNWVbslUhdSMJg6quM5f9vJqYwBuRMO9foprozwioc=;
        b=ffW3hc4LnwwviIoGoe5gnQflzXCd9cYZdMHOoXum4nNbQJvSCC2AfWclS2wU/au9de
         CFRJUjnnhMitRBSu7S3m1/DZy+pxT7lr6QGCTwyNFsjyN9nB4rQa2RwDFVKSQldHo20t
         TSaB19bBSSSneWcjrQvt1mrcSxut+vop26XwhsLB4836gzQMg5Itas4U1iMBYR4Ce63y
         2DAFnXsicdrem0orFA6VQTXVbdXmnJN8xiDo6IjoKhbUluKAbEltdsYNJc7OtM3K5s25
         EdP3oDR0uFcuTNrtyDOjvUyHFnNrPeTeyqMioYmbHubqagHho7lrZ/++FzLpqNwNm/Nf
         i4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bjNWVbslUhdSMJg6quM5f9vJqYwBuRMO9foprozwioc=;
        b=FGqbBRALDVE34F3KQ3zA3rF71f9cLWwsRPEa+95hRdSISL1+KTUNbNOm87buHe2IEp
         tKu2SbQ1sHSajzH24URdAZTmmSn5IEEc6/kSoMP8TZKHrbLVBlSqUYj0D7cU06qZtI/q
         yrCbZPmDw4IxOLzDMewuuKkvCAThOzUhUCo/hehkvb1tJmSkV3i35LTbaGfEZ7l8gBTG
         BZs8kp6w12yt+4vV8ck/6FQ7qmu/2Ca24XZ/DCgNtVxuTQIQwUw7gT6xE9tL99ggX3NV
         FnQjaI6Jc20ah5Gplh9oMQUVs5opZIIqHgkqc7/ePlLRAZn521pYMpP1IIKM3DI7xvtc
         rY5A==
X-Gm-Message-State: AOAM532YI3NsZ1fGYoOSh9ODUzZJBnh4/Zlu5a6N0+03sigqUS6qkSp2
        dqsqKZ1HmFHGCebC6xMplaM7OtdVaS+yzpk0LCyOFA==
X-Google-Smtp-Source: ABdhPJzMu1+JWnwyGx4GwTGFIGNXBqrQijaNrTRbEw4zMGC6WhznJvX295T+Ea7ZyLY4NNnZiFJ6MzxNGPb4DoZb8aA=
X-Received: by 2002:a25:dfcb:: with SMTP id w194mr13618ybg.346.1611187142006;
 Wed, 20 Jan 2021 15:59:02 -0800 (PST)
MIME-Version: 1.0
References: <20210120105246.23218-1-michael@walle.cc> <CAL_JsqLSJCLtgPyAdKSqsy=JoHSLYef_0s-stTbiJ+VCq2qaSA@mail.gmail.com>
 <CAGETcx86HMo=gaDdXFyJ4QQ-pGXWzw2G0J=SjC-eq4K7B1zQHg@mail.gmail.com>
 <c3e35b90e173b15870a859fd7001a712@walle.cc> <CAGETcx8eZRd1fJ3yuO_t2UXBFHObeNdv-c8oFH3mXw6zi=zOkQ@mail.gmail.com>
 <f706c0e4b684e07635396fcf02f4c9a6@walle.cc>
In-Reply-To: <f706c0e4b684e07635396fcf02f4c9a6@walle.cc>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 20 Jan 2021 15:58:26 -0800
Message-ID: <CAGETcx8_6Hp+MWFOhRohXwdWFSfCc7A=zpb5QYNHZE5zv0bDig@mail.gmail.com>
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

On Wed, Jan 20, 2021 at 3:53 PM Michael Walle <michael@walle.cc> wrote:
>
> Am 2021-01-20 20:47, schrieb Saravana Kannan:
> > On Wed, Jan 20, 2021 at 11:28 AM Michael Walle <michael@walle.cc>
> > wrote:
> >>
> >> [RESEND, fat-fingered the buttons of my mail client and converted
> >> all CCs to BCCs :(]
> >>
> >> Am 2021-01-20 20:02, schrieb Saravana Kannan:
> >> > On Wed, Jan 20, 2021 at 6:24 AM Rob Herring <robh@kernel.org> wrote:
> >> >>
> >> >> On Wed, Jan 20, 2021 at 4:53 AM Michael Walle <michael@walle.cc>
> >> >> wrote:
> >> >> >
> >> >> > fw_devlink will defer the probe until all suppliers are ready. We can't
> >> >> > use builtin_platform_driver_probe() because it doesn't retry after probe
> >> >> > deferral. Convert it to builtin_platform_driver().
> >> >>
> >> >> If builtin_platform_driver_probe() doesn't work with fw_devlink, then
> >> >> shouldn't it be fixed or removed?
> >> >
> >> > I was actually thinking about this too. The problem with fixing
> >> > builtin_platform_driver_probe() to behave like
> >> > builtin_platform_driver() is that these probe functions could be
> >> > marked with __init. But there are also only 20 instances of
> >> > builtin_platform_driver_probe() in the kernel:
> >> > $ git grep ^builtin_platform_driver_probe | wc -l
> >> > 20
> >> >
> >> > So it might be easier to just fix them to not use
> >> > builtin_platform_driver_probe().
> >> >
> >> > Michael,
> >> >
> >> > Any chance you'd be willing to help me by converting all these to
> >> > builtin_platform_driver() and delete builtin_platform_driver_probe()?
> >>
> >> If it just moving the probe function to the _driver struct and
> >> remove the __init annotations. I could look into that.
> >
> > Yup. That's pretty much it AFAICT.
> >
> > builtin_platform_driver_probe() also makes sure the driver doesn't ask
> > for async probe, etc. But I doubt anyone is actually setting async
> > flags and still using builtin_platform_driver_probe().
>
> Hasn't module_platform_driver_probe() the same problem? And there
> are ~80 drivers which uses that.

Yeah. The biggest problem with all of these is the __init markers.
Maybe some familiar with coccinelle can help?

-Saravana
