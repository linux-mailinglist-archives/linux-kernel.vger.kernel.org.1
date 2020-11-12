Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32A12B04F0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 13:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgKLM2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 07:28:50 -0500
Received: from mga01.intel.com ([192.55.52.88]:21637 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbgKLM2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 07:28:50 -0500
IronPort-SDR: SX3zXs5Iew2UObSmSGqnspC8OZ/h373mIexmLBIMly0+9h/7JW/ObJIAEK/KLAJcFwSg1kaL+x
 qWJ99TwVzNTg==
X-IronPort-AV: E=McAfee;i="6000,8403,9802"; a="188295147"
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="188295147"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 04:28:49 -0800
IronPort-SDR: cYT05BI9hxvnX9PUk2QLfJ0mphTCpDXpBr9Pw1Lp6Hgj3aKdYuTckw3C1Hfjq/3ovCmNGK6ep3
 KCZvZ+DpENaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="357073525"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.98])
  by fmsmga004.fm.intel.com with ESMTP; 12 Nov 2020 04:28:45 -0800
Date:   Thu, 12 Nov 2020 20:28:44 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
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
Message-ID: <20201112122844.GA11000@shbuild999.sh.intel.com>
References: <20201102091543.GM31092@shao2-debian>
 <20201102092754.GD22613@dhcp22.suse.cz>
 <82d73ebb-a31e-4766-35b8-82afa85aa047@intel.com>
 <20201102100247.GF22613@dhcp22.suse.cz>
 <bd87e8bd-c918-3f41-0cc5-e2927d91625f@linux.intel.com>
 <20201104081546.GB10052@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104081546.GB10052@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Wed, Nov 04, 2020 at 09:15:46AM +0100, Michal Hocko wrote:
> > > > Hi Michal,
> > > > 
> > > > We used the default configure of cgroups, not sure what configuration you
> > > > want,
> > > > could you give me more details? and here is the cgroup info of will-it-scale
> > > > process:
> > > > 
> > > > $ cat /proc/3042/cgroup
> > > > 12:hugetlb:/
> > > > 11:memory:/system.slice/lkp-bootstrap.service
> > > 
> > > OK, this means that memory controler is enabled and in use. Btw. do you
> > > get the original performance if you add one phony page_counter after the
> > > union?
> > > 
> > I add one phony page_counter after the union and re-test, the regression
> > reduced to -1.2%. It looks like the regression caused by the data structure
> > layout change.
> 
> Thanks for double checking. Could you try to cache align the
> page_counter struct? If that helps then we should figure which counters
> acks against each other by adding the alignement between the respective
> counters. 

We tried below patch to make the 'page_counter' aligned.
  
  diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
  index bab7e57..9efa6f7 100644
  --- a/include/linux/page_counter.h
  +++ b/include/linux/page_counter.h
  @@ -26,7 +26,7 @@ struct page_counter {
   	/* legacy */
   	unsigned long watermark;
   	unsigned long failcnt;
  -};
  +} ____cacheline_internodealigned_in_smp;
   
and with it, the -22.7% peformance change turns to a small -1.7%, which
confirms the performance bump is caused by the change to data alignment.

After the patch, size of 'page_counter' increases from 104 bytes to 128
bytes, and the size of 'mem_cgroup' increases from 2880 bytes to 3008
bytes(with our kernel config). Another major data structure which
contains 'page_counter' is 'hugetlb_cgroup', whose size will change
from 912B to 1024B.

Should we make these page_counters aligned to reduce cacheline conflict?

Thanks,
Feng

