Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308EA303113
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 02:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731966AbhAYThB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 14:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730891AbhAYTAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:00:01 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF04C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 10:59:20 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id b11so14330437ybj.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 10:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MycbrezgsQZFT8oqiMufe2gK1ooAaS0SUCHVJFVQ9MQ=;
        b=D89ARNqQBSe6Gl9R5DO/KGq6f+XwI019KcTyn5HUgOjPlzNOoKDGLvzncEHAHxv7re
         lb0QJau2yo6HykmQLwhmFTcTH8Sq6QkyRikthUtPyKV308YBxPqBa17hLZ7vVdG82tdr
         1ZYHEmIoWgXZXzZgGJavOcNzowg9rVJTESsTDHUrdAkVRtjVOXki39cVm64f90B/xnUN
         p++bUV3uNwbHulfuik0Rs79fbFZMM9ifY6BNJzC7/LyidIkjYH3n/Y3WfoT8VtT0C7bQ
         vqglJpySbxKD72RPbiNIaXSY6RlQxd1v9SjROcZsCNjlhR4Ys9ezoFcio6JbYI7EjanP
         cYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MycbrezgsQZFT8oqiMufe2gK1ooAaS0SUCHVJFVQ9MQ=;
        b=tFWNGh6SzgJr/0qEW9urMZD7Xoq4G7TCD5dkwSr43ppquY+WMnPAPP3T1zzE1isWPv
         jV+oBDfiu0MVo+Lzycn+7mP6nE115Y98L1KnJvxLWmDX8nxry/Ou35LYwDEhPWZHSbx2
         ezXHTkRdfd/2xLCzzGEFj3VoQibeyHwU1SJtpTddv5mbkbUdYZ0KzFrpV5nM0T596oLm
         009vCs3KdS8fJWaK7OIYRAWzpCltGMvixRix2NB8/uQUrNkUMqB2Omq+NrvEyTeAOy6B
         g3lb1K4O73Og0MVkcef9ZPF5Aa0L2L/l+IDmHoNCZhBIJBtreMrrFXOXnZH1D/HPArGA
         UKLA==
X-Gm-Message-State: AOAM5309leCo9r2rdU21rpbyJPbGYoNenNRvOG99o3lo34iv1fOC1BMW
        FBMJCnagm1S8vCRSU67iu/hV0PCWp4K8jbA2maBV7Q==
X-Google-Smtp-Source: ABdhPJwgOyKDm0nJVp7CDR5p+pD9pfx6JsaeKrbh2AWLDPYbm1qy57jLH9fVrTDF4d9HZfHyOf/YQTtTZFeWAQ46qnY=
X-Received: by 2002:a25:2f46:: with SMTP id v67mr3110432ybv.20.1611601159888;
 Mon, 25 Jan 2021 10:59:19 -0800 (PST)
MIME-Version: 1.0
References: <20210120105246.23218-1-michael@walle.cc> <CAL_JsqLSJCLtgPyAdKSqsy=JoHSLYef_0s-stTbiJ+VCq2qaSA@mail.gmail.com>
 <CAGETcx86HMo=gaDdXFyJ4QQ-pGXWzw2G0J=SjC-eq4K7B1zQHg@mail.gmail.com>
 <c3e35b90e173b15870a859fd7001a712@walle.cc> <20210125165041.GA5979@e121166-lin.cambridge.arm.com>
In-Reply-To: <20210125165041.GA5979@e121166-lin.cambridge.arm.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 25 Jan 2021 10:58:43 -0800
Message-ID: <CAGETcx-P-MxM+49XdUGBmg5YgnHS=fmz8uewywXvLSFKj=MqRQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: layerscape: convert to builtin_platform_driver()
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Michael Walle <michael@walle.cc>, Rob Herring <robh@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 8:50 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Wed, Jan 20, 2021 at 08:28:36PM +0100, Michael Walle wrote:
> > [RESEND, fat-fingered the buttons of my mail client and converted
> > all CCs to BCCs :(]
> >
> > Am 2021-01-20 20:02, schrieb Saravana Kannan:
> > > On Wed, Jan 20, 2021 at 6:24 AM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Wed, Jan 20, 2021 at 4:53 AM Michael Walle <michael@walle.cc>
> > > > wrote:
> > > > >
> > > > > fw_devlink will defer the probe until all suppliers are ready. We can't
> > > > > use builtin_platform_driver_probe() because it doesn't retry after probe
> > > > > deferral. Convert it to builtin_platform_driver().
> > > >
> > > > If builtin_platform_driver_probe() doesn't work with fw_devlink, then
> > > > shouldn't it be fixed or removed?
> > >
> > > I was actually thinking about this too. The problem with fixing
> > > builtin_platform_driver_probe() to behave like
> > > builtin_platform_driver() is that these probe functions could be
> > > marked with __init. But there are also only 20 instances of
> > > builtin_platform_driver_probe() in the kernel:
> > > $ git grep ^builtin_platform_driver_probe | wc -l
> > > 20
> > >
> > > So it might be easier to just fix them to not use
> > > builtin_platform_driver_probe().
> > >
> > > Michael,
> > >
> > > Any chance you'd be willing to help me by converting all these to
> > > builtin_platform_driver() and delete builtin_platform_driver_probe()?
> >
> > If it just moving the probe function to the _driver struct and
> > remove the __init annotations. I could look into that.
>
> Can I drop this patch then ?

No, please pick it up. Michael and I were talking about doing similar
changes for other drivers.

-Saravana
