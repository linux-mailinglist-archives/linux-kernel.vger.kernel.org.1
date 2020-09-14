Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC94269373
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 19:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgINRdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 13:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgINRcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 13:32:32 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0A2C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 10:32:31 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id m5so137770lfp.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 10:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3xtDFEIrvwA/6L1bjyoorbZAuxfj/GqXppLxNbWixgs=;
        b=U9lHjJaTQ2ejYDJEjf9MUl/d/ihUqXM/TqkzXUb4AZOxhoEk7TVNn0COhc84RxSaLV
         3+pcJlf0crqOlq4vrcIb8dqZd4MQ0SeI25NKoH0hAKjXq1cgkB4ZXEqDD1m0tRBT8ip6
         SQGeknRq4aJyT20tR2LNEMQ0JT7ImcwsFJHlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3xtDFEIrvwA/6L1bjyoorbZAuxfj/GqXppLxNbWixgs=;
        b=IQeZ1AZ1Nz9D2OYxVuEbyJf/2+Ekx+CTFV0KKgr7aGUUSUhJiJenXuKHghd2239WWI
         jWAx2A9o/9wkVGZSnrzVuV6bm9UmH2tyJMETU35SGl9Fl7AQicnwzrLPRah+4ho2OgXy
         5ky93TwW+6mq+OfpmSA7YUwdjmvTvLoyU4rO2nhzJfFehE+RkxbGm2QYNjLSuRD8aDwm
         4gVwqMEOGVGVG60ZQgcjdZyb+gDI28mHW+mVaT6a/RfQw5N5klepnVmDxrN9wRE+EfeO
         oN+XV1YXZpxoIATMuiJ23+KKzV+nGLx5jVa8HaWiKTiOiOQ7xpqs4L1HY8hSrFiW8Kw1
         zv8Q==
X-Gm-Message-State: AOAM530ebH+zWzex2mOkpJl6kNHWFSfggCwT31pIyq9aSrifGEXIqkF6
        ceaTaCjlqQKdxlVi8GpQhPv1LJval0LS+g==
X-Google-Smtp-Source: ABdhPJy3BkOpgzj9HeZdH9H9wWlOid1wECNthAGYfecFZcFD0+9tT8NZPKHqg7imIuLjy03JOYRLHw==
X-Received: by 2002:a19:cb52:: with SMTP id b79mr2123687lfg.592.1600104749956;
        Mon, 14 Sep 2020 10:32:29 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id x2sm4147266lji.9.2020.09.14.10.32.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 10:32:28 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id k25so425544ljk.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 10:32:28 -0700 (PDT)
X-Received: by 2002:a05:651c:32e:: with SMTP id b14mr4983630ljp.314.1600104747758;
 Mon, 14 Sep 2020 10:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200821234958.7896-1-peterx@redhat.com> <20200821234958.7896-2-peterx@redhat.com>
 <20200914143829.GA1424636@nvidia.com>
In-Reply-To: <20200914143829.GA1424636@nvidia.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Sep 2020 10:32:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1EDd3dUGz_992_oRqvsy3LGDvxvyQBvutLhBqkYqgcQ@mail.gmail.com>
Message-ID: <CAHk-=wj1EDd3dUGz_992_oRqvsy3LGDvxvyQBvutLhBqkYqgcQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Peter Xu <peterx@redhat.com>, Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 7:38 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> I don't have a detailed explanation right now, but this patch appears
> to be causing a regression where RDMA subsystem tests fail. Tests
> return to normal when this patch is reverted.
>
> It kind of looks like the process is not seeing DMA'd data to a
> pin_user_pages()?

I'm a nincompoop. I actually _talked_ to Hugh Dickins about this when
he raised concerns, and I dismissed his concerns with "but PAGE_PIN is
special".

As usual, Hugh was right. Page pinning certainly _is_ special, but
it's not that different from the regular GUP code.

But in the meantime, I have a lovely confirmation from the kernel test
robot, saying that commit 09854ba94c results in a
"vm-scalability.throughput 31.4% improvement", which was what I was
hoping for - the complexity wasn't just complexity, it was active
badness due to the page locking horrors.

I think what we want to do is basically do the "early COW", but only
do it for FOLL_PIN (and not turn them into writes for anything but the
COW code). So basically redo the "enforced COW mechanism", but rather
than do it for everything, now do it only for FOLL_PIN, and only in
that COW path.

Peter - any chance you can look at this? I'm still looking at the page
lock fairness performance regression, although I now think I have a
test patch for Phoronix to test out.

                     Linus
