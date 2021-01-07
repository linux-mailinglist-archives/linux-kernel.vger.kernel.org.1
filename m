Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5E52ECBE4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 09:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbhAGIud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 03:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbhAGIud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 03:50:33 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD03AC0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 00:49:52 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id y21so2026168uag.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 00:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=30GZdV6yoZTjN43UUf8O6lUN7KtKnrac+ulwk7uWls4=;
        b=GiCjAe7ft9jSLyjN1BGwf4PaudJDU7KZ42niY+wmkRHQVtqecDJaNwFCIUBe4R4rHt
         Vg3DtlmutWOSt87PgWrRapf9Le7H1YSmZinxozgcevt+7HEYJi14kAmRvWO2RBPMzRRW
         /EPVC7c5U/G6FJQt1X4rUwlgFrj/a9ffb96xE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=30GZdV6yoZTjN43UUf8O6lUN7KtKnrac+ulwk7uWls4=;
        b=oajEjp4WYwKzRI2Xu2JaSludemTEHcNV9V751hiKgyatkcqulj8xt7q+I9G2fm1JPI
         DiVasRgSnvIZAFkE5CeqionpNDc/ZPNfRJ+sBYWk8l4PYdjMliD/WK6d2bgxB3fX8SBT
         BBw6Dc9oxU3bpPNanHz7nkS2erE7AUWGaEQcqewbCpnU0n1RdgnBqOnFD/NqDjHk/uEu
         5LFzqwyuL8l0ruPJK1VRNoxOGFNvG9SF5b6KARGknZnvvQNxhWBdKLVhVPszymhrhZKj
         2/4mUqJoU8woPl5JMiB7nHaGfJlZ2JYea4nbOgksVFJpNS7KATdHATcYm8BmQQ7NtZXB
         252Q==
X-Gm-Message-State: AOAM531RkOLpAJiRwASG3Xj+e7C+Iq/r3ATFwHGWZGS1dfkSlfcqbLrK
        efZuYiN88erj5GCsLBbVtbM0Ko6CfBpRG+rOGl32yQ==
X-Google-Smtp-Source: ABdhPJzL1oFMG34f0SDGnJBCPatm0Dzl8SNmJQzSFw+e0Pd//cfRkKuxMWxZ3x0IbqcHCO8QiSYTwjFvSP7CTHEdI6E=
X-Received: by 2002:ab0:3894:: with SMTP id z20mr6702320uav.82.1610009392004;
 Thu, 07 Jan 2021 00:49:52 -0800 (PST)
MIME-Version: 1.0
References: <20210107082653.3519337-1-drinkcat@chromium.org>
 <20210107162632.v7.3.I3af068abe30c9c85cabc4486385c52e56527a509@changeid> <a1367c40-7c30-95c2-0c7f-7eec58f04b9e@collabora.com>
In-Reply-To: <a1367c40-7c30-95c2-0c7f-7eec58f04b9e@collabora.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 7 Jan 2021 16:49:41 +0800
Message-ID: <CANMq1KDXomm4X8vyDPCHRy_KmHuqdschOhWRjiaR1Zzb6Rs8Pw@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] drm/panfrost: devfreq: Disable devfreq when
 num_supplies > 1
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Kristian Kristensen <hoegsberg@chromium.org>,
        Fei Shao <fshao@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 4:31 PM Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
>
> On 1/7/21 9:26 AM, Nicolas Boichat wrote:
> > GPUs with more than a single regulator (e.g. G72 on MT8183) will
> > require platform-specific handling, disable devfreq for now.
> >
> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > ---
> >
> > Changes in v7:
> >   - Fix GPU ID in commit message
> >
> > Changes in v6:
> >   - New change
> >
> >   drivers/gpu/drm/panfrost/panfrost_devfreq.c | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> > index f44d28fad085..1f49043aae73 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> > @@ -92,6 +92,15 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
> >       struct thermal_cooling_device *cooling;
> >       struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
> >
> > +     if (pfdev->comp->num_supplies > 1) {
> > +             /*
> > +              * GPUs with more than 1 supply require platform-specific handling:
> > +              * continue without devfreq
> > +              */
> > +             DRM_DEV_ERROR(dev, "More than 1 supply is not supported yet\n");
>
> Should this be info instead?

Sure, will fix in v8.

>
> Regards,
>
> Tomeu
>
> > +             return 0;
> > +     }
> > +
> >       opp_table = dev_pm_opp_set_regulators(dev, pfdev->comp->supply_names,
> >                                             pfdev->comp->num_supplies);
> >       if (IS_ERR(opp_table)) {
> >
