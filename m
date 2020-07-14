Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA5521F647
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 17:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgGNPjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 11:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgGNPjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 11:39:20 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699ADC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 08:39:19 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id e13so15978029qkg.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 08:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WksUM6pNI+S4CMahaIw3W532k7nAO9tbEiDkzLv1CSM=;
        b=Wim6yhMrOtHj4Obe5ed3OHki+ECj+oGFL5miVjOUk/VdS8ZzJuC9l+wt2q2ai1dEQe
         TlrGeWOCFBEiVGdatHH0GWLAdKOp/Pbda9YggdQasMCy6pqwDpHv4+m3GwzZKsqfXDQM
         wVLLbO0svs94J/bEPWFTvqxqE/NvlRMZJJ2kM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WksUM6pNI+S4CMahaIw3W532k7nAO9tbEiDkzLv1CSM=;
        b=dqMhVwzbETS6Ts7nLI3FVZjDqhGU2GJSaVznJx70IeYHaPjodQOAiOvaNEfOcvfQQC
         Ht0wovdLLArbujlov+nv2XzXuDbW+Ddt+8Z0lDtc1mp8K8VwkyFhDZzNx+hCmsMHZlel
         Ss/vRm1gYShAO4NlG/epm161O5GEXHb0kJpReOzUZi2ETLoiegOLXx9WFCSj3XAas9Lh
         nij+fsoX1oRuRL+8sjR8INhe9U2VsZdAPMo6a/eLhk9XTpKQJcCu7lD/zUh8xywIqyL7
         doPoC5ZALBZhkfhImJQO0WUe0LsMjMCq6moTwgibPc6cYjcG29tIOareV6ROhbpiJ/JG
         bDMA==
X-Gm-Message-State: AOAM533yQ+4wl5Jbvni/EfhPNcN++XVPSAUnbzSK6u+IXAb6ggSRumwv
        ZGh2elHCpWlewP92UCfCgxQcS8pZCBI=
X-Google-Smtp-Source: ABdhPJwdS/flJ3QLeHjVtaBGRgLxtn93Rsn36CePPtykDNqygC72RZFd3PTOMOs3MXhhDsiUH95G9w==
X-Received: by 2002:a05:620a:1519:: with SMTP id i25mr4912866qkk.91.1594741158194;
        Tue, 14 Jul 2020 08:39:18 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id x23sm22247979qki.6.2020.07.14.08.39.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 08:39:18 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id x138so6805107ybg.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 08:39:17 -0700 (PDT)
X-Received: by 2002:ab0:150c:: with SMTP id o12mr3958335uae.90.1594740682019;
 Tue, 14 Jul 2020 08:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20191218143416.v3.6.Iaf8d698f4e5253d658ae283d2fd07268076a7c27@changeid>
 <20200710011935.GA7056@gentoo.org> <CAD=FV=X3oazamoKR1jHoXm-yCAp9208ahNd8y+NDPt1pU=5xRg@mail.gmail.com>
 <CAD=FV=UWQsGit6XMCzHn5cBRAC9nAaGReDyMzMM2Su02bfiPyQ@mail.gmail.com>
 <dc786abb-4bc2-2416-7ee5-de408aceb8f1@kali.org> <e0702671-3bed-9e3d-c7f4-d050c617eb65@kali.org>
 <bc795659-7dd6-c667-1c93-4331510ecfbc@kali.org> <CAD=FV=VC+RP8WfS-yuc65WRN2KokNbAs-F3UdQtQoZjcMMSNFA@mail.gmail.com>
 <f81f0d22-85d6-66eb-c8d9-345757f53959@kali.org> <CAD=FV=WB_4xLe9UZX3eVemybQ1neXJVZgzrDCW-xUxbAM6hCTA@mail.gmail.com>
 <8e306b6d-246d-aa7f-cb24-923e13afcd04@kali.org>
In-Reply-To: <8e306b6d-246d-aa7f-cb24-923e13afcd04@kali.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 14 Jul 2020 08:31:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XeBLRc4v5K3vj=m9PGMuW8GVUq110ApX6xS2QaiJd=pw@mail.gmail.com>
Message-ID: <CAD=FV=XeBLRc4v5K3vj=m9PGMuW8GVUq110ApX6xS2QaiJd=pw@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] drm/bridge: ti-sn65dsi86: Use 18-bit DP if we can
To:     Steev Klimaszewski <steev@kali.org>
Cc:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Steev Klimaszewski <steev@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 10, 2020 at 10:11 AM Steev Klimaszewski <steev@kali.org> wrote:
>
>
> On 7/10/20 9:47 AM, Doug Anderson wrote:
> > Hi,
> >
> >
> > But should I continue on this path,
> > It's probably worth getting dithering working on your sdm845 anyway in
> > case anyone actually does put a 6bpp panel on this SoC.
> >
> >
> >> or should we be finding others who
> >> have an N61 and see what their EDID reports?
> > I have an email out to BOE, but it might take a little while to get a
> > response.  I'll see what they say.  If they say that the panel
> > actually supports 8bpp then it's a no-brainer and we should just
> > switch to 8bpp and be done.
> >
> > ...but if they say it's a 6bpp panel that has its own dither logic
> > then it gets more complicated.  Initially one would think there should
> > be very little downside in defining the panel as an 8bpp panel and
> > calling it done.  ...except that it conflicts with some other work
> > that I have in progress.  :-P  Specifically if you treat the panel as
> > 6bpp and then reduce the blanking a tiny bit you can actually save 75
> > mW of total system power on my board (probably similar on your board
> > since you have the same bridge chip).  You can see a patch to do that
> > here:
> >
> > https://crrev.com/c/2276384
> >
> > ...so I'm hoping to get some clarity from BOE both on the true bits
> > per pixel and whether my proposed timings are valid before moving
> > forward.  Is that OK?
> >
> >
> > -Doug
>
>
> It's fine by me - testing Rob's suggestion of changing
> MAX_HDISPLAY_SPLIT 1080->1920 along with the change to adding IS_SDM845
> does give me a full screen that looks nicer, I'm fine with using the
> hack locally until a proper solution is found.  And I'm always a fan of
> using less power on a laptop.
>
>
> I'll give the patch a spin here if you want as well.
>
>
> Hopefully BOE gets back to you soon, and there's no rush, I'm just an
> end user who is extremely appreciative of all the work everyone on the
> list and the kernel in general put in to make my machines usable.

Just FYI that I got confirmation that the panel is truly 6 bpp but it
will do FRC dithering if given an 8 bpp input.  That means that you
should be getting just as good picture quality (and possibly more
tunable) by using the dithering in the display pipeline and leaving
the panel as 6bpp.  Thus I'm going to assume that's the route we'll go
down.  If ever we find someone that wants to use this panel on a
display controller that can't do its own dithering then I guess we'll
have to figure out what to do then...

In terms of the more optimal pixel clock for saving power, my proposal
is still being analyzed and I'll report back when I hear more.  I'm
seeing if BOE can confirm that my proposal will work both for my panel
(the -n62 variant) and the one you have (the -n61 variant).

-Doug
