Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35E32F27D2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 06:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388618AbhALFZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 00:25:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:45106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388269AbhALFZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 00:25:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B70C22CB1;
        Tue, 12 Jan 2021 05:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610429118;
        bh=uvDTU8FaU7yOkfe2pGLwnjQMQD4oR9HYmVqal4l7F9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YUWeUizltAb6WC6hTZu2VOz1v1fhKG+iqNO9l0CkRbiLuKE7pWggL6iKf12+AE5fs
         4DhYlvrKJV2wGOP7Qsu/PGo2/2hM1fvuAaB9L1rRReWCRqxxfLSSeWPb5wO9sU2VUs
         YW/R5PySDsru3JP5DcVGbbUNF7/r9WZa/aVWqr3Bsgn+sO1vmW0BG0g+5d7Fz2+dPu
         IZ8R9A6LfY5nZcCuj8sf2Wbzy2E/QwFz1gGw5w6BJRaO+WmBxfOOZYlyUYCtRZeuzw
         UKLr/FTqiTOoFPJDn1uK/a/8XkHxsUgOFnTn55w55uB9x8zgTJU0Yf3Q40BsnUYFoV
         oCpoKGej+yY8w==
Date:   Tue, 12 Jan 2021 07:25:08 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        David Hildenbrand <david@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v3 0/2] mm: fix initialization of struct page for holes
 in  memory layout
Message-ID: <20210112052508.GF1106298@kernel.org>
References: <20210111194017.22696-1-rppt@kernel.org>
 <20210111165801.ef35b01b15132d5513b2f3ce@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111165801.ef35b01b15132d5513b2f3ce@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 04:58:01PM -0800, Andrew Morton wrote:
> On Mon, 11 Jan 2021 21:40:15 +0200 Mike Rapoport <rppt@kernel.org> wrote:
> 
> > Commit 73a6e474cb37 ("mm: memmap_init: iterate over
> > memblock regions rather that check each PFN") exposed several issues with
> > the memory map initialization and these patches fix those issues.
> > 
> > Initially there were crashes during compaction that Qian Cai reported back
> > in April [1]. It seemed back then that the problem was fixed, but a few
> > weeks ago Andrea Arcangeli hit the same bug [2] and there was an additional
> > discussion at [3].
> 
> The earlier version of these fixes had cc:stable.  Was the omission
> this time deliberate?

Nope, it was accidental. 
Thanks for noticing.

-- 
Sincerely yours,
Mike.
