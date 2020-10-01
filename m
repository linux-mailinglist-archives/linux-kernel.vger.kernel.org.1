Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB51E27FE4E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 13:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731977AbgJALZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 07:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731134AbgJALZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 07:25:16 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D719C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 04:25:16 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id n61so4955204ota.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 04:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=up+YfAa4hUEz2jauGbOGQupzqkFEIqP5miPRNKb6g88=;
        b=AVTt1tHvqiwpCn8ORfJ3ByfuaERKEB+VTJJVMRxSler0/mRZ/81hC2shW3JAG3KsP8
         E8u9Nzr6mVudbSqiKqFVv7BGJL7rKVBkWkNYVynnJMbzVpx0UczuVqS8yRzajY0HbTwA
         CAxQvocmUjBq8KWPNbJzrGa+aEnqrb+128m6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=up+YfAa4hUEz2jauGbOGQupzqkFEIqP5miPRNKb6g88=;
        b=e0Vqb9w1Zb5FBwDQ206ZGPP49aK1eDA/uEXpG/WaK8I4KGBgX7pyKH/2d1PcLFdAKi
         4b5xuO4EgJ96HK0LzwnEAhGu54L52GUN9XXpm/auyWKWqVQhVT+nMK6LPHZkaOArh5MI
         hNt1C3ADQbjvGsoLmvq6SdHQpLEqBywyY1Z39b8ghzDZYCFTVkcR1LWp771Ady8jdI+v
         yM+Pr4JLKvu/rt2o+u70JizTF1v1yueBmS3Vaw7cSsjtpeRFMOkUs5FNyLHaNmsvJQ3Z
         quZB2XNlI8umtgff2dwkOiG2DT2d9LT1awVCelMSkONHkTxyCVRJek81ETCEp0OB/lql
         /DOQ==
X-Gm-Message-State: AOAM531MxhJxVXPLJq/7SOp8D3/AgHSxNwL+4jOfRZPFjps8gUdYCG7X
        96n0/UGyDJgcnZ7yqIjQpfSvwLovWvFUUdGpqkaEBA==
X-Google-Smtp-Source: ABdhPJxPbL7LHeQL+k6gIy5NueiQXRMgOWTDIjglH6aXw9lY8zq0IMYSGJyw2kRbFhVw5K0r/VLucvhZmUE5VMcAKsM=
X-Received: by 2002:a9d:4b99:: with SMTP id k25mr4758628otf.281.1601551515453;
 Thu, 01 Oct 2020 04:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200921131021.91604-1-miaoqinglang@huawei.com> <8ae8a758-23ee-a413-5b25-b7beb8f4e254@arm.com>
In-Reply-To: <8ae8a758-23ee-a413-5b25-b7beb8f4e254@arm.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 1 Oct 2020 13:25:03 +0200
Message-ID: <CAKMK7uHQe3PBnNinaGn37s+Cgko1taKcCT3=Yy1uw63pRurOhw@mail.gmail.com>
Subject: Re: [PATCH -next] drm/panfrost: simplify the return expression of panfrost_devfreq_target()
To:     Steven Price <steven.price@arm.com>
Cc:     Qinglang Miao <miaoqinglang@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 1, 2020 at 12:58 PM Steven Price <steven.price@arm.com> wrote:
>
> On 21/09/2020 14:10, Qinglang Miao wrote:
> > Simplify the return expression.
> >
> > Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
>
> Reviewed-by: Steven Price <steven.price@arm.com>

As committer/maintainer for this please indicate whether you'll merge
this or not, with just an r-b patches are in an awkward limbo state.
Since Qinglang isn't committer you probably want to merge their
patches, for otherwise they get lost.
-Daniel
>
> > ---
> >   drivers/gpu/drm/panfrost/panfrost_devfreq.c | 7 +------
> >   1 file changed, 1 insertion(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> > index 8ab025d00..913eaa6d0 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> > @@ -29,18 +29,13 @@ static int panfrost_devfreq_target(struct device *dev, unsigned long *freq,
> >                                  u32 flags)
> >   {
> >       struct dev_pm_opp *opp;
> > -     int err;
> >
> >       opp = devfreq_recommended_opp(dev, freq, flags);
> >       if (IS_ERR(opp))
> >               return PTR_ERR(opp);
> >       dev_pm_opp_put(opp);
> >
> > -     err = dev_pm_opp_set_rate(dev, *freq);
> > -     if (err)
> > -             return err;
> > -
> > -     return 0;
> > +     return dev_pm_opp_set_rate(dev, *freq);
> >   }
> >
> >   static void panfrost_devfreq_reset(struct panfrost_devfreq *pfdevfreq)
> >
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
