Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7DF2CAC9D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 20:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbgLATmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 14:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgLATmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 14:42:06 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A77C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 11:41:26 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id y74so3029309oia.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 11:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ceg6uRVcVSL9wT3YtP/QD1TGNQLWKegOeS5Bb86s4gI=;
        b=pCAWe+v9IIUAG+DZMgT2pr5/+Ty924IWTrpYsnjDlfg9BTcGw7wzxEcvziDSIa3qJx
         IpEs2d5GYDTYCzmXVsJKPlMIayD08Nqv0faiea3YOy6Syd3RmYHr6z3i+mkTW2TdhVj9
         yzJgr/XSCd20IAaS/KD8f3kTzI4KDlxDpl3w8L8TIdGX9nPDPE9hWt7R79hx/7uMib+6
         hK9oXprGTJ6gmpYo8PGwSSukW+oSr2VUSQRFxJG7S2J8rLt3JpD34yQRrGsSo+l4pM19
         FjmYxQfBJ1kMFRIYnaKkJPSnsfUz+r33fmJwhTd/RP2/dC0V5Hirlh0rxTeYpUSeS68X
         0IXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ceg6uRVcVSL9wT3YtP/QD1TGNQLWKegOeS5Bb86s4gI=;
        b=EnsCgolASz6LEpvDzKEnO6QcHsHF3onbmtqbkRswM8TE95QCnGEBmjJ6ls23BxTASv
         eZCwIq+Uyptmkwtv4RJl2EpoROtIJ/T5fyL7FnyyTenWbjbRl0mlkOoB0Uz42kM8m65S
         UxPqElwy3liJ1cHKArWgogagjCyb6lfJB09GtvzRNPfmeJnDCD9PHKuYFhGcmIA9OZYn
         0VLmVzBnTnvRDil/a79yBjMS8tAYkpe9Q9DNVGWxG6p4636TADRWP3sMu/faU74ML2Fp
         csxIh633I5aqmYb78svOz3aWorc6vvEaEko08GSgzp8LxfiyyIPDqTVLzk6oknUMnOK/
         Dxfg==
X-Gm-Message-State: AOAM533X0Q74my9KZGtPVnx9XWKM75tws5zAf/JMzxGrdlQFxXnFbTS0
        OblwcbdozfwD57C5rqCnyfIkXkvDRDT59ENnDFM=
X-Google-Smtp-Source: ABdhPJzaUYRENbRF5AjUOGhsw16kD7TwgpunPbwNMQzGnEtx23qMxG6NhsbK1kDo1mmu5rtvUqg3kfZ9FtIzfxH9q7I=
X-Received: by 2002:a54:4608:: with SMTP id p8mr2790019oip.5.1606851685414;
 Tue, 01 Dec 2020 11:41:25 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org>
 <20201126134240.3214176-35-lee.jones@linaro.org> <CADnq5_On90z1w=_usmjA7kHFVig3uHg4VJRecDraYZv8cmRAUQ@mail.gmail.com>
 <b5050f44-9542-2ae3-c019-c9821f978cc8@amd.com>
In-Reply-To: <b5050f44-9542-2ae3-c019-c9821f978cc8@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 1 Dec 2020 14:41:14 -0500
Message-ID: <CADnq5_PtbAeAxsxHB4=gYf2=Gqc=vQTz5oRpTiwzaAFkpuC5AQ@mail.gmail.com>
Subject: Re: [PATCH 34/40] drm/amd/display/amdgpu_dm/amdgpu_dm_helpers: Use
 'gnu_printf' format notation
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Leo Li <sunpeng.li@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 1:59 PM Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
> Am 01.12.20 um 19:42 schrieb Alex Deucher:
> > On Thu, Nov 26, 2020 at 8:44 AM Lee Jones <lee.jones@linaro.org> wrote:
> >> Fixes the following W=3D1 kernel build warning(s):
> >>
> >>   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.c:=
 In function =E2=80=98dm_dtn_log_append_v=E2=80=99:
> >>   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.c:=
345:2: warning: function =E2=80=98dm_dtn_log_append_v=E2=80=99 might be a c=
andidate for =E2=80=98gnu_printf=E2=80=99 format attribute [-Wsuggest-attri=
bute=3Dformat]
> >>   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.c:=
375:3: warning: function =E2=80=98dm_dtn_log_append_v=E2=80=99 might be a c=
andidate for =E2=80=98gnu_printf=E2=80=99 format attribute [-Wsuggest-attri=
bute=3Dformat]
> >>
> >> Cc: Harry Wentland <harry.wentland@amd.com>
> >> Cc: Leo Li <sunpeng.li@amd.com>
> >> Cc: Alex Deucher <alexander.deucher@amd.com>
> >> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> >> Cc: David Airlie <airlied@linux.ie>
> >> Cc: Daniel Vetter <daniel@ffwll.ch>
> >> Cc: amd-gfx@lists.freedesktop.org
> >> Cc: dri-devel@lists.freedesktop.org
> >> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >> ---
> >>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c=
 b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> >> index b7d7ec3ba00d7..24a81642baa26 100644
> >> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> >> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> >> @@ -318,6 +318,7 @@ void dm_dtn_log_begin(struct dc_context *ctx,
> >>          dm_dtn_log_append_v(ctx, log_ctx, "%s", msg);
> >>   }
> >>
> >> +__printf(3, 4)
> > Can you expand a bit on what this does?
>
> Been a while since I looked into something like this, but IIRC this
> means that parameter 3 (msg) is considered a printf format string and
> the types of parameter 4 and following checked against that.
>
> Looks correct to me.

Thanks.  Applied.

Alex


>
> Christian.
>
> >
> > Alex
> >
> >>   void dm_dtn_log_append_v(struct dc_context *ctx,
> >>          struct dc_log_buffer_ctx *log_ctx,
> >>          const char *msg, ...)
> >> --
> >> 2.25.1
> >>
> >> _______________________________________________
> >> dri-devel mailing list
> >> dri-devel@lists.freedesktop.org
> >> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fli=
sts.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel&amp;data=3D04%7C01%7Cc=
hristian.koenig%40amd.com%7C50bdbd2fb7a5400e91c008d89628d11c%7C3dd8961fe488=
4e608e11a82d994e183d%7C0%7C1%7C637424450053181783%7CUnknown%7CTWFpbGZsb3d8e=
yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&am=
p;sdata=3DafzSSu%2Fba0%2FQiwOameJRO5Sgs5joRPondWQx%2ByQZZlU%3D&amp;reserved=
=3D0
>
