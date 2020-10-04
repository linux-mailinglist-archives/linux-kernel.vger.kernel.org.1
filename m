Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71898282A9D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 14:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgJDMTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 08:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgJDMTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 08:19:03 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1768DC0613CE
        for <linux-kernel@vger.kernel.org>; Sun,  4 Oct 2020 05:19:02 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id c13so6007674oiy.6
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 05:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uXNdWYMromVSx/RjkxXpJxcfqReLqFvZyFU3dhbaUTA=;
        b=i/qkeKCDlG6ZxOEGMPbFh2xphG0sL7pHvduuvjQwfE8ZVBLygJQZk8PTYjU1im4Alf
         gEfrjhTU3FUci3cyYGdlylDMJzTfnFAF89Np2n5TmPDqshBTw9RKzUWktl3d3NersM+6
         rbutunneNKu/OOrI3wrleyZ30aaLAuBI+Oc50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uXNdWYMromVSx/RjkxXpJxcfqReLqFvZyFU3dhbaUTA=;
        b=lEHKRN1KwUgoXsDTrIrnX/+A/hY5yZnWKIU7VnrgUoN48jMoKYA0GdgjEQlYoZgrRq
         MtmnQWANiFWIkXPQyQaNcKsQ6Iwyani2c7CdayloaGsUuk3FcXJCUbDpwbgzWUvbuqko
         heYxmWzybzrgMBVBwQtTmznGH4bisJQN3y/0lJKkHoVtkOB0wQZT+T1YDIr1od0XYcOQ
         DQfMmRWUIq4Jf2qAGSLuzzzJtpTliZgWbvcQh/Oej5xXF3/OL+IwYyLuCE90Nu9W7E2n
         /gmTG4MXQT2SKkCT7VxxATqpBqRbXubcjyCvgAuBWjYXeTorNm5n/xGlIsMgRihNuA/9
         5PLw==
X-Gm-Message-State: AOAM532k7uzji/DOxDzvxmGP7ux8RENYaoQ7KlJvKkMG/L5S/V8pDxIH
        4oR2xXL0Xj2RDKfqZWA6/PT9BSpjgTY8hw==
X-Google-Smtp-Source: ABdhPJwFST+JmNuHX1LTYyOSXILqq1Ba02qUd7A3opA8M68HUEHoNS4NXqMcKR+x2OJccrAqQav72w==
X-Received: by 2002:a54:468f:: with SMTP id k15mr6136608oic.121.1601813940974;
        Sun, 04 Oct 2020 05:19:00 -0700 (PDT)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com. [209.85.167.176])
        by smtp.gmail.com with ESMTPSA id d63sm1585930oig.53.2020.10.04.05.18.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2020 05:19:00 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id n2so6024626oij.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 05:18:59 -0700 (PDT)
X-Received: by 2002:aca:cd42:: with SMTP id d63mr5722000oig.94.1601813939470;
 Sun, 04 Oct 2020 05:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201003130947.555637-1-acourbot@chromium.org> <43e118c9-0bc6-d85d-2f86-e74f833e1e8a@infradead.org>
In-Reply-To: <43e118c9-0bc6-d85d-2f86-e74f833e1e8a@infradead.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Sun, 4 Oct 2020 21:18:46 +0900
X-Gmail-Original-Message-ID: <CAPBb6MXjeRMV_q3E8M7wdA9C9tVfY0X36c1ye=VrJGwmWBpEKg@mail.gmail.com>
Message-ID: <CAPBb6MXjeRMV_q3E8M7wdA9C9tVfY0X36c1ye=VrJGwmWBpEKg@mail.gmail.com>
Subject: Re: [PATCH] media: mtk-vcodec: fix builds when remoteproc is disabled
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 4, 2020 at 1:50 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 10/3/20 6:09 AM, Alexandre Courbot wrote:
> > The addition of MT8183 support added a dependency on the SCP remoteproc
> > module. However the initial patch used the "select" Kconfig directive,
> > which may result in the SCP module to not be compiled if remoteproc was
> > disabled. In such a case, mtk-vcodec would try to link against
> > non-existent SCP symbols. "select" was clearly misused here as explained
> > in kconfig-language.txt.
> >
> > Replace this by a "depends" directive on at least one of the VPU and
> > SCP modules, to allow the driver to be compiled as long as one of these
> > is enabled, and adapt the code to support this new scenario.
> >
> > Also adapt the Kconfig text to explain the extra requirements for MT8173
> > and MT8183.
> >
> > Reported-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
>
> I was seeing this also, so I checked this patch. WFM.
>
> Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks for checking! I will send a v2 with your Acked-by and fix.

>
> See below.
>
> > ---
> >  drivers/media/platform/Kconfig                | 11 +--
> >  .../media/platform/mtk-vcodec/mtk_vcodec_fw.c | 72 ++++++++++++-------
> >  2 files changed, 55 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> > index a3cb104956d5..e559d9c529b6 100644
> > --- a/drivers/media/platform/Kconfig
> > +++ b/drivers/media/platform/Kconfig
> > @@ -253,14 +253,17 @@ config VIDEO_MEDIATEK_VCODEC
> >       depends on MTK_IOMMU || COMPILE_TEST
> >       depends on VIDEO_DEV && VIDEO_V4L2
> >       depends on ARCH_MEDIATEK || COMPILE_TEST
> > +     depends on VIDEO_MEDIATEK_VPU || MTK_SCP
> >       select VIDEOBUF2_DMA_CONTIG
> >       select V4L2_MEM2MEM_DEV
> > -     select VIDEO_MEDIATEK_VPU
> > -     select MTK_SCP
> >       help
> >           Mediatek video codec driver provides HW capability to
> > -         encode and decode in a range of video formats
> > -         This driver rely on VPU driver to communicate with VPU.
> > +         encode and decode in a range of video formats on MT8173
> > +         and MT8183.
> > +
> > +         Note that support for support for MT8173 requires
>
> Drop one of "support for" above. (or "for support" ;)
>
> > +         VIDEO_MEDIATEK_VPU to also be selected. Support for
> > +         MT8183 depends on MTK_SCP.
> >
> >           To compile this driver as modules, choose M here: the
> >           modules will be called mtk-vcodec-dec and mtk-vcodec-enc.
>
>
> thanks.
> --
> ~Randy
