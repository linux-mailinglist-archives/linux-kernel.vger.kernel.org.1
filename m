Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB68D2A0CB8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 18:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbgJ3Rpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 13:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgJ3Rpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 13:45:35 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8EBC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 10:45:35 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c16so3704736wmd.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 10:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7wEr5Dqk9C4lrCpsWhhhfQP1Jc/kVZd8qfNomT6z69M=;
        b=T8d3YMICnoOKnXtEbbghVhWKZ3yII6mafp3clEg+DIdgIUQRAwj4kzKL0tre+6nw/f
         P4jUgaU8fsaBbltL+Q1ci2XXkWPGsakMLHbbjwrKwN4Zh7ViAtGUNvSzKywMXWLIzjuq
         mVxIB8NwhsFaBbBYf/LxfcTQ1ivXoeuRdeegUICZiUkmqGgqqTg5RK0ZZ6MKdI5PnVPc
         YrhEGoTLkCdH9GIdbVHzGXfOpZ4Qm7qwgstPrVdNzr5BazWxSEBdlUmH7WzzoQymseiP
         5MgRBnCWszu7096iYogx0VoVjRsGXZKE/HctieslL/ekoB3W8FZ2dXqAmUQkkhLcJsgU
         YZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7wEr5Dqk9C4lrCpsWhhhfQP1Jc/kVZd8qfNomT6z69M=;
        b=kEqYjfs+NdOZIfpnCe3+1s6oyRdL5htuHr0wUWtgkkbuaWSi6WZxNFq4Ep/z3Y3yEC
         yHmd58zNVoaZ1bdzzlsXs/Tru0vf1d1hdvlfANYwDISyAz7nsfORZDIhwtbXn7awaieT
         HnYS/mf6A9/svCvgrkTz1FAH/2T2xRwlj1v/9lHjfJ4XyUNbAtsVqDtAfy4afEJVsOXP
         W/PEmRrvWbsMRVRQuPqk1i+ejgBRhP3BsQNOHHISBRGlnVu0UcPBnt8Wummz27n7sxUz
         yzoVOuOVpaL3AHm7F4W6CVGBU09iuOBeImDzsMw0WXt9NbTJnRfbpec/UfxcD6Nw/K8S
         BYcQ==
X-Gm-Message-State: AOAM530Cw10TmWataWdyVKN8bZtHAM2fMEZH99Rk/LKMUA/jo5g394gy
        1SjULt+xBgHjC6wbgxW0QeKfU6KNZu78ZAQ51OM=
X-Google-Smtp-Source: ABdhPJx1luv8bnwT4cFNgdaMqCEsZE0R3sacZyY6hfrZF4GCZ5YjXyQrEGKpGUN7aUFYxC9FNLlIrJooPNw35YhoBMs=
X-Received: by 2002:a1c:6302:: with SMTP id x2mr4030775wmb.56.1604079934351;
 Fri, 30 Oct 2020 10:45:34 -0700 (PDT)
MIME-Version: 1.0
References: <20201026210039.3884312-1-arnd@kernel.org> <20201026210039.3884312-4-arnd@kernel.org>
 <CADnq5_MdJt02hpdTsvPDVwN4_1D7-1ybDexDreL6GjDipc_Yvw@mail.gmail.com> <c5335426-c19a-c174-40a9-a012711cdf0b@amd.com>
In-Reply-To: <c5335426-c19a-c174-40a9-a012711cdf0b@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 30 Oct 2020 13:45:22 -0400
Message-ID: <CADnq5_MNuPuUPvSfHTqL2icZgAV11q7zgcgDhLB3Q1hyd+r7nw@mail.gmail.com>
Subject: Re: [PATCH 4/5] drm/amdgpu: fix build_coefficients() argument
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Anthony Koo <Anthony.Koo@amd.com>,
        Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
        Lewis Huang <Lewis.Huang@amd.com>, Aric Cyr <Aric.Cyr@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Denis Efremov <efremov@linux.com>,
        Reza Amini <Reza.Amini@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Josip Pavic <Josip.Pavic@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Fri, Oct 30, 2020 at 1:04 PM Harry Wentland <harry.wentland@amd.com> wro=
te:
>
>
>
> On 2020-10-29 11:53 p.m., Alex Deucher wrote:
> > On Mon, Oct 26, 2020 at 5:01 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >>
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>
> >> gcc -Wextra warns about a function taking an enum argument
> >> being called with a bool:
> >>
> >> drivers/gpu/drm/amd/amdgpu/../display/modules/color/color_gamma.c: In =
function 'apply_degamma_for_user_regamma':
> >> drivers/gpu/drm/amd/amdgpu/../display/modules/color/color_gamma.c:1617=
:29: warning: implicit conversion from 'enum <anonymous>' to 'enum dc_trans=
fer_func_predefined' [-Wenum-conversion]
> >>   1617 |  build_coefficients(&coeff, true);
> >>
> >> It appears that a patch was added using the old calling conventions
> >> after the type was changed, and the value should actually be 0
> >> (TRANSFER_FUNCTION_SRGB) here instead of 1 (true).
> >
> > This looks correct to me.  Harry, Leo?
> >
>
> Confirmed with Kruno, this is correct.
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > Alex
> >
> >
> >>
> >> Fixes: 55a01d4023ce ("drm/amd/display: Add user_regamma to color modul=
e")
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> ---
> >>   drivers/gpu/drm/amd/display/modules/color/color_gamma.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b=
/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
> >> index b8695660b480..09bc2c249e1a 100644
> >> --- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
> >> +++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
> >> @@ -1614,7 +1614,7 @@ static void apply_degamma_for_user_regamma(struc=
t pwl_float_data_ex *rgb_regamma
> >>          struct pwl_float_data_ex *rgb =3D rgb_regamma;
> >>          const struct hw_x_point *coord_x =3D coordinates_x;
> >>
> >> -       build_coefficients(&coeff, true);
> >> +       build_coefficients(&coeff, TRANSFER_FUNCTION_SRGB);
> >>
> >>          i =3D 0;
> >>          while (i !=3D hw_points_num + 1) {
> >> --
> >> 2.27.0
> >>
> >> _______________________________________________
> >> amd-gfx mailing list
> >> amd-gfx@lists.freedesktop.org
> >> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fli=
sts.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Char=
ry.wentland%40amd.com%7C3b50cfb318a04e2708e308d87c875c07%7C3dd8961fe4884e60=
8e11a82d994e183d%7C0%7C0%7C637396268091128887%7CUnknown%7CTWFpbGZsb3d8eyJWI=
joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sd=
ata=3DQGijLrlFTXI3xx2sGx1iNczHBezfWdu%2FP2xkfoq%2FMB0%3D&amp;reserved=3D0
