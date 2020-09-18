Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA2226F65A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 08:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgIRGzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 02:55:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:16062 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbgIRGzC (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 02:55:02 -0400
IronPort-SDR: ne0plUTF0BcPNcm05SBQr5hkkqKerLqygmxT98ehS+9TDyr2OfJFf/r1X0X1GxzH34RePafXK5
 Znlnq6Og8cpQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="157264721"
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="157264721"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 23:55:01 -0700
IronPort-SDR: xLTZvktxiSHXoIH6O7c5dQEXAuSjJl71mQf8hFDHjjQyKj9c4gbHHlryWluvhUgf2KjI7iGVKN
 Rbr+qmZJJsyw==
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="484075645"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.5.239]) ([10.238.5.239])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 23:54:58 -0700
Subject: Re: [PATCH v6 0/7] perf: Stream comparison
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <20200911080353.13359-1-yao.jin@linux.intel.com>
 <20200917130556.GA2511679@krava> <20200917201320.GB1431236@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <6bf033e6-56a0-ea20-c46c-364b51952fef@linux.intel.com>
Date:   Fri, 18 Sep 2020 14:54:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200917201320.GB1431236@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 9/18/2020 4:13 AM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Sep 17, 2020 at 03:05:56PM +0200, Jiri Olsa escreveu:
>> On Fri, Sep 11, 2020 at 04:03:46PM +0800, Jin Yao wrote:
>>
>> SNIP
>>
>>>                        main div.c:40
>>>                        main div.c:40
>>>                        main div.c:39
>>>
>>> [ Hot streams in new perf data only ]
>>>
>>> hot chain 1:
>>>                                                       cycles: 4, hits: 4.54%
>>>                                                   --------------------------
>>>                                                                main div.c:42
>>>                                                        compute_flag div.c:28
>>>
>>> hot chain 2:
>>>                                                       cycles: 5, hits: 3.51%
>>>                                                   --------------------------
>>>                                                                main div.c:39
>>>                                                                main div.c:44
>>>                                                                main div.c:42
>>>                                                        compute_flag div.c:28
>>>
>>>   v6:
>>>   ---
>>>   Rebase to perf/core
>>
>> it looks good to me
>>
>> Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> Jin,
> 
> 	I'm sorry I only got to look at this now, there are some issues,
> I'll try to point them out patch by patch,
> 
> Thanks,
> 
> - Arnaldo
> 

Thanks so much for looking at this patchset! :)

I will fix the issues which you point out in other mail threads. Once the fixes are done, I will 
post v7.

Thanks
Jin Yao
