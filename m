Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C1F2EBBD4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 10:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbhAFJsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 04:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbhAFJsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 04:48:14 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BE7C061359
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 01:47:33 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id 6so4230984ejz.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 01:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BkCCsh4gMOjo/AEllVdOt08zLRkTEYDX13jd8VQoyfM=;
        b=JazHcfOklVp6oR2Mx22vR82cebwsjMmUriXCRkUmcqM58SfpOUKHRlfSmqjOEr68Ut
         thByJQfNJGMTyLtDFLsF2kwEAst2JW180MHHYZwkhZpoSZL9y1GVOqpebSHC+drwcaGj
         9QW8pWXEtIHNrb/aK84HQnG3bJ5Eh1AAo3TME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BkCCsh4gMOjo/AEllVdOt08zLRkTEYDX13jd8VQoyfM=;
        b=ZBvA0vbd1vZGI3UklcTtZbmJX4gCzEf5Nq3m6OhBhZCT7bBPisJ+QtAf4OZPhlOdX2
         NZqRZ7CYm9FIPJ415nYjB3kDENNXkJAssuPRxDNKmj9Jthh2PG0CADFTvsDqIQmbpGvV
         xsqIpJga4Tr67cmNrEzONTLVnuMV2scNxktgdqVDuToUyYoKOOE5azxHGJfM4KBM047I
         sgkNQskzxOoaCGKQK/0Q2Lpj2XSBuEwVLJW3e/Q+kSZG78UNpukiL/DH3JI7izHozeK0
         kB7v3PRM3DF4HHAYNz24f4guYhT0N6nq9tQsvRmHmBa1Oe/TsX9FPQX4Wuj5nUkzBf5Y
         +AgA==
X-Gm-Message-State: AOAM530gS0gXuNCxuaeO/IKPVHmEdkhju1enxxvTihKVPNXE7dmVVRRm
        rQbcxFMdf0nZUfitwzocRlWdmXDBfQqy1DWe9ZFS4/D97F3PIoVi
X-Google-Smtp-Source: ABdhPJwRsLUHwjPiTZh6TI27HBF3OVWMoQ9t8GUS/t5MOc2+BGz+Y1B6Cwt47SyKc4vT/sQ7/OcL3Ib2Eh9c0b+eYcc=
X-Received: by 2002:a17:906:4ec7:: with SMTP id i7mr2386067ejv.252.1609926452552;
 Wed, 06 Jan 2021 01:47:32 -0800 (PST)
MIME-Version: 1.0
References: <20201128125257.1626588-1-icenowy@aosc.io>
In-Reply-To: <20201128125257.1626588-1-icenowy@aosc.io>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 6 Jan 2021 15:17:20 +0530
Message-ID: <CAMty3ZCkEb9g5t6Hs5DN5yHXYvDhymriYqqV+6DZiC+Qb645ww@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: feiyang-fy07024di26a30d: cleanup if panel
 attaching failed
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 28, 2020 at 6:23 PM Icenowy Zheng <icenowy@aosc.io> wrote:
>
> Attaching the panel can fail, so cleanup work is necessary, otherwise
> a pointer to freed struct drm_panel* will remain in drm_panel code.
>
> Do the cleanup if panel attaching failed.
>
> Fixes: 69dc678abc2b ("drm/panel: Add Feiyang FY07024DI26A30-D MIPI-DSI LCD panel")

The fact that this has failed to probe due to recent changes in
sun6i_mipi_dsi.c I don't know how to put that into the commit message.
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
