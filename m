Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB31329420B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 20:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389047AbgJTSTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 14:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388966AbgJTSTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 14:19:53 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D667C0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 11:19:53 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id h6so1592204pgk.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 11:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=IVrzZbw7goNfC82dZACxg91XRxqOSWNSID4hxuCsuLI=;
        b=YwtfGPM1145zbl3+ttQYrwV1eh+561qMYjT6jluDUkyl1w5s058GO3E4aXt0flgRWu
         uu+2w17zlRZHTnBfpNlJLpRTYlfcL7Dr7gkLusiBiPR4vmrNYuL574BgaX/4o2DOi+Ku
         paEu1eZDcS2Qn++naX+sKLrSTFRsJEk9VgVjc/WGOdnFXoPWCcWgh/nYEw+wjHsNV1GI
         ydVcDkUkUPqbNqEYb8PklaoN6K5hoaPZnDqlY1aFWiiMtuFOUQBomf7PYSP+kXTRu0PG
         7pH6gs3U+scc7ix1581loN9YLeU8FW0NMX3ArIYcOkNNs25uyvCVCO9Pga7UV9m9QDpY
         TpvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=IVrzZbw7goNfC82dZACxg91XRxqOSWNSID4hxuCsuLI=;
        b=t2R01uJa7eQssCb4uoKbAdQGWM26b6LRaDX5R2pEJ9ymjvfcMxcmdgcIrho7bTyaQr
         Trdtoi0VP59ELAmeeKtcQm38lCEqmSHMjnvgvjqalDqbe4VlE3vZSPyd3wP/uciImF8b
         QdGodO0BSaCAfPwJ2pjbNK4i7lCpWakhK7u/ndohRXMa+vjy8Lde/PWvrW4kMy/lFBmT
         OuRseoTFWzAIxwEuoP4AoTwDBj2hJOn6a6dafOKafG7K1xm6Q35zjPIpbhB9j6/pEy06
         Ad3vZgz1sCueQEJp2f1AsZe5UwnDTgEfzgdLeQMXWGx4rvOAtBm2zpsLpEhVhZkSywnu
         Dzrg==
X-Gm-Message-State: AOAM530hjtPt5dqGVY8kL1ELPIY5ShJl4NeWBWBt4UpjNDb+UmvcoLMq
        qBRDVPtTrK0LoyD8vHY59VIZiQ==
X-Google-Smtp-Source: ABdhPJxgNeL9YAw+OntAuShREMKm++tLnMbTvTzGYNcGXToeVLXhAXQKHY5QaHHB2nFsn3/Qc0h3wQ==
X-Received: by 2002:a65:6493:: with SMTP id e19mr3674035pgv.276.1603217992276;
        Tue, 20 Oct 2020 11:19:52 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id q2sm2897833pfb.106.2020.10.20.11.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 11:19:51 -0700 (PDT)
Date:   Tue, 20 Oct 2020 11:19:50 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     "Huang, Ying" <ying.huang@intel.com>
cc:     kernel test robot <rong.a.chen@intel.com>,
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
Subject: Re: [mm, thp] 85b9f46e8e: vm-scalability.throughput -8.7%
 regression
In-Reply-To: <87a6whh96k.fsf@yhuang-dev.intel.com>
Message-ID: <alpine.DEB.2.23.453.2010201110420.750649@chino.kir.corp.google.com>
References: <20201004132838.GU393@shao2-debian> <alpine.DEB.2.23.453.2010041157270.3597796@chino.kir.corp.google.com> <87a6whh96k.fsf@yhuang-dev.intel.com>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1482994552-1255092291-1603217991=:750649"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1482994552-1255092291-1603217991=:750649
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 20 Oct 2020, Huang, Ying wrote:

> >> =========================================================================================
> >> compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/testcase/ucode:
> >>   gcc-9/performance/x86_64-rhel-8.3/debian-10.4-x86_64-20200603.cgz/300s/1T/lkp-skl-fpga01/lru-shm/vm-scalability/0x2006906
> >> 
> >> commit: 
> >>   dcdf11ee14 ("mm, shmem: add vmstat for hugepage fallback")
> >>   85b9f46e8e ("mm, thp: track fallbacks due to failed memcg charges separately")
> >> 
> >> dcdf11ee14413332 85b9f46e8ea451633ccd60a7d8c 
> >> ---------------- --------------------------- 
> >>        fail:runs  %reproduction    fail:runs
> >>            |             |             |    
> >>           1:4           24%           2:4     perf-profile.calltrace.cycles-pp.sync_regs.error_entry.do_access
> >>           3:4           53%           5:4     perf-profile.calltrace.cycles-pp.error_entry.do_access
> >>           9:4          -27%           8:4     perf-profile.children.cycles-pp.error_entry
> >>           4:4          -10%           4:4     perf-profile.self.cycles-pp.error_entry
> >>          %stddev     %change         %stddev
> >>              \          |                \  
> >>     477291            -9.1%     434041        vm-scalability.median
> >>   49791027            -8.7%   45476799        vm-scalability.throughput
> >>     223.67            +1.6%     227.36        vm-scalability.time.elapsed_time
> >>     223.67            +1.6%     227.36        vm-scalability.time.elapsed_time.max
> >>      50364 ±  6%     +24.1%      62482 ± 10%  vm-scalability.time.involuntary_context_switches
> >>       2237            +7.8%       2412        vm-scalability.time.percent_of_cpu_this_job_got
> >>       3084           +18.2%       3646        vm-scalability.time.system_time
> >>       1921            -4.2%       1839        vm-scalability.time.user_time
> >>      13.68            +2.2       15.86        mpstat.cpu.all.sys%
> >>      28535 ± 30%     -47.0%      15114 ± 79%  numa-numastat.node0.other_node
> >>     142734 ± 11%     -19.4%     115000 ± 17%  numa-meminfo.node0.AnonPages
> >>      11168 ±  3%      +8.8%      12150 ±  5%  numa-meminfo.node1.PageTables
> >>      76.00            -1.6%      74.75        vmstat.cpu.id
> >>       3626            -1.9%       3555        vmstat.system.cs
> >>    2214928 ±166%     -96.6%      75321 ±  7%  cpuidle.C1.usage
> >>     200981 ±  7%     -18.0%     164861 ±  7%  cpuidle.POLL.time
> >>      52675 ±  3%     -16.7%      43866 ± 10%  cpuidle.POLL.usage
> >>      35659 ± 11%     -19.4%      28754 ± 17%  numa-vmstat.node0.nr_anon_pages
> >>    1248014 ±  3%     +10.9%    1384236        numa-vmstat.node1.nr_mapped
> >>       2722 ±  4%     +10.6%       3011 ±  5%  numa-vmstat.node1.nr_page_table_pages
> >
> > I'm not sure that I'm reading this correctly, but I suspect that this just 
> > happens because of NUMA: memory affinity will obviously impact 
> > vm-scalability.throughput quite substantially, but I don't think the 
> > bisected commit can be to be blame.  Commit 85b9f46e8ea4 ("mm, thp: track 
> > fallbacks due to failed memcg charges separately") simply adds new 
> > count_vm_event() calls in a couple areas to track thp fallback due to 
> > memcg limits separate from fragmentation.
> >
> > It's likely a question about the testing methodology in general: for 
> > memory intensive benchmarks, I suggest it is configured in a manner that 
> > we can expect consistent memory access latency at the hardware level when 
> > running on a NUMA system.
> 
> So you think it's better to bind processes to NUMA node or CPU?  But we
> want to use this test case to capture NUMA/CPU placement/balance issue
> too.
> 

No, because binding to a specific socket may cause other performance 
"improvements" or "degradations" depending on how fragmented local memory 
is, or whether or not it's under memory pressure.  Is the system rebooted 
before testing so that we have a consistent state of memory availability 
and fragmentation across sockets?

> 0day solve the problem in another way.  We run the test case
> multiple-times and calculate the average and standard deviation, then
> compare.
> 

Depending on fragmentation or memory availability, any benchmark that 
assesses performance may be adversely affected if its results can be 
impacted by hugepage backing.
--1482994552-1255092291-1603217991=:750649--
