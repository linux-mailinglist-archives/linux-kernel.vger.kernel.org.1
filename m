Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB83304228
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 16:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406105AbhAZPSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 10:18:45 -0500
Received: from mail-yb1-f173.google.com ([209.85.219.173]:44524 "EHLO
        mail-yb1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406211AbhAZPSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:18:31 -0500
Received: by mail-yb1-f173.google.com with SMTP id x78so17016271ybe.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 07:18:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n9FXFErP6A/gwSBw+rzAfUKjLz1z1fESxpPei8HXWfU=;
        b=jFuyav5sjboeKMSzBINRgBvSSsLy2ctN8jukLorHT6TabAgkN+nAckM5T/2gOLYX4x
         YhWvRt7vvKtN5hQ0fyrvCT765pFbICT3Dku4ACjeILg0RW7G9lDP5j8aFbSemQhBGyRW
         FwswSXYwWDhG5C/+gQUPceCBnDnJWrKhAqfss1OXEZcYsZpz2ZS6ddD4tAdpkYUVGLsz
         UQXeoxmdARe629SDOXTNfBjbNDEtJ+IxF1Up6AhywBYENUYVua010pczV4BtcDJ4YC8/
         4aQcLJRP4i4NhxhX0zsy41x9dqZZzgejSK31d+opY1p2NQSbFdKVoqhjjJkOv0bdbWJq
         Q9Qw==
X-Gm-Message-State: AOAM5336wTp25nF9AmxD4vfU2VtGaWivzmk2MPe5VDxL/GHmxFScFxMY
        D2RJTNi6Q+8DKs1MkTOOazrWubR3aTZ2G1E9+KQ=
X-Google-Smtp-Source: ABdhPJzAgd63qyLJVImVip/7rjTH6ghSPCQZjYDK57bWxjJxanQIx3y+KXmR8ojrUJ+gKmZCuSxYMNsgd6+SxosGpi8=
X-Received: by 2002:a25:ade8:: with SMTP id d40mr9247170ybe.414.1611674270857;
 Tue, 26 Jan 2021 07:17:50 -0800 (PST)
MIME-Version: 1.0
References: <20210126150155.1617-1-kernel@esmil.dk> <161167397638.2943.18167940013400200979@build.alporthouse.com>
In-Reply-To: <161167397638.2943.18167940013400200979@build.alporthouse.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Tue, 26 Jan 2021 16:17:40 +0100
Message-ID: <CANBLGcyh_fENbRCp481An7YOjFOhXYRP48zkKhWbYoHrGfPo4w@mail.gmail.com>
Subject: Re: [PATCH v2] drm/i915/gt: use new tasklet API for execution list
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jan 2021 at 16:13, Chris Wilson <chris@chris-wilson.co.uk> wrote:
> Quoting Emil Renner Berthing (2021-01-26 15:01:55)
> > This converts the driver to use the new tasklet API introduced in
> > commit 12cc923f1ccc ("tasklet: Introduce new initialization API")
> >
> > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> >
> > ---
> > v2: Rebased on drm-intel-next
>
> Ta. Saves me having to do the fixup.
>
> Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
>
> Will be applied to drm-intel-gt-next which is scheduled for inclusion in
> 5.13. It should apply against the 5.12 merge window if there's a tree
> through which you want to migrate the tasklet API faster.

That's fine by me, thanks!

/Emil
