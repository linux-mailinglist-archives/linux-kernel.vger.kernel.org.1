Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5AC82CDD09
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 19:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbgLCSEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 13:04:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30789 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726222AbgLCSEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 13:04:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607018559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a2+UpSo6XPrHw9eGBG0KMLvoOle6y6b1PoPGuGKDswg=;
        b=ZCQqG6SKWzdc90m8qgDgrqoWzaFfdGyoTMHvBiiggcKMYUVQB/oqOTDbdHNpceT9HramOO
        CmkQmybBMAwlmP8byoEMOzo5+OnYdQuPWRPyAPpmMKOD3yJxWWcneZWCQSalROsaq4DAC6
        EXIsHPB2L+Ym1F1zNXJenIOwgwRrdkc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-EcScNoQ8NHCdvaYgVMIGmA-1; Thu, 03 Dec 2020 13:02:37 -0500
X-MC-Unique: EcScNoQ8NHCdvaYgVMIGmA-1
Received: by mail-qk1-f197.google.com with SMTP id g28so2644870qka.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 10:02:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a2+UpSo6XPrHw9eGBG0KMLvoOle6y6b1PoPGuGKDswg=;
        b=hJw9uS4cfGzHoOZYprYLfwRnyaq6aLRgEAq1CIFjJrjhLF4aGuXTuEjG0zqK3EAABH
         GjDTgO6QiTdaGY238ttMunugxwxdJt+d16ACDNcDpP95Q9pY84Q40XIghndbK0PBDpTy
         yV0XF8d9AYsvGBJDFDQayj9tIYysI4eckU+C8j3fDGEzrTP3zH3NPwdPKTGdUt08YuKb
         p8N+XrxhfpIYNnNzzvL9YZipoa4sGRp0BGNx78Dr+YPKzo2qE9qAa3u7BxSAv3/t6G/l
         fT7k3YwvJVLBd+7kGVhT5wb5xK6EfUuWEPBxsKfVk3yYugppzbeZ7haBNMLtQHCdfL3x
         LKcQ==
X-Gm-Message-State: AOAM532KN9T7gtQqHSZ8uQ8TLaXbX0QQRWldC/fSDjq61qd5XmWBu87z
        B/2HB83Rzs8tQ0SkVYCU8V+8Pmp21/P6wqYL5/KmUgwSICyn7r1xK4gF19rDzSrLinLgs0hA39r
        Bc53thuORRNPkaqsUmNx8P9A/
X-Received: by 2002:a0c:c3cf:: with SMTP id p15mr195944qvi.13.1607018557311;
        Thu, 03 Dec 2020 10:02:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx6QB5+m7IR/CUDyS+SYYgOVMwH+T7exPAg4NObUJAzQFGaa22mijTPbvgciaVlOORdOrzuhw==
X-Received: by 2002:a0c:c3cf:: with SMTP id p15mr195906qvi.13.1607018556966;
        Thu, 03 Dec 2020 10:02:36 -0800 (PST)
Received: from xz-x1 ([142.126.94.187])
        by smtp.gmail.com with ESMTPSA id y192sm2281006qkb.12.2020.12.03.10.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:02:36 -0800 (PST)
Date:   Thu, 3 Dec 2020 13:02:34 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] mm: Don't fault around userfaultfd-registered regions
 on reads
Message-ID: <20201203180234.GJ108496@xz-x1>
References: <20201130230603.46187-1-peterx@redhat.com>
 <20201201125927.GB11935@casper.infradead.org>
 <20201201223033.GG3277@xz-x1>
 <X8bZk3jTGU8QyJWc@redhat.com>
 <alpine.LSU.2.11.2012021410260.4989@eggly.anvils>
 <20201202234117.GD108496@xz-x1>
 <alpine.LSU.2.11.2012022119010.11674@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2012022119010.11674@eggly.anvils>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 09:36:45PM -0800, Hugh Dickins wrote:
> On Wed, 2 Dec 2020, Peter Xu wrote:
> > On Wed, Dec 02, 2020 at 02:37:33PM -0800, Hugh Dickins wrote:
> > > On Tue, 1 Dec 2020, Andrea Arcangeli wrote:
> > > > 
> > > > Any suggestions on how to have the per-vaddr per-mm _PAGE_UFFD_WP bit
> > > > survive the pte invalidates in a way that remains associated to a
> > > > certain vaddr in a single mm (so it can shoot itself in the foot if it
> > > > wants, but it can't interfere with all other mm sharing the shmem
> > > > file) would be welcome...
> > > 
> > > I think it has to be a new variety of swap-like non_swap_entry() pte,
> > > see include/linux/swapops.h.  Anything else would be more troublesome.
> > > 
> > > Search for non_swap_entry and for migration_entry, to find places that 
> > > might need to learn about this new variety.
> > > 
> > > IIUC you only need a single value, no need to carve out another whole
> > > swp_type: could probably be swp_offset 0 of any swp_type other than 0.
> > > 
> > > Note that fork's copy_page_range() does not "copy ptes where a page
> > > fault will fill them correctly", so would in effect put a pte_none
> > > into the child where the parent has this uffd_wp entry.  I don't know
> > > anything about uffd versus fork, whether that would pose a problem.
> > 
> > Thanks for the idea, Hugh!
> > 
> > I thought about something similar today, but instead of swap entries, I was
> > thinking about constantly filling in a pte with a value of "_PAGE_PROTNONE |
> > _PAGE_UFFD_WP" when e.g. we'd like to zap a page with shmem+uffd-wp. I feel
> > like the fundamental idea is similar - we can somehow keep the pte with uffd-wp
> > information even if zapped/swapped-out, so as long as the shmem access will
> > fruther trap into the fault handler, then we can operate on that pte and read
> > that information out, like recover that pte into a normal pte (with swap/page
> > cache, and vma/addr information, we'll be able to) and then we can retry the
> > fault.
> 
> Yes, I think that should work too: I can't predict which way would cause
> less trouble.
> 
> We usually tend to keep away from protnone games, because NUMA balancing
> use of protnone is already confusing enough.

Yes it is tricky.  However it gives me the feeling that numa balancing and its
protnone trick provided a general solution for things like this, so that we can
trap a per-mm per-pte page access like this.

With that, I'm currently slightly prefer to try the protnone way first, because
using swp entry could be a bit misleading from the 1st glance - note that when
this happens, we could have two states for this pte:

  1. Page in shmem page cache
  2. Page in shmem swap cache (so page cache is a value)

And actually there's another 3rd state that should never happen as long as the
userspace does unprotect properly, but I guess we'd better also take care of:

  3. Page is not cached at all (page missing; logically should not happen
     because when page cache evicted then all ptes should have been removed,
     however since this pte is not linked to the page in any way, it could get
     lost?  Then we should simply retry the fault after recovering the tricky
     pte into an all-zero pte)

It'll be a bit odd imho to use a swp entry to represent all these states, for
example we can see the pte is a swp-like entry but in reality the shmem page
sits right in the page cache..

So I'm thinking whether we could decouple the pte_protnone() idea with numa
balancing first (currently, there's a close bind), let numa depend on protnone,
then uffd-wp+shmem can also depend on protnone.

> 
> But those ptes will be pte_present(), so you must provide a pfn,

Could I ask why?

> and I think if you use the zero_pfn, vm_normal_page() will return false on it,
> and avoid special casing (and reference counting) it in various places.

I'll keep this in mind, thanks.

Meanwhile, this reminded me another option - besides _PAGE_PROTNONE, can we use
_PAGE_SPECIAL?  That sounds better at least from its naming that it tells it's
a special page already. We can also leverage existing pte_special() checks here
and there, then mimic what we do with pte_devmap(), maybe?

-- 
Peter Xu

