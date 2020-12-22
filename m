Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695A02E0C74
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 16:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgLVPJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 10:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgLVPJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 10:09:14 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E31C0613D6;
        Tue, 22 Dec 2020 07:08:33 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id s75so15057007oih.1;
        Tue, 22 Dec 2020 07:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9iX58YMx8qY2LSjohdfZ3DU1IKC59lgYW43Efd3MkEI=;
        b=p1CZSIKxfXhHNUVOHLNAuoSWLjD2CRJNrxIzcW7j2SJxYk2YNkLEyF/IRbHKlfhLix
         Oj3dFbJACsvuBfeeSKwn6i3sgHpLoGJIlD9x1UN6wtBOKF3fPB8/ADH5clxzQu0GcoJb
         vPXZqhWWjYjEYvOD8UDoqremOPyKwbNAV6Y4uhf4H6tsppnZDPgUuUk3mIcIMWdcao3+
         7cGE7KAq9SN0xt3YGu6OQHqjWVNUKywvCkOOc+pBxXcYsuOZtkwBL0TFpsYW6LuL86qi
         CsRhb7Plhinl8Aqs07yyMz0sA323oS+Ik7DppPVpYgU6c/4+rO4chkYrQu5VVujqwACw
         d+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9iX58YMx8qY2LSjohdfZ3DU1IKC59lgYW43Efd3MkEI=;
        b=PoQW2D5Zy+GoVpDIfGqCWGpz69NKEwMZmCE8vyhudBAjBhBTZEIAeQZaL43MxAvHJT
         lC5wiJy62uCxUsURC80x7pTcSm63IENoTWpNep8VJ2H/p9kRVFeKoYnxzDpZtaH77ylK
         8Bl7RPTTydYEJNBKuaFOP1oo1AllsoIAXvpL1xZ6TPfbjxj/8q3dVoqexeKZ1Eio/krs
         buqNHIPHdbNo45VyXCGJ83by8OM7i6roNtW1zcsz6KH133FnOt4PISe3gGrBLWIvWxCe
         00uNd58TGBT5/k1cSzqPfU/sBdMhp9/se0kkMyC2VsuMJmyd6crYyHj8mnAIiLln7kPt
         +rmg==
X-Gm-Message-State: AOAM532+NGokgfiLRAVdB6fSO0I20CtIfYwUv+jQ7rff7E2wWCIrnI0Q
        4uUZ9sX7SXGARpD0gDPQOk3ukRP/g7LV+ZaFYNE=
X-Google-Smtp-Source: ABdhPJy19Ods0aRD/JDrJl5ZdgsTjfLu8fnSZO6MPFsqsu0ylwodKntXg6ma9XB4AnxVPc0aNvmdHonLoCQxKzOK2E8=
X-Received: by 2002:a54:4083:: with SMTP id i3mr14464839oii.120.1608649713481;
 Tue, 22 Dec 2020 07:08:33 -0800 (PST)
MIME-Version: 1.0
References: <98e71ee7-1eb9-ada8-a438-703be03e96d1@web.de>
In-Reply-To: <98e71ee7-1eb9-ada8-a438-703be03e96d1@web.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 22 Dec 2020 10:08:22 -0500
Message-ID: <CADnq5_PVm+04LqPJoQ6mPHf0YM6jEeR_Xh_Bkap7Nuw+Fo6sgw@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/amd/display: Adjustments for dc_create()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Alvin Lee <alvin.lee2@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>, Aric Cyr <aric.cyr@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Chiawen Huang <chiawen.huang@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Yongqiang Sun <yongqiang.sun@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 20, 2020 at 6:10 AM Markus Elfring <Markus.Elfring@web.de> wrote:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 19 Dec 2020 18:30:56 +0100
>
> Two update suggestions were taken into account
> from static source code analysis.
>

Applied.  Thanks!

Alex


> Markus Elfring (2):
>   Return directly after a failed kzalloc()
>   Use common error handling code
>
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
>
> --
> 2.29.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
