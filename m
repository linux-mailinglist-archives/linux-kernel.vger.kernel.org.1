Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3412F3CF6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437532AbhALVe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 16:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436924AbhALU25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 15:28:57 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBA5C061794
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 12:28:17 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id u25so5362317lfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 12:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5960geX9HCG16DZ39o4+2JHIAqK0nJMhnDxc5cpnSNU=;
        b=GkTjCKATdgwwzl5zWFKM/GZkJ8Ru5mD2K4+0F8dAgffuBUOVU+23PX0EQ32Blth15w
         JG7AF7Z66SHX+yZKqO4phDlR31DIpX/ncUdaDbhFLbNBCt8yLxNJ4dZS7u1rUVE6tpaH
         +HDiGZhynjjrtmmziGnzXsAsJ5iYJkxSXkDi1q7gwxJs9+p6ZKTagbX6o3TGF7DkFF+N
         68trtXJdFXS/9iK8vcTYWckfat2CPb6DnRQ/pT2cX6VG/5Dh7iaiF44HAEPKNkdL90xT
         BXsKesBCDYzHOyFbbyEKIKnz4Jtp8aNIG2C6b3rUzc3TjWPq7dE55a+n0ogYYoHtyDj3
         5p2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5960geX9HCG16DZ39o4+2JHIAqK0nJMhnDxc5cpnSNU=;
        b=saGRObGAbShYqgfecYFTn/D3jN+NaygCSE6lEacwCMNpJy1ttN2n2qrHjvMw0GxGlj
         KYwSrqG0Zjrsg0Yq0FE1wV/WFh5AkR6QKG8ttEzpZ6qQWkme59lsDGC3c7yp0dzM+h+H
         uYGI4pkDtXZpKkxC4BXNF1u793t2+OFXQwTwAvYKbMhVBgos1rELurHHxzCK5w/dzWOY
         GOHQiQ9bir6ElX1+Fs1sovriUMlz56cV1P3SRPyFWB/ajcAcgdx4ICMOcGtfvIXLcyUQ
         WWdWRF0c43IsOqb88x/7bfjJGhtYCY+nKnHZRcNH8K2WQDMrIMjRfCagcI5d8aERASG7
         KFIA==
X-Gm-Message-State: AOAM533d1NtKh7j0XcAhQpYQuhpuhpA+TwXJcugoHgRNVhWYFI5eC5lS
        88zPkkE7QHxthScxCqEsXPiTR2ePkFk64TZd0s97Xw==
X-Google-Smtp-Source: ABdhPJwCQ+KHw0YYH7t/aGGO4JPatl+HtEdaW2X4PZ4+wyKoFsnmqV8R9BIFSXKRLdy8xpSwOj4zzANfZ6KkElnR2Oc=
X-Received: by 2002:a05:6512:20c1:: with SMTP id u1mr258609lfr.549.1610483295372;
 Tue, 12 Jan 2021 12:28:15 -0800 (PST)
MIME-Version: 1.0
References: <20210112163011.127833-1-hannes@cmpxchg.org> <CALvZod4VFA52dsdkW79-gUbiCf2ONfFJj6LkRU+3-fQpvYXL+A@mail.gmail.com>
 <X/3+IgDVb+Jn4XfQ@cmpxchg.org>
In-Reply-To: <X/3+IgDVb+Jn4XfQ@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 12 Jan 2021 12:28:04 -0800
Message-ID: <CALvZod4qKrwvT7MAKrhemjrBfAAsk=fKa9g8QRij42j0CaF4nw@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: prevent starvation when writing memory.high
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 11:55 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Tue, Jan 12, 2021 at 10:59:58AM -0800, Shakeel Butt wrote:
> > On Tue, Jan 12, 2021 at 9:12 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > When a value is written to a cgroup's memory.high control file, the
> > > write() context first tries to reclaim the cgroup to size before
> > > putting the limit in place for the workload. Concurrent charges from
> > > the workload can keep such a write() looping in reclaim indefinitely.
> > >
> >
> > Is this observed on real workload?
>
> Yes.
>
> On several production hosts running a particularly aggressive
> workload, we've observed writers to memory.high getting stuck for
> minutes while consuming significant amount of CPU.
>

Good to add this in the commit message or at least mentioning that it
happened in production.

> > Any particular reason to remove !reclaimed?
>
> It's purpose so far was to allow successful reclaim to continue
> indefinitely, while restricting no-progress loops to 'nr_retries'.
>
> Without the first part, it doesn't really matter whether reclaim is
> making progress or not: we do a maximum of 'nr_retries' loops until
> the cgroup size meets the new limit, then exit one way or another.

Does it make sense to add this in the commit message as well? I am
fine with either way.

For the patch:
Reviewed-by: Shakeel Butt <shakeelb@google.com>
