Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9CB2C4CC2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 02:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730963AbgKZBpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 20:45:06 -0500
Received: from mga17.intel.com ([192.55.52.151]:39756 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgKZBpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 20:45:05 -0500
IronPort-SDR: HOkOzRD0U5fZcoABq3d1A407H6ASjGHqdlCWsbG9LHobbDwWsdiQzXxOmqm93L/nxWgQ6JEhXU
 x6NMuR39Ra+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="152058687"
X-IronPort-AV: E=Sophos;i="5.78,370,1599548400"; 
   d="scan'208";a="152058687"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 17:45:04 -0800
IronPort-SDR: zJhsZISN6zolVB+cjXsvSs3la757HJkgnz0WqsJXQMDiYcEiSB4G7giyU+C8ptErAFYJjMk15Q
 H6xKhhySqVSA==
X-IronPort-AV: E=Sophos;i="5.78,370,1599548400"; 
   d="scan'208";a="479162524"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.4.68]) ([10.238.4.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 17:44:57 -0800
Subject: Re: [Intel-gfx] [drm/i915/gem] 59dd13ad31:
 phoronix-test-suite.jxrendermark.RadialGradientPaint.1024x1024.operations_per_second
 -54.0% regression
To:     Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Oliver Sang <oliver.sang@intel.com>
Cc:     feng.tang@intel.com, tiejun.li@intel.com, frank.du@intel.com,
        guobing.chen@intel.com, jiebin.sun@intel.com, Shuhua.Fan@intel.com,
        Matthew Auld <matthew.auld@intel.com>, fan.zhao@intel.com,
        ying.huang@intel.com, shan.kang@intel.com, zhengjun.xing@intel.com,
        Wenhuan.Huang@intel.com, intel-gfx@lists.freedesktop.org,
        guangli.li@intel.com, gengxin.xie@intel.com, ming.a.chen@intel.com,
        yu.ma@intel.com, jessica.ji@intel.com, lkp@lists.01.org,
        wangyang.guo@intel.com, dapeng1.mi@intel.com,
        LKML <linux-kernel@vger.kernel.org>
References: <20201111155811.GB24657@xsang-OptiPlex-9020>
 <160527763346.5566.3471508802857132043@jlahtine-mobl.ger.corp.intel.com>
 <20201119072018.GA15197@xsang-OptiPlex-9020>
 <160625087275.29168.7080737993781611765@build.alporthouse.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <ab9ebc5a-7d79-8003-c7bc-5cf0923983c6@linux.intel.com>
Date:   Thu, 26 Nov 2020 09:44:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <160625087275.29168.7080737993781611765@build.alporthouse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/25/2020 4:47 AM, Chris Wilson wrote:
> Quoting Oliver Sang (2020-11-19 07:20:18)
>> On Fri, Nov 13, 2020 at 04:27:13PM +0200, Joonas Lahtinen wrote:
>>> Hi,
>>>
>>> Could you add intel-gfx@lists.freedesktop.org into reports going
>>> forward.
>>>
>>> Quoting kernel test robot (2020-11-11 17:58:11)
>>>>
>>>> Greeting,
>>>>
>>>> FYI, we noticed a -54.0% regression of phoronix-test-suite.jxrendermark.RadialGradientPaint.1024x1024.operations_per_second due to commit:
>>>
>>> How many runs are there on the bad version to ensure the bisect is
>>> repeatable?
>>
>> test 4 times.
>> zxing@inn:/result/phoronix-test-suite/performance-true-Radial_Gradient_Paint-1024x1024-jxrendermark-1.2.4-ucode=0xd6-monitor=da39a3ee/lkp-cfl-d1/debian-x86_64-phoronix/x86_64-rhel-8.3/gcc-9/59dd13ad310793757e34afa489dd6fc8544fc3da$ grep -r "operations_per_second" */stats.json
>> 0/stats.json: "phoronix-test-suite.jxrendermark.RadialGradientPaint.1024x1024.operations_per_second": 4133.487932,
>> 1/stats.json: "phoronix-test-suite.jxrendermark.RadialGradientPaint.1024x1024.operations_per_second": 4120.421503,
>> 2/stats.json: "phoronix-test-suite.jxrendermark.RadialGradientPaint.1024x1024.operations_per_second": 4188.414835,
>> 3/stats.json: "phoronix-test-suite.jxrendermark.RadialGradientPaint.1024x1024.operations_per_second": 4068.549514,
> 
> a w/o revert (drm-tip)
> b w/ revert
> +mB----------------------------------------------------------------------------+
> |                             ..b                                              |
> |                             ..b.aa                                           |
> |                             ....a.a                                          |
> |                             ....a.a                                          |
> |                      b  b  ........a                                         |
> |                   b  b  b b......... a                                       |
> |                   b  bb bbb...........                                       |
> |b               ab bbab.bb.b............ba b a a            ab               a|
> |                             |__A__|                                          |
> |                             |MA_|                                            |
> +------------------------------------------------------------------------------+
>      N                Min           Max        Median           Avg        Stddev
> a 120          3621.8761     7356.4442     4606.7895     4607.9132     156.17693
> b 120          2664.0563     6359.9686     4519.5036     4534.4463     95.471121
> 
> The patch is not expected to have any impact on the machine you are testing on.
> -Chris
> 

What's your code base?
For my side:
1) sync the code to the head of Linux mainline
2) git reset --hard 59dd13ad31
3) git revert 59dd13ad3107
We compare the test result of commit 59dd13ad3107 (step 2) and 
2052847b06f8 (step 3, revert 59dd13ad3107), the regression should 
related with 59dd13ad3107. Each test case we run 5 times.
=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/need_x/test/option_a/option_b/cpufreq_governor/ucode/debug-setup:
 
lkp-cfl-d1/phoronix-test-suite/debian-x86_64-phoronix/x86_64-rhel-8.3/gcc-9/true/jxrendermark-1.2.4/Radial 
Gradient Paint/1024x1024/performance/0xde/regression_test

commit:
   0dccdba51e852271a3dbc9358375f4c882b863f2
   59dd13ad310793757e34afa489dd6fc8544fc3da
   2052847b06f863a028f7f3bbc62401e043b34301 (revert 59dd13ad3107)

0dccdba51e852271 59dd13ad310793757e34afa489d 2052847b06f863a028f7f3bbc62
---------------- --------------------------- ---------------------------
          %stddev     %change         %stddev     %change         %stddev
              \          |                \          |                \
       8145 ±  2%     -53.1%       3817 ±  3%      -1.8%       7995 
 
phoronix-test-suite.jxrendermark.RadialGradientPaint.1024x1024.operations_per_second


-- 
Zhengjun Xing
