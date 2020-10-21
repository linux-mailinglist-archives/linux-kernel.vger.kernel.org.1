Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCDC294614
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 02:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439713AbgJUAmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 20:42:03 -0400
Received: from mga07.intel.com ([134.134.136.100]:15265 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439681AbgJUAmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 20:42:02 -0400
IronPort-SDR: MzhUnk4xubqrb97nb6qSbHPnNL7drLhJPkvnHSzK7IEapKlYlkJ9jf/FNuW2ehhmA0FcSBOvxt
 oWeLI2Tyl1tQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="231490409"
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="231490409"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 17:42:01 -0700
IronPort-SDR: DflOQu+6KifpgabAvfToOQ19TLr0xOxxwbTkGpdF4ULV/BsoqYZmi+IrTtXDosQXe3IxVRo5qI
 VprZzbfmoN9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="348085763"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.65])
  by fmsmga004.fm.intel.com with ESMTP; 20 Oct 2020 17:41:57 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     David Rientjes <rientjes@google.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jeremy Cline <jcline@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, feng.tang@intel.com, zhengjun.xing@intel.com
Subject: Re: [mm, thp] 85b9f46e8e: vm-scalability.throughput -8.7% regression
References: <20201004132838.GU393@shao2-debian>
        <alpine.DEB.2.23.453.2010041157270.3597796@chino.kir.corp.google.com>
        <87a6whh96k.fsf@yhuang-dev.intel.com>
        <alpine.DEB.2.23.453.2010201110420.750649@chino.kir.corp.google.com>
Date:   Wed, 21 Oct 2020 08:41:56 +0800
In-Reply-To: <alpine.DEB.2.23.453.2010201110420.750649@chino.kir.corp.google.com>
        (David Rientjes's message of "Tue, 20 Oct 2020 11:19:50 -0700 (PDT)")
Message-ID: <87d01ce7fv.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Rientjes <rientjes@google.com> writes:

> On Tue, 20 Oct 2020, Huang, Ying wrote:
>
>> >> =========================================================================================
>> >> compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/testcase/ucode:
>> >>   gcc-9/performance/x86_64-rhel-8.3/debian-10.4-x86_64-20200603.cgz/300s/1T/lkp-skl-fpga01/lru-shm/vm-scalability/0x2006906
>> >> 
>> >> commit: 
>> >>   dcdf11ee14 ("mm, shmem: add vmstat for hugepage fallback")
>> >>   85b9f46e8e ("mm, thp: track fallbacks due to failed memcg charges separately")
>> >> 
>> >> dcdf11ee14413332 85b9f46e8ea451633ccd60a7d8c 
>> >> ---------------- --------------------------- 
>> >>        fail:runs  %reproduction    fail:runs
>> >>            |             |             |    
>> >>           1:4           24%           2:4     perf-profile.calltrace.cycles-pp.sync_regs.error_entry.do_access
>> >>           3:4           53%           5:4     perf-profile.calltrace.cycles-pp.error_entry.do_access
>> >>           9:4          -27%           8:4     perf-profile.children.cycles-pp.error_entry
>> >>           4:4          -10%           4:4     perf-profile.self.cycles-pp.error_entry
>> >>          %stddev     %change         %stddev
>> >>              \          |                \  
>> >>     477291            -9.1%     434041        vm-scalability.median
>> >>   49791027            -8.7%   45476799        vm-scalability.throughput
>> >>     223.67            +1.6%     227.36        vm-scalability.time.elapsed_time
>> >>     223.67            +1.6%     227.36        vm-scalability.time.elapsed_time.max
>> >>      50364 ±  6%     +24.1%      62482 ± 10%  vm-scalability.time.involuntary_context_switches
>> >>       2237            +7.8%       2412        vm-scalability.time.percent_of_cpu_this_job_got
>> >>       3084           +18.2%       3646        vm-scalability.time.system_time
>> >>       1921            -4.2%       1839        vm-scalability.time.user_time
>> >>      13.68            +2.2       15.86        mpstat.cpu.all.sys%
>> >>      28535 ± 30%     -47.0%      15114 ± 79%  numa-numastat.node0.other_node
>> >>     142734 ± 11%     -19.4%     115000 ± 17%  numa-meminfo.node0.AnonPages
>> >>      11168 ±  3%      +8.8%      12150 ±  5%  numa-meminfo.node1.PageTables
>> >>      76.00            -1.6%      74.75        vmstat.cpu.id
>> >>       3626            -1.9%       3555        vmstat.system.cs
>> >>    2214928 ±166%     -96.6%      75321 ±  7%  cpuidle.C1.usage
>> >>     200981 ±  7%     -18.0%     164861 ±  7%  cpuidle.POLL.time
>> >>      52675 ±  3%     -16.7%      43866 ± 10%  cpuidle.POLL.usage
>> >>      35659 ± 11%     -19.4%      28754 ± 17%  numa-vmstat.node0.nr_anon_pages
>> >>    1248014 ±  3%     +10.9%    1384236        numa-vmstat.node1.nr_mapped
>> >>       2722 ±  4%     +10.6%       3011 ±  5%  numa-vmstat.node1.nr_page_table_pages
>> >
>> > I'm not sure that I'm reading this correctly, but I suspect that this just 
>> > happens because of NUMA: memory affinity will obviously impact 
>> > vm-scalability.throughput quite substantially, but I don't think the 
>> > bisected commit can be to be blame.  Commit 85b9f46e8ea4 ("mm, thp: track 
>> > fallbacks due to failed memcg charges separately") simply adds new 
>> > count_vm_event() calls in a couple areas to track thp fallback due to 
>> > memcg limits separate from fragmentation.
>> >
>> > It's likely a question about the testing methodology in general: for 
>> > memory intensive benchmarks, I suggest it is configured in a manner that 
>> > we can expect consistent memory access latency at the hardware level when 
>> > running on a NUMA system.
>> 
>> So you think it's better to bind processes to NUMA node or CPU?  But we
>> want to use this test case to capture NUMA/CPU placement/balance issue
>> too.
>> 
>
> No, because binding to a specific socket may cause other performance 
> "improvements" or "degradations" depending on how fragmented local memory 
> is, or whether or not it's under memory pressure.  Is the system rebooted 
> before testing so that we have a consistent state of memory availability 
> and fragmentation across sockets?

Yes.  System is rebooted before testing (0day uses kexec to accelerate
rebooting).

>> 0day solve the problem in another way.  We run the test case
>> multiple-times and calculate the average and standard deviation, then
>> compare.
>> 
>
> Depending on fragmentation or memory availability, any benchmark that 
> assesses performance may be adversely affected if its results can be 
> impacted by hugepage backing.

Best Regards,
Huang, Ying
