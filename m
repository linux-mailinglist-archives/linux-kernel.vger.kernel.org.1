Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7D92D2BCE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 14:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbgLHNZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 08:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgLHNZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 08:25:24 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8717AC061749
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 05:24:38 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id u16so1711826qvl.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 05:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T1isYDgNOE+W2Se2WweJvNcMIu/bUl82g6ebJ/LNKcU=;
        b=LxiKONrQHdtHhwSGFXZbRrBSyEbPrU5yj811v9vs/vE+7qDYrFlwKV99EXr0Q3cRIk
         vQ+ymv1wxeFAsKN5nVMpAhAFLIqt9DMP8du1lYrtrd5VH0ufoGaKqBhpiLsURwjMCqF2
         qRpOJ6BxfCYE9CaXCtbkxpgeoLa8DXrYBePbsePjEaKn+tz0WaerXDo7YN+SUwUUQlXc
         rAMMs9J3CCrWKCJYfZ62lpdjH6kDaBur1+NHAhqkCmyJbWAR8pfZmCw/Yon8NEJItu8s
         DA7apEDLUKx8XQG9q86aBb5NRzqMSOnHYvx4TTQVlXtwgkir3fwmQsPcP49C5sNTckAf
         DzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T1isYDgNOE+W2Se2WweJvNcMIu/bUl82g6ebJ/LNKcU=;
        b=HsoJakLWMwfs/W+vaYHBFxklMoYkjE22EhfD2UFn/ygy7PDUhLb8DpqoG6kM17KD1E
         dkeHloyZbfNn/zNf/1lChi+RfSd/3VmmPREh08AxZUw2X9xqdj+vBNvw1IC1ysDRimAd
         wpFrHmoK2EkebLtGSc3cPfk4TITKG1rJjCZrt1prAiUNxmUPjuKs/72X0wIflaTRiN5k
         sQoyFUORk8MlokAbXfMAMFuwMX2+PIaROKX79/CRa2bNVVIKCLESTPXqcDZW2To3VuIN
         /X1qOeaHHUxhWUsgRwhpxyd1SgW7aIstuZVkkZIGqc9dDam0eAgfjDtjKRivn25WMkzF
         N6bQ==
X-Gm-Message-State: AOAM533sHclTwiTvchu0wBsnGhqG6iy+9hvTZ7FiYR3Kp64JE2USBmYO
        /AECdpA8kJtKTk7f/Io0JuOdnw==
X-Google-Smtp-Source: ABdhPJyZJY645sm/nFuVEPVllkY/fRaekelCSSUjYfDlrFnd8MBXK6r0R4EqyY4TOyZ1JvnvCgY8sA==
X-Received: by 2002:ad4:4e09:: with SMTP id dl9mr2942254qvb.44.1607433877750;
        Tue, 08 Dec 2020 05:24:37 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id h9sm984790qkk.33.2020.12.08.05.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 05:24:36 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kmcyp-007uB3-Qi; Tue, 08 Dec 2020 09:24:35 -0400
Date:   Tue, 8 Dec 2020 09:24:35 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
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
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 6/6] mm/gup: migrate pinned pages out of movable zone
Message-ID: <20201208132435.GN5487@ziepe.ca>
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-7-pasha.tatashin@soleen.com>
 <20201202163507.GL5487@ziepe.ca>
 <CA+CK2bBT=U+xhbzXTDFwsL5wTvPHgNJ0DRpaeseiUq=w4EOe9w@mail.gmail.com>
 <20201203010809.GQ5487@ziepe.ca>
 <CA+CK2bBRgcCc5Nm0RcsEgVFpGBFC-_icA6UDRiqQxeRJE5U-Aw@mail.gmail.com>
 <20201203141729.GS5487@ziepe.ca>
 <87360lnxph.fsf@oracle.com>
 <20201204205233.GF5487@ziepe.ca>
 <87k0ttrp0v.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0ttrp0v.fsf@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 09:48:48PM -0500, Daniel Jordan wrote:
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> > On Fri, Dec 04, 2020 at 03:05:46PM -0500, Daniel Jordan wrote:
> >> Well Alex can correct me, but I went digging and a comment from the
> >> first type1 vfio commit says the iommu API didn't promise to unmap
> >> subpages of previous mappings, so doing page at a time gave flexibility
> >> at the cost of inefficiency.
> >
> > iommu restrictions are not related to with gup. vfio needs to get the
> > page list from the page tables as efficiently as possible, then you
> > break it up into what you want to feed into the IOMMU how the iommu
> > wants.
> >
> > vfio must maintain a page list to call unpin_user_pages() anyhow, so
> 
> It does in some cases but not others, namely the expensive
> VFIO_IOMMU_MAP_DMA/UNMAP_DMA path where the iommu page tables are used
> to find the pfns when unpinning.

Oh, I see.. Well, that is still possible, but vfio really needs to
batch operations, eg call pin_user_pages() with some larger buffer and
store those into the iommu and then reverse this to build up
contiguous runs of pages to unpin

> I don't see why vfio couldn't do as you say, though, and the worst case
> memory overhead of using scatterlist to remember the pfns of a 300g VM
> backed by huge but physically discontiguous pages is only a few meg, not
> bad at all.

Yes, but 0 is still better.. I would start by focusing on batching
pin_user_pages.

Jason
