Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7BF2D8359
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 01:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437568AbgLLASi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 19:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407277AbgLLASI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 19:18:08 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99AAC0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 16:17:25 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id m12so15795941lfo.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 16:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k6oIUvn/IBCxtIINsfT27es3SVZ5FJQGfE7GX4CvWQ0=;
        b=TykSgSbxK85MbhpzI4vYR/Ri9l5a7iWwL/pohJU4OO7DKhs3wk/uimaqizBaM/vpqZ
         SLw9ET5otvLqzWxt2X2B6pr+mgjxbjz6Bz1pa7hJhwiuK0Uh0/0TMc2++bjFX3TDb2RP
         IXJNDzNKImgMO/uZzJPvYpY/2ozgdpzLga1lFK/BZS+i7CJ4O6YTbzYoExtQxEOdGEgn
         kLr1zpS3dIMo18HYlCQpCHP0JJEHk7ySvfa5C4oE/KT8pZZ2cNfouecTekbNVwbTjsZM
         EgujEd051O8tPdCxYWalo7PJKCuDMT2BsOKWYCX/y8Bla7ybS8qH3q58wLgpJujOB+qz
         KdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k6oIUvn/IBCxtIINsfT27es3SVZ5FJQGfE7GX4CvWQ0=;
        b=WYEW1VuiZXxO9kwahdz5QkdaUOwZR7RJnSN8gcT0fahEvxkBHNhWoxmEPMa7LHKzPf
         KRipUrD3OsaIlQxqW+/ObJ2EBZuzFYxlOI9L0D3f5Y11XKJaO8xrG16B8ybtBXmpEc0l
         Z5LBedWJQkhJutQR5A//ka0NpUCNrWpEM9AhkugrzsCreM2V5xeOJ7aP3E34cH+7Ep4t
         qHrlFqFFP4Q74kqYMn1sylYMj+2xnS4H2tVy7yUJoTHk2dd7oGXlCNuECR0Lhsg7kXmx
         j2WOdhJ5lpks1KJPrjEd3bD5STInqbmOLB9mzz+oE34E8wXff8iTsuMyJ5jLaHNAzM0V
         sLYg==
X-Gm-Message-State: AOAM532nwK0+zXL5vjOSyhUIile/ZmkySEyk8vIm6dibUwLLpPbyq6F2
        MGsJKj5+KePe8PcqOQ6qIB++33h6zFDsGSpfoR9MPQ==
X-Google-Smtp-Source: ABdhPJwn8/rXUEFnVDx91D7syH2qUxybJmjPMept6dleKna4tEdWQz/TUZBPUsQAlRjCuv+5Sr61kt/PjAJPgf4zF9M=
X-Received: by 2002:a19:8cb:: with SMTP id 194mr5438253lfi.463.1607732243934;
 Fri, 11 Dec 2020 16:17:23 -0800 (PST)
MIME-Version: 1.0
References: <20201124053943.1684874-1-surenb@google.com> <20201124053943.1684874-2-surenb@google.com>
 <20201125231322.GF1484898@google.com> <CAG48ez0UKYCdgyW91SmOcT52vbLFz9RjLpaucWpj6bTrgQCwnA@mail.gmail.com>
 <X9P6XuRG1l1Q6zdR@google.com>
In-Reply-To: <X9P6XuRG1l1Q6zdR@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 12 Dec 2020 01:16:57 +0100
Message-ID: <CAG48ez3m5ymH46DuAB3CEQgtTcx703jbABFzQ8-V1W_Mt1drtg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/madvise: allow process_madvise operations on
 entire memory range
To:     Minchan Kim <minchan@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 12, 2020 at 12:01 AM Minchan Kim <minchan@kernel.org> wrote:
> On Fri, Dec 11, 2020 at 09:27:46PM +0100, Jann Horn wrote:
> > +CC Christoph Hellwig for opinions on compat
> >
> > On Thu, Nov 26, 2020 at 12:22 AM Minchan Kim <minchan@kernel.org> wrote:
> > > On Mon, Nov 23, 2020 at 09:39:42PM -0800, Suren Baghdasaryan wrote:
> > > > process_madvise requires a vector of address ranges to be provided for
> > > > its operations. When an advice should be applied to the entire process,
> > > > the caller process has to obtain the list of VMAs of the target process
> > > > by reading the /proc/pid/maps or some other way. The cost of this
> > > > operation grows linearly with increasing number of VMAs in the target
> > > > process. Even constructing the input vector can be non-trivial when
> > > > target process has several thousands of VMAs and the syscall is being
> > > > issued during high memory pressure period when new allocations for such
> > > > a vector would only worsen the situation.
> > > > In the case when advice is being applied to the entire memory space of
> > > > the target process, this creates an extra overhead.
> > > > Add PMADV_FLAG_RANGE flag for process_madvise enabling the caller to
> > > > advise a memory range of the target process. For now, to keep it simple,
> > > > only the entire process memory range is supported, vec and vlen inputs
> > > > in this mode are ignored and can be NULL and 0.
> > > > Instead of returning the number of bytes that advice was successfully
> > > > applied to, the syscall in this mode returns 0 on success. This is due
> > > > to the fact that the number of bytes would not be useful for the caller
> > > > that does not know the amount of memory the call is supposed to affect.
> > > > Besides, the ssize_t return type can be too small to hold the number of
> > > > bytes affected when the operation is applied to a large memory range.
> > >
> > > Can we just use one element in iovec to indicate entire address rather
> > > than using up the reserved flags?
> > >
> > >         struct iovec {
> > >                 .iov_base = NULL,
> > >                 .iov_len = (~(size_t)0),
> > >         };
> >
> > In addition to Suren's objections, I think it's also worth considering
> > how this looks in terms of compat API. If a compat process does
> > process_madvise() on another compat process, it would be specifying
> > the maximum 32-bit number, rather than the maximum 64-bit number, so
> > you'd need special code to catch that case, which would be ugly.
> >
> > And when a compat process uses this API on a non-compat process, it
> > semantically gets really weird: The actual address range covered would
> > be larger than the address range specified.
> >
> > And if we want different access checks for the two flavors in the
> > future, gating that different behavior on special values in the iovec
> > would feel too magical to me.
> >
> > And the length value SIZE_MAX doesn't really make sense anyway because
> > the length of the whole address space would be SIZE_MAX+1, which you
> > can't express.
> >
> > So I'm in favor of a new flag, and strongly against using SIZE_MAX as
> > a magic number here.
>
> Can't we simply pass NULL as iovec as special id, then?

AFAIK in theory NULL can be a valid userspace pointer (although that
basically never happens and, on MMU systems, requires root to
explicitly do it). On the other hand, there are some parts of the UAPI
that already special-case NULL, so maybe that's considered acceptable?

Also, special-casing NULL slightly increases the chance that userspace
messes up and accidentally triggers completely different behavior
because an allocation failed or something like that.

So while I'm not strongly against using NULL here, I don't exactly
like the idea.
