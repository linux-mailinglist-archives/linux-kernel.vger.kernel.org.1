Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A98B275E98
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 19:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgIWR1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 13:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgIWR1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 13:27:42 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92609C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 10:27:41 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id t16so586533edw.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 10:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anholt-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d6g3455a1ScXUcd3tlYPR8Jrde6qF+MAZeft9+wDWRA=;
        b=hu1UKjWI/j63BvQfyfhnjAt2MIGqGjhgOYGhUlIK/c5GtE/t6U0bB63jEklyVsiEVK
         QvYvmlIZ8R7ZUEW5yefPR5rCmjnDrJ3PRjQq3rGKBAhEgOiMQ2lnFxBKH+DJOEJeU5TY
         86AhQykHhXwNxla1e7leyKsS/K/+yyzpKR782c6UWn3RmAsnjglghfsKOgYT+pO7pY1u
         XSW/8h4gG6vxtRgg6xoGr0i2GyPHWzQFzkAVqBmdLJMfaxhrKUJ5FfzqyHPKXiRD5hrw
         +TFnK7HvyPmaLgDg0YIpah+LgYEwf7X5VSWvWKcEA+6IkAaIM+8rDPdfS12WT1j+biQC
         MxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d6g3455a1ScXUcd3tlYPR8Jrde6qF+MAZeft9+wDWRA=;
        b=A6neJB9744rZTbb9fdoxmT5NMgeHus/i+2uWuKzCGnsFoKMT+fWGmfC9dpIQ/2wGvU
         LjLd7qGv8Iult9niEcApDsSFQyrJISMFZoLARBTLfh/87HkFYGSTwOi3+RtU15VqePSR
         8inOitA8c9mEavJaiqYotLhHhnvkwjUQlnS2qs59oGAxXf7n9UkwXYZ7So5pE3QdVs+/
         hzwQ1TuE2TK0q0COkX7dxtyB0guICXxWXw81kTAkud5tXrdQPixMC+8mdIjas2t2UikH
         RpA6AsUE6G2486ZrZNiFcJ1/1hyec4m3GBjQHq4F5/gTzLjMwnhx9mHmiHhv5Lq+7upg
         zBlw==
X-Gm-Message-State: AOAM5303qHZq1Nys5Zf9iADp3Y6yoYh281PFBZfBzgqjq1EyAech1dtc
        j9kY8tiabupVTxgaN+9GS6JrhaqgnBHEE8sViYMn0Q==
X-Google-Smtp-Source: ABdhPJwOTvYnWv6mTh5YpDJfYxsxrb5ts1bwRu37E6frcI1J1gT5JzJQ1OeOxJYtayHtad2amfiBfqNoPXP6jSiHTiA=
X-Received: by 2002:aa7:db47:: with SMTP id n7mr362463edt.315.1600882060116;
 Wed, 23 Sep 2020 10:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <1600774764-50332-1-git-send-email-liheng40@huawei.com> <CAPY8ntCnsD=LfqxSG-HrkY1ZjUPSaXbGKC=nc4Xkc7a+a7jF3w@mail.gmail.com>
In-Reply-To: <CAPY8ntCnsD=LfqxSG-HrkY1ZjUPSaXbGKC=nc4Xkc7a+a7jF3w@mail.gmail.com>
From:   Eric Anholt <eric@anholt.net>
Date:   Wed, 23 Sep 2020 10:27:29 -0700
Message-ID: <CADaigPWBgjRPq54_swpEmvHxPB0mY-FdzJpbeWO+1O23BV_zwg@mail.gmail.com>
Subject: Re: [PATCH -next] drm/v3d: Remove set but not used variable
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     Li Heng <liheng40@huawei.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 6:13 AM Dave Stevenson
<dave.stevenson@raspberrypi.com> wrote:
>
> Hi
>
> On Wed, 23 Sep 2020 at 08:53, Li Heng <liheng40@huawei.com> wrote:
> >
> > This addresses the following gcc warning with "make W=3D1":
> >
> > drivers/gpu/drm/v3d/v3d_drv.c:73:32: warning:
> > =E2=80=98v3d_v3d_pm_ops=E2=80=99 defined but not used [-Wunused-const-v=
ariable=3D]
> >
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Li Heng <liheng40@huawei.com>
> > ---
> >  drivers/gpu/drm/v3d/v3d_drv.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_dr=
v.c
> > index 9f7c261..05140db 100644
> > --- a/drivers/gpu/drm/v3d/v3d_drv.c
> > +++ b/drivers/gpu/drm/v3d/v3d_drv.c
> > @@ -70,10 +70,6 @@ static int v3d_runtime_resume(struct device *dev)
> >  }
> >  #endif
> >
> > -static const struct dev_pm_ops v3d_v3d_pm_ops =3D {
> > -       SET_RUNTIME_PM_OPS(v3d_runtime_suspend, v3d_runtime_resume, NUL=
L)
> > -};
> > -
>
> This looks to be the wrong approach, and I think a patch has got
> dropped somewhere.
>
> On our Raspberry Pi downstream vendor tree we have a patch [1] from
> Eric that renames v3d_v3d_pm_ops to v3d_pm_ops (don't need the
> duplicated suffix), and adds it to v3d_platform_driver. Why that never
> made it through the mainline trees I don't know.
>
> Eric: How good's your memory on this one?

The RPM stuff ended up abandoned because I didn't have any support in
debugging the power domain driver and I punted for a downstream hack.
We should at least be using these ops, though.
