Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0FD2F2803
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 06:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732865AbhALFtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 00:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbhALFtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 00:49:31 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F60EC061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 21:48:51 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id b8so832923plx.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 21:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z+UuZJMzg7vrix92H8yNvymjWYn4v4tuh1SrKJzSLm8=;
        b=JQsTmcLPoTaeeli611Tt6mGBNg5TJNkKTfXLDKVEnoX/OOqLNikQE4Ip2Rw6MA9Yuz
         KemfmMaptOX/ZNgHeDXdIN72y0gMJ44Dj2zLYwZ6eAwiDN9a7SPJjT4Vn3yO4vLV00pL
         DOY6W8keINeAjRVcriy8igeimSynyNmMITakQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z+UuZJMzg7vrix92H8yNvymjWYn4v4tuh1SrKJzSLm8=;
        b=kYk/AALWAx1bRfeIClU95ORUx8zV8QUAGNSt2eKeCijbN7murMJazSk4YWZnG4+ufe
         MbWXNKxDSNzuF6bJYBgtYuTdxun47yNoDuNpjIrlgOzl2oXusT2f9bD0HRQUqaRtOBS8
         qMJk5BZZyigXeH7z2184gTCXt3Lt+qBONfLPPsEHljpJRQLwXTSpZcs42dfZw2R5hl/6
         bhanPgL24zklLJ4gj8/lN1Kcw5V/ySFJyoHedmfsvSBpXefyctQj7nm3HQELORYyLxPz
         b3vUh1RETqtbW1nYZdOnh1AKDE+An7vEVhe64pM84UocAk7a5kPx9qOdab9f5rW1QyhL
         CfDw==
X-Gm-Message-State: AOAM530GgO9JlPKQoXtVNf8VlXhuW7vULBUAVyiHtwczY8XgOrAzmLmX
        abV9a9AnBfSBdt9mKYMYB0g6o57nfYXL1LkboyBn3w==
X-Google-Smtp-Source: ABdhPJz9iIQLZymh1Is42qGoVxhqbm83qoS8/tq7zs4AGxjPBu/MVfIrFA556/ppn3JB78x6W6Xh7UezS/ywc0QGduM=
X-Received: by 2002:a17:902:a501:b029:dc:3e1d:4ddb with SMTP id
 s1-20020a170902a501b02900dc3e1d4ddbmr3151522plq.60.1610430530661; Mon, 11 Jan
 2021 21:48:50 -0800 (PST)
MIME-Version: 1.0
References: <20201229142406.v5.1.Id0d31b5f3ddf5e734d2ab11161ac5821921b1e1e@changeid>
 <2aea44f0-85e7-fd55-2c35-c1d994f20e03@linux.intel.com> <1610086308.24856.30.camel@mhfsdcap03>
 <e43632e2-08b3-7a1a-8272-1d493e25fc67@linux.intel.com>
In-Reply-To: <e43632e2-08b3-7a1a-8272-1d493e25fc67@linux.intel.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Tue, 12 Jan 2021 13:48:39 +0800
Message-ID: <CAATdQgD2OAmf7_NWSVwzyJE7mF0vngzE=QeE79PS7MJsgPhbtA@mail.gmail.com>
Subject: Re: [PATCH v5] usb: xhci-mtk: fix unreleased bandwidth data
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
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

On Fri, Jan 8, 2021 at 10:44 PM Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
> On 8.1.2021 8.11, Chunfeng Yun wrote:
> > On Thu, 2021-01-07 at 13:09 +0200, Mathias Nyman wrote:
> >> On 29.12.2020 8.24, Ikjoon Jang wrote:
> >>> xhci-mtk has hooks on add_endpoint() and drop_endpoint() from xhci
> >>> to handle its own sw bandwidth managements and stores bandwidth data
> >>> into internal table every time add_endpoint() is called,
> >>> so when bandwidth allocation fails at one endpoint, all earlier
> >>> allocation from the same interface could still remain at the table.
> >>>
> >>> This patch adds two more hooks from check_bandwidth() and
> >>> reset_bandwidth(), and make mtk-xhci to releases all failed endpoints
> >>> from reset_bandwidth().
> >>>
> >>> Fixes: 08e469de87a2 ("usb: xhci-mtk: supports bandwidth scheduling with multi-TT")
> >>> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> >>>
> >>
> >> ...
> >>
> >>>
> >>> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> >>> index d4a8d0efbbc4..e1fcd3cf723f 100644
> >>> --- a/drivers/usb/host/xhci.c
> >>> +++ b/drivers/usb/host/xhci.c
> >>> @@ -2882,6 +2882,12 @@ static int xhci_check_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
> >>>     xhci_dbg(xhci, "%s called for udev %p\n", __func__, udev);
> >>>     virt_dev = xhci->devs[udev->slot_id];
> >>>
> >>> +   if (xhci->quirks & XHCI_MTK_HOST) {
> >>> +           ret = xhci_mtk_check_bandwidth(hcd, udev);
> >>> +           if (ret < 0)
> >>> +                   return ret;
> >>> +   }
> >>> +
> >>
> >> Just noticed that XHCI_MTK_HOST quirk is only set in xhci-mtk.c.
> >> xhci-mtk.c calls xhci_init_driver(..., xhci_mtk_overrides) with a .reset override function.
> >>
> >> why not add override functions for .check_bandwidth and .reset_bandwidth to xhci_mtk_overrides instead?
> >>
> >> Another patch to add similar overrides for .add_endpoint and .drop_endpoint should probably be
> >> done so that we can get rid of the xhci_mtk_add/drop_ep_quirk() calls in xhci.c as well
> > You mean, we can export xhci_add/drop_endpoint()?
>
> I think so, unless you have a better idea.
> I prefer exporting the generic add/drop_endpoint functions rather than the vendor specific quirk functions.
>

When moving out all MTK_HOST quirks and unlink xhci-mtk-sch from xhci,
xhci-mtk-sch still needs to touch the xhci internals, at least struct
xhci_ep_ctx.

My naive idea is just let xhci export one more function to expose xhci_ep_ctx.
But I'm not sure whether this is acceptable:

+struct xhci_ep_ctx* xhci_get_ep_contex(struct xhci_hcd *xhci, struct
usb_host_endpoint *ep)
+{ ... }
+EXPORT_SYMBOL(xhci_get_ep_context);

But for v6, I'm going to submit a patch with {check|reset}_bandwidth()
quirk function
 switched into xhci_driver_overrides first. (and preserve existing
MTK_HOST quirk functions).

Thanks!

> -Mathias
>
