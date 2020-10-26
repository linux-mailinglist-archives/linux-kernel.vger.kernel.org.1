Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF97299713
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 20:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784933AbgJZTek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 15:34:40 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55772 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1774611AbgJZTei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 15:34:38 -0400
Received: by mail-wm1-f67.google.com with SMTP id a72so12838642wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 12:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dt4AWesHgq95MuA9noAsqgwDvEHb5guDweoxzfn9TuQ=;
        b=ua/skFVpbRauDrk7eU647JocRmuulattFN3tamwpD1R3kDFDul1hutbRR/NHpZZ4TR
         QOi9sR0tej5ewSmtacJVK/RSoeta5RBfVfqvleriesi6pvhQp2yqoHNgM/2JLOD5xsSu
         SFwtCTo5TYmVdyL75EcYwQo+6ROk+p0Al8X+CWVAoWDkxgsC7Pgcj+Lk8j8IbN8W2eJ+
         uJn8gMZkGofT8ifLHiVV6l5SEiAp3MfwQmhnRswrc5p/tmX8M+Fkvqek1phdIvOxk02O
         uV3lIfkgbFdyVEimgrwM8H3TCHAjSfgPXgQZQmJKhuHSxbqX1ZVYFNLJhYQdm8ellHs0
         GdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dt4AWesHgq95MuA9noAsqgwDvEHb5guDweoxzfn9TuQ=;
        b=TEiz0eY9uraNi2NApze80TruV7m5M+E5rtpagBPmromYro5YpnrUeQue9eKUbYZAF9
         t1dkVnq+9wxKyjeRcHUiw2gB+/bmLI3LSU9x4PV63quMeSGOQjbsmL0jmEFSvHk6a4Vi
         QLXh5aySR6pR58hj1MeDFwopP0+6/jgWnmnieA/sp6vcCAX6GMtYnlHwifhWCzEUoEhQ
         bugTWQG7IjK7pZgi4RpCn8xOxFPIdLDhzSx4p1YduKIa6DClT9YBtSOVV2k9eli8Eoud
         9p1pVR4Oz/Ld9P1QJYJaaJ4zCuiboQjT68IHCpfnmtDYJ1uiD5bptgxaGQ+veQ/bXT6B
         ISYw==
X-Gm-Message-State: AOAM530dVZjbTcNRPUyMlmf51ci6JwYMbpRAQf3onZGIzkkgRMwXLJnk
        bbH5Vz7GIKpWNw6BuZnVxtUygdnnHh1oE+zzXLQ=
X-Google-Smtp-Source: ABdhPJx8VRcrhv9u5TFKRPzbWDC4InYcOACd443ZXQxhRMYnK4DNXUCXAYaxfxxQ6ex6FFNBDhBx6aM37v+/WXqsGi8=
X-Received: by 2002:a1c:6302:: with SMTP id x2mr17930983wmb.56.1603740875736;
 Mon, 26 Oct 2020 12:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <20201023074656.11855-1-tiwai@suse.de> <1d3e22ef-a301-f557-79ca-33d6520bb64e@amd.com>
In-Reply-To: <1d3e22ef-a301-f557-79ca-33d6520bb64e@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 26 Oct 2020 15:34:24 -0400
Message-ID: <CADnq5_OY8tRqs-bao9mkKxgcXC=305-_71U=04C5z9HM0+5MuQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] drm/amd/display: Fix kernel panic by breakpoint
To:     Luben Tuikov <luben.tuikov@amd.com>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, looks good to me as well.  Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>
I'll give the display guys a few more days to look this over, but if
there are no objections, I'll apply them.

Thanks!

Alex

On Fri, Oct 23, 2020 at 7:16 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> On 2020-10-23 03:46, Takashi Iwai wrote:
> > Hi,
> >
> > the amdgpu driver's ASSERT_CRITICAL() macro calls the
> > kgdb_breakpoing() even if no debug option is set, and this leads to a
> > kernel panic on distro kernels.  The first two patches are the
> > oneliner fixes for those, while the last one is the cleanup of those
> > debug macros.
>
> This looks like good work and solid. Hopefully it gets picked up.
>
> Regards,
> Luben
>
> >
> >
> > Takashi
> >
> > ===
> >
> > Takashi Iwai (3):
> >   drm/amd/display: Fix kernel panic by dal_gpio_open() error
> >   drm/amd/display: Don't invoke kgdb_breakpoint() unconditionally
> >   drm/amd/display: Clean up debug macros
> >
> >  drivers/gpu/drm/amd/display/Kconfig             |  1 +
> >  drivers/gpu/drm/amd/display/dc/gpio/gpio_base.c |  4 +--
> >  drivers/gpu/drm/amd/display/dc/os_types.h       | 33 +++++++++----------------
> >  3 files changed, 15 insertions(+), 23 deletions(-)
> >
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
