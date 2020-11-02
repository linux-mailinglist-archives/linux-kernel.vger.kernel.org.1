Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9891C2A240F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 06:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgKBFWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 00:22:35 -0500
Received: from mga11.intel.com ([192.55.52.93]:59999 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbgKBFWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 00:22:35 -0500
IronPort-SDR: NJpGpnj2phsXK0o04EOasKxTd58PShqN895s+DrafQxGFMCztTfuVmRDtG91DIIpHGySiYHclD
 tBhK4AZNtbqQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9792"; a="165332952"
X-IronPort-AV: E=Sophos;i="5.77,444,1596524400"; 
   d="scan'208";a="165332952"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2020 21:22:35 -0800
IronPort-SDR: rQhpyjIiH47CqOYU91p1ngBfEgHkdG6jCelVCMiMi2f7NuNfLGNdRw9Ar6tv2abShdG+g/DqbX
 nk6WLuAsLIZg==
X-IronPort-AV: E=Sophos;i="5.77,444,1596524400"; 
   d="scan'208";a="537880659"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2020 21:22:30 -0800
Subject: Re: [mm] e6e88712e4: stress-ng.tmpfs.ops_per_sec -69.7% regression
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Qian Cai <cai@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, lkp@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
References: <20201030071715.GV31092@shao2-debian>
 <20201030131711.GJ27442@casper.infradead.org>
 <dc3864d6-f474-02b8-fdf2-ca138afe3735@intel.com>
 <20201030145835.GL27442@casper.infradead.org>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <d57f327c-a22e-1fb0-26fe-68b4964e75dc@intel.com>
Date:   Mon, 2 Nov 2020 13:21:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20201030145835.GL27442@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/30/20 10:58 PM, Matthew Wilcox wrote:
> On Fri, Oct 30, 2020 at 10:02:45PM +0800, Chen, Rong A wrote:
>> On 10/30/2020 9:17 PM, Matthew Wilcox wrote:
>>> On Fri, Oct 30, 2020 at 03:17:15PM +0800, kernel test robot wrote:
>>>> Details are as below:
>>>> -------------------------------------------------------------------------------------------------->
>>>>
>>>>
>>>> To reproduce:
>>>>
>>>>           git clone https://github.com/intel/lkp-tests.git
>>>>           cd lkp-tests
>>>>           bin/lkp install job.yaml  # job file is attached in this email
>>>>           bin/lkp run     job.yaml
>>> Do you actually test these instructions before you send them out?
>>>
>>> hdd_partitions: "/dev/disk/by-id/ata-WDC_WD2500BEKT-00PVMT0_WD-WX11A23L4840-part
>>> 1"
>>> ssd_partitions: "/dev/nvme1n1p1 /dev/nvme0n1p1"
>>> rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2CW240A3_CVCV204303WP240CGN-part1"
>>>
>>> That's _very_ specific to a given machine.  I'm not familiar with
>>> this test, so I don't know what I need to change.
>>
>> Hi Matthew,
>>
>> Sorry about that, I copied the job.yaml file from the server,
>> the right way to do is to set your disk partitions in the yaml,
>> please see https://github.com/intel/lkp-tests#run-your-own-disk-partitions.
>>
>> there is another reproduce script attached in the original mail
>> for your reference.
> Can you reproduce this?  Here's my results:
>
> # stress-ng "--timeout" "100" "--times" "--verify" "--metrics-brief" "--sequential" "96" "--class" "memory" "--minimize" "--exclude" "spawn,exec,swap,stack,atomic,bad-altstack,bsearch,context,full,heapsort,hsearch,judy,lockbus,lsearch,malloc,matrix-3d,matrix,mcontend,membarrier,memcpy,memfd,memrate,memthrash,mergesort,mincore,null,numa,pipe,pipeherd,qsort,radixsort,remap,resources,rmap,shellsort,skiplist,stackmmap,str,stream,tlb-shootdown,tree,tsearch,vm-addr,vm-rw,vm-segv,vm,wcs,zero,zlib"
> stress-ng: info:  [7670] disabled 'oom-pipe' as it may hang or reboot the machine (enable it with the --pathological option)
> stress-ng: info:  [7670] dispatching hogs: 96 tmpfs
> stress-ng: info:  [7670] successful run completed in 100.23s (1 min, 40.23 secs)
> stress-ng: info:  [7670] stressor       bogo ops real time  usr time  sys time   bogo ops/s   bogo ops/s
> stress-ng: info:  [7670]                           (secs)    (secs)    (secs)   (real time) (usr+sys time)
> stress-ng: info:  [7670] tmpfs              8216    100.10    368.02    230.89        82.08        13.72
> stress-ng: info:  [7670] for a 100.23s run time:
> stress-ng: info:  [7670]     601.38s available CPU time
> stress-ng: info:  [7670]     368.71s user time   ( 61.31%)
> stress-ng: info:  [7670]     231.55s system time ( 38.50%)
> stress-ng: info:  [7670]     600.26s total time  ( 99.81%)
> stress-ng: info:  [7670] load average: 78.32 27.87 10.10
>

Hi Matthew,

IIUC, yes, we can reproduce it, here is the result from the server:

$ stress-ng --timeout 100 --times --verify --metrics-brief --sequential 
96 --class memory --minimize --exclude 
spawn,exec,swap,stack,atomic,bad-altstack,bsearch,context,full,heapsort,hsearch,judy,lockbus,lsearch,malloc,matrix-3d,matrix,mcontend,membarrier,memcpy,memfd,memrate,memthrash,mergesort,mincore,null,numa,pipe,pipeherd,qsort,radixsort,remap,resources,rmap,shellsort,skiplist,stackmmap,str,stream,tlb-shootdown,tree,tsearch,vm-addr,vm-rw,vm-segv,vm,wcs,zero,zlib 

stress-ng: info:  [2765] disabled 'oom-pipe' as it may hang or reboot 
the machine (enable it with the --pathological option)
stress-ng: info:  [2765] dispatching hogs: 96 tmpfs
stress-ng: info:  [2765] successful run completed in 104.67s (1 min, 
44.67 secs)
stress-ng: info:  [2765] stressor       bogo ops real time  usr time  
sys time   bogo ops/s   bogo ops/s
stress-ng: info:  [2765]                           (secs) (secs)    
(secs)   (real time) (usr+sys time)
stress-ng: info:  [2765] tmpfs               363    103.02 622.07   
7289.85         3.52         0.05
stress-ng: info:  [2765] for a 104.67s run time:
stress-ng: info:  [2765]   10047.98s available CPU time
stress-ng: info:  [2765]     622.46s user time   (  6.19%)
stress-ng: info:  [2765]    7290.66s system time ( 72.56%)
stress-ng: info:  [2765]    7913.12s total time  ( 78.75%)
stress-ng: info:  [2765] load average: 79.62 28.89 10.45

we compared the tmpfs.ops_per_sec: (363 / 103.02) between this commit 
and parent commit.

Best Regards,
Rong Chen
