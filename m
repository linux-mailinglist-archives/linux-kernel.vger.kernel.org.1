Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D170C299809
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 21:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732531AbgJZUd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 16:33:28 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55961 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732481AbgJZUdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 16:33:19 -0400
Received: by mail-wm1-f67.google.com with SMTP id a72so12979159wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 13:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/O8B5tDsbMKoWPbr5etGrG3WN9TQf/YvulQxtm1JNqc=;
        b=fgGtA4dZkC7fJbJEp77T2zNmJPL+rQzgZ1HlLKVt9cz6ql8n6Ew8NtQxmH48a25heT
         lkDvFDx9tZgelHI68g+i3kcvouujmjmCv6AQVtHFRvt07YjyP2EZmGVBm8Wt56o2cORX
         wRO+5ZqpFhdG6Ac53AX7WPmPeLDNH2bucLyVDtdurw0THcKB7xgZ0qdUjmnAhov8y8E4
         xSEIBjkL944sHXH0benknMyN3QHAffKFDnglOwcPQUYcAr32JBvTBWqT/5UXf0dnsww+
         1f8kFHIKp3KuUV2ogMZyU++YgUpCB4zQs0wa7WvtqQBO+mf3QgBdjrAb2KkzSy3M9uJf
         0QwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/O8B5tDsbMKoWPbr5etGrG3WN9TQf/YvulQxtm1JNqc=;
        b=mHvnk73W01/gF2SXmyyWOvrbTdcJ6hWR9dRDmAaVFPf4V07MYhYL7MenIolnNjLsON
         loychQ9xVhW/YzJv76eI7oyO/xabryVEhtRvlUa15iYzuah9mbMxUBtpDTIKt6D4JHV1
         +beDpl4p60MJgIUQH/GJuMwbfL/omD1CYI46Bl2SUiIF5piKAKcWzEN+771w0i/9njrq
         FfZy6GwSCWrWLNQ9ay/wEAUDcBvO2zOja7SixypfThO3Eatbd7od4P3Tcu/o+tA1wNtU
         UL0Csjk5mYq7K9DprtRDCWVetbKbLX4mBwFOZn+xv/BSlnGGqQnMax0h7CrlvxVmhECT
         Lbkw==
X-Gm-Message-State: AOAM531Mr2qTgRwB66AyDeiFmbQY+TZiGi+QiR06K15Hyql+Osa1Jv08
        aRTMv2T5EKcdwNuV3TFngmy5mGew+7fWCZHeIII=
X-Google-Smtp-Source: ABdhPJwMDiAiLRKHlrvYhOBxCY24XJ9FgKn7gwnrmpvOmcovyvuheNcYl6kswwxOccE6N3E2mp6N1hUoQVyoAadJXtE=
X-Received: by 2002:a05:600c:25a:: with SMTP id 26mr17442752wmj.39.1603744397278;
 Mon, 26 Oct 2020 13:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201023074656.11855-1-tiwai@suse.de> <1d3e22ef-a301-f557-79ca-33d6520bb64e@amd.com>
 <CADnq5_OY8tRqs-bao9mkKxgcXC=305-_71U=04C5z9HM0+5MuQ@mail.gmail.com> <22ab9117-0281-2ff3-8328-d7780e353643@amd.com>
In-Reply-To: <22ab9117-0281-2ff3-8328-d7780e353643@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 26 Oct 2020 16:33:06 -0400
Message-ID: <CADnq5_NVPRpiOj+Cpzh1TM=2J-ym8xbKbxGc_hUL=4_j_MAo6A@mail.gmail.com>
Subject: Re: [PATCH 0/3] drm/amd/display: Fix kernel panic by breakpoint
To:     "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Cc:     Luben Tuikov <luben.tuikov@amd.com>, Takashi Iwai <tiwai@suse.de>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Oct 26, 2020 at 4:22 PM Kazlauskas, Nicholas
<nicholas.kazlauskas@amd.com> wrote:
>
> Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
>
> Looks fine to me. Feel free to apply.
>
> Regards,
> Nicholas Kazlauskas
>
> On 2020-10-26 3:34 p.m., Alex Deucher wrote:
> > Yes, looks good to me as well.  Series is:
> > Acked-by: Alex Deucher <alexander.deucher@amd.com>
> > I'll give the display guys a few more days to look this over, but if
> > there are no objections, I'll apply them.
> >
> > Thanks!
> >
> > Alex
> >
> > On Fri, Oct 23, 2020 at 7:16 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
> >>
> >> On 2020-10-23 03:46, Takashi Iwai wrote:
> >>> Hi,
> >>>
> >>> the amdgpu driver's ASSERT_CRITICAL() macro calls the
> >>> kgdb_breakpoing() even if no debug option is set, and this leads to a
> >>> kernel panic on distro kernels.  The first two patches are the
> >>> oneliner fixes for those, while the last one is the cleanup of those
> >>> debug macros.
> >>
> >> This looks like good work and solid. Hopefully it gets picked up.
> >>
> >> Regards,
> >> Luben
> >>
> >>>
> >>>
> >>> Takashi
> >>>
> >>> ===
> >>>
> >>> Takashi Iwai (3):
> >>>    drm/amd/display: Fix kernel panic by dal_gpio_open() error
> >>>    drm/amd/display: Don't invoke kgdb_breakpoint() unconditionally
> >>>    drm/amd/display: Clean up debug macros
> >>>
> >>>   drivers/gpu/drm/amd/display/Kconfig             |  1 +
> >>>   drivers/gpu/drm/amd/display/dc/gpio/gpio_base.c |  4 +--
> >>>   drivers/gpu/drm/amd/display/dc/os_types.h       | 33 +++++++++----------------
> >>>   3 files changed, 15 insertions(+), 23 deletions(-)
> >>>
> >>
> >> _______________________________________________
> >> amd-gfx mailing list
> >> amd-gfx@lists.freedesktop.org
> >> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >
>
