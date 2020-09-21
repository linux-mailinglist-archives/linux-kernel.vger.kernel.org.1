Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289DC2735C0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 00:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgIUW11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 18:27:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47234 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726457AbgIUW11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 18:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600727246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3Y3BFMMga4eqj/OQvqbNbqZ9EEiAzPKsrbE58dm7rTQ=;
        b=HBeoGyb1oOHWkKB93hztD+SJJ2ViFcuiYBYU305nqPIMI+o3x+slq+H41dWCYXB4jPdFor
        TNT1JTwFk4X7WaXUbAyUonxdOvYkCcEelbGIBOZTXxsMqt1/xn9ZPCRpPI9WW2y92t/51I
        8+7KXHGnRiwN4VulxO/RiJMRZjF6rwo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-My2_GGICMMC9pQiPnIylzQ-1; Mon, 21 Sep 2020 18:27:24 -0400
X-MC-Unique: My2_GGICMMC9pQiPnIylzQ-1
Received: by mail-qt1-f197.google.com with SMTP id j35so14305476qtk.14
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 15:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3Y3BFMMga4eqj/OQvqbNbqZ9EEiAzPKsrbE58dm7rTQ=;
        b=WIG7kbGXJq7avSoW6LKLzpE71cbF+xziJXy+pYlbfx8F0Y9hWQjGcHUxnv03DCKgqz
         60Padzk8mV6SO0Ee2dJFod1cnUm/ISCYYZHhVwEfX26sUFpBdAdYETYljlxFwoAbVBtx
         SuOiigGtfIy8MPXTUGKgAdY8oGnRXzxyhZO1DQOtwYirq+Qwejkw/Ued10YpDyqGOKG6
         /Z3cq/+051VJlImJWAO4DQvJjzG3BCpidvRNhGdnxI2mkBP63m+LBAZHP5vQN/eQA4Ci
         hSW4nv6RlOksED+Ixjrc4vyKyzOliDs+TccDT5BjPgRolBzLtu4mdtny1436/K4n77M0
         dqBw==
X-Gm-Message-State: AOAM530q1Ght0xsPmpZWSvgbj94H3zsmpgA6c6pwSS3B9Wv+hTfXzeB6
        iXTMo2RgSK5/YOo1ko/tWJDo+Rtbx3VrU0T+d/wJvQORqlfepDQSondDUYJ2Nhj+3ZWu382xEUI
        yxzEhVLBQ1nlhMDOnoaGB75N0
X-Received: by 2002:a37:638d:: with SMTP id x135mr2133309qkb.60.1600727243755;
        Mon, 21 Sep 2020 15:27:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXeszQ8v+I0gHuiyOcxO+4Ql50Jhun0n7Wk3k1WQyONvPgUy/yCr+GWhmxVp1Dq/luFIF0Tg==
X-Received: by 2002:a37:638d:: with SMTP id x135mr2133284qkb.60.1600727243472;
        Mon, 21 Sep 2020 15:27:23 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id c1sm11539452qta.86.2020.09.21.15.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 15:27:22 -0700 (PDT)
Date:   Mon, 21 Sep 2020 18:27:20 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jann Horn <jannh@google.com>
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
Subject: Re: [PATCH 4/5] mm: Do early cow for pinned pages during fork() for
 ptes
Message-ID: <20200921222720.GA19098@xz-x1>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921212028.25184-1-peterx@redhat.com>
 <CAG48ez3frkqQNHbE5bEB6rwYdbyoAA3B9FQZo=HKkUzWCM4H0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez3frkqQNHbE5bEB6rwYdbyoAA3B9FQZo=HKkUzWCM4H0Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jann,

On Mon, Sep 21, 2020 at 11:55:06PM +0200, Jann Horn wrote:
> On Mon, Sep 21, 2020 at 11:20 PM Peter Xu <peterx@redhat.com> wrote:
> > This patch is greatly inspired by the discussions on the list from Linus, Jason
> > Gunthorpe and others [1].
> >
> > It allows copy_pte_range() to do early cow if the pages were pinned on the
> > source mm.  Currently we don't have an accurate way to know whether a page is
> > pinned or not.  The only thing we have is page_maybe_dma_pinned().  However
> > that's good enough for now.  Especially, with the newly added mm->has_pinned
> > flag to make sure we won't affect processes that never pinned any pages.
> 
> To clarify: This patch only handles pin_user_pages() callers and
> doesn't try to address other GUP users, right? E.g. if task A uses
> process_vm_write() on task B while task B is going through fork(),
> that can still race in such a way that the written data only shows up
> in the child and not in B, right?

I saw that process_vm_write() is using pin_user_pages_remote(), so I think
after this patch applied the data will only be written to B but not the child.
Because when B fork() with these temp pinned pages, it will copy the pages
rather than write-protect them any more.  IIUC the child could still have
partial data, but at last (after unpinned) B should always have the complete
data set.

> 
> I dislike the whole pin_user_pages() concept because (as far as I
> understand) it fundamentally tries to fix a problem in the subset of
> cases that are more likely to occur in practice (long-term pins
> overlapping with things like writeback), and ignores the rarer cases
> ("short-term" GUP).

John/Jason or others may be better on commenting on this one.  From my own
understanding, I thought it was the right thing to do so that we'll always
guarantee process B gets the whole data.  From that pov this patch should make
sense even for short term gups.  But maybe I've missed something.

-- 
Peter Xu

