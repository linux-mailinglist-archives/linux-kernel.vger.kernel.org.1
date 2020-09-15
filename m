Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D3D26ADEB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgIOTpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 15:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbgIOToY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:44:24 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C6FC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 12:44:23 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c18so4527819wrm.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 12:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cc84912ps9QzBUrSER3j4GRi1EEaiC0ms1w3qlDFryQ=;
        b=aEQyiLWSOdLI4o7RIrCD77KLfP9RTLKwjeaNeEcI7p0ufgj6Cwg0oD/xgFdaGhYEeK
         teKZXHaAOcOo3CTdOaCNr4PUxQplO9fazQEU/d617gbFnAU7lVzHq9wnWNtakwC2b9G4
         CaBh6qEHyRCvuew+3cabF3oISRn4cepWn/+gmlYYwGHDPdSijPs45RdJs43GbthH7EHF
         J5Ez3dnqQcrxn79ysb3lfe4qGZQUM80N6Hfy0rbbJvOH1IyOkDx59k3tJrSTJNJ59BRE
         R3ExEmZ6iiRzrZ0jNdn3idP7zl/u3JbFLZUkMJfjzl9xZbh/+8328HvAJhp2+U9/JRep
         SYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cc84912ps9QzBUrSER3j4GRi1EEaiC0ms1w3qlDFryQ=;
        b=kAj/r3vuvwnEJrGgqCuPQBNkj9lU5I5W9csHHwP8G7M2hb24CrlYatjtN/CkphGwEk
         P+1EVap6vrDMUjJyNeO8HbnCb17OycCETcNHnr1fXrTs+g8tHtn4zXTUwvBDkiP4ZV/C
         mvS/dHDKhVOJDedn8QkMyrElojT1LpXr6UhVQasbEYt6aGIzU3RhL2ZJ3HEmY1x+v3JL
         6UpJIpK6Jp0hj9zu9Oh4e0sEQbTT/wTinM/EwsxDwppfw3ZUJoa9lCmlR2PEi4m76yXZ
         rt5HOd/ahZ9sbwj6MaP+yjYy8w+8zXwiYiOYrs7v0MtObOo+HF82Hxg+AMMJA0qo8zGa
         xunQ==
X-Gm-Message-State: AOAM532M7Y8IrKg2eBg29pTsdIDNmuuKUF0A5yeYdFYuemmW00it52RX
        pIQ31hhQXY9MdEVu+wDgGRbcuG50lQHQkBrpkDg=
X-Google-Smtp-Source: ABdhPJzOePrptUE3RAcwh0Ybv8+dGJ8Y7Ir6h24d+B4f9X84uHxDb5x1cF2UQnnahPWpshF4Qeh6SmHVUxzfyYLHFhk=
X-Received: by 2002:adf:dd82:: with SMTP id x2mr24399319wrl.419.1600199062537;
 Tue, 15 Sep 2020 12:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200910032636.27296-1-yuehaibing@huawei.com> <62c4312b-9e92-23bb-0823-7f1aca125c0f@amd.com>
In-Reply-To: <62c4312b-9e92-23bb-0823-7f1aca125c0f@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 15 Sep 2020 15:44:11 -0400
Message-ID: <CADnq5_OTqZFZ9urP+aUK+KNuvSpkNSM2m0E4=DZYn4d+uaTS2w@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: Fix possible memleak in dp_trigger_hotplug()
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

Applied.  Thanks,

Alex

On Thu, Sep 10, 2020 at 11:34 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2020-09-09 11:26 p.m., YueHaibing wrote:
> > If parse_write_buffer_into_params() fails, we should free
> > wr_buf before return.
> >
> > Fixes: 6f77b2ac6280 ("drm/amd/display: Add connector HPD trigger debugfs entry")
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> > index 83da24aced45..11e16fbe484d 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> > @@ -1089,8 +1089,10 @@ static ssize_t dp_trigger_hotplug(struct file *f, const char __user *buf,
> >       if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
> >                                               (long *)param, buf,
> >                                               max_param_num,
> > -                                             &param_nums))
> > +                                             &param_nums)) {
> > +             kfree(wr_buf);
> >               return -EINVAL;
> > +     }
> >
> >       if (param_nums <= 0) {
> >               DRM_DEBUG_DRIVER("user data not be read\n");
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
