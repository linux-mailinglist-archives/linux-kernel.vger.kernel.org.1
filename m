Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD6F2FFE73
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 09:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbhAVInv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 03:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbhAVIlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 03:41:46 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9A1C061788
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 00:41:00 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id g46so846806ooi.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 00:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wOljwRCTbqyi57Y0Livy/H/EyT5660ugsfV4DuzfwqY=;
        b=O0p5VKMoY2x8AgqrSCwbvRe2f+uh5jMDWo8v1uN5BFnIpTYeylv7jXtmw2xwBF6CvZ
         cvAidVCqZX4yBuePIjcFU+6pgnI6q/Ep1Z5C+g7Iacpr5DV3r+R36zNMnln8Q8Lzl9lz
         E1uzZCGg7oqS3+ZlEG+gNKDcsFMA0JCZIyhoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wOljwRCTbqyi57Y0Livy/H/EyT5660ugsfV4DuzfwqY=;
        b=KA75uiX9826AyMFX5u6PRRpmRBLb06Tg7oyl/lsRMeLoICHNFl8ExFPFyaCIPSeeyA
         KQJa6Dcw3U16IGuHimBLarFcO3BJAuLUnPGt52AZFih+NAqjfKBxwOuDhlyOlYBvWxcR
         QXOijerVNdpWlzyGRuuMVNjs4QhKAm170LeXMZk0yS2TTHbdq8bqQVFF5IgKihc1Uvwz
         0OO5UKZbjJYxJfSdoflXpJ7EyQrzWNgPmkT6Q3qQ0s+qkwuH6mpIdZKi4yTVtn7X3QQM
         sZuuycJa5f6fOFilqzqfE3p8As0hCsCl14KzCmJs+3hUokv7cfhBY3S1+Vw0HhiUFv1P
         AbmA==
X-Gm-Message-State: AOAM530uKbzifdqfPnsBb2jYDLcQDakSGXT5zpjOAG9LITcoNM/M890T
        dOm++rcPq9M24fjocEtOEvxkl4mQSdQ/IFF6VaZ/Sw==
X-Google-Smtp-Source: ABdhPJxDy+y1OaANdzA4wIMi5FJQjgdMKPG0dL2eTTJxJ2qmVIP8X8bscBmGEkbq8xeEe5veGwWsHRsLPQr71Q6nkYA=
X-Received: by 2002:a4a:9722:: with SMTP id u31mr2968367ooi.28.1611304859529;
 Fri, 22 Jan 2021 00:40:59 -0800 (PST)
MIME-Version: 1.0
References: <20210122115918.63b56fa1@canb.auug.org.au> <CAKMK7uEuJa1J66mo5dS+QRPy9NOENTx95SZ4rU2MeVRTWj7Kcw@mail.gmail.com>
 <20210122182946.6beb10b7@canb.auug.org.au>
In-Reply-To: <20210122182946.6beb10b7@canb.auug.org.au>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 22 Jan 2021 09:40:48 +0100
Message-ID: <CAKMK7uFWFVC0be2foiP8+2=vrqyh1e4mqkuk+2xY+fgSWAExyQ@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the drm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Nikula, Jani" <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 8:29 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Daniel,
>
> On Fri, 22 Jan 2021 08:17:58 +0100 Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > Hm that has been in drm-intel-gt-next for a few days, is that tree not
> > in linux-next?
>
> It is not.

Adding -intel maintainers to get that sorted.
-Daniel

> These are the drm branches currently in linux-next:

Oh for ordering maybe put drm-misc ahead of the other subtrees, -misc
is where nowadays a lot of refactorings and core changes land.
Probably doesn't matter in practice.
-Daniel

> drm-fixes       git://git.freedesktop.org/git/drm/drm.git       drm-fixes
> amdgpu-fixes    git://people.freedesktop.org/~agd5f/linux       drm-fixes
> drm-intel-fixes git://anongit.freedesktop.org/drm-intel         for-linux-next-fixes
> drm-misc-fixes  git://anongit.freedesktop.org/drm/drm-misc      for-linux-next-fixes
> drm             git://git.freedesktop.org/git/drm/drm.git       drm-next
> amdgpu          https://gitlab.freedesktop.org/agd5f/linux      drm-next
> drm-intel       git://anongit.freedesktop.org/drm-intel         for-linux-next
> drm-tegra       git://anongit.freedesktop.org/tegra/linux.git   drm/tegra/for-next
> drm-misc        git://anongit.freedesktop.org/drm/drm-misc      for-linux-next
> drm-msm         https://gitlab.freedesktop.org/drm/msm.git      msm-next
> imx-drm         https://git.pengutronix.de/git/pza/linux        imx-drm/next
> etnaviv         https://git.pengutronix.de/git/lst/linux        etnaviv/next
>
> --
> Cheers,
> Stephen Rothwell



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
