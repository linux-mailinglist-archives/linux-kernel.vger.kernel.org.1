Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A122D82E5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 00:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407239AbgLKXuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 18:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407240AbgLKXus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 18:50:48 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBDDC0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 15:50:07 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id 1so10248640qka.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 15:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HrpGpeVouHWBAWlwrnZQ4b3o3PuUhfDT7U1jbXkeBu0=;
        b=GkXTizU3ycac1nelpZF2sNwUDnkJz+uMtcieEL8oScb/rVsKe9rafWpqBC7NOxOPn4
         f4bbSpVGMC2pK+wSiXWHy3ydET3zlc7CsmT9WXsaxYTWGKWOtBmsJiFY/4s86W0SDS59
         GeEuQdfKrA3twfw40/pfwcJR/neFN5aGRZVppTKKoxZnCxMua4Lnd9mCkqyQkNQJH6B3
         TxNb3EcXzodCmFq8AmRiIXZTgOncSfUI0GsMML3F+KF90CPFhhY5+rMKX31FpbnHyNry
         9AKN/hy8qVJY4/JcrIbXDI+BvczTI11Evh7DMHoe7XtKHBa9J9HFBgZqVdipReMAWcaJ
         CQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HrpGpeVouHWBAWlwrnZQ4b3o3PuUhfDT7U1jbXkeBu0=;
        b=XP7u8Zd8r5SdKtrQPb29IYwB85Cy72pFhdnqek7s3XRfQjzSDBEBTkUaMXbNa9X9KN
         75auNJ4++eTIgVAXvPIp57a7DCDhr3Ip7ejJlvYZU3u7Nls96+7Fdm82t4tFaNkB32f2
         E1k32THB99PzuTMDY0SsHXjnitOrfXAhbhd/qxcy0mQpWU11d8C7S6hcImX5tuG08IIg
         RvhB6tInpKrjTFj4KYFHg5Wl+DR8Do7n+UClZX3RUZV7uszP1R5DcvwukpmaALaRKv0k
         jKMr5BrFvSNKdDp36rvceruTq8Fou8wZvc92ILVD0O9ka0/GULDIWiIAnkK7WhQnOBjh
         7ajw==
X-Gm-Message-State: AOAM532xju9UDI0nobROizTx0NuUWtcBKr/YGer3+Hu5S3DXhHfAAWMA
        1I3gBE0H+c597ixDZRyz7rbnQg==
X-Google-Smtp-Source: ABdhPJwRik/cgYcUX4O4YYOW6YknrDcIWCPIuQc0ZZLz/iLsSfNxZJmy3774/8jUzLnYsn9Z5QZpag==
X-Received: by 2002:a37:c92:: with SMTP id 140mr18588142qkm.152.1607730607157;
        Fri, 11 Dec 2020 15:50:07 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id v204sm8719490qka.4.2020.12.11.15.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 15:50:06 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1knsAn-009OHS-Jq; Fri, 11 Dec 2020 19:50:05 -0400
Date:   Fri, 11 Dec 2020 19:50:05 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     David Hildenbrand <david@redhat.com>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, mike.kravetz@oracle.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 5/6] mm/gup: migrate pinned pages out of movable zone
Message-ID: <20201211235005.GE5487@ziepe.ca>
References: <CA+CK2bCc9gk3Yy+ueaZVJs90MFE3fqukLsdb5R2kTUH4tWRbkA@mail.gmail.com>
 <447A41F3-EB94-4DA4-8B98-038B127774A5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447A41F3-EB94-4DA4-8B98-038B127774A5@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 10:53:00PM +0100, David Hildenbrand wrote:

> > When check_and_migrate_movable_pages() is called, the pages are
> > already pinned. If some of those pages are in movable zone, and we
> > fail to migrate or isolate them what should we do: proceed, and
> > keep it as exception of when movable zone can actually have pinned
> > pages or unpin all pages in the array, and return an error, or
> > unpin only pages in movable zone, and return an error?
> 
> I guess revert what we did (unpin) and return an error. The
> interesting question is what can make migration/isolation fail
> 
> a) out of memory: smells like a zone setup issue. Failures are acceptable I guess.

Out of memory is reasonable..
 
> b) short term pinnings: process dying - not relevant I guess. Other cases? (Fork?)

Concurrent with non-longterm GUP users are less reasonable, fork is
not reasonable, etc..

Racing with another GUP in another thread is also not reasonable, so
failing to isolate can't be a failure

Jasnon
