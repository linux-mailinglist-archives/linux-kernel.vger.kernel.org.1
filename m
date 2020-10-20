Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6FA2933A2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 05:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391097AbgJTD2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 23:28:34 -0400
Received: from mga01.intel.com ([192.55.52.88]:40415 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729973AbgJTD2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 23:28:34 -0400
IronPort-SDR: nVn1STLFPQP8YmsAtV9r6St1T9H6VySMd3qyZ8954hdBZ9M3GaGKPD8SbmvbJLvnGKWANT5Otl
 SVMbJOsRme8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9779"; a="184770534"
X-IronPort-AV: E=Sophos;i="5.77,396,1596524400"; 
   d="scan'208";a="184770534"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 20:28:33 -0700
IronPort-SDR: LQOOj/EAninqCcKSQlitVHFU/a8ztNYY3LQgvv9oy+/F6lJEkWB4uRLolp4Y+pMXFlej3mgLad
 MVKBXGTuoiww==
X-IronPort-AV: E=Sophos;i="5.77,396,1596524400"; 
   d="scan'208";a="532876595"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.4.68]) ([10.238.4.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 20:28:31 -0700
Subject: Re: [LKP] Re: Unreliable will-it-scale context_switch1 test on 0day
 bot
To:     Philip Li <philip.li@intel.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Anton Blanchard <anton@au.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        lkp <lkp@lists.01.org>, 0day robot <lkp@intel.com>,
        Zhengjun Xing <zhengjun.xing@intel.com>
References: <104775100.27222.1603114052224.JavaMail.zimbra@efficios.com>
 <20201019152410.GA14293@intel.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <9b8bb76e-5349-acff-117a-fb2b3192c4cb@linux.intel.com>
Date:   Tue, 20 Oct 2020 11:28:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201019152410.GA14293@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/2020 11:24 PM, Philip Li wrote:
> On Mon, Oct 19, 2020 at 09:27:32AM -0400, Mathieu Desnoyers wrote:
>> Hi,
>>
>> I pointed out an issue with the will-it-scale context_switch1 test run by the 0day bot on
>> October 7, 2020, and got no reply.
> Thanks Mathieu for the feedback, we had added it to the TODO list but sorry for
> not reply in time.
> 
> Zhengjun, can you help follow up this mail thread?
> 

I have replied in the origin mail.

>>
>> Until this issue is solved, the results of those tests are basically pure noise when run on
>> SMT hardware:
>>
>> https://lore.kernel.org/lkml/1183082664.11002.1602082242482.JavaMail.zimbra@efficios.com/
>>
>> Who is maintaining those tests and the 0day bot ?
> will-it-scale itself is from community at https://github.com/antonblanchard/will-it-scale
> and we will look for the support if we don't have quick solution. 0day bot basically wraps
> the test and analyze the result to find which commit leads to change.
> 
>>
>> Thanks,
>>
>> Mathieu
>>
>> -- 
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com
>> _______________________________________________
>> LKP mailing list -- lkp@lists.01.org
>> To unsubscribe send an email to lkp-leave@lists.01.org
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org
> 

-- 
Zhengjun Xing
