Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE162A5BCE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 02:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbgKDBUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 20:20:11 -0500
Received: from mga07.intel.com ([134.134.136.100]:35041 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729246AbgKDBUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 20:20:11 -0500
IronPort-SDR: cyMiIHyyTdQH4G5DF9L1HaJjxx/NOyccr7EcQQdilFN8p9NeppqhvzN+SR85naq+gtCXypFD2j
 ykjMB3KaREXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="233315191"
X-IronPort-AV: E=Sophos;i="5.77,449,1596524400"; 
   d="scan'208";a="233315191"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 17:20:10 -0800
IronPort-SDR: 4pY2+a1DIwkXToZ9q2M6653+q/Wz3pGfS2jTa8wHOA1K1563ntTuBtzjeNksNQax5UIErewMw8
 4rB+PLuCbtqw==
X-IronPort-AV: E=Sophos;i="5.77,449,1596524400"; 
   d="scan'208";a="471016005"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.4.68]) ([10.238.4.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 17:20:06 -0800
Subject: Re: [LKP] Re: [mm/memcg] bd0b230fe1: will-it-scale.per_process_ops
 -22.7% regression
To:     Michal Hocko <mhocko@suse.com>, Rong Chen <rong.a.chen@intel.com>
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
 <82d73ebb-a31e-4766-35b8-82afa85aa047@intel.com>
 <20201102100247.GF22613@dhcp22.suse.cz>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <bd87e8bd-c918-3f41-0cc5-e2927d91625f@linux.intel.com>
Date:   Wed, 4 Nov 2020 09:20:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201102100247.GF22613@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/2/2020 6:02 PM, Michal Hocko wrote:
> On Mon 02-11-20 17:53:14, Rong Chen wrote:
>>
>>
>> On 11/2/20 5:27 PM, Michal Hocko wrote:
>>> On Mon 02-11-20 17:15:43, kernel test robot wrote:
>>>> Greeting,
>>>>
>>>> FYI, we noticed a -22.7% regression of will-it-scale.per_process_ops due to commit:
>>>>
>>>>
>>>> commit: bd0b230fe14554bfffbae54e19038716f96f5a41 ("mm/memcg: unify swap and memsw page counters")
>>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>> I really fail to see how this can be anything else than a data structure
>>> layout change. There is one counter less.
>>>
>>> btw. are cgroups configured at all? What would be the configuration?
>>
>> Hi Michal,
>>
>> We used the default configure of cgroups, not sure what configuration you
>> want,
>> could you give me more details? and here is the cgroup info of will-it-scale
>> process:
>>
>> $ cat /proc/3042/cgroup
>> 12:hugetlb:/
>> 11:memory:/system.slice/lkp-bootstrap.service
> 
> OK, this means that memory controler is enabled and in use. Btw. do you
> get the original performance if you add one phony page_counter after the
> union?
> 
I add one phony page_counter after the union and re-test, the regression 
reduced to -1.2%. It looks like the regression caused by the data 
structure layout change.

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/nr_task/mode/test/cpufreq_governor/ucode/debug-setup:
 
lkp-hsw-4ex1/will-it-scale/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/50%/process/page_fault2/performance/0x16/test1

commit:
   8d387a5f172f26ff8c76096d5876b881dec6b7ce
   bd0b230fe14554bfffbae54e19038716f96f5a41
   b3233916ab0a883e1117397e28b723bd0e4ac1eb (debug patch add one phony 
page_counter after the union)

8d387a5f172f26ff bd0b230fe14554bfffbae54e190 b3233916ab0a883e1117397e28b
---------------- --------------------------- ---------------------------
          %stddev     %change         %stddev     %change         %stddev
              \          |                \          |                \
     187632           -22.8%     144931            -1.2%     185391 
    will-it-scale.per_process_ops
   13509525           -22.8%   10435073            -1.2%   13348181 
    will-it-scale.workload



-- 
Zhengjun Xing
