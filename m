Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02B62A5F04
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 08:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgKDH6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 02:58:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:38666 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbgKDH6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 02:58:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604476699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o5t73FJL2cIGGLS9sQVQy/L//ynMdEds7tHewABSxig=;
        b=RAbSDf700bKOzDt8UkoSPQbN/PooV8eIPCyhSAIaGoEOFfEl/rHNu+aYgUyRt/KuDPxN84
        hKcyQLFCmm8AX27hSzNuZ/nNBnMagGLLrbIymwcaRBqPCwkzIXiHPzdbzwDhj96mKnCjKE
        h6tGSJemS0+z/9yHcL+ZNGdmsLgQMQM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C87D7AC24;
        Wed,  4 Nov 2020 07:58:19 +0000 (UTC)
Date:   Wed, 4 Nov 2020 08:58:19 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, dave.hansen@intel.com,
        ying.huang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] mm: fix OOMs for binding workloads to movable
 zone only node
Message-ID: <20201104075819.GA10052@dhcp22.suse.cz>
References: <1604470210-124827-1-git-send-email-feng.tang@intel.com>
 <20201104071308.GN21990@dhcp22.suse.cz>
 <20201104073826.GA15700@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104073826.GA15700@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04-11-20 15:38:26, Feng Tang wrote:
[...]
> > Could you be more specific about the usecase here? Why do you need a
> > binding to a pure movable node? 
> 
> One common configuration for a platform is small size of DRAM plus huge
> size of PMEM (which is slower but cheaper), and my guess of their use
> is to try to lead the bulk of user space allocation (GFP_HIGHUSER_MOVABLE)
> to PMEM node, and only let DRAM be used as less as possible. 

While this is possible, it is a tricky configuration. It is essentially 
get us back to 32b and highmem...

As I've said in reply to your second patch. I think we can make the oom
killer behavior more sensible in this misconfigured cases but I do not
think we want break the cpuset isolation for such a configuration.
-- 
Michal Hocko
SUSE Labs
