Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97CBD2E22C8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 00:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgLWXcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 18:32:47 -0500
Received: from mail-ua1-f49.google.com ([209.85.222.49]:34233 "EHLO
        mail-ua1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgLWXcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 18:32:46 -0500
Received: by mail-ua1-f49.google.com with SMTP id k47so247059uad.1;
        Wed, 23 Dec 2020 15:32:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fEu2Ywja5d9FNVZ2oyUL01foxq4s/+vbWDIIInwf/3Y=;
        b=JQNwZRMWA7OQFxHgP2RVH17imQMVFjKv7URl1CVNN3N342x6ByN6+XN41za7G1YMJ1
         EaLnc9p5hBdGenCswlbOdheDffa+qMrJQ6sVgmsKnZAIU2QBdfcEt9vlKY65xbA2435R
         MXHlQCVTrsbtOdjcyESCqO77Igd3wZkQo2PIKqY6Szhdaz721nMQPUMOoiIHkGY+BqCw
         IwcFGol/PTS+i6XwlAxlX0zu2FNp6IgfKZio/9IdX2m/5ezKkrm/qxm6cP8L++lzxrkD
         N5kXu76PRl3cbnoYHMaJqJzi98gG0lvZEj+2wNo4wCHw/vmapuvO03QJb3dv5jBASd39
         K57Q==
X-Gm-Message-State: AOAM531xt8iovut+mcv9sKgwab8emPYmiwN04tABfVLXoc/9NBM/VZqz
        0T1j1R3zhixlbL1mWuqL4nn4Xr2T4JEcH1cjixY=
X-Google-Smtp-Source: ABdhPJwySkAvYhz8FiJc8VpzujAk3FRX2ZP0d52TcGByCjej5AfIA2XXPb4MfmF1b6chJRb52fMDyWnUbD15LiVpLQM=
X-Received: by 2002:ab0:32cb:: with SMTP id f11mr20373557uao.109.1608766325168;
 Wed, 23 Dec 2020 15:32:05 -0800 (PST)
MIME-Version: 1.0
References: <20201223212947.160565-1-paul.kocialkowski@bootlin.com>
 <20201223212947.160565-5-paul.kocialkowski@bootlin.com> <oDsOkjfTYKa11LxfNy4LBLqutkVidfFn8--tjQPZj4w9gzCYNTOFglHqxXohsrYqTJ4uDv2xgJNKXPHzgAsACGnCkbKQis95SScGucOb1PI=@emersion.fr>
In-Reply-To: <oDsOkjfTYKa11LxfNy4LBLqutkVidfFn8--tjQPZj4w9gzCYNTOFglHqxXohsrYqTJ4uDv2xgJNKXPHzgAsACGnCkbKQis95SScGucOb1PI=@emersion.fr>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Wed, 23 Dec 2020 18:31:54 -0500
Message-ID: <CAKb7UvhgHPkG5Sn-HLdpsFw0R=kATJKUmjSwPSuwviDCk0RGyw@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] NOTFORMERGE: drm/logicvc: Add plane colorkey support
To:     Simon Ser <contact@emersion.fr>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        devicetree <devicetree@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FWIW this is something I added, hoping it was going to get used at
some point, but I never followed up with support in xf86-video-nouveau
for Xv. At this point, I'm not sure I ever will. I encoded the
"enabled" part into the value with a high bit (1<<24) -- not sure that
was such a great idea. All NVIDIA hardware supports colorkey (and not
actual alpha, until the very latest GPUs - Volta/Turing families),
although my implementation only covers the pre-G80 series (i.e. DX9
and earlier GPUs - pre-2008). Should a determination of usefulness be
reached, it would be easy to implement on the remainder though.

Cheers,

  -ilia

On Wed, Dec 23, 2020 at 5:20 PM Simon Ser <contact@emersion.fr> wrote:
>
> nouveau already has something for colorkey:
> https://drmdb.emersion.fr/properties/4008636142/colorkey
>
> I know this is marked "not for merge", but it would be nice to discuss
> with them and come up with a standardized property.
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
