Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E102F70BC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 03:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732302AbhAOCv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 21:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732180AbhAOCvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 21:51:55 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E93C061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 18:51:14 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id 11so4581176pfu.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 18:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JC7oohfALujgMdyPvPz4HUk+eyvN9WaqpC/oTBTunFI=;
        b=PrktYQGnOhf6EonDJAl8crgFkgsS7LCIJaR7PlQ1E+Uy0kyhg5qSosGhtYPiiq7b6V
         5xz5WW/SyAckeqPvTvrSqmIrAy51BY6+mPjJn45FCtc7F53DB5wiDx/DJjJHzHeQm65j
         FyZsL2UAupewpdTXTuV65l3UjDbXMI1QzA7kQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JC7oohfALujgMdyPvPz4HUk+eyvN9WaqpC/oTBTunFI=;
        b=OSG6yzJZyfKzFw7vKFY2MLmztnOyjDnoIHcSGaIOFvfphe6e9B3M/kXSShMr06H/wo
         lGWRp3biOtay/MVYKecJoqS9dCw9kFLqIUhFfLMjKrK7AHqTDb/JyI2hn8fwpApAsJtZ
         amGUinLUzEsTRbzg8YKRJCmjRAP9vlvaY9v9iG0BeN98j6nqDssfkMge5SimrSCFqYdi
         PNclNNLex6fQVg7q6QGu26CBMFTcELkxfZWlKCc4gWDMb4fM//H5KxqSARhPlck51hak
         Y1G1kvf0pVplLPxbyEKkzF5WgQtqHjXhS34l/LegaMJdYspVTBza1fifALrmC7z91fNn
         tV+w==
X-Gm-Message-State: AOAM5313K98doNI+Xp1rrFmH/DUSwWKugoFDUwaOZ3vSj3GFEGPS8yrC
        kfRRmrSptBzru8fH6BrCZAK0AfRoDfw9X6sftlscZw==
X-Google-Smtp-Source: ABdhPJwEr7vgyC+XwBFfX12iNXroO8R+0dGE9jOmm8CmOWVFx0OdWCdNJ4jSrTu1mfkC1rQ3Zt0rCf+jrGnngfKGlzg=
X-Received: by 2002:a63:1a10:: with SMTP id a16mr10165921pga.317.1610679074288;
 Thu, 14 Jan 2021 18:51:14 -0800 (PST)
MIME-Version: 1.0
References: <20201229142406.v5.1.Id0d31b5f3ddf5e734d2ab11161ac5821921b1e1e@changeid>
 <2aea44f0-85e7-fd55-2c35-c1d994f20e03@linux.intel.com> <1610086308.24856.30.camel@mhfsdcap03>
 <e43632e2-08b3-7a1a-8272-1d493e25fc67@linux.intel.com> <CAATdQgD2OAmf7_NWSVwzyJE7mF0vngzE=QeE79PS7MJsgPhbtA@mail.gmail.com>
 <1610612988.30053.15.camel@mhfsdcap03>
In-Reply-To: <1610612988.30053.15.camel@mhfsdcap03>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Fri, 15 Jan 2021 10:51:03 +0800
Message-ID: <CAATdQgCb254YJ2tpiqWZ0RDHRiN59NuuHBuhavoYQT3STh=jkg@mail.gmail.com>
Subject: Re: [PATCH v5] usb: xhci-mtk: fix unreleased bandwidth data
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-usb@vger.kernel.org,
        Tianping Fang <tianping.fang@mediatek.com>,
        Zhanyong Wang <zhanyong.wang@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 4:30 PM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> Hi Ikjoon,
>
> On Tue, 2021-01-12 at 13:48 +0800, Ikjoon Jang wrote:
> > On Fri, Jan 8, 2021 at 10:44 PM Mathias Nyman
> > <mathias.nyman@linux.intel.com> wrote:
> > >
> > > On 8.1.2021 8.11, Chunfeng Yun wrote:
> > > > On Thu, 2021-01-07 at 13:09 +0200, Mathias Nyman wrote:
> > > >> On 29.12.2020 8.24, Ikjoon Jang wrote:
> > > >>> xhci-mtk has hooks on add_endpoint() and drop_endpoint() from xhci
> > > >>> to handle its own sw bandwidth managements and stores bandwidth data
> > > >>> into internal table every time add_endpoint() is called,
> > > >>> so when bandwidth allocation fails at one endpoint, all earlier
> > > >>> allocation from the same interface could still remain at the table.
> > > >>>
> > > >>> This patch adds two more hooks from check_bandwidth() and
> > > >>> reset_bandwidth(), and make mtk-xhci to releases all failed endpoints
> > > >>> from reset_bandwidth().
> > > >>>
> > > >>> Fixes: 08e469de87a2 ("usb: xhci-mtk: supports bandwidth scheduling with multi-TT")
> > > >>> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> > > >>>
> > > >>
> > > >> ...
> > > >>
> > > >>>
> > > >>> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> > > >>> index d4a8d0efbbc4..e1fcd3cf723f 100644
> > > >>> --- a/drivers/usb/host/xhci.c
> > > >>> +++ b/drivers/usb/host/xhci.c
> > > >>> @@ -2882,6 +2882,12 @@ static int xhci_check_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
> > > >>>     xhci_dbg(xhci, "%s called for udev %p\n", __func__, udev);
> > > >>>     virt_dev = xhci->devs[udev->slot_id];
> > > >>>
> > > >>> +   if (xhci->quirks & XHCI_MTK_HOST) {
> > > >>> +           ret = xhci_mtk_check_bandwidth(hcd, udev);
> > > >>> +           if (ret < 0)
> > > >>> +                   return ret;
> > > >>> +   }
> > > >>> +
> > > >>
> > > >> Just noticed that XHCI_MTK_HOST quirk is only set in xhci-mtk.c.
> > > >> xhci-mtk.c calls xhci_init_driver(..., xhci_mtk_overrides) with a .reset override function.
> > > >>
> > > >> why not add override functions for .check_bandwidth and .reset_bandwidth to xhci_mtk_overrides instead?
> > > >>
> > > >> Another patch to add similar overrides for .add_endpoint and .drop_endpoint should probably be
> > > >> done so that we can get rid of the xhci_mtk_add/drop_ep_quirk() calls in xhci.c as well
> > > > You mean, we can export xhci_add/drop_endpoint()?
> > >
> > > I think so, unless you have a better idea.
> > > I prefer exporting the generic add/drop_endpoint functions rather than the vendor specific quirk functions.
> > >
> >
> > When moving out all MTK_HOST quirks and unlink xhci-mtk-sch from xhci,
> > xhci-mtk-sch still needs to touch the xhci internals, at least struct
> > xhci_ep_ctx.
> >
> > My naive idea is just let xhci export one more function to expose xhci_ep_ctx.
> > But I'm not sure whether this is acceptable:
> I find that xhci_add_endpoint() ignores some errors with return 0, for
> these cases we needn't call xhci_mtk_add_ep-quirk(), so may be not a
> good way to just export xhci_add_endpoint().

yeah, maybe that's from ep0 case?

And I've thought that we could also unlink xhci-mtk-sch from the xhci module
if MTK_HOST quirk functions are moved out to mtk platform driver's overrides.
I guess I've gone too far.

If we keep xhci-mtk-sch being built with the xhci module,
xhci-mtk-sch can directly access input control context and its drop/add flags,
so I think we can simply remove {add|drop}_endpoint() quirks and just handle
them all in {check|reset}_bandwidth() overrides.

>
> >
> > +struct xhci_ep_ctx* xhci_get_ep_contex(struct xhci_hcd *xhci, struct
> > usb_host_endpoint *ep)
> > +{ ... }
> > +EXPORT_SYMBOL(xhci_get_ep_context);
> >
> > But for v6, I'm going to submit a patch with {check|reset}_bandwidth()
> > quirk function
> >  switched into xhci_driver_overrides first. (and preserve existing
> > MTK_HOST quirk functions).
> >
> > Thanks!
> >
> > > -Mathias
> > >
>
