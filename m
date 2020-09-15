Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51EE926ADFA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgIOTsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 15:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbgIOTrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:47:09 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3916C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 12:47:07 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x23so621761wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 12:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8+w8MCZQVwLOcsa3UrmLYJYKtPwxj8ft1SlgJbNyeA8=;
        b=JPTHDc7rYypOSzSp9W0qxKhrmv41dRTmrYY14fVmDhwlD3/oajrz9G9KpUZo079VL7
         44ro9qC0vm+IFhW6kvfynC5gW5sZOVFn62xnR0MW2kRWXOgTXsONiaLKWQw2TvM74oN0
         bddr5mBHqv6u2Fwi4BxoXGT3pTGY7CZFqETQHqzzqDe0M4sBgKsPKLGUavapLbB/uG0J
         QscIdNzW1iPSM/Ew+iCZwez5CSOGmDPkc+fFT3SuzOV1wCenDCuzVtofmYTFwvSdX7Fk
         jEvvloxSTgv5Ggd6z1QPAYR7sjJjpf29BVYSGtfbpECtVKit9tZtJgfIxyD25NoET+HC
         Klnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8+w8MCZQVwLOcsa3UrmLYJYKtPwxj8ft1SlgJbNyeA8=;
        b=OHvaBmLsedRbVvCAIgL+4BBkC3iJF8nXX9T1Md9/LbO0GyrqRcOshhsY1deDGbF/ei
         rYOhJmvih0u7aprMNcT1HVbVLn4AbOHBbhFR4dfikpTEBHwmiq5g4+EXUx2ATqzS6+a0
         HZ2xjs9kCjuu8Fo4FPUHoO7gL1SWZSSFiWf5vGeg0+nGS4iNyz+6B6852+eosQFmREce
         QRZ4Jp5Coa5ojSUYttVkR37DNXdU5vtPipT+fC1qaZuB7TqwvSf8hTH311bRo1B3yQ8i
         iUH+DbBNKPMIGNNQcxEbBCcVTzs7ozhq/1NpYZP9uslAnB2ifJJg59De7eCfWhwj0OZg
         JcgQ==
X-Gm-Message-State: AOAM531Dv9IduKoNynUUwxTHzCGOp3PzbgbguvWYggrTccANjojdT8tF
        z1G4LWTAfPhBfMfpFoneJTZ9NhEfVRXLm2jVni8=
X-Google-Smtp-Source: ABdhPJx6Ivzd0nNSmmhbl1IKKhrcmi1LfG3GKuvvOAz6Uz7/Pbfr0luVZDBYbgMVE1u+QTxYjK6nyw1fk30RGkoVDDs=
X-Received: by 2002:a7b:c141:: with SMTP id z1mr953211wmi.79.1600199226000;
 Tue, 15 Sep 2020 12:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200910031352.39992-1-yuehaibing@huawei.com> <dcdc327c-c0d1-85cb-28fa-5b7cb5d4e555@amd.com>
In-Reply-To: <dcdc327c-c0d1-85cb-28fa-5b7cb5d4e555@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 15 Sep 2020 15:46:54 -0400
Message-ID: <CADnq5_O4zWOoWu5HggTJNhqLCgasX-BerJKzd9UgrL3s09R6nA@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: Create trigger_hotplug entry
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Lipski, Mikita" <mikita.lipski@amd.com>,
        Eryk Brol <eryk.brol@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Sep 10, 2020 at 11:35 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2020-09-09 11:13 p.m., YueHaibing wrote:
> > Add trigger_hotplug debugfs entry.
> >
> > Fixes: 6f77b2ac6280 ("drm/amd/display: Add connector HPD trigger debugfs entry")
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> > index 94fcb086154c..83da24aced45 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> > @@ -2098,6 +2098,7 @@ static const struct {
> >       const struct file_operations *fops;
> >   } dp_debugfs_entries[] = {
> >               {"link_settings", &dp_link_settings_debugfs_fops},
> > +             {"trigger_hotplug", &dp_trigger_hotplug_debugfs_fops},
> >               {"phy_settings", &dp_phy_settings_debugfs_fop},
> >               {"test_pattern", &dp_phy_test_pattern_fops},
> >   #ifdef CONFIG_DRM_AMD_DC_HDCP
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
