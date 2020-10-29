Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140D029E5AC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 09:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbgJ2IEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 04:04:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:47772 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbgJ2IDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 04:03:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603957875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BgtRc1tJzjcBk9DP7mLA/DnbL1eDZa5Y6LB/m/lUTuM=;
        b=R5OvWMfhoqRFhkFNUGx6yE44xwRsHuZDHMlTe6vER++0EGasTAr0YqUe5YQzCGo9R5R25y
        hvPp7gNUeHG6ow/n4Q9uBAo3tli+g1uaHLPCOoHNj158xwnG5WAN/7xB2OwQU3znt8LVYC
        r6C75PgN75sh4/fMhmKmbqcTD/sfoIU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 36466B012;
        Thu, 29 Oct 2020 07:51:15 +0000 (UTC)
Date:   Thu, 29 Oct 2020 08:51:14 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hui Su <sh_def@163.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/oom_kill: remove comment and rename
 is_dump_unreclaim_slabs()
Message-ID: <20201029075114.GA17500@dhcp22.suse.cz>
References: <20201027144529.GA3558@rlk>
 <20201027145814.GY20500@dhcp22.suse.cz>
 <20201027151156.GA4336@rlk>
 <20201027192322.GA20500@dhcp22.suse.cz>
 <20201028153141.GB77196@rlk>
 <20201028145330.1cf7a32bb109ccb50d2b0dbb@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028145330.1cf7a32bb109ccb50d2b0dbb@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 28-10-20 14:53:30, Andrew Morton wrote:
> On Wed, 28 Oct 2020 23:31:41 +0800 Hui Su <sh_def@163.com> wrote:
> 
> > Comment for is_dump_unreclaim_slabs is not really clear whether it is
> > meant to instruct how to use the function or whether it is an outdated
> > information of the past implementation of the function. it doesn't realy
> > help that is_dump_unreclaim_slabs is hard to grasp on its own.
> > 
> > Rename the helper to should_dump_unreclaim_slabs which should make it
> > clear what it is meant to do and drop the comment as the purpose
> > should be pretty evident now.
> > 
> 
> I think your recent attempt to improve the comment:
> 
> /*
>  * Check whether unreclaimable slabs amount is greater than all user
>  * memory(LRU pages).
>  */
> 
> was actually somewhat useful, and worth retaining.
> 
> It would be better if it explained *why* we're doing this, rather than
> simply "what we are doing"?
> 
> <looks at the code>
> 
> It's actually quite unobvious why we're doing this!

It's quite arbitrary criterion to print slab information in the oom
report. The current logic is to dump if there is more slabs than LRU
pages which should be pretty obvious from the code. Why this rather than
e.g. slab * k > lru? Well, no strong reason, AFAIK. We just want to
catch too much slab memory cases.

-- 
Michal Hocko
SUSE Labs
