Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F17A2ECBC7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 09:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbhAGIeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 03:34:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:40436 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbhAGIeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 03:34:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610008404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=atqkR6C9/ExhC/8cuG/QGTvgoAMgF5+BLpqtsv0ezpE=;
        b=eaMrF6pBLcI5HmqeMr5Jwf+N7AZJQq8O4+DcXq7tmFfc6hk/5BvC3NJALjUFiUgr3EsOQy
        TVCRQCSZ54+/t5HcLebSjTy5EAKb2FrsJwfKw9q95ofQN5XWd4wRKVxjX3MrehNuBRZ9cP
        UWa5doHmCnua8SQfLS3A6ARHjKlIsnI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 76E86B762;
        Thu,  7 Jan 2021 08:33:24 +0000 (UTC)
Date:   Thu, 7 Jan 2021 09:33:23 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmap: replace if (cond) BUG() with BUG_ON()
Message-ID: <20210107083323.GZ13207@dhcp22.suse.cz>
References: <1607743586-80303-1-git-send-email-alex.shi@linux.alibaba.com>
 <1607743586-80303-2-git-send-email-alex.shi@linux.alibaba.com>
 <e50574aa-87b8-8ddf-2235-ef98e22bcb7d@linux.alibaba.com>
 <alpine.LSU.2.11.2101051919130.1361@eggly.anvils>
 <20210106114620.5c221690f3a9cad7afcc3077@linux-foundation.org>
 <alpine.LSU.2.11.2101061150180.2400@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2101061150180.2400@eggly.anvils>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 06-01-21 12:10:30, Hugh Dickins wrote:
> On Wed, 6 Jan 2021, Andrew Morton wrote:
> > On Tue, 5 Jan 2021 20:28:27 -0800 (PST) Hugh Dickins <hughd@google.com> wrote:
> > 
> > > Alex, please consider why the authors of these lines (whom you
> > > did not Cc) chose to write them without BUG_ON(): it has always
> > > been preferred practice to use BUG_ON() on predicates, but not on
> > > functionally effective statements (sorry, I've forgotten the proper
> > > term: I'd say statements with side-effects, but here they are not
> > > just side-effects: they are their main purpose).
> > > 
> > > We prefer not to hide those away inside BUG macros
> > 
> > Should we change that?  I find BUG_ON(something_which_shouldnt_fail())
> > to be quite natural and readable.
> 
> Fair enough.  Whereas my mind tends to filter out the BUG lines when
> skimming code, knowing they can be skipped, not needing that effort
> to pull out what's inside them.
> 
> Perhaps I'm a relic and everyone else is with you: I can only offer
> my own preference, which until now was supported by kernel practice.

I agree with Hugh. BUG_ON on something that is not a trivial predicate
makes the code slightly harder to follow.

I also do agree that accomodating the coding style to the existing code
is better as well because the resulting code is more compact.

In general I consider code transformations like this without a higher
goal that is stated explicitly a pointless churn which doesn't bring
much while it consumes a very scarce review bandwidth. Even when those
look trivial there is always a room to introduce silent breakage.
Be it a checkpatch or coccinelle the change shouldn't be based solely on
the script complains. Really, what is the point of changing an existing
if (cond) BUG into BUG_ON? Fewer lines? Taste? Code consistency?
-- 
Michal Hocko
SUSE Labs
