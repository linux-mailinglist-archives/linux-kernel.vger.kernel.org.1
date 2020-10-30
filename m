Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B90529FFCC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 09:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgJ3IZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 04:25:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:36532 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgJ3IZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 04:25:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604046318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TlqCc445gHa4XWddBXHmQOwC+ZbidmpZH/MCUItZO28=;
        b=cRZ7sKHzINgJBComDadhYBb4ZxkFePL4FZ8wqGbVKvc7wZACT7qdiHOQEvP0z3lmxP+/Ur
        gA/a5Ka0jvM9XCWI0sxD8YwZ+9cO2a1qz1GMXoZ5su6MLcg85BFBPvxi7A/4uQY66xLS3H
        T4mkFih8LVEbOqYF1mh0wwWRzAbrTxg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9FB0FAD31;
        Fri, 30 Oct 2020 08:25:18 +0000 (UTC)
Date:   Fri, 30 Oct 2020 09:25:17 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Rafael Aquini <aquini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Rik van Riel <riel@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH -V2 1/2] mempolicy: Rename MPOL_F_MORON to MPOL_F_MOPRON
Message-ID: <20201030082517.GD1478@dhcp22.suse.cz>
References: <20201028023411.15045-1-ying.huang@intel.com>
 <20201028023411.15045-2-ying.huang@intel.com>
 <20201029090421.GC17500@dhcp22.suse.cz>
 <87h7qcxjew.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7qcxjew.fsf@yhuang-dev.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 30-10-20 15:27:51, Huang, Ying wrote:
> Michal Hocko <mhocko@suse.com> writes:
> 
> > On Wed 28-10-20 10:34:10, Huang Ying wrote:
> >> To follow code-of-conduct better.
> >
> > This is changing a user visible interface and any userspace which refers
> > to the existing name will fail to compile unless I am missing something.
> 
> Although these flags are put in uapi, I found these flags are actually
> internal flags used in "flags" field of struct mempolicy, they are never
> used as flags for any user space API.  I guess they are placed in uapi
> header file to guarantee they aren't conflict with MPOL_MODE_FLAGS.

You are right. I have missed that. The comment in the header even explains
that. Anyway the placement is rather unusual and I think that those
flags do not belong there.
 
> > Have you checked how many applications would be affected?
> 
> Based on above analysis, I think there is no application that will be
> affected.
> 
> > Btw I find "follow CoC better" a very weak argument without further
> > explanation.
> 
> That is the only reason for the patch.  If nobody thinks the change is
> necessary, I can just drop the patch.

Well, to be honest I do not see any problem with the naming.
-- 
Michal Hocko
SUSE Labs
