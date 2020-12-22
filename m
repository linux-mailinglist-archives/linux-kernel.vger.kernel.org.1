Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E34F2E0A01
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 13:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgLVMYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 07:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgLVMYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 07:24:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77978C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 04:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=Osd9g2TNV5QvdwHKZvb3omjfetHJzVWlGemenPIEwH4=; b=gqW4nps1XLdJsgPKF5WzJ7KVqt
        9iMHScrzgpCF3rdWxXCCC2XRkMT5vxYMkfK0OpqvmTBst7MS5GZVtY0Lv+akjSGUWQqPQ+SyJ42ct
        3iHv53xIpSUpOE8AIbePdekzSJ02yvo6gw6urNLCRah1b7iMr0dfqFJVqKk3ner7+gmZmLRijTCH2
        G0+u5GyVEnmZu6TWn0j4Qa3PTytk3lJcrkoAxtkeHFLnrdd9nmAQTpMwPJqoaQNDkQwpTSlFfp502
        ezJzwmLTSgWXDlk5MEOnhWWn6zjmBhTvTzTjs10WUHUdQ+sjQ7+6atEnqz5VEI+nebWmnUd5t0YxT
        OAcHsVEA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1krgh6-0005Uy-E9; Tue, 22 Dec 2020 12:23:12 +0000
Date:   Tue, 22 Dec 2020 12:23:12 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Liang Li <liliangleo@didiglobal.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [RFC v2 PATCH 0/4] speed up page allocation for __GFP_ZERO
Message-ID: <20201222122312.GH874@casper.infradead.org>
References: <20201221162519.GA22504@open-light-1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201221162519.GA22504@open-light-1.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 11:25:22AM -0500, Liang Li wrote:
> Creating a VM [64G RAM, 32 CPUs] with GPU passthrough
> =====================================================
> QEMU use 4K pages, THP is off
>                   round1      round2      round3
> w/o this patch:    23.5s       24.7s       24.6s
> w/ this patch:     10.2s       10.3s       11.2s
> 
> QEMU use 4K pages, THP is on
>                   round1      round2      round3
> w/o this patch:    17.9s       14.8s       14.9s
> w/ this patch:     1.9s        1.8s        1.9s
> =====================================================

The cost of zeroing pages has to be paid somewhere.  You've successfully
moved it out of this path that you can measure.  So now you've put it
somewhere that you're not measuring.  Why is this a win?

> Speed up kernel routine
> =======================
> This can’t be guaranteed because we don’t pre zero out all the free pages,
> but is true for most case. It can help to speed up some important system
> call just like fork, which will allocate zero pages for building page
> table. And speed up the process of page fault, especially for huge page
> fault. The POC of Hugetlb free page pre zero out has been done.

Try kernbench with and without your patch.
