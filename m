Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87BF275002
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 06:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgIWEfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 00:35:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27231 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726802AbgIWEfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 00:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600835707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FvFGx3rWCRs2m52pGzHi8mNBwRLDuVFOSz8HGbgXm5Y=;
        b=Oy3TV/3iNFGOuUspRM6EvsrWfeWCPqN1Wd0HwF/lHJabWGeWU/EVlzKJb3trAa7iqmumhB
        FzIyMhgVKr9NtKnvIAPjaLgW2HcnRZpCp44tIO3te7YE8fqVYBCjxRbSgMqBtkqeVCQMyr
        4ZNT3PRXCvxMYhF6LWlI5Qw+sTkSsU0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-THBCtSVMNrKph0Y5ketjig-1; Wed, 23 Sep 2020 00:35:04 -0400
X-MC-Unique: THBCtSVMNrKph0Y5ketjig-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82DB41007468;
        Wed, 23 Sep 2020 04:35:03 +0000 (UTC)
Received: from optiplex-lnx (unknown [10.3.128.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 779D010027A5;
        Wed, 23 Sep 2020 04:35:02 +0000 (UTC)
Date:   Wed, 23 Sep 2020 00:34:59 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm: swapfile: avoid split_swap_cluster() NULL pointer
 dereference
Message-ID: <20200923043459.GL795820@optiplex-lnx>
References: <20200922184838.978540-1-aquini@redhat.com>
 <878sd1qllb.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878sd1qllb.fsf@yhuang-dev.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 10:21:36AM +0800, Huang, Ying wrote:
> Hi, Rafael,
> 
> Rafael Aquini <aquini@redhat.com> writes:
> 
> > The swap area descriptor only gets struct swap_cluster_info *cluster_info
> > allocated if the swapfile is backed by non-rotational storage.
> > When the swap area is laid on top of ordinary disk spindles, lock_cluster()
> > will naturally return NULL.
> 
> Thanks for reporting.  But the bug looks strange.  Because in a system
> with only HDD swap devices, during THP swap out, the swap cluster
> shouldn't be allocated, as in
> 
> shrink_page_list()
>   add_to_swap()
>     get_swap_page()
>       get_swap_pages()
>         swap_alloc_cluster()
>

The underlying problem is that swap_info_struct.cluster_info is always NULL 
on the rotational storage case. So, it's very easy to follow that constructions 
like this one, in split_swap_cluster 

...
        ci = lock_cluster(si, offset);
        cluster_clear_huge(ci);
...

will go for a NULL pointer dereference, in that case, given that lock_cluster 
reads:

...
	struct swap_cluster_info *ci;
        ci = si->cluster_info;
        if (ci) {
                ci += offset / SWAPFILE_CLUSTER;
                spin_lock(&ci->lock);
        }
        return ci;
...


