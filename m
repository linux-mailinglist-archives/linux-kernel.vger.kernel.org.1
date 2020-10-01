Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73905280111
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 16:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732580AbgJAOOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 10:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732569AbgJAONy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 10:13:54 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4614C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 07:13:53 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id z1so1507822ooj.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 07:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=us8thQANzunB8liJvtH1u9KjYvMWBCN/6ee+Pda/bWA=;
        b=HOsJWxDxB4xVjDfa1aZ5JJBMlRAfvVPFyyu2Rh+RQ2NPZaSZofBx1uadVQmfF+1xHE
         01o0lELbi++17LNc25VmGKUpiJmoJKu0Q67QKXYMG3vp5iZ34cn9XKsV4Vpfa3wk0h8a
         XkCxyWk1iGK/n7KrvdNWIv3phDHesCb4MRubs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=us8thQANzunB8liJvtH1u9KjYvMWBCN/6ee+Pda/bWA=;
        b=PM93GOPfFvbJdXlQNtJkZoyHqkt64CVAGvbK1sSedPUxkPXL/3Y3ocVEhBKnb09JIa
         2o/DngP9bBYSCpDbQThmKYllapHuCLPy9aOXOTMMPL+IOr/9EGRHQ1jYhQM13Lj7RMSD
         AvHHsadBEtTtzLErFVavuF2HVnGuKYuHjnDYH0hPXYJEImGu8pugM1Vt5SOShJZ4/dUm
         J8YZxH5Gzg6/7WAqeMtdBy2p2mVo0nBnCETJhdqPV0lq1cjjJwNCWFNRg3Fn0DeKUes8
         Ps3SerhrDzVsRwzsu2us4cvGpO5vhwd3nk7Hl2DaanlqYXEPANj6GhJdqvmu6Q05nFMQ
         U8wA==
X-Gm-Message-State: AOAM532n6EUKX3V+2o2ZW3JoDE5P7HjOJXJBx7ZPVRGxAziasItixch8
        SF+W46b5CPO8AuS9GkrrNPQsRWLqDmDx3woXmiGQeg==
X-Google-Smtp-Source: ABdhPJy+Qa1QnyOeGpgz2tEALV5zV/r+Mw/i+fe/ScEgQVuLKXLkdkccDTrTDmW6x67TiI0MqOdlBgeDXl3v04GVz3k=
X-Received: by 2002:a4a:344b:: with SMTP id n11mr5774966oof.89.1601561633049;
 Thu, 01 Oct 2020 07:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20201001203917.43d46a3d@canb.auug.org.au> <20201001135350.GA14869@lst.de>
In-Reply-To: <20201001135350.GA14869@lst.de>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu, 1 Oct 2020 16:13:42 +0200
Message-ID: <CAKMK7uFfBLsZ=wetii4bc+BTiKObD5DJ7B-kDO4am6AhBY+AhQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the akpm tree with the drm-intel tree
To:     Christoph Hellwig <hch@lst.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 1, 2020 at 3:53 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Oct 01, 2020 at 08:39:17PM +1000, Stephen Rothwell wrote:
> > Hi all,
> >
> > Today's linux-next merge of the akpm tree got a conflict in:
> >
> >   drivers/gpu/drm/i915/gem/i915_gem_pages.c
> >
> > between commit:
> >
> >   4caf017ee937 ("drm/i915/gem: Avoid implicit vmap for highmem on x86-32")
> >   ba2ebf605d5f ("drm/i915/gem: Prevent using pgprot_writecombine() if PAT is not supported")

Uh these patches shouldn't be in linux-next because they're for 5.11,
not the 5.10 merge window that will open soon. Joonas?

> > from the drm-intel tree and patch:
> >
> >   "drm/i915: use vmap in i915_gem_object_map"
> >
> > from the akpm tree.
> >
> > I fixed it up (I just dropped the changes in the former commits) and
>
> Sigh.  The solution is a bit more complicated, but I just redid my
> patches to not depend on the above ones.  I can revert back to the old
> version, though.  Andrew, let me know what works for you.

Imo ignore, rebasing onto linux-next without those intel patches was
the right thing for the 5.10 merge window.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
