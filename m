Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC9A2B3AD6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 01:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgKPAkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 19:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgKPAkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 19:40:25 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8DDC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 16:40:25 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id a3so22153544wmb.5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 16:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iL9lxpBrBrFPICBKOKFu8c0itrIvAktEk+HvGD/57WU=;
        b=RIBUgFVzIehyrerUMVA16aCP2pidbc5aHBjBh/R0UdHr4tzUDUwyVwEDiWGmBJz2JR
         n1+RBo6KMRoziyaeAaoyyY1iaJ0hedkMNJqDg/+SYNpElQcNqUvGuJeIay/+m2GU86XZ
         H2FA5WH+9NoW3pr4DeqFWY2anXbofCrwB6xVPsaMSVaSkqnt0LWV0mqE2dx2NfnXDVXo
         aeCJ6KBFYWCOy4mupN1DDZe39FCQg7RoqyvPRA8rVBOtPmDfqxWQjeUFLQ/hknhk96/T
         v/ok88YsX53eNponOjd3wodpteGjdhm7tj1Az46mPi19M03K3ws4oF7TYTb9V1FwBEJX
         4LZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iL9lxpBrBrFPICBKOKFu8c0itrIvAktEk+HvGD/57WU=;
        b=IDdEiTpEYURiIizeL3gGxdfJDAdGJEPvr5av+BSkqtfsyIk26iO3KQhWlcpatEe2Gy
         2822RJ5w7BmrYItVOqsseBKvTdHLqkm6hCAXHOI8up8SGgbmiNQbUSAthNeo4Xdy0jAY
         ApgRuQxFgZKNLlF/nwrxBW48inNTjiY7rgybIsSg4oxiiMgTuzhNecfEUBCjaYJs8mZt
         9OPpWzxc/OJY9BoI0ZfeNz7WPLT9jawNVX0uXS3nP4uIcp34wja3cbujzbnLI1lmvV5w
         Lm9B7WaY88QGJvh6m+RqfvE2bsHNhPspED3EjQ6/yQILlB7cirGc5Nv9eHAhXrv2fP2o
         wvgw==
X-Gm-Message-State: AOAM532+g3iwxK0aNbt+NfU0+u11OMjPvcCQWrIDULyRCjpTA5jfA/wg
        vNYkXsv9f/1fXdlWsBdggBQ/aqZ+0kvg1p1jgRc=
X-Google-Smtp-Source: ABdhPJy83h9RCKQuWB+fCby7aMfjpLzevqYvBLH0EU2YJjVvMX9zHGkCsE5gQWjMTmUuHJ5fqiIwHtXtzCM3WME/5Sc=
X-Received: by 2002:a1c:9ec9:: with SMTP id h192mr12679379wme.8.1605487223649;
 Sun, 15 Nov 2020 16:40:23 -0800 (PST)
MIME-Version: 1.0
References: <c995335d16d8b4b4ff47b1273869c33e14782b32.1603867405.git.viresh.kumar@linaro.org>
In-Reply-To: <c995335d16d8b4b4ff47b1273869c33e14782b32.1603867405.git.viresh.kumar@linaro.org>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Mon, 16 Nov 2020 08:40:12 +0800
Message-ID: <CAKGbVbumtz4qG186Eane+1JvoE2QfCCUMUEKcRCojX_sJhhKGw@mail.gmail.com>
Subject: Re: [PATCH V2 Resend 1/2] drm/lima: Unconditionally call dev_pm_opp_of_remove_table()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        freedreno@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        lima@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to drm-misc-next.

On Wed, Oct 28, 2020 at 2:44 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> dev_pm_opp_of_remove_table() doesn't report any errors when it fails to
> find the OPP table with error -ENODEV (i.e. OPP table not present for
> the device). And we can call dev_pm_opp_of_remove_table()
> unconditionally here.
>
> Reviewed-by: Qiang Yu <yuq825@gmail.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> ---
> V2: Applied Reviewed by tag.
> ---
>  drivers/gpu/drm/lima/lima_devfreq.c | 6 +-----
>  drivers/gpu/drm/lima/lima_devfreq.h | 1 -
>  2 files changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/lima/lima_devfreq.c b/drivers/gpu/drm/lima/lima_devfreq.c
> index bbe02817721b..cd290d866a04 100644
> --- a/drivers/gpu/drm/lima/lima_devfreq.c
> +++ b/drivers/gpu/drm/lima/lima_devfreq.c
> @@ -105,10 +105,7 @@ void lima_devfreq_fini(struct lima_device *ldev)
>                 devfreq->devfreq = NULL;
>         }
>
> -       if (devfreq->opp_of_table_added) {
> -               dev_pm_opp_of_remove_table(ldev->dev);
> -               devfreq->opp_of_table_added = false;
> -       }
> +       dev_pm_opp_of_remove_table(ldev->dev);
>
>         if (devfreq->regulators_opp_table) {
>                 dev_pm_opp_put_regulators(devfreq->regulators_opp_table);
> @@ -162,7 +159,6 @@ int lima_devfreq_init(struct lima_device *ldev)
>         ret = dev_pm_opp_of_add_table(dev);
>         if (ret)
>                 goto err_fini;
> -       ldevfreq->opp_of_table_added = true;
>
>         lima_devfreq_reset(ldevfreq);
>
> diff --git a/drivers/gpu/drm/lima/lima_devfreq.h b/drivers/gpu/drm/lima/lima_devfreq.h
> index 5eed2975a375..2d9b3008ce77 100644
> --- a/drivers/gpu/drm/lima/lima_devfreq.h
> +++ b/drivers/gpu/drm/lima/lima_devfreq.h
> @@ -18,7 +18,6 @@ struct lima_devfreq {
>         struct opp_table *clkname_opp_table;
>         struct opp_table *regulators_opp_table;
>         struct thermal_cooling_device *cooling;
> -       bool opp_of_table_added;
>
>         ktime_t busy_time;
>         ktime_t idle_time;
> --
> 2.25.0.rc1.19.g042ed3e048af
>
