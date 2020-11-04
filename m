Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1862A5F2D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 09:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgKDIPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 03:15:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:60474 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgKDIPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:15:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604477747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pu9nDlElO36818d6c492u/kEii7j/MmIxPyMpMKROnw=;
        b=M560DL4Lx3O469FViCozhx+pg+wAT6bhy87LkS0daF7UpbL2pSwdQb0qgQjOjuaQEY+ZgE
        QfrD1GZRJV6VZsMjWN1korL9SoGHicDqo0UanIqWyiAOiZ8M7QMbtYKtGE6DjHjLGMueYb
        fZH8iTV79Qulw6LTGp9j1eM+BKwi4w8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2A284ACE0;
        Wed,  4 Nov 2020 08:15:47 +0000 (UTC)
Date:   Wed, 4 Nov 2020 09:15:46 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     Rong Chen <rong.a.chen@intel.com>,
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
        lkp@intel.com, zhengjun.xing@intel.com
Subject: Re: [LKP] Re: [mm/memcg] bd0b230fe1: will-it-scale.per_process_ops
 -22.7% regression
Message-ID: <20201104081546.GB10052@dhcp22.suse.cz>
References: <20201102091543.GM31092@shao2-debian>
 <20201102092754.GD22613@dhcp22.suse.cz>
 <82d73ebb-a31e-4766-35b8-82afa85aa047@intel.com>
 <20201102100247.GF22613@dhcp22.suse.cz>
 <bd87e8bd-c918-3f41-0cc5-e2927d91625f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd87e8bd-c918-3f41-0cc5-e2927d91625f@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04-11-20 09:20:04, Xing Zhengjun wrote:
> 
> 
> On 11/2/2020 6:02 PM, Michal Hocko wrote:
> > On Mon 02-11-20 17:53:14, Rong Chen wrote:
> > > 
> > > 
> > > On 11/2/20 5:27 PM, Michal Hocko wrote:
> > > > On Mon 02-11-20 17:15:43, kernel test robot wrote:
> > > > > Greeting,
> > > > > 
> > > > > FYI, we noticed a -22.7% regression of will-it-scale.per_process_ops due to commit:
> > > > > 
> > > > > 
> > > > > commit: bd0b230fe14554bfffbae54e19038716f96f5a41 ("mm/memcg: unify swap and memsw page counters")
> > > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > > I really fail to see how this can be anything else than a data structure
> > > > layout change. There is one counter less.
> > > > 
> > > > btw. are cgroups configured at all? What would be the configuration?
> > > 
> > > Hi Michal,
> > > 
> > > We used the default configure of cgroups, not sure what configuration you
> > > want,
> > > could you give me more details? and here is the cgroup info of will-it-scale
> > > process:
> > > 
> > > $ cat /proc/3042/cgroup
> > > 12:hugetlb:/
> > > 11:memory:/system.slice/lkp-bootstrap.service
> > 
> > OK, this means that memory controler is enabled and in use. Btw. do you
> > get the original performance if you add one phony page_counter after the
> > union?
> > 
> I add one phony page_counter after the union and re-test, the regression
> reduced to -1.2%. It looks like the regression caused by the data structure
> layout change.

Thanks for double checking. Could you try to cache align the
page_counter struct? If that helps then we should figure which counters
acks against each other by adding the alignement between the respective
counters. 

> =========================================================================================
> tbox_group/testcase/rootfs/kconfig/compiler/nr_task/mode/test/cpufreq_governor/ucode/debug-setup:
> 
> lkp-hsw-4ex1/will-it-scale/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/50%/process/page_fault2/performance/0x16/test1
> 
> commit:
>   8d387a5f172f26ff8c76096d5876b881dec6b7ce
>   bd0b230fe14554bfffbae54e19038716f96f5a41
>   b3233916ab0a883e1117397e28b723bd0e4ac1eb (debug patch add one phony
> page_counter after the union)
> 
> 8d387a5f172f26ff bd0b230fe14554bfffbae54e190 b3233916ab0a883e1117397e28b
> ---------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \
>     187632           -22.8%     144931            -1.2%     185391
> will-it-scale.per_process_ops
>   13509525           -22.8%   10435073            -1.2%   13348181
> will-it-scale.workload
> 
> 
> 
> -- 
> Zhengjun Xing

-- 
Michal Hocko
SUSE Labs
