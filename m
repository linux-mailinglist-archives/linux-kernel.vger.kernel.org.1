Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A2B2FDA17
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 20:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392628AbhATTwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 14:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392785AbhATTtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 14:49:14 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B944C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 11:48:33 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id f6so20561404ybq.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 11:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ObV+Zrw0ag3h+RPkcqP4IfhPjoMoAtg+NMqr3jjO+Go=;
        b=oC6SN/sbj4bIrF3B4GUuhs9TwpbLn4WPe1e9cjwF7wwmLDRIO7pF44hc+PlUUR5s6f
         BUa/nNUWktSkKrynSgljkxdDWgmOVVMVyk8uWzs3rc62W0hdOV2OZFhKAvCRrJue94uF
         dtTS6xLCZnR4CARQJgq3BQNQntv8GvoIMDidgambBPn09cfAnJTf/fW2G1wUUaSef+Lb
         eUdBgvApC0YkqmFU3YIk/cUwKzppcJs1fvb2jH3Mxq+LoT5Y1ONy+9CAcS/N9SgllEh8
         BpR65N56lr1oYN/R2Sk1xRq0HxiULzg425ngiI8FJXDLpvPxGxLFwJJPKAUdWbIf3wHj
         w/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ObV+Zrw0ag3h+RPkcqP4IfhPjoMoAtg+NMqr3jjO+Go=;
        b=EHTLbivbZvP3AlXER1tuT6ZuETwQ2T9WcSUWMW6EdXw3NW860019pScoaWjxBQyr3f
         d4UtoK6Y0mr1vIgcmfn8tARJqywRjPpk9cExObA7GBYZz+OFBG3MsF9bWVYOXt9L+ci5
         rE6W+rgwg2lFAt13zsao6aqsrkEFsMdO/0vczSCEV46XLvSXbHdBpxJu+fP07YT50hXz
         tGZO+8DP/dq3MFeAe5J7uOogHWdXESoIxjrN5+M+nNhR81wbXp9V4Iy9OFEBeCeAxTyP
         DaE5bhPHB3OgyC7gNpc7rkCYzP6vvT6wstpscniN7bRn6RgvTHtldQwfvfRyMRtKJ8n0
         RipQ==
X-Gm-Message-State: AOAM530eMT75z+PgbpstW4QB062aMrXpdHWDlmAAktGhbyph/TKdtcjK
        JdoA4Ntgp10qKMHld5YWiCrU/xoH2xgmJeNRye9F17s4fPA=
X-Google-Smtp-Source: ABdhPJwnmI7Ki+dDkxtJ432CAmCzDl+L83UkNWO3KhRK6fxwAFD24zUFGq1C6V2bl4d7oNvSYCj+gOEJxriWc7ov3P4=
X-Received: by 2002:a25:b703:: with SMTP id t3mr17175535ybj.96.1611172112724;
 Wed, 20 Jan 2021 11:48:32 -0800 (PST)
MIME-Version: 1.0
References: <20210120105246.23218-1-michael@walle.cc> <CAL_JsqLSJCLtgPyAdKSqsy=JoHSLYef_0s-stTbiJ+VCq2qaSA@mail.gmail.com>
 <CAGETcx86HMo=gaDdXFyJ4QQ-pGXWzw2G0J=SjC-eq4K7B1zQHg@mail.gmail.com>
 <c3e35b90e173b15870a859fd7001a712@walle.cc> <CAGETcx8eZRd1fJ3yuO_t2UXBFHObeNdv-c8oFH3mXw6zi=zOkQ@mail.gmail.com>
In-Reply-To: <CAGETcx8eZRd1fJ3yuO_t2UXBFHObeNdv-c8oFH3mXw6zi=zOkQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 20 Jan 2021 11:47:56 -0800
Message-ID: <CAGETcx_bT46e1JFsSDQ+Rv8uFwHYima-00anH220qmK=cCs=Ww@mail.gmail.com>
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

On Wed, Jan 20, 2021 at 11:47 AM Saravana Kannan <saravanak@google.com> wrote:
>
> On Wed, Jan 20, 2021 at 11:28 AM Michael Walle <michael@walle.cc> wrote:
> >
> > [RESEND, fat-fingered the buttons of my mail client and converted
> > all CCs to BCCs :(]
> >
> > Am 2021-01-20 20:02, schrieb Saravana Kannan:
> > > On Wed, Jan 20, 2021 at 6:24 AM Rob Herring <robh@kernel.org> wrote:
> > >>
> > >> On Wed, Jan 20, 2021 at 4:53 AM Michael Walle <michael@walle.cc>
> > >> wrote:
> > >> >
> > >> > fw_devlink will defer the probe until all suppliers are ready. We can't
> > >> > use builtin_platform_driver_probe() because it doesn't retry after probe
> > >> > deferral. Convert it to builtin_platform_driver().
> > >>
> > >> If builtin_platform_driver_probe() doesn't work with fw_devlink, then
> > >> shouldn't it be fixed or removed?
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
> Yup. That's pretty much it AFAICT.
>
> builtin_platform_driver_probe() also makes sure the driver doesn't ask
> for async probe, etc. But I doubt anyone is actually setting async
> flags and still using builtin_platform_driver_probe().
>

And thanks for agreeing to help!

-Saravana
