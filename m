Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE752AC07B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 17:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbgKIQGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 11:06:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:41144 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727774AbgKIQGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 11:06:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604937979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8X96c2/H5wzDkqogVwautXAUAzUmZ3oj3YSRgwu1wjs=;
        b=Xrr1q1Kpx83+bHS3BP0vuURiWs0c741Dw7MaSEVo3payss/4etcMOpUmKHXKNK1IoxwHFd
        da6YR6W4TLOeoWU9CunN7gQcvjwxGk4LSW+qa5+LF9frnqKrWUndLDO8CoOF056SmreTTd
        y71oU4G+FLtuiBEauZPkKQlAt8sxmR4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5744AAB93;
        Mon,  9 Nov 2020 16:06:19 +0000 (UTC)
Date:   Mon, 9 Nov 2020 17:06:18 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: introduce oom_kill_disable sysctl knob
Message-ID: <20201109160618.GI12240@dhcp22.suse.cz>
References: <20201106203238.1375577-1-minchan@kernel.org>
 <20201109073706.GA12240@dhcp22.suse.cz>
 <20201109153933.GA449970@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109153933.GA449970@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09-11-20 07:39:33, Minchan Kim wrote:
> On Mon, Nov 09, 2020 at 08:37:06AM +0100, Michal Hocko wrote:
> > On Fri 06-11-20 12:32:38, Minchan Kim wrote:
> > > It's hard to have some tests to be supposed to work under heavy
> > > memory pressure(e.g., injecting some memory hogger) because
> > > out-of-memory killer easily kicks out one of processes so system
> > > is broken or system loses the memory pressure state since it has
> > > plenty of free memory soon so.
> > 
> > I do not follow the reasoning here. So you want to test for a close to
> > no memory available situation and the oom killer stands in the way
> > because it puts a relief?
> 
> Yub, technically, I'd like to have consistent memory pressure to cause
> direct reclaims on proesses on the system and swapping in/out.
 
> > 
> > > Even though we could mark existing process's oom_adj to -1000,
> > > it couldn't cover upcoming processes to be forked for the job.
> > 
> > Why?
> 
> Thing is the system has out-of-control processes created on demand.
> so only option to prevent OOM is echo -1000 > `pidof the process`
> since they are forked. However, I have no idea when they are forked
> so should race with OOM with /proc polling and OOM is frequently
> ahead of me.

I am still confused. Why would you want all/most processes to be hidden
from the oom killer?
 
> > > This knob is handy to keep system memory pressure.
> > 
> > This sounds like a very dubious reason to introduce a knob to cripple
> > the system.
> > 
> > I can see some reason to control the oom handling policy because the
> > effect of the oom killer is really disruptive but a global on/off switch
> > sounds like a too coarse interface. Really what kind of production
> > environment would ever go with oom killer disabled completely?
> 
> I don't think shipping production system will use it. It would be
> just testing only option.

Then it doesn't really belong to the kernel IMHO.

> My intention uses such heavy memory load to see various system behaviors
> before the production launching because it usually happens in real workload
> once we shipped but hard to generate such a corner case without artificial
> memory pressure.

But changing the oom behavior will result in a completely different
system behavior. So you would be testing something that doesn't really
happen in any production system.

> Any suggestion?

Not really because I still do not understand your objective. You can
generate memory pressure and tune it up for specific testing scenario.
Sure there will be a some interference from the background noise (kernel
subsystems reacting to external events, processes created etc.) but why
that is a problem? This is normal to any running system.

-- 
Michal Hocko
SUSE Labs
