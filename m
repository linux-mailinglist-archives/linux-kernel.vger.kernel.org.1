Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E613B26F664
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 08:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgIRG6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 02:58:47 -0400
Received: from mga03.intel.com ([134.134.136.65]:42264 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgIRG6q (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 02:58:46 -0400
IronPort-SDR: 7pCun6oaUXieIV8A/abCmHzlKF10sbquJGHkoa0DMouQCaLPECpSJuqT1A7MgEd7p/UShUQeQI
 zDYlXZkTk36Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="159930126"
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="159930126"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 23:58:45 -0700
IronPort-SDR: NhBC5+hQLcJEqE7MvibANDu5NP9xT0X4A7Cop9EJek12/jzt5TxjojZjcjc0nvI7tWoJY2IM4q
 U3a7aC5B2Bzw==
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="484076772"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.5.239]) ([10.238.5.239])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 23:58:43 -0700
Subject: Re: [PATCH v6 7/7] perf diff: Support hot streams comparison
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <20200911080353.13359-1-yao.jin@linux.intel.com>
 <20200911080353.13359-8-yao.jin@linux.intel.com>
 <20200917202608.GF1431236@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <87bb9e8c-a695-1344-0752-735466cfb4ce@linux.intel.com>
Date:   Fri, 18 Sep 2020 14:58:41 +0800
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

Yes, that would be better. Let me think about the implementation.

Thanks
Jin Yao
