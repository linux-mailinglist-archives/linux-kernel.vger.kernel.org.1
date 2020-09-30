Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E983027E7FC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 13:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbgI3LzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 07:55:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:36816 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgI3LzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 07:55:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601466906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ejKNHE0UFyqEBk7h2uyf05l7nr1RUgj4PZw1uir7ohM=;
        b=O8pXse5o8S+FxLSPFYMYcfq2SlzbpWZEp3RD4tOpHDzwYYNe731ThPPRGT2xhrVQiLy//v
        YbeJKQiuOAbDh5o6K1grN9ZErKnERRIiE0bxiHF4Sx9zl+8Q+ljsb7sQiv64MHAI+MV1kQ
        wi8eoc+3cMeYlejinBpW3Q8HOpA0kuk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3E255AE1B;
        Wed, 30 Sep 2020 11:55:06 +0000 (UTC)
Date:   Wed, 30 Sep 2020 13:55:05 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 00/30] 1GB PUD THP support on x86_64
Message-ID: <20200930115505.GT2277@dhcp22.suse.cz>
References: <20200928175428.4110504-1-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928175428.4110504-1-zi.yan@sent.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 28-09-20 13:53:58, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Hi all,
> 
> This patchset adds support for 1GB PUD THP on x86_64. It is on top of
> v5.9-rc5-mmots-2020-09-18-21-23. It is also available at:
> https://github.com/x-y-z/linux-1gb-thp/tree/1gb_thp_v5.9-rc5-mmots-2020-09-18-21-23
> 
> Other than PUD THP, we had some discussion on generating THPs and contiguous
> physical memory via a synchronous system call [0]. I am planning to send out a
> separate patchset on it later, since I feel that it can be done independently of
> PUD THP support.

While the technical challenges for the kernel implementation can be
discussed before the user API is decided I believe we cannot simply add
something now and then decide about a proper interface. I have raised
few basic questions we should should find answers for before the any
interface is added. Let me copy them here for easier reference
- THP allocation time - #PF and/or madvise context
- lazy/sync instantiation
- huge page sizes controllable by the userspace?
- aggressiveness - how hard to try
- internal fragmentation - allow to create THPs on sparsely or unpopulated
  ranges
- do we need some sort of access control or privilege check as some THPs
  would be a really scarce (like those that require pre-reservation).
-- 
Michal Hocko
SUSE Labs
