Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB0620BDDF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jun 2020 05:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgF0DNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 23:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgF0DNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 23:13:40 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371CBC03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 20:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0qSzBJi+XuKj7CRmKywfW9dDWMGYScdJeNBfiOOZ+Go=; b=Zoz0O+FeBjpB00KsH/icqN4hlA
        bJvQZcDlrmgrAAP+E7FTJFMzV8OXmiIF5uNvDaTR5pYc+7aidJbIdhZ9qZGPXa3hUg8JtBikKkR5b
        vUEjtn5eZB7T4+4RbDgZM6G47Ca7v7iXnfi21tBTlKuZ9mhz57aHn+vusYzH9YEalhcd+mwp3eG2U
        3TQDdl4RdR3bAH8A/1ChoWYiaHHBnNeTeGDGYNBPJlJWO5WrBay4wBMWhIKy1V5Du5Bt7WfsC75cH
        V8U0xLXF7bXbp5Ktg8Ku3T00ZTjJLp8hq//BgLqZ93NfBNEHqujQpSdtXWVl6I7+cPTNID85wTkNz
        dkXWi78w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jp1H7-0006RJ-0j; Sat, 27 Jun 2020 03:13:05 +0000
Date:   Sat, 27 Jun 2020 04:13:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.cz>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch] mm: Increase pagevec size on large system
Message-ID: <20200627031304.GC25039@casper.infradead.org>
References: <d1cc9f12a8ad6c2a52cb600d93b06b064f2bbc57.1593205965.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1cc9f12a8ad6c2a52cb600d93b06b064f2bbc57.1593205965.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 02:23:03PM -0700, Tim Chen wrote:
> Enlarge the pagevec size to 31 to reduce LRU lock contention for
> large systems.
> 
> The LRU lock contention is reduced from 8.9% of total CPU cycles
> to 2.2% of CPU cyles.  And the pmbench throughput increases
> from 88.8 Mpages/sec to 95.1 Mpages/sec.

The downside here is that pagevecs are often stored on the stack (eg
truncate_inode_pages_range()) as well as being used for the LRU list.
On a 64-bit system, this increases the stack usage from 128 to 256 bytes
for this array.

I wonder if we could do something where we transform the ones on the
stack to DECLARE_STACK_PAGEVEC(pvec), and similarly DECLARE_LRU_PAGEVEC
the ones used for the LRUs.  There's plenty of space in the header to
add an unsigned char sz, delete PAGEVEC_SIZE and make it an variable
length struct.

Or maybe our stacks are now big enough that we just don't care.
What do you think?

