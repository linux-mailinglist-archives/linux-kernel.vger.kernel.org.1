Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F58B2ACB26
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 03:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbgKJCdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 21:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgKJCdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 21:33:00 -0500
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93546C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 18:33:00 -0800 (PST)
Received: by mail-vk1-xa44.google.com with SMTP id e8so1892829vkk.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 18:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o+lVk1WHisUKZ0ebgNE5tDXFPu93D1B4Zca284NgzcQ=;
        b=GJRClqbYC/ueiUBw9YuKsjXkEw63X9r4tK7+iLGVFKH/StPRDxy2T3Mr/Ka7YlvFeC
         TXCwP0wXzGyKi/10XaLQVzNbZkq4EdB5IuysFAeYRRJ+P7vRXQ56Nqi/P6mdvFX8xlb1
         X+c/OSEYEH3f/FrRh8oiyAcHyweOhOTHyGBZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o+lVk1WHisUKZ0ebgNE5tDXFPu93D1B4Zca284NgzcQ=;
        b=lXtM4O+Wqu9h9mSlE5KccZIMsqJZ+voNy+uiTUwXxXcQc26TSJTsV5T5QU19xha5Nt
         Veob8+880KstpsfpdrE93u+1b75IGIahJbpfE/Kly7EXN2PrIEmtkuAdIkPRrPNZpDEF
         pp84gRi2fAdPCjHaNLy/9b0ZPbh+wf8LcA9Pk3zQD9i8Xb+GHljzbzteDBPKNoIHYGdy
         ZnM5Yzy0bFcO8WnlpuY5yhgiP3idmkTkdv4NBw0oC5fCf+URZvBT514lN+OGZMEem8HD
         CwkKFP5kXaT6LpEcGIXelyMzHJTo1i4zMrCKHPIodNsvxRkGOJfAb1Ze4i8JOY2rqbZD
         AwRQ==
X-Gm-Message-State: AOAM532gYCiIHbZ8kbx4YFGKYn2tIdU9Pg2Oa/s3L1n1vOgJCPVsMBAs
        MJOQuhdpyfwOP1YpCcCBVi2DRDZoXN5Xug==
X-Google-Smtp-Source: ABdhPJwjHZvLsx66idWzjfpD6yboUW0U0Rvz6AAqJ/mSglRLn9yMhxq8V7uxOJakgYhP1jfHezez0A==
X-Received: by 2002:a1f:260e:: with SMTP id m14mr8658454vkm.25.1604975579310;
        Mon, 09 Nov 2020 18:32:59 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id h128sm1422934vkg.24.2020.11.09.18.32.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 18:32:58 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id r14so6182171vsa.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 18:32:58 -0800 (PST)
X-Received: by 2002:a67:1e01:: with SMTP id e1mr10457712vse.49.1604975577696;
 Mon, 09 Nov 2020 18:32:57 -0800 (PST)
MIME-Version: 1.0
References: <20201109170018.v4.1.Icaa86f0a4ca45a9a7184da4bc63386b29792d613@changeid>
 <20201109170018.v4.4.I71b2118dfc00fd7b43b02d28e7b890081c2acfa2@changeid>
In-Reply-To: <20201109170018.v4.4.I71b2118dfc00fd7b43b02d28e7b890081c2acfa2@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 9 Nov 2020 18:32:46 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UPkuJ5E2sCQeozNR3CO+LZW=DW9h77vfooeiSMqGnYpA@mail.gmail.com>
Message-ID: <CAD=FV=UPkuJ5E2sCQeozNR3CO+LZW=DW9h77vfooeiSMqGnYpA@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] drm: panel: simple: Add BOE NV110WTM-N61
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 9, 2020 at 5:01 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> Add support for the BOE NV110WTM-N61 panel.  The EDID lists two modes
> (one for 60 Hz refresh rate and one for 40 Hz), so we'll list both of
> them here.
>
> Note that the panel datasheet requires 80 ms between HPD asserting and
> the backlight power being turned on.  We'll use the new timing
> constraints structure to do this cleanly.  This assumes that the
> backlight will be enabled _after_ the panel enable finishes.  This is
> how it works today and seems a sane assumption.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v4:
> - Rebased atop changes in earlier patches.
>
> Changes in v2:
> - Adjust for shorter names in patch #1.
>
>  drivers/gpu/drm/panel/panel-simple.c | 46 ++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index a54f42cb3adc..9bb723696e94 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -1396,6 +1396,49 @@ static const struct panel_desc boe_nv101wxmn51 = {
>         },
>  };
>
> +static const struct drm_display_mode boe_nv110wtm_n61_modes[] = {
> +       {
> +               .clock = 207800,
> +               .hdisplay = 2160,
> +               .hsync_start = 2160 + 48,
> +               .hsync_end = 2160 + 48 + 32,
> +               .htotal = 2160 + 48 + 32 + 100,
> +               .vdisplay = 1440,
> +               .vsync_start = 1440 + 3,
> +               .vsync_end = 1440 + 3 + 6,
> +               .vtotal = 1440 + 3 + 6 + 31,
> +       },
> +       {
> +               .clock = 138500,
> +               .hdisplay = 2160,
> +               .hsync_start = 2160 + 48,
> +               .hsync_end = 2160 + 48 + 32,
> +               .htotal = 2160 + 48 + 32 + 100,
> +               .vdisplay = 1440,
> +               .vsync_start = 1440 + 3,
> +               .vsync_end = 1440 + 3 + 6,
> +               .vtotal = 1440 + 3 + 6 + 31,
> +       },

I can do it as a follow-up patch if there is no other reason to spin,
but I realized that I forgot to add:

.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_NVSYNC,

...to both the 40 and 60 Hz modes to make it match what's in the EDID.
I'm also OK w/ it getting added by a maintainer when this lands if
that makes sense.

-Doug
