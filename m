Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF692E9B8E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 18:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbhADRBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 12:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbhADRBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 12:01:19 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E5BC061795
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 09:00:38 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id j12so26605865ota.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 09:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mLJaDNIBiSp2oExEtnWCPvISc7T9R6s/K5ftE3MvkzI=;
        b=hY56ihJuziw/5YQ7KCQQBkSqw7AbisOyW+vph4s5wGL2khGhvtWA/hnjqO9Cp6dNcc
         TZbEAx4h/eQY6oF4RMRdzsQLpoKAvf71IMknElWFWIkU/C2Od8KXZ6ZYTU+IbrgpEGxp
         dbs4ZSD+AqtrIw8X54RmzwvGJJdMNh55vlgxJiVhLxNL3BlejfBbVtE5ZpurF7vuHVgX
         Z5WKcybXlSVGRPI2S9xeCBGW5bOO1gRWNHZdqinFGCU2ugfQSEExGf5gKDE7xMgmLdi0
         3Zhw4x9bmDpQxkqsNvEKsuZyhTNwuaP8Lmk0Yz3rmrUVjU+SZo61zXEU3uYBxkH+VPhH
         1iSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mLJaDNIBiSp2oExEtnWCPvISc7T9R6s/K5ftE3MvkzI=;
        b=deQ9Rs4vVnqZ0QhqDnIqGEKUxdTPK7vxT1hsRhvElONvlkFisHES9CI29xrupixsMw
         VVnxY/d8ss03tpKmtvFpx2K4j1hOpCgoxydPi8bzpVwM3EAqD0PZ601dM3xSS65KUU5G
         6AaGGnhfNkU5KkD51pxC1xHyywNIoc+bXPglEbHvWuCf0/owhccLcTRl/9ILie7ycuN8
         bA+XBVVVxtK/Q9mdg8tZvWggwLVmtoC07iKsQiBGCibxbs+w91C1wdxHpfkjrgbdfQ8R
         APhzEKOnoRaK480tXF9W9ynziZWnvZ8rU+M5mzlS8No9g4hFNbGgYyJMv1Ffl/QYj0g1
         yoMw==
X-Gm-Message-State: AOAM532fznOT7Au8zYUNqWDD58cblIYO9F85nAGnGISIrMi44MlfCjsV
        jJdoUDHntESvrLsigzb4psIJVOMpUD+ZZ2F9s/M=
X-Google-Smtp-Source: ABdhPJwm7yJXYb0sKmhZ64e8rOh+obz10xknZR5Tj9FfQjOj0F2CBe+0kvbY+VEU7A/ESkv4gGGY6agIjBFEb7WawpY=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id d27mr54799967ote.132.1609779638100;
 Mon, 04 Jan 2021 09:00:38 -0800 (PST)
MIME-Version: 1.0
References: <1609057469-3844200-1-git-send-email-bodefang@126.com>
In-Reply-To: <1609057469-3844200-1-git-send-email-bodefang@126.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 4 Jan 2021 12:00:27 -0500
Message-ID: <CADnq5_NhD5WUft5BnBrSjMn4x=5tb5Pje1_BUJyu60FtiFpNpw@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon:avoid null pointer dereference when dev is not bound
To:     Defang Bo <bodefang@126.com>
Cc:     Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 27, 2020 at 3:56 PM Defang Bo <bodefang@126.com> wrote:
>
> [Why]
> Similar to commit<0fa375e6>. If the set_state/can_switch code access the drm_device when dev is not bound,
> a null pointer dereference can happen.
>
> [How]
> Add sanity checks to prevent it.
>
> Signed-off-by: Defang Bo <bodefang@126.com>

Are you actually hitting this or is this just defensive?  I don't
think we can actually get into a state where this would be a problem.

Alex

> ---
>  drivers/gpu/drm/radeon/radeon_device.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
> index 266e3cb..50a1a60 100644
> --- a/drivers/gpu/drm/radeon/radeon_device.c
> +++ b/drivers/gpu/drm/radeon/radeon_device.c
> @@ -1224,6 +1224,9 @@ static void radeon_switcheroo_set_state(struct pci_dev *pdev, enum vga_switchero
>  {
>         struct drm_device *dev = pci_get_drvdata(pdev);
>
> +       if (!dev)
> +               return;
> +
>         if (radeon_is_px(dev) && state == VGA_SWITCHEROO_OFF)
>                 return;
>
> @@ -1257,6 +1260,9 @@ static void radeon_switcheroo_set_state(struct pci_dev *pdev, enum vga_switchero
>  static bool radeon_switcheroo_can_switch(struct pci_dev *pdev)
>  {
>         struct drm_device *dev = pci_get_drvdata(pdev);
> +
> +       if (!dev)
> +               return false;
>
>         /*
>          * FIXME: open_count is protected by drm_global_mutex but that would lead to
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
