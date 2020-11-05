Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18A22A7F7E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 14:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730672AbgKENMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 08:12:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:54356 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgKENMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 08:12:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604581966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1cQMqepbRUufJd0LEl58+DQPcyB93jp5PFQf7B863kI=;
        b=Yj2zmeQgYC4Qz3x3Vx3Rl+rbY/imun55QtR3+OZKtLLLqB9CnvSo+uSmfrl/Ta9yjyiJ9A
        W+hJ2r5IXAGBcXCA+gVyC8KHTV8xmhL+ERrA48qR21Q5E5R+kiRriOjPid7RXhk6Vdxeeh
        wkMRFX7VwacyCIOPu7P4wCYQvYXttks=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 37DB2AD5C;
        Thu,  5 Nov 2020 13:12:46 +0000 (UTC)
Date:   Thu, 5 Nov 2020 14:12:45 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, dave.hansen@intel.com,
        ying.huang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] mm: fix OOMs for binding workloads to movable
 zone only node
Message-ID: <20201105131245.GH21348@dhcp22.suse.cz>
References: <20201104071308.GN21990@dhcp22.suse.cz>
 <20201104073826.GA15700@shbuild999.sh.intel.com>
 <20201104075819.GA10052@dhcp22.suse.cz>
 <20201104084021.GB15700@shbuild999.sh.intel.com>
 <20201104085343.GA18718@dhcp22.suse.cz>
 <20201105014028.GA86777@shbuild999.sh.intel.com>
 <20201105120818.GC21348@dhcp22.suse.cz>
 <4029c079-b1f3-f290-26b6-a819c52f5200@suse.cz>
 <20201105125828.GG21348@dhcp22.suse.cz>
 <20201105130710.GB16525@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105130710.GB16525@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 05-11-20 21:07:10, Feng Tang wrote:
[...]
> My debug traces shows it is, and its gfp_mask is 'GFP_KERNEL'

Can you provide the full information please? Which node has been
requested. Which cpuset the calling process run in and which node has
the allocation succeeded from? A bare dump_stack without any further
context is not really helpful.

-- 
Michal Hocko
SUSE Labs
