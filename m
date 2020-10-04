Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD5E282CDD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 21:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgJDTFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 15:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgJDTFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 15:05:25 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D174FC0613CE
        for <linux-kernel@vger.kernel.org>; Sun,  4 Oct 2020 12:05:23 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a200so242487pfa.10
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 12:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=1z+J4wleBAAXO8Bl0tTa8RpVW3ap9JtU1YI+9aeS5FU=;
        b=InZd8HmK02jutziCPuhP9UDc1JbfyA8cpIVlh3jgdvcpb7Qd1HhzQQWcfQ8iYekSdr
         quLt61btouooO/r20c6lOQRMRBt6yZmA5FbyH3bGVs+N1c+Kjr7ljsV05b13YIq0uvyK
         cP8n3Pe+ux8/7wfGoAW/t8EjunERB6vjrhK84zGHTcacf9HK0uiH2KoWCdG2K/CyAIY0
         V23nrUVDQPTfLpdVkrZ1RcJL5PatOlPirsioaPDJzVd8iz4jb46oDPVoB0gbyLB3+TAZ
         IiGUFVnaxt+GU7jluveGbeRVAO0BSh81T34VRgmXpP6LZDJ4Dc0GpLoOmvafbmkeOay8
         bFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=1z+J4wleBAAXO8Bl0tTa8RpVW3ap9JtU1YI+9aeS5FU=;
        b=PYz0XX9zsoU3rn3jmR1hhjI5z16BvZf7OVvnRMCSSNIoBQbvnkEa051HJPVoalEOn9
         pHGas44zEGEeIQyXC3lfKWRaIYEYde0v4tiSTxKmD9saHTvwKWw7j6PI2+FSVrFzl2WQ
         0mhEwDdCHgHqdQGfrW87Oq484MjvNfb06OO6x1ygzpwcZHOieWfI2Lqpx8qU1JTJu9Vn
         oVKMjDLqWoZq5sNTTLofSHdfbVV4zx+EgFNLM1YkiykhfEOzkQ1iQ4rKs0damGnudpXn
         Z8ZqSxc8C5VxqEp9C1nnPW7VHq0Py0knVS48BEIAHhpIxXaHQfjhg+ZDCETFI3634P0A
         +QBg==
X-Gm-Message-State: AOAM531/zW55Sa2QEQUKw1Otl6EhMwshy8s78VmTbhUIwLOgNi14Qsx0
        X6A40Ss/zSA2ldbyTWdXAd0Evw==
X-Google-Smtp-Source: ABdhPJxmDcsFVdMImmVw55h3IbhFPer7JQPAEH0H+IbA0yI+vF532Y3FbBOmBUgAGMahlwIFetQktQ==
X-Received: by 2002:a62:be0a:0:b029:142:2501:35de with SMTP id l10-20020a62be0a0000b0290142250135demr13547405pff.62.1601838323148;
        Sun, 04 Oct 2020 12:05:23 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id k4sm10144116pfp.189.2020.10.04.12.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 12:05:22 -0700 (PDT)
Date:   Sun, 4 Oct 2020 12:05:21 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     kernel test robot <rong.a.chen@intel.com>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: [mm, thp] 85b9f46e8e: vm-scalability.throughput -8.7%
 regression
In-Reply-To: <20201004132838.GU393@shao2-debian>
Message-ID: <alpine.DEB.2.23.453.2010041157270.3597796@chino.kir.corp.google.com>
References: <20201004132838.GU393@shao2-debian>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1482994552-888175115-1601838322=:3597796"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1482994552-888175115-1601838322=:3597796
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sun, 4 Oct 2020, kernel test robot wrote:

> Greeting,
> 
> FYI, we noticed a -8.7% regression of vm-scalability.throughput due to commit:
> 
> 
> commit: 85b9f46e8ea451633ccd60a7d8cacbfff9f34047 ("mm, thp: track fallbacks due to failed memcg charges separately")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> 
> in testcase: vm-scalability
> on test machine: 104 threads Skylake with 192G memory
> with following parameters:
> 
> 	runtime: 300s
> 	size: 1T
> 	test: lru-shm
> 	cpufreq_governor: performance
> 	ucode: 0x2006906
> 
> test-description: The motivation behind this suite is to exercise functions and regions of the mm/ of the Linux kernel which are of interest to us.
> test-url: https://git.kernel.org/cgit/linux/kernel/git/wfg/vm-scalability.git/
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install job.yaml  # job file is attached in this email
>         bin/lkp run     job.yaml
> 
> =========================================================================================
> compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/testcase/ucode:
>   gcc-9/performance/x86_64-rhel-8.3/debian-10.4-x86_64-20200603.cgz/300s/1T/lkp-skl-fpga01/lru-shm/vm-scalability/0x2006906
> 
> commit: 
>   dcdf11ee14 ("mm, shmem: add vmstat for hugepage fallback")
>   85b9f46e8e ("mm, thp: track fallbacks due to failed memcg charges separately")
> 
> dcdf11ee14413332 85b9f46e8ea451633ccd60a7d8c 
> ---------------- --------------------------- 
>        fail:runs  %reproduction    fail:runs
>            |             |             |    
>           1:4           24%           2:4     perf-profile.calltrace.cycles-pp.sync_regs.error_entry.do_access
>           3:4           53%           5:4     perf-profile.calltrace.cycles-pp.error_entry.do_access
>           9:4          -27%           8:4     perf-profile.children.cycles-pp.error_entry
>           4:4          -10%           4:4     perf-profile.self.cycles-pp.error_entry
>          %stddev     %change         %stddev
>              \          |                \  
>     477291            -9.1%     434041        vm-scalability.median
>   49791027            -8.7%   45476799        vm-scalability.throughput
>     223.67            +1.6%     227.36        vm-scalability.time.elapsed_time
>     223.67            +1.6%     227.36        vm-scalability.time.elapsed_time.max
>      50364 ±  6%     +24.1%      62482 ± 10%  vm-scalability.time.involuntary_context_switches
>       2237            +7.8%       2412        vm-scalability.time.percent_of_cpu_this_job_got
>       3084           +18.2%       3646        vm-scalability.time.system_time
>       1921            -4.2%       1839        vm-scalability.time.user_time
>      13.68            +2.2       15.86        mpstat.cpu.all.sys%
>      28535 ± 30%     -47.0%      15114 ± 79%  numa-numastat.node0.other_node
>     142734 ± 11%     -19.4%     115000 ± 17%  numa-meminfo.node0.AnonPages
>      11168 ±  3%      +8.8%      12150 ±  5%  numa-meminfo.node1.PageTables
>      76.00            -1.6%      74.75        vmstat.cpu.id
>       3626            -1.9%       3555        vmstat.system.cs
>    2214928 ±166%     -96.6%      75321 ±  7%  cpuidle.C1.usage
>     200981 ±  7%     -18.0%     164861 ±  7%  cpuidle.POLL.time
>      52675 ±  3%     -16.7%      43866 ± 10%  cpuidle.POLL.usage
>      35659 ± 11%     -19.4%      28754 ± 17%  numa-vmstat.node0.nr_anon_pages
>    1248014 ±  3%     +10.9%    1384236        numa-vmstat.node1.nr_mapped
>       2722 ±  4%     +10.6%       3011 ±  5%  numa-vmstat.node1.nr_page_table_pages

I'm not sure that I'm reading this correctly, but I suspect that this just 
happens because of NUMA: memory affinity will obviously impact 
vm-scalability.throughput quite substantially, but I don't think the 
bisected commit can be to be blame.  Commit 85b9f46e8ea4 ("mm, thp: track 
fallbacks due to failed memcg charges separately") simply adds new 
count_vm_event() calls in a couple areas to track thp fallback due to 
memcg limits separate from fragmentation.

It's likely a question about the testing methodology in general: for 
memory intensive benchmarks, I suggest it is configured in a manner that 
we can expect consistent memory access latency at the hardware level when 
running on a NUMA system.
--1482994552-888175115-1601838322=:3597796--
