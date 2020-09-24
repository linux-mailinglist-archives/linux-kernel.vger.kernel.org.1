Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C2F2777D1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 19:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgIXR3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 13:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbgIXR3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 13:29:41 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE922C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 10:29:40 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id i1so4225506edv.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 10:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Rj2Ks53EYaHscbbljFejwCf3ZpdNdZ5OllPTvKUc/0=;
        b=Woov+o1kw1EK1aSaUuoL3PVlebOvnRY6f+pfbBElcTMbl75/r4kyVtBUDsnkeX7/Io
         wm6iheIreC2XmElF2f++bs4mxq2Jo5oPsatSG8Rq9ndJBvPxTqpepT+yrWgwj57PI/+a
         +LZLT4EJ8uM+Sfo1bfA869fgW7IUB9fZK/CS36Gr5qX/YbovR8YQppw88Cq7PEVm+gL+
         9nM8eBWxKo2HfaOLXoOHicT5lFIBAgya71JW7Q+8q8tDqMZfhzhlz8axcUVFuNHnSz6d
         iDyJR5X1ZI8hqZpXg7R/EK5tsCN0e+zsCTj+Lm8ftwZWlSPybyIhZNE4yjX8f5ua3FZd
         zbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Rj2Ks53EYaHscbbljFejwCf3ZpdNdZ5OllPTvKUc/0=;
        b=ZlhQdPqJM29J00hs1zrxS8U8J2YK6kSd4kPqWY5nFeZ1YgfV1X1Z6Hcsqc1s5o3qM+
         9joOmHI9Rq2Kjn7qIcrVEdx0kZHYzYwKY7cUuF7cMGU4atCAsFfvxrTqfFBShET8kros
         6AyJOB5BYZUgL3AS6yOgGrnSSiv0hcAUU7byVq74qAWdpDdGypnOLe9GfbgimiVKSlLd
         AVjiQYwib0HUveu4OQEoKuDifV6V6BhetTX5QF3qdcrH1xz+10zd9YlN7s5JeG+Ca3gh
         o7jnD7B/Ug18aVZubFLiwslhVX+Qpis3rZc+aupM8R9PzWkG+55UhNDnjbfQxZmZjhiG
         zVug==
X-Gm-Message-State: AOAM533AdONu5+ADwiIiWVIqVbmdc9hTasSUlAtqw7TsrmjSi2ktfqHR
        wbnk676rDfvTZIrlhQD38IdMA/wrYQk0ezWXBxw=
X-Google-Smtp-Source: ABdhPJwE+gV2rqKX4L5LNtPzhzs3Evc1OCIOBBlXvRXLiRVnVsWs54pX2kSNC+Idy7rF+BpyJ7sd0cXL0BbzSqh/DMQ=
X-Received: by 2002:aa7:cf05:: with SMTP id a5mr1047406edy.313.1600968579647;
 Thu, 24 Sep 2020 10:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200921211744.24758-1-peterx@redhat.com> <20200921212031.25233-1-peterx@redhat.com>
 <20200922120505.GH8409@ziepe.ca> <20200923152409.GC59978@xz-x1>
 <CAHbLzkr_C-4g+ArA3JXyvFHiAzU1ObHA9f4t1anj=N9b8oi7wQ@mail.gmail.com> <20200924154750.GG79898@xz-x1>
In-Reply-To: <20200924154750.GG79898@xz-x1>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 24 Sep 2020 10:29:27 -0700
Message-ID: <CAHbLzkp1wuKQ8PxeKVEs94+hjgtdX20Eo88i+9iQba6x0swnWA@mail.gmail.com>
Subject: Re: [PATCH 5/5] mm/thp: Split huge pmds/puds if they're pinned when fork()
To:     Peter Xu <peterx@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 8:47 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Sep 23, 2020 at 09:07:49AM -0700, Yang Shi wrote:
> > For tmpfs map, the pmd split just clears the pmd entry without
> > reinstalling ptes (oppositely anonymous map would reinstall ptes). It
> > looks this patch intends to copy at pte level by splitting pmd. But
> > I'm afraid this may not work for tmpfs mappings.
>
> IIUC that's exactly what we want.
>
> We only want to make sure the pinned tmpfs shared pages will be kept there in
> the parent.  It's not a must to copy the pages to the child, as long as they
> can be faulted in later correctly.

Aha, got your point. Yes, they can be refaulted in later. This is how
the file THP pmd split was designed.

>
> --
> Peter Xu
>
