Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC12E1AB78A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 07:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407277AbgDPFs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 01:48:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:2915 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407149AbgDPFsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 01:48:16 -0400
IronPort-SDR: 1MnNJUp19vJwvEROKs1VPjwHDiNl+sHqxUqVVnHvjNvG/8paaw7KN3+Al7o0eY8Vv+uXDY47pg
 9qBNlJA6wmrg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 22:48:15 -0700
IronPort-SDR: kSgWfODYLPIBI+Ko+8skThE/Mc9TejguXhlMxJ86rY+O8OqEpbwA0DhMGRuh59LaPdUH6Xz8iP
 sW/20cnw+ODQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,388,1580803200"; 
   d="scan'208";a="245887317"
Received: from xingzhen-mobl1.ccr.corp.intel.com (HELO [10.238.5.222]) ([10.238.5.222])
  by fmsmga008.fm.intel.com with ESMTP; 15 Apr 2020 22:48:12 -0700
Subject: Re: [LKP] Re: [ext4] b1b4705d54: filebench.sum_bytes_mb/s -20.2%
 regression
To:     Jan Kara <jack@suse.cz>
Cc:     Rong Chen <rong.a.chen@intel.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkp@lists.01.org
References: <20191224005915.GW2760@shao2-debian>
 <20200107134106.GD25547@quack2.suse.cz> <20200107165708.GA3619@mit.edu>
 <20200107172824.GK25547@quack2.suse.cz>
 <fde1ad11-c9b0-4393-a123-3f7625c819fa@intel.com>
 <7ec6b078-7b09-fb87-8ad2-a328e96c5bf9@linux.intel.com>
 <49a59199-53af-206f-d07c-5c8c45f498b3@linux.intel.com>
 <20200325143102.GJ28951@quack2.suse.cz>
 <309baa89-9f69-0545-946e-4b3624f83e60@linux.intel.com>
 <20200415083954.GD501@quack2.suse.cz>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <3dbd1c40-00d5-5e3e-f864-cb9abe30a7fa@linux.intel.com>
Date:   Thu, 16 Apr 2020 13:48:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200415083954.GD501@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/15/2020 4:39 PM, Jan Kara wrote:
> On Wed 15-04-20 15:55:09, Xing Zhengjun wrote:
>>
>>
>> On 3/25/2020 10:31 PM, Jan Kara wrote:
>>> On Wed 25-03-20 13:50:09, Xing Zhengjun wrote:
>>>> ping...
>>>> The issue still exists in v5.6-rc7.
>>>
>>> So I have tried again to reproduce this so that I can look into the
>>> regression. When observing what is actually happening in the system I have
>>> to say that this workfile (or actually its implementation in filebench) is
>>> pretty dubious. The problem is that filebench first creates the files by
>>> writing them through ordinary write(2). Then it immediately starts reading
>>> the files with direct IO read. So what happens is that by the time direct
>>> IO read is running, the system is still writing back the create files and
>>> depending on how read vs writes get scheduled, you get different results.
>>> Also direct IO read will first flush the range it is going to read from the
>>> page cache so to some extent this is actually parallel small ranged
>>> fsync(2) benchmark. Finally differences in how we achieve integrity of
>>> direct IO reads with dirty page cache are going to impact this benchmark.
>>>
>>
>> Sounds reasonable!  Thanks for the clarification!
>>
>>> So overall can now see why this commit makes a difference but the workload
>>> is IMHO largely irrelevant. What would make sense is to run filebench once,
>>> then unmount & mount the fs to force files to disk and clear page cache and
>>> then run it again. Filebench will reuse the files in this case and then
>>> parallel direct IO readers without page cache are a sensible workload. But
>>> I didn't see any difference in that (even with rotating disk) on my
>>> machines.
>>>
>> We do a test per your suggestion, run "filebench" once during setup stage,
>> then do a "sync",  after that run "filebench" again, from the attached test
>> result "compare", "filebench.sum_bytes_mb/s" regression is disappeared.
> 
> Cool. Thanks for improving the testcase! I'd just note that if you only do
> sync(2) between the setup and benchmark phase, you'll still have files
> cached in the page cache and so direct IO will go through the slow path
> when it has to evict pages from the page cache. The standard (and optimized
> for) situation for direct IO is that there is no page cache for the files
> direct IO is performed to. That's why I suggested remounting the
> filesystem, not just calling sync(2)...
>

Thanks. We will keep improving the test case and try to make sure there 
is no page cache for the files direct IO is performed to.

> 								Honza
> 
>> =========================================================================================
>> tbox_group/testcase/rootfs/kconfig/compiler/debug-setup/disk/fs/test/cpufreq_governor/ucode:
>>    lkp-hsw-d01/filebench/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/test2/1HDD/ext4/fivestreamreaddirect.f/performance/0x27
>>
>> commit:
>>    b1b4705d54abedfd69dcdf42779c521aa1e0fbd3
>>    09edf4d381957b144440bac18a4769c53063b943
>>    v5.5
>>    v5.7-rc1
>>
>> b1b4705d54abedfd 09edf4d381957b144440bac18a4                        v5.5                    v5.7-rc1
>> ---------------- --------------------------- --------------------------- ---------------------------
>>           %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>>               \          |                \          |                \          |                \
>>       59.40            +0.0%      59.40            -0.8%      58.93            -1.0%      58.80        filebench.sum_bytes_mb/s
>>        3570            +0.0%       3570            -0.8%       3541            -1.0%       3533        filebench.sum_operations
>>       59.50            +0.0%      59.50            -0.8%      59.02            -1.0%      58.89        filebench.sum_operations/s
>>       59.33            +0.0%      59.33            +0.0%      59.33            -0.6%      59.00        filebench.sum_reads/s
>>       83.98            -1.5%      82.75            +0.8%      84.62            +1.0%      84.84        filebench.sum_time_ms/op
> 

-- 
Zhengjun Xing
