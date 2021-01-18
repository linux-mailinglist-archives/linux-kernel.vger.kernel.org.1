Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6B22F9899
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 05:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbhARES3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 23:18:29 -0500
Received: from mga01.intel.com ([192.55.52.88]:11830 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726592AbhARESY (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 23:18:24 -0500
IronPort-SDR: r3asPwcg81QSBRdf42CWVlOW/NmkT9KSjpQ2842w3xNJdbSa4b78flVPsPz8nuem/ivh76YHyd
 3jEYGBBRmHYg==
X-IronPort-AV: E=McAfee;i="6000,8403,9867"; a="197449035"
X-IronPort-AV: E=Sophos;i="5.79,355,1602572400"; 
   d="scan'208";a="197449035"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2021 20:16:39 -0800
IronPort-SDR: ycejwHF6gSbH3++8jekt+s4GyT0SVblVdpq21lWYO+RoDjfi9hVm3/WOKtjkM7Dl3gSy9Xjca/
 VaKlczcztQBA==
X-IronPort-AV: E=Sophos;i="5.79,355,1602572400"; 
   d="scan'208";a="383421365"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.27]) ([10.238.4.27])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2021 20:16:36 -0800
Subject: Re: [PATCH v6] perf stat: Fix wrong skipping for per-die aggregation
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        ying.huang@intel.com
References: <20210114012755.1106-1-yao.jin@linux.intel.com>
 <20210114190032.GC1416940@krava> <20210115202814.GM457607@kernel.org>
 <20210115203119.GN457607@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <007d5b53-360c-1540-a7b1-b846cab1decd@linux.intel.com>
Date:   Mon, 18 Jan 2021 12:16:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210115203119.GN457607@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo, Jiri,

On 1/16/2021 4:31 AM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jan 15, 2021 at 05:28:14PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Thu, Jan 14, 2021 at 08:00:32PM +0100, Jiri Olsa escreveu:
>>> On Thu, Jan 14, 2021 at 09:27:55AM +0800, Jin Yao wrote:
>>>
>>> SNIP
>>>
>>>>       2.003776312 S1-D0           1             855616 Bytes llc_misses.mem_read
>>>>       2.003776312 S1-D1           1             949376 Bytes llc_misses.mem_read
>>>>       3.006512788 S0-D0           1            1338880 Bytes llc_misses.mem_read
>>>>       3.006512788 S0-D1           1             920064 Bytes llc_misses.mem_read
>>>>       3.006512788 S1-D0           1             877184 Bytes llc_misses.mem_read
>>>>       3.006512788 S1-D1           1            1020736 Bytes llc_misses.mem_read
>>>>       4.008895291 S0-D0           1             926592 Bytes llc_misses.mem_read
>>>>       4.008895291 S0-D1           1             906368 Bytes llc_misses.mem_read
>>>>       4.008895291 S1-D0           1             892224 Bytes llc_misses.mem_read
>>>>       4.008895291 S1-D1           1             987712 Bytes llc_misses.mem_read
>>>>       5.001590993 S0-D0           1             962624 Bytes llc_misses.mem_read
>>>>       5.001590993 S0-D1           1             912512 Bytes llc_misses.mem_read
>>>>       5.001590993 S1-D0           1             891200 Bytes llc_misses.mem_read
>>>>       5.001590993 S1-D1           1             978432 Bytes llc_misses.mem_read
>>>>
>>>> On no-die system, die_id is 0, actually it's hashmap(socket,0), original behavior
>>>> is not changed.
>>>>
>>>> Reported-by: Huang Ying <ying.huang@intel.com>
>>>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>>>> ---
>>>> v6:
>>>>   Fix the perf test python failure by adding hashmap.c to python-ext-sources.
>>>>
>>>>   root@kbl-ppc:~# ./perf test python
>>>>   19: 'import perf' in python                                         : Ok
>>>
>>> Acked-by: Jiri Olsa <jolsa@redhat.com>
>>
>> Jin, this is breaking the build in some 32-bit system, can you please
>> take a look to validate these warnings?
> 
> One such system:
> 
>    28    13.75 debian:experimental-x-mipsel  : FAIL mipsel-linux-gnu-gcc (Debian 10.2.1-3) 10.2.1 20201224
> 
>   
>>    CC       /tmp/build/perf/util/srcline.o
>> util/stat.c: In function 'pkg_id_hash':
>> util/stat.c:285:9: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>>    return (int64_t)key & 0xffffffff;
>>           ^
>> util/stat.c: In function 'pkg_id_equal':
>> util/stat.c:291:9: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>>    return (int64_t)key1 == (int64_t)key2;
>>           ^
>> util/stat.c:291:26: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>>    return (int64_t)key1 == (int64_t)key2;
>>                            ^
>> util/stat.c: In function 'check_per_pkg':
>> util/stat.c:342:26: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>>    if (hashmap__find(mask, (void *)key, NULL))
>>                            ^
>> util/stat.c:345:28: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>>     ret = hashmap__add(mask, (void *)key, (void *)1);
>>                              ^
>>    CC       /tmp/build/perf/tests/expand-cgroup.o
> 

Thanks for reporting this build issue on 32 bit system.

In v7, I use size_t to replace uint64_t and change the hash key to 'die_id << 16 | socket_id'. I 
assume that 16 bits is enough for socket id, is it true? But if it's not true, we have to use a more 
complicated way such as allocate a structure which has die_id and socket_id and add it to hashmap.

But I'm not sure if that's necessary because I can't imagine a system which has socket id > 65535.

Thanks
Jin Yao

