Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5463D2C6739
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 14:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730725AbgK0Nv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 08:51:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39542 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730049AbgK0NvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 08:51:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606485083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oL1K04H6TOx2kchIg7eSiLGosXHvS8ImhKROc4cKP4Y=;
        b=eHTeT/i3ngXOL5lFVBYUs+QtRxTCaGlN2zlf7CyaIVRXAOBJ5N156FnKuV3CGSGmxskfGH
        Gx9U49MugBj9PqZGlcUbMjMcmxn6eHfwaCZawjhRY4xM1eLwZu2rb4Gg+MXZzNFzfxjFvK
        NWyciIPADWR11bn/sHxn8CkeQpddrvo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-lBHLHQX6OjCtv-s6cDNC4A-1; Fri, 27 Nov 2020 08:51:21 -0500
X-MC-Unique: lBHLHQX6OjCtv-s6cDNC4A-1
Received: by mail-qk1-f197.google.com with SMTP id c71so3715859qkg.21
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 05:51:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oL1K04H6TOx2kchIg7eSiLGosXHvS8ImhKROc4cKP4Y=;
        b=YAEsS7h5CMRAOXr/uYHUXb4CxqX5TBkLba9gRSLtAvl2UVtBHJlqhHOEZqGCRW73JJ
         MXfNedLY1f2/LJzQsbVA715I+8NWu0INX5YXQYIHlv3zTdAskjiSrQ5oGR5LdgLqL6MQ
         U2sUIu0rfL42SJY6/zsPCgKUCCA8Vy5jxGzVetBFPxMGYxOP1lrI7C5ZWiwqKge08McZ
         sJHs9R0VyTzjHTJXGLlwZBay5FXjYjWHmhSN/2P1PHHypISJUpsRUsQEivcig+pSaMhZ
         uNQxKgoFnMJLca/fcjWmo43qeFJfbe7nwWgGqJWZpqN1ul8zWrzokzA7ATCZWJJ42KFT
         nfUg==
X-Gm-Message-State: AOAM532NHjml6wWo3//0+uF3bkCiNQVfK6gRVVwRObcKYtwNdCiH6scZ
        TsylodhPvzhNCls/695Qixls4jA+oVS32jq5QUT7zEye7NS+cv/3ziB19YvOPJDudkXjEnhgC8A
        UM6TgrHG64/MZO0Y7+vk+NyvG
X-Received: by 2002:a05:6214:2b4:: with SMTP id m20mr8544614qvv.34.1606485080428;
        Fri, 27 Nov 2020 05:51:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyJXidIHT7EKDJVOLGExk+yC7fmwmSmUOpt0hf48/TLb8mpxRnxTmgDelXwtSx2ylZxw5X/Cw==
X-Received: by 2002:a05:6214:2b4:: with SMTP id m20mr8544596qvv.34.1606485080151;
        Fri, 27 Nov 2020 05:51:20 -0800 (PST)
Received: from xz-x1 ([142.126.81.247])
        by smtp.gmail.com with ESMTPSA id r201sm5992534qka.114.2020.11.27.05.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 05:51:19 -0800 (PST)
Date:   Fri, 27 Nov 2020 08:51:17 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH] mm: Don't fault around userfaultfd-registered regions on
 reads
Message-ID: <20201127135117.GB6573@xz-x1>
References: <20201126222359.8120-1-peterx@redhat.com>
 <20201127122224.GX4327@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201127122224.GX4327@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew,

Thanks for the review comments.

On Fri, Nov 27, 2020 at 12:22:24PM +0000, Matthew Wilcox wrote:
> On Thu, Nov 26, 2020 at 05:23:59PM -0500, Peter Xu wrote:
> > For missing mode uffds, fault around does not help because if the page cache
> > existed, then the page should be there already.  If the page cache is not
> > there, nothing else we can do, either.  If the fault-around code is destined to
> > be helpless for userfault-missing vmas, then ideally we can skip it.
> 
> But it might have been faulted into the cache by another task, so skipping
> it is bad.

Is there a real use case of such?

I thought about it, at least for qemu postcopy it's not working like that.  I
feel like CRIU neither, but Mike could correct me.

Even if there's a case of that, for example, if task A tries to copy the pages
over to a tmpfs file and task B accesses the pages too with uffd missing
registered, the ideal solution is still that when a page is copied task A can
installs the pte for the current task, rather than relying on the fault around
on reads, IMHO.  I don't know whether there's a way to do it, though.

> 
> > For wr-protected mode uffds, errornously fault in those pages around could lead
> > to threads accessing the pages without uffd server's awareness.  For example,
> > when punching holes on uffd-wp registered shmem regions, we'll first try to
> > unmap all the pages before evicting the page cache but without locking the
> > page (please refer to shmem_fallocate(), where unmap_mapping_range() is called
> > before shmem_truncate_range()).  When fault-around happens near a hole being
> > punched, we might errornously fault in the "holes" right before it will be
> > punched.  Then there's a small window before the page cache was finally
> > dropped, and after the page will be writable again (NOTE: the uffd-wp protect
> > information is totally lost due to the pre-unmap in shmem_fallocate(), so the
> > page can be writable within the small window).  That's severe data loss.
> 
> Sounds like you have a missing page_mkwrite implementation.

I think it's slightly different issue, because shmem may not know whether the
page should be allowed to write or not.  AFAIU, uffd-wp is designed and
implemented in a way that the final protect information is kept within ptes so
e.g. vmas does not have a solid understanding on whether a page should be
write-protected or not (so VM_UFFD_WP in vma flags is a hint only, and also
that's why we won't abuse creating tons of vmas).  We tried hard to keep the
pte information on track, majorly _PAGE_UFFD_WP, alive even across swap in/outs
and migrations.  If pte is lost, we can't get that information from page cache,
at least for now.

> 
> > This patch comes from debugging a data loss issue when working on the uffd-wp
> > support on shmem/hugetlbfs.  I posted this out for early review and comments,
> > but also because it should already start to benefit missing mode userfaultfd to
> > avoid trying to fault around on reads.
> 
> A measurable difference?

Nop.  I didn't measure missing case.  It should really depend on whether
there's a use case of such, imho.  If there's, then we may still want that
(however uffd-wp might be a different story, as discussed above).  Otherwise
maybe we should just avoid doing that for all.

The other thing that led me to this patch (rather than only check against
uffd-wp, for which case I'll just keep that small patch in my own tree until
posting the uffd-wp series) is I thought about when the community would like to
introduce things like "minor-faults" for userfaultfd.  In that case we'd need
to be careful too here otherwise we may lose some minor faults.  And from that
pov I'm thinking whether it's easier to just forbid kernel-side tricks like
this for uffd in general, since as I also stated previously that IMHO if a
memory region is registered with userfaultfd, maybe it's always good to
"always" rely on the userspace on resolving page faults, so that we don't need
to debug things like uffd-wp data crash as userfaultfd evolves, because that'll
be non-trivial task at least to me...

Thanks,

-- 
Peter Xu

