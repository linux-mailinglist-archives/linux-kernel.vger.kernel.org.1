Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E450A2A2783
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 10:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgKBJyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 04:54:13 -0500
Received: from mga06.intel.com ([134.134.136.31]:48043 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728004AbgKBJyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 04:54:13 -0500
IronPort-SDR: PpE7Vcd7skNO/h5IAlr+93oKUTja3kXDSB+mjMWOdpuJCEm4p2gFxSVP4L4F1fE0kECUmTOCJT
 5WR1AwWnQzVQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9792"; a="230491790"
X-IronPort-AV: E=Sophos;i="5.77,444,1596524400"; 
   d="scan'208";a="230491790"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 01:54:12 -0800
IronPort-SDR: JFnzcHIS0ocVCOuLZQQXLfeWNXLPgVacHHUqDagIitcpLGX4guq/LHx3vJySyPPXbj+aLlIAfA
 5glFWw/gmiAg==
X-IronPort-AV: E=Sophos;i="5.77,444,1596524400"; 
   d="scan'208";a="352704306"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 01:54:09 -0800
Subject: Re: [LKP] Re: [mm/memcg] bd0b230fe1: will-it-scale.per_process_ops
 -22.7% regression
To:     Michal Hocko <mhocko@suse.com>
Cc:     Waiman Long <longman@redhat.com>,
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
References: <20201102091543.GM31092@shao2-debian>
 <20201102092754.GD22613@dhcp22.suse.cz>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <82d73ebb-a31e-4766-35b8-82afa85aa047@intel.com>
Date:   Mon, 2 Nov 2020 17:53:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20201102092754.GD22613@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/2/20 5:27 PM, Michal Hocko wrote:
> On Mon 02-11-20 17:15:43, kernel test robot wrote:
>> Greeting,
>>
>> FYI, we noticed a -22.7% regression of will-it-scale.per_process_ops due to commit:
>>
>>
>> commit: bd0b230fe14554bfffbae54e19038716f96f5a41 ("mm/memcg: unify swap and memsw page counters")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> I really fail to see how this can be anything else than a data structure
> layout change. There is one counter less.
>
> btw. are cgroups configured at all? What would be the configuration?

Hi Michal,

We used the default configure of cgroups, not sure what configuration 
you want,
could you give me more details? and here is the cgroup info of 
will-it-scale process:

$ cat /proc/3042/cgroup
12:hugetlb:/
11:memory:/system.slice/lkp-bootstrap.service
10:devices:/system.slice/lkp-bootstrap.service
9:cpuset:/
8:perf_event:/
7:rdma:/
6:freezer:/
5:pids:/system.slice/lkp-bootstrap.service
4:net_cls,net_prio:/
3:blkio:/
2:cpu,cpuacct:/
1:name=systemd:/system.slice/lkp-bootstrap.service

Best Regards,
Rong Chen
