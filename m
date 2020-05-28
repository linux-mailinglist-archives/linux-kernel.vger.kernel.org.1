Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89721E635D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 16:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390971AbgE1OId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 10:08:33 -0400
Received: from mga06.intel.com ([134.134.136.31]:47664 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390658AbgE1OId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:08:33 -0400
IronPort-SDR: WwPl4F/y7v25SPZV3vvsdqAplTiEVNWz7Xot+hzxPm6Sn4C9LTRlv09/hrTMnuX43BtcAFgoBF
 u6vuWyERX+qA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 07:08:32 -0700
IronPort-SDR: jhvXYTMRxGyLYTjqyMgsmUO8xYLqrhvph+wpWlnok9jeP2btu47K5r2fmEWuX9EBbJTGGxCYwf
 IRAeqivDnweA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,444,1583222400"; 
   d="scan'208";a="345913556"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 28 May 2020 07:08:32 -0700
Received: from [10.251.9.11] (kliang2-mobl.ccr.corp.intel.com [10.251.9.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 9E9B75803E3;
        Thu, 28 May 2020 07:08:31 -0700 (PDT)
Subject: Re: [PATCH V2 3/3] perf/x86/intel/uncore: Validate MMIO address
 before accessing
To:     Andi Kleen <ak@linux.intel.com>
Cc:     David Laight <David.Laight@aculab.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1590671727-99311-1-git-send-email-kan.liang@linux.intel.com>
 <1590671727-99311-3-git-send-email-kan.liang@linux.intel.com>
 <de3b847eddd143998997d70a1ba161b8@AcuMS.aculab.com>
 <79403443-e893-da26-ee6d-1fd7f252bbfe@linux.intel.com>
 <20200528140226.GI611145@tassilo.jf.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <6746309b-c761-e338-c7d6-85ab6edb9052@linux.intel.com>
Date:   Thu, 28 May 2020 10:08:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200528140226.GI611145@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/28/2020 10:02 AM, Andi Kleen wrote:
>>>> +
>>>> +	pr_warn_once("perf uncore: Access invalid address of %s.\n",
>>>> +		     box->pmu->type->name);
>>>
>>> Pretty hard to debug without the invalid offset.
>>>
>>
>> I will dump the box->io_addr and offset for debugging.
> 
> Please don't overengineer.
> 

OK. Will only dump the invalid offset.

Thanks,
Kan
