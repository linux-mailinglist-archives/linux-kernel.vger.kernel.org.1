Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21F62F73AD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 08:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731226AbhAOHZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 02:25:04 -0500
Received: from mga01.intel.com ([192.55.52.88]:20855 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729451AbhAOHZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 02:25:03 -0500
IronPort-SDR: 2mquRg54P9JbPGC5P7rmf3gH1t3R0pji7sUtatJ/VILf8BwTorXaDT+uUnfQF1mPguYiegD/xy
 19YmTQ0zcQSQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="197173954"
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; 
   d="scan'208";a="197173954"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 23:23:11 -0800
IronPort-SDR: rI+g70nMjeju82zmMHGK73x/doUFYZSAe2vGJuYhomHwkIvTWuVo0O7Ct7zsxNcIwXaSIhdfNP
 DZ8veDKLVzNw==
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; 
   d="scan'208";a="382568970"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.255.30.191]) ([10.255.30.191])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 23:23:10 -0800
To:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>, Tony <tony.luck@intel.com>,
        Tim C Chen <tim.c.chen@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Du, Julie" <julie.du@intel.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: Test report for kernel direct mapping performance
Message-ID: <213b4567-46ce-f116-9cdf-bbd0c884eb3c@linux.intel.com>
Date:   Fri, 15 Jan 2021 15:23:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There is currently a bit of a debate about the kernel direct map. Does 
using 2M/1G pages aggressively for the kernel direct map help 
performance? Or, is it an old optimization which is not as helpful on 
modern CPUs as it was in the old days? What is the penalty of a kernel 
feature that heavily demotes this mapping from larger to smaller pages? 
We did a set of runs with 1G and 2M pages enabled /disabled and saw the 
changes.

[Conclusions]

Assuming that this was a good representative set of workloads and that 
the data are good, for server usage, we conclude that the existing 
aggressive use of 1G mappings is a good choice since it represents the 
best in a plurality of the workloads. However, in a *majority* of cases, 
another mapping size (2M or 4k) potentially offers a performance 
improvement. This leads us to conclude that although 1G mappings are a 
good default choice, there is no compelling evidence that it must be the 
only choice, or that folks deriving benefits (like hardening) from 
smaller mapping sizes should avoid the smaller mapping sizes.

[Summary of results]

1. The test was done on server platforms with 11 benchmarks. For the 4 
different server platforms tested, each with three different maximums 
kernel mapping sizes: 4k, 2M, and 1G. Each system has enough memory to 
effectively deploy 1G mappings.  For the 11 different benchmarks were 
used, not every benchmark was run on every system, there was a total of 
259 tests.

2. For each benchmark/system combination, the 1G mapping had the highest 
performance for 45% of the tests, 2M for ~30%, and 4k for~20%.

3. From the average delta, among 1G/2M/4K, 4K gets the lowest 
performance in all the 4 test machines, while 1G gets the best 
performance on 2 test machines and 2M gets the best performance on the 
other 2 machines.

4. By testing with machine memory from 256G to 512G, we observed that 
the larger memory will lead to the performance better for 1G page size. 
With Large memory, 
Will-it-scale/vm-scalability/unixbench/reaim/hackbench shows 1G has the 
best performance, while kbuild/memtier/netperf shows 4K has the best 
performance.

For more details please see the following web link:

https://01.org/sites/default/files/documentation/test_report_for_kernel_direct_mapping_performance_0.pdf

-- 
Zhengjun Xing
