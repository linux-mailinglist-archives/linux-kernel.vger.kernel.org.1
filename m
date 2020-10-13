Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C7828CE78
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgJMMic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgJMMia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 08:38:30 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07883C0613D2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 05:38:29 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id n61so18859429ota.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 05:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s185zwWcpFWZXmjk0XfZLH1jYMkQ8pmY2UrGI8e/2Cc=;
        b=avFt+8xSpNxHIE0rLlsKdL0S1oWqx3zu2gP3OWYeLlh+27eOdUVYGKDS/5m/ZtoJ0h
         Yrza2wsd6Kc/6uuAnM5lP4SJR0cxrT3nkG2P+oV0Srmum8t7PbEoBlnYA/7EVYRzRAav
         54HJpiHwCSgTBskUW+uV0TWXyaVAZyuM7MF24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s185zwWcpFWZXmjk0XfZLH1jYMkQ8pmY2UrGI8e/2Cc=;
        b=tCHKChHKiQ3ZeX95KNKq9Nu+RMgmhn41L/Z9YP2hWF4WJuOSIPk4HE1bznOdAumfV5
         OuOGTwMqT8tstVnLjHzOR+/n107/XalU9Tk72Y89gtJH9anfJfHq7ed1JLSV16jQDwZH
         t/xf7oYlbnfYUMnmJ/XczZph5/ZC8FLSu1sQstcQEvr0wiprkKTUFqOgdbChmRMp9raB
         yINcfSY8tsNHh+gp4FEk3KKVakxx2Xw76oQ5+RZAjSqGHPXnlGCaxWLXYnqVXl42BbLV
         oTo/HX0FSZIzkr/IScBivC8uJC74AMDqRXUu5V/ZG4FPN1dd2DHoOchnuAMYJoyx3Meo
         hs3g==
X-Gm-Message-State: AOAM530ewtrA4gnbtgHBY6LextkIkluUKMTEehCDnymeC3lEm8KmW1iH
        H1RKH2Mw+y6U3xIA39SnFHpdt3Xf2qPuHQ==
X-Google-Smtp-Source: ABdhPJz/ozBBRrLkneSJbeHs3MvIF0BSeVMuTsM1FVT/i2zeBWLTmibIdFxJOETqyTcc0cCynZPUkw==
X-Received: by 2002:a05:6830:2153:: with SMTP id r19mr942490otd.207.1602592708466;
        Tue, 13 Oct 2020 05:38:28 -0700 (PDT)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com. [209.85.210.43])
        by smtp.gmail.com with ESMTPSA id l109sm9984588otc.10.2020.10.13.05.38.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 05:38:27 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id f10so18879223otb.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 05:38:26 -0700 (PDT)
X-Received: by 2002:a9d:242:: with SMTP id 60mr9713952otb.141.1602592706203;
 Tue, 13 Oct 2020 05:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201012053557.4102148-1-acourbot@chromium.org>
 <20201012053557.4102148-3-acourbot@chromium.org> <20201012094307.1f32155b@coco.lan>
In-Reply-To: <20201012094307.1f32155b@coco.lan>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Tue, 13 Oct 2020 21:38:14 +0900
X-Gmail-Original-Message-ID: <CAPBb6MWTnCbKAWPYGBt-xS71Evj1kP14bfv8jThtsc0yzA+obw@mail.gmail.com>
Message-ID: <CAPBb6MWTnCbKAWPYGBt-xS71Evj1kP14bfv8jThtsc0yzA+obw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] media: mtk-vcodec: fix build breakage when one of
 VPU or SCP is enabled
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On Mon, Oct 12, 2020 at 4:43 PM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Em Mon, 12 Oct 2020 14:35:57 +0900
> Alexandre Courbot <acourbot@chromium.org> escreveu:
>
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
> > Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
> > Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  drivers/media/platform/Kconfig                | 22 +++++++++++++++----
> >  drivers/media/platform/mtk-vcodec/Makefile    | 10 +++++++--
> >  .../platform/mtk-vcodec/mtk_vcodec_fw_priv.h  | 18 +++++++++++++++
> >  3 files changed, 44 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> > index a3cb104956d5..457b6c39ddc0 100644
> > --- a/drivers/media/platform/Kconfig
> > +++ b/drivers/media/platform/Kconfig
> > @@ -253,18 +253,32 @@ config VIDEO_MEDIATEK_VCODEC
> >       depends on MTK_IOMMU || COMPILE_TEST
> >       depends on VIDEO_DEV && VIDEO_V4L2
> >       depends on ARCH_MEDIATEK || COMPILE_TEST
> > +     depends on VIDEO_MEDIATEK_VPU || MTK_SCP
> > +     # The two following lines ensure we have the same state ("m" or "y") as
> > +     # our dependencies, to avoid missing symbols during link.
> > +     depends on VIDEO_MEDIATEK_VPU || !VIDEO_MEDIATEK_VPU
> > +     depends on MTK_SCP || !MTK_SCP
> >       select VIDEOBUF2_DMA_CONTIG
> >       select V4L2_MEM2MEM_DEV
> > -     select VIDEO_MEDIATEK_VPU
> > -     select MTK_SCP
> > +     select VIDEO_MEDIATEK_VCODEC_VPU if VIDEO_MEDIATEK_VPU
> > +     select VIDEO_MEDIATEK_VCODEC_SCP if MTK_SCP
> >       help
> >           Mediatek video codec driver provides HW capability to
> > -         encode and decode in a range of video formats
> > -         This driver rely on VPU driver to communicate with VPU.
> > +         encode and decode in a range of video formats on MT8173
> > +         and MT8183.
> > +
> > +         Note that support for MT8173 requires VIDEO_MEDIATEK_VPU to
> > +         also be selected. Support for MT8183 depends on MTK_SCP.
> >
> >           To compile this driver as modules, choose M here: the
> >           modules will be called mtk-vcodec-dec and mtk-vcodec-enc.
>
> Just my 2 cents here, and to complement my last e-mail, the helper message
> here IMO is a lot more confusing than if you do this, instead:
>
>         config VIDEO_MEDIATEK_CODEC
>                  depends on VIDEO_MEDIATEK_VPU_SCP || VIDEO_MEDIATEK_VPU
>                  default y
>
>         config VIDEO_MEDIATEK_VPU
>             depends on VIDEO_DEV && VIDEO_V4L2
>             depends on ARCH_MEDIATEK || COMPILE_TEST
>             tristate "Enable Mediatek Video Processor Unit for MT8173"
>             help
>                 Select this option to enable Mediatek VPU on MT8173.
>
>         config VIDEO_MEDIATEK_VPU_SCP
>             depends on VIDEO_DEV && VIDEO_V4L2
>             depends on ARCH_MEDIATEK || COMPILE_TEST
>             tristate "Enable Mediatek Video Processor Unit for MT8183"
>             help
>                 Select this option to enable Mediatek VPU on MT8183.
>
> To be clear, from my side, I can live with either one of the alternatives,
> but, IMHO, the above is a lot clearer for anyone wanting to use
> VPU, as, if MTK_SCP is disabled, the MT8183 Kconfig prompt will
> disappear.

So I have experimented a bit and it turns out that even after adding
these new entries and using the "default" option that you suggested,
one still needs to perform the

    depends on VIDEO_MEDIATEK_VPU || !VIDEO_MEDIATEK_VPU
    depends on MTK_SCP || !MTK_SCP

magic to prevent the VCODEC module from being built-in while having
the SCP and/or VPU support as modules (which would trigger the same
link error as before).

Also from experiment, the additional menu entries for SCP and VPU
won't bring any improvement in visibility since e.g. we cannot make
VIDEO_MEDIATEK_VPU_SCP visible unless MTK_SCP (the remoteproc option)
is also enabled. And this would leave us with the possibility of
having MTK_SCP enabled while leaving VIDEO_MEDIATEK_VPU_SCP
unselected, which is not a configuration one would want in practice.

Maybe I am missing something again, but I cannot find a benefit over
the current way - I'm completely open to revisit this in the future,
maybe by restructuring the driver some more, but for now I suggest we
fix the build breakage quickly. :)

I will send a v4 with some minor fixes.
