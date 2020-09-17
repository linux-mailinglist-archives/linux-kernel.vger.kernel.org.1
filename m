Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE4E26DFEC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 17:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgIQPn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 11:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbgIQPm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 11:42:59 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD69C061788
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 08:35:55 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o5so2542902wrn.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 08:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=++KjjTeArkQUc6wTWp+OUexd5LFyCKXsX9i3O0Psxsg=;
        b=vdIO7GRao1HIL7dDL5HmL7RgluYPLILqZijreSW8tI3heqpGROlE+g6JUvU8DgkyI9
         6TRbJxmXdMuRcFA82d8pXd3KqM5j7x2k4VF0otEj9YS8sStZ7NYi+9Zhc46FRaWdD2gP
         llkuK1ntu1GYTTlMyHPBP+HH4EzCrXnUtvklzb/PDqkmGQK4RyS4zghJkgC3we2Ld0xW
         jUaxfCxYoyvRH/QdaHFxPor/58NzsYJaCw+Sm/AAhgw5/45wT+GtzNqM9qHorCwBDDTd
         X+9CHr8U+PSeNMkaTn818RIsLuEevjd+mUn/9eGfmspJogTLkgloJG3WI9TZB94qfhGC
         B+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=++KjjTeArkQUc6wTWp+OUexd5LFyCKXsX9i3O0Psxsg=;
        b=Lfor3WZGcuM9Shm6F5QMQKMEKTxvXmmJwkhfsEdCZmBR3hBqOBC5FZmyJjHbzc86PY
         +/98FkwnweN2c45Begm1pOTB7PwQhqAwsyz/1C8ZkJZBP5j4RZz0xYrzeYaheWAvFJvz
         5wKZZ2rGDI3zMOwwH1oTts9YOjPzQycD9amoaDnpOfvRjUgKPONAYilFmFcNaZKxXl79
         fgvsG0uk8ArXm4VBuDOuotW7BNXmRl2YiTlb+CDAzaG041y/VhfU6IFG9pZuuhRvW7XG
         j0wpSS/uaKIrJohwpRHSnN/qQRxMJ0AIJ+apJgn0LzJRkF6RJWAfPxco+H71gCsvp20r
         kfOQ==
X-Gm-Message-State: AOAM531XvYYHvfIFGSaQfSUdd5TJqLZDPrTfx5ot4QeBr0ovNY6VA1by
        TeXIHCvE4jma3srCRw2BJje4coYTAX/MFnsIw5Q=
X-Google-Smtp-Source: ABdhPJx+y5u32oEgAaxgCr4+qkhtdjMNEjLzBX2Y42T5/J7OajS6cvRPu2WGqZQFekeAyY44eKuWJ6ETVkhNYfMPRQs=
X-Received: by 2002:adf:dd82:: with SMTP id x2mr34902393wrl.419.1600356954497;
 Thu, 17 Sep 2020 08:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200917034610.21703-1-dawning.pang@gmail.com> <e4ac75c6-ce1f-7d4e-9402-82f499392521@amd.com>
In-Reply-To: <e4ac75c6-ce1f-7d4e-9402-82f499392521@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 17 Sep 2020 11:35:43 -0400
Message-ID: <CADnq5_N4S9gOGPcgUzdkyF2svD3_4bxMyB=k9Px_ddyT-q3RTA@mail.gmail.com>
Subject: Re: [PATCH v1] powerplay:hwmgr - modify the return value
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Xiaoliang Pang <dawning.pang@gmail.com>,
        "Quan, Evan" <evan.quan@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kenneth Feng <kenneth.feng@amd.com>,
        zhengbin <zhengbin13@huawei.com>, pelle@vangils.xyz,
        Yintian Tao <yttao@amd.com>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Nirmoy Das <nirmoy.das@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Eric Huang <JinHuiEric.Huang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 4:28 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 17.09.20 um 05:46 schrieb Xiaoliang Pang:
> > modify the return value is -EINVAL
>
> Maybe better write something like "The correct return value should be
> -EINVAL." With that done feel free to add my acked-by.

Applied with updated commit message.

Thanks!

Alex


>
> Christian.
>
> >
> > Fixes: f83a9991648bb("drm/amd/powerplay: add Vega10 powerplay support (=
v5)")
> > Fixes: 2cac05dee6e30("drm/amd/powerplay: add the hw manager for vega12 =
(v4)")
> > Cc: Eric Huang <JinHuiEric.Huang@amd.com>
> > Cc: Evan Quan <evan.quan@amd.com>
> > Signed-off-by: Xiaoliang Pang <dawning.pang@gmail.com>
> > ---
> >   drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 2 +-
> >   drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drive=
rs/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> > index c378a000c934..7eada3098ffc 100644
> > --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> > +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> > @@ -4659,7 +4659,7 @@ static int vega10_display_configuration_changed_t=
ask(struct pp_hwmgr *hwmgr)
> >       if ((data->water_marks_bitmap & WaterMarksExist) &&
> >                       !(data->water_marks_bitmap & WaterMarksLoaded)) {
> >               result =3D smum_smc_table_manager(hwmgr, (uint8_t *)wm_ta=
ble, WMTABLE, false);
> > -             PP_ASSERT_WITH_CODE(result, "Failed to update WMTABLE!", =
return EINVAL);
> > +             PP_ASSERT_WITH_CODE(result, "Failed to update WMTABLE!", =
return -EINVAL);
> >               data->water_marks_bitmap |=3D WaterMarksLoaded;
> >       }
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c b/drive=
rs/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
> > index a678a67f1c0d..04da52cea824 100644
> > --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
> > +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
> > @@ -2390,7 +2390,7 @@ static int vega12_display_configuration_changed_t=
ask(struct pp_hwmgr *hwmgr)
> >                       !(data->water_marks_bitmap & WaterMarksLoaded)) {
> >               result =3D smum_smc_table_manager(hwmgr,
> >                                               (uint8_t *)wm_table, TABL=
E_WATERMARKS, false);
> > -             PP_ASSERT_WITH_CODE(result, "Failed to update WMTABLE!", =
return EINVAL);
> > +             PP_ASSERT_WITH_CODE(result, "Failed to update WMTABLE!", =
return -EINVAL);
> >               data->water_marks_bitmap |=3D WaterMarksLoaded;
> >       }
> >
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
