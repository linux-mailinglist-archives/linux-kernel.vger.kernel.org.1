Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16E82881D1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 07:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731644AbgJIFug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 01:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgJIFug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 01:50:36 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D063C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 22:50:34 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id t77so9090005oie.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 22:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=5WePdr/iw6Yd6Xdt25KouG+cEhpLu/D+hcK7anznQVc=;
        b=TUGzzv5wRU1uM6h4CcNL4Wh1RvtrSTNdLaI7tLLgFYGazofmizEnu4w09XCeRR3NLo
         87OAGGWxZnr5/Q/GOOlKdNBIxyJjKOoR2/xa/GPCmEylGVEMLv744oKJzyEAwkcesgkh
         6xV+QDc9RatvLv4SxOCoSfpX3IRx2M7XQ7Oo9MsS15Af+1kS0eMc3VywzvNTpWyUpP3z
         cr63hDaVXf6M9gAdnDzm5kL+BEED/Ana5ChJouGGlj7zYS94pQTyAsuGO/2k/nU0YPv6
         1GfhJrhPpcupmNPmF8YQBfWSAdE7+FE0lvJBJuG3puybXURrDWVub9MwShhtbxy6Kf4D
         qeGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=5WePdr/iw6Yd6Xdt25KouG+cEhpLu/D+hcK7anznQVc=;
        b=qWv29lCfIx4mSH4PFl8mPmoipmfnpq6mkYYotyPZloJDKXn5BpFyL6Dwg0h0u7f2D2
         z/a6GXWMBUrNzPahKH9yg66erFmoEAGkio4ykHq+HTh8mAWx69mRFUMqh5k/sH0+pc1q
         7u2gNzb2p8gEneTlfOYMDu/cOrayoMo4+3Eg2dLKM3/eFrqXAQIzE7z6mtr6vsEECOvo
         2BAkBvnCSvat6WXAIekzDt/6vcKrNRixutbOJOdezzpFCvkUh9fhmpEG4+cGMf+x7GtX
         kqv42m/PCNIDDDMUXaVYxHRPY1IqgEyDsHZRsVwiRk+IxtXKttYgiesI7lA7/49oN/5n
         GEFA==
X-Gm-Message-State: AOAM531hGQqYxjQDVCps3ydeWBkaScgQzAozLvopXvX5v1MTXXQD/CCU
        Ed9MrO4xh/CwMNWNJVHGiUp89Q==
X-Google-Smtp-Source: ABdhPJyGod/abwBc9sNxWCaq+vdZroBiHEzDZZBsRkggm2Xfo5o5KmvSEYQcdA8A4ErKxYGMqYir5Q==
X-Received: by 2002:aca:cfce:: with SMTP id f197mr1533894oig.44.1602222633666;
        Thu, 08 Oct 2020 22:50:33 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id r62sm6678939oih.12.2020.10.08.22.50.31
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 08 Oct 2020 22:50:32 -0700 (PDT)
Date:   Thu, 8 Oct 2020 22:50:16 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Mike Kravetz <mike.kravetz@oracle.com>
cc:     Hugh Dickins <hughd@google.com>, Qian Cai <cai@lca.pw>,
        js1304@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v3 7/8] mm/mempolicy: use a standard migration target
 allocation callback
In-Reply-To: <cf715524-f30d-634f-2a05-e02c4e52e675@oracle.com>
Message-ID: <alpine.LSU.2.11.2010082216250.10228@eggly.anvils>
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com> <1592892828-1934-8-git-send-email-iamjoonsoo.kim@lge.com> <20200708012044.GC992@lca.pw> <alpine.LSU.2.11.2010071833100.2214@eggly.anvils>
 <cf715524-f30d-634f-2a05-e02c4e52e675@oracle.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Oct 2020, Mike Kravetz wrote:
> On 10/7/20 8:21 PM, Hugh Dickins wrote:
> > 
> > Mike, j'accuse... your 5.7 commit c0d0381ade79 ("hugetlbfs:
> > use i_mmap_rwsem for more pmd sharing synchronization"), in which
> > unmap_and_move_huge_page() now passes the TTU_RMAP_LOCKED flag to
> > try_to_unmap(), because it's already holding mapping->i_mmap_rwsem:
> > but that is not the right lock to secure an anon_vma lookup.
> 
> Thanks Hugh!  Your analysis is correct and the code in that commit is
> not correct.  I was so focused on the file mapping case, I overlooked
> (actually introduced) this issue for anon mappings.
> 
> Let me verify that this indeed is the root cause.  However, since
> move_pages12 migrated anon hugetlb pages it certainly does look to be
> the case.
> 
> > I intended to send a patch, passing TTU_RMAP_LOCKED only in the
> > !PageAnon case (and, see vma_adjust(), anon_vma lock conveniently
> > nests inside i_mmap_rwsem); but then wondered if i_mmap_rwsem was
> > needed in that case or not, so looked deeper into c0d0381ade79.
> > 
> > Hmm, not even you liked it!  But the worst of it looks simply
> > unnecessary to me, and I hope can be deleted - but better by you
> > than by me (in particular, you were trying to kill 1) and 2) birds
> > with one stone, and I've always given up on understanding hugetlb's
> > reservations: I suspect that side of it is irrelevant here,
> > but I wouldn't pretend to be sure).
> > 
> > How could you ever find a PageAnon page in a vma_shareable() area?
> > 
> > It is all rather confusing (vma_shareable() depending on VM_MAYSHARE,
> > whereas is_cow_mapping() on VM_SHARED and VM_MAYWRITE: they have to
> > be studied together with do_mmap()'s 
> > 			vm_flags |= VM_SHARED | VM_MAYSHARE;
> > 			if (!(file->f_mode & FMODE_WRITE))
> > 				vm_flags &= ~(VM_MAYWRITE | VM_SHARED);
> > 
> > (And let me add to the confusion by admitting that, prior to 3.15's
> > cda540ace6a1 "mm: get_user_pages(write,force) refuse to COW in
> > shared areas", maybe it was possible to find a PageAnon there.)
> > 
> > But my belief (best confirmed by you running your tests with a
> > suitably placed BUG_ON or WARN_ON) is that you'll never find a
> > PageAnon in a vma_shareable() area, so will never need try_to_unmap()
> > to unshare a pagetable in the PageAnon case, so won't need i_mmap_rwsem
> > for PageAnon there, and _get_hugetlb_page_mapping() (your function that
> > deduces an address_space from an anon_vma) can just be deleted.
> 
> Yes, it is confusing.  Let me look into this.  I would be really happy
> to delete that ugly function.
> 
> > (And in passing, may I ask what hugetlb_page_mapping_lock_write()'s
> > hpage->_mapcount inc and dec are for?  You comment it as a hack,
> > but don't explain what needs that hack, and I don't see it.)
> 
> We are trying to lock the mapping (mapping->i_mmap_rwsem).  We know
> mapping is valid, because we obtained it from page_mapping() and it
> will remain valid because we have the page locked.  Page needs to be
> unlocked to unmap.  However, we have to drop page lock in order to
> acquire i_mmap_rwsem.  Once we drop page lock, mapping could become
> invalid.  So, the code code artifically incs mapcount so that mapping
> will remain valid when upmapping page.

No, unless you can point me to some other hugetlbfs-does-it-differently
(and I didn't see it there in that commit), raising _mapcount does not
provide any such protection; but does add the possiblility of a
"BUG: Bad page cache" and leak from unaccount_page_cache_page().

Earlier in the day I was trying to work out what to recommend instead,
but had to turn aside to something else: I'll try again tomorrow.

It's a problem I've faced before in tmpfs, keeping a hold on the
mapping while page lock is dropped.  Quite awkward: igrab() looks as
if it's the right thing to use, but turns out to give no protection
against umount.  Last time around, I ended up with a stop_eviction
count in the shmem inode, which shmem_evict_inode() waits on if
necessary.  Something like that could be done for hugetlbfs too,
but I'd prefer to do it without adding extra, if there is a way.

> 
> As mentioned above, I hope all this can be removed.

If you continue to nest page lock inside i_mmap_rwsem for hugetlbfs,
then I think that part of hugetlb_page_mapping_lock_write() has to
remain.  I'd much prefer that hugetlbfs did not reverse the usual
nesting, but accept that you had reasons for doing it that way.

Hugh
