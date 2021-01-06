Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9C82EC0DD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 17:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbhAFQJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 11:09:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:42068 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbhAFQJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 11:09:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609949308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DqIGbcceYvDxkWsAJN0aQAT/RO0PdGdUprcpKKPoJYc=;
        b=FVZ5LPOFge/VBmJ/fHjfRqNhyng0Huq1LpfiWWD8JBDYkeUpBuOzuKdagFWmKgeB4wDJSF
        HOCiWnDetJMcdA9xdbaqvnv8ZyuuS79gUWWGdKyhKnSpEyBK8T/nl+UcqSKksTj18dDQ60
        ucJYQeRrMLsVu65tHG7RQoeTGpgmM0M=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7A7FBAD8C;
        Wed,  6 Jan 2021 16:08:28 +0000 (UTC)
Date:   Wed, 6 Jan 2021 17:08:27 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Liang Li <liliang324@gmail.com>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Liang Li <liliangleo@didiglobal.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 3/6] hugetlb: add free page reporting support
Message-ID: <20210106160827.GO13207@dhcp22.suse.cz>
References: <20210106034918.GA1154@open-light-1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106034918.GA1154@open-light-1.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 05-01-21 22:49:21, Liang Li wrote:
> hugetlb manages its page in hstate's free page list, not in buddy
> system, this patch try to make it works for hugetlbfs. It canbe
> used for memory overcommit in virtualization and hugetlb pre zero
> out.

David has layed down some more fundamental questions in the reply to the
cover letter (btw. can you fix your scripts to send patches and make all
the patches to be in reply to the cover letter please?). But I would
like to point out that this changelog would need to change a lot as
well. It doesn't explain really what, why and how. E.g. what would any
guest gain by being able to report free huge pages? What would guarantee
that the pool is replenished when there is a demand? Can this make the
fault fail or it just takes more time to be satisfied? Why did you
decide that the reporting infrastructure should be abused to do the
zeroying? I do remember Alexander pushing back against that and so you
should better have a very strong arguments to proceed that way.

I am pretty sure there are more questions to come when more details are
uncovered.
-- 
Michal Hocko
SUSE Labs
