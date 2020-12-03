Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3132CD8D2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 15:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730892AbgLCOSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 09:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgLCOSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 09:18:12 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97D3C061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 06:17:31 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id q5so2100742qkc.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 06:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8OibpZHqlmZvNVYfBDxh1hs2pxMvlwSThz0lOwApQaI=;
        b=dk5q4Lr+q5IgxWjo0A+9TcXXXrq384wcGpfFnW+QthnBUzC+5B7hiePCXYDMPpV6jE
         sNhAIvlE1T5mx9PVfjK4oGcrSWpFcFeMzVu+qY+xubhZBvnXhJhAYP38b89l5ZZYibf9
         ocSsdnRcueGyZCJvpT9QabpaDr/Oo55UVTpqQqm85hxK8UMQ3mqzE4IQkNLC9Wqo4cqT
         emcy7qR9d49DEeksCWwyjYGTuliI6iG0poQtlw8IIaDRn7kfinv8yVxM077suxO3eOa4
         2KIKuaU0HTR6fp16fNrja+iOMPZgFPEyX6CGqQX4l857+vRgOlhbFMG5sIDG1rPhATEl
         L8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8OibpZHqlmZvNVYfBDxh1hs2pxMvlwSThz0lOwApQaI=;
        b=NmG7jL0gl05RI97HQWLU6z5+a9Y5MkMjGn+Vj4KGkoaB4BmHP8p1ujatA0nPJK4Jnx
         U7A0oDruYUz4oy8RRIGhLELH0/yb1tLBqjDWxNPEx+zo9oBQnbJpjSvuG29X2qBDJh4g
         rW2ZfRyeDqIEOpUShi/7ebNO9LzKE9Y1LXhNTd22hsWXOhXEU7/dmXYl8fYoKMGQ/7TV
         HYg7WI8hFtzheLAII/iUvlgbAx6gUejp5iQ4cbc6fpmt8cdCVUvw3U4+ddltMAQn9udq
         Xx+aThNHuguss6XoFYt4M64CJf/ByYFU+cSRPDobgwb5uudQ+o/M10TFw0l3ilmPV/X1
         fYYA==
X-Gm-Message-State: AOAM532t5rSXXksLigWNmEvPm/qTvnyID1wXCdOmoPw+HL6+rvPniMuO
        tLnjotBt+57OrVdbnCmFsQ0ILQ==
X-Google-Smtp-Source: ABdhPJwekmPGYB/ERv8yHMpnOrpDO1avwVj040d2RPkHZ1T7FlCYSfz1dxpVnmg6r8sbfURRChh19A==
X-Received: by 2002:a05:620a:1489:: with SMTP id w9mr3060597qkj.43.1607005051082;
        Thu, 03 Dec 2020 06:17:31 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id k188sm1386697qkd.98.2020.12.03.06.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 06:17:29 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kkpQH-005V9B-25; Thu, 03 Dec 2020 10:17:29 -0400
Date:   Thu, 3 Dec 2020 10:17:29 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
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
Message-ID: <20201203141729.GS5487@ziepe.ca>
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-7-pasha.tatashin@soleen.com>
 <20201202163507.GL5487@ziepe.ca>
 <CA+CK2bBT=U+xhbzXTDFwsL5wTvPHgNJ0DRpaeseiUq=w4EOe9w@mail.gmail.com>
 <20201203010809.GQ5487@ziepe.ca>
 <CA+CK2bBRgcCc5Nm0RcsEgVFpGBFC-_icA6UDRiqQxeRJE5U-Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bBRgcCc5Nm0RcsEgVFpGBFC-_icA6UDRiqQxeRJE5U-Aw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 08:34:32PM -0500, Pavel Tatashin wrote:

> > Either here or perhaps even lower down the call chain when the page is
> > captured, similar to how GUP fast would detect it. (how is that done
> > anyhow?)
> 
> Ah, thank you for pointing this out. I think I need to address it here:
> 
> https://soleen.com/source/xref/linux/mm/gup.c?r=96e1fac1#94
> 
> static __maybe_unused struct page *try_grab_compound_head()
>               if (unlikely(flags & FOLL_LONGTERM) &&  is_migrate_cma_page(page))
>                    return NULL;
> 
> I need to change is_migrate_cma_page() to all migratable pages. Will
> study, and send an update with this fix.

Yes, missing the two flows is a common error :(

Looking at this code some more.. How is it even correct?

1633  				if (!isolate_lru_page(head)) {
1634  					list_add_tail(&head->lru, &cma_page_list);

Here we are only running under the read side of the mmap sem so multiple
GUPs can be calling that sequence in parallel. I don't see any
obvious exclusion that will prevent corruption of head->lru. The first
GUP thread to do isolate_lru_page() will ClearPageLRU() and the second
GUP thread will be a NOP for isolate_lru_page().

They will both race list_add_tail and other list ops. That is not OK.

> What I meant is the users of the interface do it incrementally not in
> large chunks. For example:
> 
> vfio_pin_pages_remote
>    vaddr_get_pfn
>         ret = pin_user_pages_remote(mm, vaddr, 1, flags |
> FOLL_LONGTERM, page, NULL, NULL);
> 1 -> pin only one pages at a time

I don't know why vfio does this, it is why it so ridiculously slow at
least.

Jason
