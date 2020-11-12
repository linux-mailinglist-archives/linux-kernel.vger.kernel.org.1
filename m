Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2165E2B076E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 15:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgKLOQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 09:16:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:39540 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgKLOQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 09:16:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605190617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LJVHqV6LpWMWjpPpVPlLXoFg+2DXw5+X4zlwjH+FBLM=;
        b=U4sXm95NbyFSttsfUPs2xOdhTtY4E2oTcWrDTGvDHhem9gNboSkNck8fbFpVMvLxsDQohA
        mzmtaDZ084234AnF1FHveZwjcIO0OUFHhAMTnyn40qh0TUtIoRLlDLFcTlmJTZ96oDMfE3
        PndsQYUgaTEjV+oXdnCXiJMsyxua2tM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 39210ACC2;
        Thu, 12 Nov 2020 14:16:57 +0000 (UTC)
Date:   Thu, 12 Nov 2020 15:16:54 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Waiman Long <longman@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, zhengjun.xing@intel.com, ying.huang@intel.com
Subject: Re: [LKP] Re: [mm/memcg] bd0b230fe1: will-it-scale.per_process_ops
 -22.7% regression
Message-ID: <20201112141654.GC12240@dhcp22.suse.cz>
References: <20201102091543.GM31092@shao2-debian>
 <20201102092754.GD22613@dhcp22.suse.cz>
 <82d73ebb-a31e-4766-35b8-82afa85aa047@intel.com>
 <20201102100247.GF22613@dhcp22.suse.cz>
 <bd87e8bd-c918-3f41-0cc5-e2927d91625f@linux.intel.com>
 <20201104081546.GB10052@dhcp22.suse.cz>
 <20201112122844.GA11000@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112122844.GA11000@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 12-11-20 20:28:44, Feng Tang wrote:
> Hi Michal,
> 
> On Wed, Nov 04, 2020 at 09:15:46AM +0100, Michal Hocko wrote:
> > > > > Hi Michal,
> > > > > 
> > > > > We used the default configure of cgroups, not sure what configuration you
> > > > > want,
> > > > > could you give me more details? and here is the cgroup info of will-it-scale
> > > > > process:
> > > > > 
> > > > > $ cat /proc/3042/cgroup
> > > > > 12:hugetlb:/
> > > > > 11:memory:/system.slice/lkp-bootstrap.service
> > > > 
> > > > OK, this means that memory controler is enabled and in use. Btw. do you
> > > > get the original performance if you add one phony page_counter after the
> > > > union?
> > > > 
> > > I add one phony page_counter after the union and re-test, the regression
> > > reduced to -1.2%. It looks like the regression caused by the data structure
> > > layout change.
> > 
> > Thanks for double checking. Could you try to cache align the
> > page_counter struct? If that helps then we should figure which counters
> > acks against each other by adding the alignement between the respective
> > counters. 
> 
> We tried below patch to make the 'page_counter' aligned.
>   
>   diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
>   index bab7e57..9efa6f7 100644
>   --- a/include/linux/page_counter.h
>   +++ b/include/linux/page_counter.h
>   @@ -26,7 +26,7 @@ struct page_counter {
>    	/* legacy */
>    	unsigned long watermark;
>    	unsigned long failcnt;
>   -};
>   +} ____cacheline_internodealigned_in_smp;
>    
> and with it, the -22.7% peformance change turns to a small -1.7%, which
> confirms the performance bump is caused by the change to data alignment.
> 
> After the patch, size of 'page_counter' increases from 104 bytes to 128
> bytes, and the size of 'mem_cgroup' increases from 2880 bytes to 3008
> bytes(with our kernel config). Another major data structure which
> contains 'page_counter' is 'hugetlb_cgroup', whose size will change
> from 912B to 1024B.
> 
> Should we make these page_counters aligned to reduce cacheline conflict?

I would rather focus on a more effective mem_cgroup layout. It is very
likely that we are just stumbling over two counters here.

Could you try to add cache alignment of counters after memory and see
which one makes the difference? I do not expect memsw to be the one
because that one is used together with the main counter. But who knows
maybe the way it crosses the cache line has the exact effect. Hard to
tell without other numbers.

Btw. it would be great to see what the effect is on cgroup v2 as well.

Thanks for pursuing this!
-- 
Michal Hocko
SUSE Labs
