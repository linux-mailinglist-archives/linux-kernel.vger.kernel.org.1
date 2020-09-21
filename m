Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3142727354F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 23:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgIUVzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 17:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgIUVzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 17:55:35 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C15C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 14:55:34 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id gr14so19984069ejb.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 14:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RrMcSaTkEOALr4bDHp7ymhMGB8bDnOAQN8954Kq+6mQ=;
        b=cct76/7OEv+D+OtclOJd+ew8Tpda0f3cJNc/Yas9jXEhPJ8NvawHGSYdQJCM2/NsyN
         096Z1UkUQRHqPryA08o7CnBm2QJ8Zrf7ujnTySKPm95vLXQABDZdn9FuXbDxKsc6pPPc
         id478g66NR0G1aBg+Hwtu8+k2fFt09se2rlBAxUCteV2Y6fwAxSUfktUFFMqOpJ0qolF
         oZoB/zU/53RwQ4U9TL3Wk0XeQuqaFHJZbKOAiQvCHCVstf4v9YLoR65OzwXMsBytyK0Q
         IEfP1mNNMPGA7/7EAKDcD4mql1mxwwlJX4Rpi6A4psbdkSB0dTZR1uxBzMSqYjhfm/8O
         T2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RrMcSaTkEOALr4bDHp7ymhMGB8bDnOAQN8954Kq+6mQ=;
        b=E6tutESmducNFnQB/lES7Bc40EkCoZLccG9iXpXdrUZcyC5+chSNPmxmQdpOz2t3Hu
         PQf+gM8KPLQDHmaOITgY7q3XWBrhuedQIr6qc2ZRDuk+WJ7ajImROHDs7xed3nFTNxYm
         VhtLwiFjezs8/yuymAbvBJB32ZGmR+MyCXFQslTRto+D4Itr2ZNk1OVpq0YFd93MN6ev
         KDNOdPUqH+5LGkWv+xGAbhpryLw8cMnlBU5vvfhK15FUcdaroQhAEfIhdBn4BovglrK2
         TfdDmz2TsQvaZziJPzucLkTTWoOpG9/bjVaInP2K5vRg6BO7DzEdOOn/73HfN7cEcIg6
         1fkw==
X-Gm-Message-State: AOAM533K3jgEhvy1MMLiyvKoGxD4/OIeWhbjZVNZgrNzY2ddmFfYhCQW
        xasZEeb9jJ+WgEeHnyE2IdlVPVh99D/oJcT0tTZRNg==
X-Google-Smtp-Source: ABdhPJx968h4djD01uOVY3VldXIQBDXnuIYpDe00ugTXdoYdTTqKqIqaxCvpPeW9Y4XIDE27c5dv0DtU6rYtDhGxJkI=
X-Received: by 2002:a17:906:9389:: with SMTP id l9mr1589347ejx.537.1600725333044;
 Mon, 21 Sep 2020 14:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200921211744.24758-1-peterx@redhat.com> <20200921212028.25184-1-peterx@redhat.com>
In-Reply-To: <20200921212028.25184-1-peterx@redhat.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 21 Sep 2020 23:55:06 +0200
Message-ID: <CAG48ez3frkqQNHbE5bEB6rwYdbyoAA3B9FQZo=HKkUzWCM4H0Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] mm: Do early cow for pinned pages during fork() for ptes
To:     Peter Xu <peterx@redhat.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 11:20 PM Peter Xu <peterx@redhat.com> wrote:
> This patch is greatly inspired by the discussions on the list from Linus, Jason
> Gunthorpe and others [1].
>
> It allows copy_pte_range() to do early cow if the pages were pinned on the
> source mm.  Currently we don't have an accurate way to know whether a page is
> pinned or not.  The only thing we have is page_maybe_dma_pinned().  However
> that's good enough for now.  Especially, with the newly added mm->has_pinned
> flag to make sure we won't affect processes that never pinned any pages.

To clarify: This patch only handles pin_user_pages() callers and
doesn't try to address other GUP users, right? E.g. if task A uses
process_vm_write() on task B while task B is going through fork(),
that can still race in such a way that the written data only shows up
in the child and not in B, right?

I dislike the whole pin_user_pages() concept because (as far as I
understand) it fundamentally tries to fix a problem in the subset of
cases that are more likely to occur in practice (long-term pins
overlapping with things like writeback), and ignores the rarer cases
("short-term" GUP).
