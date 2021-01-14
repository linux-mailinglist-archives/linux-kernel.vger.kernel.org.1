Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2442F55C1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 02:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbhANBRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 20:17:30 -0500
Received: from mga14.intel.com ([192.55.52.115]:46122 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727205AbhANBMl (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 20:12:41 -0500
IronPort-SDR: CCaCAMilGAJjpT6ykpjVSmAHdnuVXzAMsHebV1Pe0+ME+ZPaMTDWaa9wTeH0Z3iHuQ2cYUz2qp
 NQHkSQa/x+Ww==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="177514156"
X-IronPort-AV: E=Sophos;i="5.79,345,1602572400"; 
   d="scan'208";a="177514156"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 17:10:15 -0800
IronPort-SDR: WfZ3odycsTkAzXZR4ynzyqlZz7JMrRDHcFd4QJq2QkRT0Vf3cMLZwp3bxAPRqjVJNFwNKWA6YJ
 6rCz+uiWUARQ==
X-IronPort-AV: E=Sophos;i="5.79,345,1602572400"; 
   d="scan'208";a="424774223"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.27]) ([10.238.4.27])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 17:10:12 -0800
Subject: Re: [PATCH v5] perf stat: Fix wrong skipping for per-die aggregation
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210113015631.8748-1-yao.jin@linux.intel.com>
 <20210113110701.GC1331835@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <2c8ea7a0-6d02-bea2-3a73-bafa481d99e9@linux.intel.com>
Date:   Thu, 14 Jan 2021 09:10:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210113110701.GC1331835@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/13/2021 7:07 PM, Jiri Olsa wrote:
> On Wed, Jan 13, 2021 at 09:56:31AM +0800, Jin Yao wrote:
> 
> SNIP
> 
>>
>> root@lkp-csl-2ap4 ~# ./perf stat -a -I 1000 -e llc_misses.mem_read --per-die -- sleep 5
>>       1.001586691 S0-D0           1            1229440 Bytes llc_misses.mem_read
>>       1.001586691 S0-D1           1             976832 Bytes llc_misses.mem_read
>>       1.001586691 S1-D0           1             938304 Bytes llc_misses.mem_read
>>       1.001586691 S1-D1           1            1227328 Bytes llc_misses.mem_read
>>       2.003776312 S0-D0           1            1586752 Bytes llc_misses.mem_read
>>       2.003776312 S0-D1           1             875392 Bytes llc_misses.mem_read
>>       2.003776312 S1-D0           1             855616 Bytes llc_misses.mem_read
>>       2.003776312 S1-D1           1             949376 Bytes llc_misses.mem_read
>>       3.006512788 S0-D0           1            1338880 Bytes llc_misses.mem_read
>>       3.006512788 S0-D1           1             920064 Bytes llc_misses.mem_read
>>       3.006512788 S1-D0           1             877184 Bytes llc_misses.mem_read
>>       3.006512788 S1-D1           1            1020736 Bytes llc_misses.mem_read
>>       4.008895291 S0-D0           1             926592 Bytes llc_misses.mem_read
>>       4.008895291 S0-D1           1             906368 Bytes llc_misses.mem_read
>>       4.008895291 S1-D0           1             892224 Bytes llc_misses.mem_read
>>       4.008895291 S1-D1           1             987712 Bytes llc_misses.mem_read
>>       5.001590993 S0-D0           1             962624 Bytes llc_misses.mem_read
>>       5.001590993 S0-D1           1             912512 Bytes llc_misses.mem_read
>>       5.001590993 S1-D0           1             891200 Bytes llc_misses.mem_read
>>       5.001590993 S1-D1           1             978432 Bytes llc_misses.mem_read
>>
>> On no-die system, die_id is 0, actually it's hashmap(socket,0), original behavior
>> is not changed.
>>
>> Reported-by: Huang Ying <ying.huang@intel.com>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>> v5:
>>   Hash key is changed to die_id << 32 | socket.
>>   In pkg_id_hash, return (int64_t)key & 0xffffffff; actually it's socket.
> 
> seems ok, but I'm getting python test fail:
> 
> 	$ sudo ./perf test python -v
> 	19: 'import perf' in python                                         :
> 	--- start ---
> 	test child forked, pid 1352066
> 	python usage test: "echo "import sys ; sys.path.append('python'); import perf" | '/usr/bin/python2' "
> 	Traceback (most recent call last):
> 	  File "<stdin>", line 1, in <module>
> 	ImportError: python/perf.so: undefined symbol: hashmap__free
> 	test child finished with -1
> 	---- end ----
> 	'import perf' in python: FAILED!
> 
> jirka
> 

Seems I need to add hashmap.c to python-ext-sources. It surprised me that it was not in it yet. :(

diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ext-sources
index a9d9c142eb7c..266874913dbb 100644
--- a/tools/perf/util/python-ext-sources
+++ b/tools/perf/util/python-ext-sources
@@ -35,3 +35,4 @@ util/symbol_fprintf.c
  util/units.c
  util/affinity.c
  util/rwsem.c
+util/hashmap.c

root@kbl-ppc:~# ./perf test 19
19: 'import perf' in python                                         : Ok

Thanks
Jin Yao
