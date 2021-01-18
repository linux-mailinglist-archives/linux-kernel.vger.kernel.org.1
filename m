Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B642F98DD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 05:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730554AbhARE4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 23:56:30 -0500
Received: from mga05.intel.com ([192.55.52.43]:43921 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbhARE42 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 23:56:28 -0500
IronPort-SDR: uRo9Et2p2EXxZduwGqDUorwnZ92whXHcYDOVb+lvKxUpyvkcOWBLYHnIs6PONW+/jqq/ja7l9H
 goplEP2FvIqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9867"; a="263562979"
X-IronPort-AV: E=Sophos;i="5.79,355,1602572400"; 
   d="scan'208";a="263562979"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2021 20:54:42 -0800
IronPort-SDR: x/F1t2tK6H5or7+JFTyHNHYtlkvRQ7PE4851Xm5SYNR2655Ho+VjAplpU1avtvAFDzAp6BNIXp
 e/n3d9zEyUwQ==
X-IronPort-AV: E=Sophos;i="5.79,355,1602572400"; 
   d="scan'208";a="383428999"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.27]) ([10.238.4.27])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2021 20:54:39 -0800
Subject: Re: [PATCH v2] perf stat: Append to default list if use -e +event
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210104021837.30473-1-yao.jin@linux.intel.com>
 <20210112100807.GB1273297@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <64dba2a3-0bf2-3af3-6f54-6e200840017d@linux.intel.com>
Date:   Mon, 18 Jan 2021 12:54:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210112100807.GB1273297@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 1/12/2021 6:08 PM, Jiri Olsa wrote:
> On Mon, Jan 04, 2021 at 10:18:37AM +0800, Jin Yao wrote:
>> The default event list includes the most common events which are widely
>> used by users. But with -e option, the current perf only counts the events
>> assigned by -e option. Users may want to collect some extra events with
>> the default list. For this case, users have to manually add all the events
>> from the default list. It's inconvenient. Also, users may don't know how to
>> get the default list.
>>
>> Now it supports a simple syntax: -e +event
>>
>> The prefix '+' tells perf to append this event (or event list) to default
>> event list.
>>
>> Before:
>>
>> root@kbl-ppc:~# ./perf stat -e power/energy-pkg/ -a -- sleep 1
>>
>>   Performance counter stats for 'system wide':
>>
>>                2.04 Joules power/energy-pkg/
>>
>>         1.000863884 seconds time elapsed
>>
>> After:
>>
>> root@kbl-ppc:~# ./perf stat -e +power/energy-pkg/ -a -- sleep 1
>>
>>   Performance counter stats for 'system wide':
>>
>>                2.11 Joules +power/energy-pkg/        #    0.000 K/sec
> 
> I dont think we should print the extra '+' prefix
> 
> jirka
> 
>>            8,007.17 msec   cpu-clock                 #    7.993 CPUs utilized
>>                 125        context-switches          #    0.016 K/sec
>>                   8        cpu-migrations            #    0.001 K/sec
>>                   2        page-faults               #    0.000 K/sec
>>           8,520,084        cycles                    #    0.001 GHz
>>           2,808,302        instructions              #    0.33  insn per cycle
>>             555,427        branches                  #    0.069 M/sec
>>              59,005        branch-misses             #   10.62% of all branches
>>
>>         1.001832003 seconds time elapsed
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> 

Printing '+' prefix is the original behavior.

Without this patch,

root@kbl-ppc:# ./perf stat -e +power/energy-pkg/ -a -- sleep 1

  Performance counter stats for 'system wide':

               2.02 Joules +power/energy-pkg/

        1.000859434 seconds time elapsed

The '+' prefix is printed. So I finally decide not to remove the '+' prefix in order to keep 
original behavior.

Thanks
Jin Yao


