Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F27127F16F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 20:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbgI3Shh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 14:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3Shh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 14:37:37 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE4DC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 11:37:36 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id c2so2818384otp.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 11:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GZokKNgMejCKfo0F2vRKE9nImzYNSzp/HUH90Pr6PJU=;
        b=Iz7k38YFYItPAO2RtiflnlRb5+BDWfPx9FQCvvU2f8SdCl7V1y7fJW6E60irWiBOlQ
         fH9GEK1n0pwT4bpaxG/cqFn7l9Zse+u3/d1Pt4ggVZd6tM3YSzezV3iBWBtU9IY/SgXQ
         GGeYqXdFFnSWXcgBytqYXCxu9xUWTpvQgSvlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GZokKNgMejCKfo0F2vRKE9nImzYNSzp/HUH90Pr6PJU=;
        b=tumvHBZkOHUJlNLqXw1M3fbX68XIrplPuckkfkaljBDg6hb+/zozynArPUshP+ubrV
         Gl/R7Mo5PuGm0/gai+RkrLuePec6fQzG+JFeBMP3HdPaNoejKGL47OAlYGImrfZKN1bE
         TCw1KlI3XT50UVx+8/FK3EhtPNQonitjyVk0n6vcQO66VI8DCMF48BrrEGFrSDux96/t
         NxgdV7HwFTShEPi7+RFjGX5me6aYLNldfGWYdHT7/0l5pcAQeLLO9FvQBNdPTgff17nR
         1vlHsoVtMrgRiPSmgB4t8ZLMr0NxB/2OXHOP3KMurSA93oCyvzjq019kYj1kqLGcjAHe
         seOA==
X-Gm-Message-State: AOAM5318p0VUCG9a4Mt54NucX1ksLETQgkk7nCSS6eBU9n5qkjCDuy4o
        u+wApJirYIsiCbvAnbDoFmKZQMhOIVbtYYKNvoGDeg==
X-Google-Smtp-Source: ABdhPJzmG8KuipdmIEStVjCt4k/yD8YpcM6mVrZ29T55c3684BNdLJdgOsz6wDtmq5u1TIJFW1qJF02gBOu8zFVEiX4=
X-Received: by 2002:a05:6830:14d9:: with SMTP id t25mr2508122otq.188.1601491055725;
 Wed, 30 Sep 2020 11:37:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200924135853.875294-1-hch@lst.de> <20200925194349.d0ee9dbedb2ec48f0bfcd2ec@linux-foundation.org>
 <20200926062959.GA3427@lst.de> <160128801808.6464.1013594053120198786@jlahtine-mobl.ger.corp.intel.com>
 <20200928123741.GA4999@lst.de> <160138340987.15771.13645983702040612672@jlahtine-mobl.ger.corp.intel.com>
 <20200930144839.GA897@lst.de>
In-Reply-To: <20200930144839.GA897@lst.de>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 30 Sep 2020 20:37:24 +0200
Message-ID: <CAKMK7uE98o-ELvPZ0YVWjrVWgESVEEz5OSexA_qU64qemihyRg@mail.gmail.com>
Subject: Re: remove alloc_vm_area v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nitin Gupta <ngupta@vflare.org>, X86 ML <x86@kernel.org>,
        "moderated list:DRM DRIVERS FOR XEN" <xen-devel@lists.xenproject.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 4:48 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Sep 29, 2020 at 03:43:30PM +0300, Joonas Lahtinen wrote:
> > Hmm, those are both committed after our last -next pull request, so they
> > would normally only target next merge window. drm-next closes the merge
> > window around -rc5 already.
> >
> > But, in this specific case those are both Fixes: patches with Cc: stable,
> > so they should be pulled into drm-intel-next-fixes PR.
> >
> > Rodrigo, can you cherry-pick those patches to -next-fixes that you send
> > to Dave?
>
> They still haven't made it to linux-next.  I think for now I'll just
> rebase without them again and then you can handle the conflicts for
> 5.11.

Yeah after -rc6 drm is frozen for features, so anything that's stuck
in subordinate trees rolls over to the next merge cycle. To avoid
upsetting sfr from linux-next we keep those -next branches out of
linux-next until after -rc1 again. iow, rebasing onto linux-next and
smashing this into 5.10 sounds like the right approach (since everyone
else freezes a bunch later afaik).

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
