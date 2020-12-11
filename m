Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92EA2D8009
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 21:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391777AbgLKU3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 15:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391336AbgLKU2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 15:28:55 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3394C061793
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 12:28:14 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id f11so12419499ljn.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 12:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ov6E9ovGP4O2PjufZFcQsFjtRg7X8nEmJMclI/QMkDc=;
        b=VfeB05TnKzT8k7qG5j2JTqEgnpHRx5eZuwRx+iOAq1g+qyYfZiMWKMjO8Llh9nqFzr
         oBwQa/TyPS7dFNb+g5BnVbBGnIjcGbutrSaIksGWvSLTWa/qN0ExWBDcxWasRBDUAhzK
         4HHKzvyL2den97oJb15WqZGhvdblNNDCNJRLU6ughgfsxVSUdgQPuf/pTY/Nuo0ZAoo+
         FsUQRvVTpLHZ/4Mfq1mK+FudM2gmfdv4uUBi1F5zhCw0pxC8AAQ3SUBmumOkQWGc39Dr
         rn00dPvBmIs6+JE58NWHwjSrID3zEcVVOV1fPyqFi3ijl3q4zYn9ZCk+R6M1De4MbcAw
         cMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ov6E9ovGP4O2PjufZFcQsFjtRg7X8nEmJMclI/QMkDc=;
        b=Y7t4IihI84bx5Gr+sN8qWZd7OfHn7v3kYT57fsM/t98fEWxreUm8CnTESNEPn/Mpax
         N/pEO0JsDLfzm09hSt2jlbPUSczvL5GGG5I8rxP5VNWFU/UXBgZ6P+EjmG4eJ4C3hh67
         3bfpvPo/x5TJUYuz44HPOa7Mmot/JmHS583F00szWayWjuQMZCl5DOLp+7+qC92UXs8E
         3Olm7qfT9unsMGYj/h2msGNmxtDHNZfizZclclAjV8jNL30uKMjxCweAssyozN9MCn0I
         pQ1ts39G5eQLGcmgi8c5OLeIyO/lex9/k+kwHHlNEZdRKB/1yShZgsSBufsqnlLjBXx4
         ud6w==
X-Gm-Message-State: AOAM531LLvrVr7424fCn3vYk/7+3U7LphPt9FtddvCRqMHBAQ0389J1Y
        2fpw2sKyVQB2Lxi6nc9JrcvsSN8jV1h6aED3tXpLqA==
X-Google-Smtp-Source: ABdhPJxcuGYuisWlCbDZQh90EUiAHflOU1xqg19jqrMoNWSdbkTHnumBHqFUPRv874mad6N7AIog1ZC/9FS0ZE36ARI=
X-Received: by 2002:a2e:593:: with SMTP id 141mr5908685ljf.86.1607718493088;
 Fri, 11 Dec 2020 12:28:13 -0800 (PST)
MIME-Version: 1.0
References: <20201124053943.1684874-1-surenb@google.com> <20201124053943.1684874-2-surenb@google.com>
 <20201125231322.GF1484898@google.com>
In-Reply-To: <20201125231322.GF1484898@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 11 Dec 2020 21:27:46 +0100
Message-ID: <CAG48ez0UKYCdgyW91SmOcT52vbLFz9RjLpaucWpj6bTrgQCwnA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/madvise: allow process_madvise operations on
 entire memory range
To:     Minchan Kim <minchan@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc:     Suren Baghdasaryan <surenb@google.com>,
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

+CC Christoph Hellwig for opinions on compat

On Thu, Nov 26, 2020 at 12:22 AM Minchan Kim <minchan@kernel.org> wrote:
> On Mon, Nov 23, 2020 at 09:39:42PM -0800, Suren Baghdasaryan wrote:
> > process_madvise requires a vector of address ranges to be provided for
> > its operations. When an advice should be applied to the entire process,
> > the caller process has to obtain the list of VMAs of the target process
> > by reading the /proc/pid/maps or some other way. The cost of this
> > operation grows linearly with increasing number of VMAs in the target
> > process. Even constructing the input vector can be non-trivial when
> > target process has several thousands of VMAs and the syscall is being
> > issued during high memory pressure period when new allocations for such
> > a vector would only worsen the situation.
> > In the case when advice is being applied to the entire memory space of
> > the target process, this creates an extra overhead.
> > Add PMADV_FLAG_RANGE flag for process_madvise enabling the caller to
> > advise a memory range of the target process. For now, to keep it simple,
> > only the entire process memory range is supported, vec and vlen inputs
> > in this mode are ignored and can be NULL and 0.
> > Instead of returning the number of bytes that advice was successfully
> > applied to, the syscall in this mode returns 0 on success. This is due
> > to the fact that the number of bytes would not be useful for the caller
> > that does not know the amount of memory the call is supposed to affect.
> > Besides, the ssize_t return type can be too small to hold the number of
> > bytes affected when the operation is applied to a large memory range.
>
> Can we just use one element in iovec to indicate entire address rather
> than using up the reserved flags?
>
>         struct iovec {
>                 .iov_base = NULL,
>                 .iov_len = (~(size_t)0),
>         };

In addition to Suren's objections, I think it's also worth considering
how this looks in terms of compat API. If a compat process does
process_madvise() on another compat process, it would be specifying
the maximum 32-bit number, rather than the maximum 64-bit number, so
you'd need special code to catch that case, which would be ugly.

And when a compat process uses this API on a non-compat process, it
semantically gets really weird: The actual address range covered would
be larger than the address range specified.

And if we want different access checks for the two flavors in the
future, gating that different behavior on special values in the iovec
would feel too magical to me.

And the length value SIZE_MAX doesn't really make sense anyway because
the length of the whole address space would be SIZE_MAX+1, which you
can't express.

So I'm in favor of a new flag, and strongly against using SIZE_MAX as
a magic number here.
