Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C1F1E62BD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 15:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390591AbgE1NtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 09:49:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:54810 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390538AbgE1NtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:49:19 -0400
IronPort-SDR: uLsYf4l7ip9LRWgVbFby9B4rvDC6A/ym5wCOfkodI7r3fc42hRLBbdOlNHSOhac3p3BJKECHwV
 O35QA3iTDwxw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 06:49:18 -0700
IronPort-SDR: 7PtZOYa/KJHSLJqDQs9bszImv8C6YZzwCdFnCN4Mo/rdidXyrdGfN4dENeAetGqtVQ9/Al4Tcj
 gY7mE9YzvK1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,444,1583222400"; 
   d="scan'208";a="376373987"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 28 May 2020 06:49:18 -0700
Received: from [10.251.9.11] (kliang2-mobl.ccr.corp.intel.com [10.251.9.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id A32185803E3;
        Thu, 28 May 2020 06:49:17 -0700 (PDT)
Subject: Re: [PATCH V2 3/3] perf/x86/intel/uncore: Validate MMIO address
 before accessing
To:     David Laight <David.Laight@ACULAB.COM>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "ak@linux.intel.com" <ak@linux.intel.com>
References: <1590671727-99311-1-git-send-email-kan.liang@linux.intel.com>
 <1590671727-99311-3-git-send-email-kan.liang@linux.intel.com>
 <de3b847eddd143998997d70a1ba161b8@AcuMS.aculab.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <79403443-e893-da26-ee6d-1fd7f252bbfe@linux.intel.com>
Date:   Thu, 28 May 2020 09:49:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <de3b847eddd143998997d70a1ba161b8@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/28/2020 9:33 AM, David Laight wrote:
> From: kan.liang@linux.intel.com
>> Sent: 28 May 2020 14:15
> ...
>> +static inline bool is_valid_mmio_offset(struct intel_uncore_box *box,
>> +					unsigned long offset)
> 
> You need a better name, needs to start 'uncore_' and 'mmio'
> probably isn't right either.
>

Sure

>> +{
>> +	if (box->pmu->type->mmio_map_size > offset)
>> +		return true;
> 
> Swap over.
> Conditionals always read best if 'variable op constant'.
> So you want:
> 	if (offset < box->pmu->type->mmio_map_size)
> 		return true;
> 

Sure

>> +
>> +	pr_warn_once("perf uncore: Access invalid address of %s.\n",
>> +		     box->pmu->type->name);
> 
> Pretty hard to debug without the invalid offset.
> 

I will dump the box->io_addr and offset for debugging.

Thanks,
Kan
> I've no idea what the code is supposed to be doing though.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
