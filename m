Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96925270ABA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 06:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgISEln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 00:41:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:33386 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgISElm (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 00:41:42 -0400
IronPort-SDR: JzDx9/Fhm+dm3OltN9re6Q9bjSxlxP7aoidCdtxMJf9nEehLww9v4AorCK1SdwQTFb/1672T3h
 p9PFlikqXIGA==
X-IronPort-AV: E=McAfee;i="6000,8403,9748"; a="178174530"
X-IronPort-AV: E=Sophos;i="5.77,277,1596524400"; 
   d="scan'208";a="178174530"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 21:41:40 -0700
IronPort-SDR: FZO4zry5E3lC/lD57kae2WKPUEbNew3ayKjxPiQoqYW1esrLoPBjDGl4pYL2eHUOVy7/YqWv7p
 Gf3AlvWKxNWg==
X-IronPort-AV: E=Sophos;i="5.77,277,1596524400"; 
   d="scan'208";a="453028905"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.254.214.1]) ([10.254.214.1])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 21:41:38 -0700
Subject: Re: [PATCH v6 7/7] perf diff: Support hot streams comparison
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <20200911080353.13359-1-yao.jin@linux.intel.com>
 <20200911080353.13359-8-yao.jin@linux.intel.com>
 <20200917202608.GF1431236@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <a0eabcde-d498-2ec5-af4f-998380951782@linux.intel.com>
Date:   Sat, 19 Sep 2020 12:41:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200917202608.GF1431236@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 9/18/2020 4:26 AM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Sep 11, 2020 at 04:03:53PM +0800, Jin Yao escreveu:
>> This patch enables perf-diff with "--stream" option.
>>
>> "--stream": Enable hot streams comparison
>>
>> Now let's see examples.
>>
>> perf record -b ...      Generate perf.data.old with branch data
>> perf record -b ...      Generate perf.data with branch data
>> perf diff --stream
>>
>> [ Matched hot streams ]
>>
>> hot chain pair 1:
>>              cycles: 1, hits: 27.77%                  cycles: 1, hits: 9.24%
>>          ---------------------------              --------------------------
>>                        main div.c:39                           main div.c:39
>>                        main div.c:44                           main div.c:44
>>
>> hot chain pair 2:
>>             cycles: 34, hits: 20.06%                cycles: 27, hits: 16.98%
>>          ---------------------------              --------------------------
>>            __random_r random_r.c:360               __random_r random_r.c:360
> 
> Would it be interesting to get the associated source code and show right below
> these file:number lines?
> 
> - Arnaldo
> 

I'm thinking we can implement this function in callchain_list__sym_name(), and then all callchain 
functionality will benefit from it. While that looks to be another patchset. :)

Thanks
Jin Yao
