Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC18C28ADBC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 07:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgJLFaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 01:30:02 -0400
Received: from mga03.intel.com ([134.134.136.65]:35131 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbgJLFaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 01:30:02 -0400
IronPort-SDR: XDudJNlmK8YV6mWoPCl2qBmhgHGl5QyxcyyWXxF/HMza9nF1V4sbNW0CMLU+JzSjEUWyXSCXp7
 ITOw+EigM2yQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="165749587"
X-IronPort-AV: E=Sophos;i="5.77,365,1596524400"; 
   d="scan'208";a="165749587"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2020 22:30:01 -0700
IronPort-SDR: 7eQVdQbX5NOM1z5RKVqTaIVr2Q4I0piUQWEe746H9eYsJPeN9tg4JdT6wlIbPsxmBSXlDz4b37
 NkUwojE60qIA==
X-IronPort-AV: E=Sophos;i="5.77,365,1596524400"; 
   d="scan'208";a="462971273"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.4.68]) ([10.238.4.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2020 22:29:57 -0700
Subject: Re: [LKP] Re: [hugetlbfs] c0d0381ade: vm-scalability.throughput
 -33.4% regression
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        kernel test robot <rong.a.chen@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A.Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <20200622005551.GK5535@shao2-debian>
 <e140ec78-1fbd-73e2-7a11-7db3b714874d@oracle.com>
 <718e1653-b273-096b-0ee3-f720cf794612@oracle.com>
 <d945497d-0edb-f540-33e1-8b1ba1e20f62@linux.intel.com>
 <691152ef-6787-9598-4445-fd2a0164f70f@oracle.com>
 <1f6d321e-96b4-18c3-2991-d6a2e94c9e60@oracle.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <68992a81-a1b9-467b-59c4-48ab65c601c5@linux.intel.com>
Date:   Mon, 12 Oct 2020 13:29:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <1f6d321e-96b4-18c3-2991-d6a2e94c9e60@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

    I re-test it in v5.9-rc8, the regression still existed. It is almost 
the same as 34ae204f1851. Do you have time to look at it? Thanks.

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/runtime/size/test/cpufreq_governor/ucode:
 
lkp-knm01/vm-scalability/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/300s/8T/anon-cow-seq-hugetlb/performance/0x11

commit:
   49aef7175cc6eb703a9280a7b830e675fe8f2704
   c0d0381ade79885c04a04c303284b040616b116e
   v5.8
   34ae204f18519f0920bd50a644abd6fefc8dbfcf
   v5.9-rc1
   v5.9-rc8

49aef7175cc6eb70 c0d0381ade79885c04a04c30328                        v5.8 
34ae204f18519f0920bd50a644a                    v5.9-rc1 
   v5.9-rc8
---------------- --------------------------- --------------------------- 
--------------------------- --------------------------- 
---------------------------
          %stddev     %change         %stddev     %change 
%stddev     %change         %stddev     %change         %stddev 
%change         %stddev
              \          |                \          |                \ 
         |                \          |                \          | 
          \
      38043 ±  3%     -30.2%      26560 ±  4%     -29.5%      26815 ± 
6%      -7.4%      35209 ±  2%      -7.4%      35244            -8.8% 
   34704        vm-scalability.median
       7.86 ± 19%      +9.7       17.54 ± 21%     +10.4       18.23 ± 
34%      -3.1        4.75 ±  7%      -4.5        3.36 ±  7%      -4.0 
     3.82 ± 15%  vm-scalability.median_stddev%
   12822071 ±  3%     -34.1%    8450822 ±  4%     -33.6%    8517252 ± 
6%     -10.7%   11453675 ±  2%     -10.2%   11513595 ±  2%     -11.6% 
11331657        vm-scalability.throughput
  2.523e+09 ±  3%     -20.7%  2.001e+09 ±  5%     -19.9%  2.021e+09 ± 
7%      +6.8%  2.694e+09 ±  2%      +7.3%  2.707e+09 ±  2%      +5.4% 
2.661e+09        vm-scalability.workload


On 8/22/2020 7:36 AM, Mike Kravetz wrote:
> On 8/21/20 2:02 PM, Mike Kravetz wrote:
>> Would you be willing to test this series on top of 34ae204f1851?  I will need
>> to rebase the series to take the changes made by 34ae204f1851 into account.
> 
> Actually, the series in this thread will apply/run cleanly on top of
> 34ae204f1851.  No need to rebase or port.  If we decide to move forward more
> work is required.  See a few FIXME's in the patches.
> 

-- 
Zhengjun Xing
