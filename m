Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C1B29408C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 18:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394696AbgJTQcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 12:32:08 -0400
Received: from mga04.intel.com ([192.55.52.120]:13024 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394631AbgJTQcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 12:32:08 -0400
IronPort-SDR: Lv31SfFclFV2HtiD3dXdhOgv8NVfuJNUVWnNM+l0fQxg7ON9pmAoKOkzlLn+ZXnWnGJ/lLn7UJ
 BXgVOoSiy9Xg==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="164630680"
X-IronPort-AV: E=Sophos;i="5.77,397,1596524400"; 
   d="scan'208";a="164630680"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 09:31:58 -0700
IronPort-SDR: J76D17Ptub9j3CSqZovWWzwPqz3I8SgCv8M7W+/58Yj0o73X4si/Ck+M24jEPOwkGorJlyCGhm
 gc9Czpwzap4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,397,1596524400"; 
   d="scan'208";a="465988061"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 20 Oct 2020 09:31:57 -0700
Received: from [10.249.231.55] (abudanko-mobl.ccr.corp.intel.com [10.249.231.55])
        by linux.intel.com (Postfix) with ESMTP id 139165804D6;
        Tue, 20 Oct 2020 09:31:54 -0700 (PDT)
Subject: Re: [PATCH v1 02/15] perf report: output trace file name in raw trace
 dump
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <810f3a69-0004-9dff-a911-b7ff97220ae0@linux.intel.com>
 <87e2050b-37e6-8ed8-e1e0-cfa074b030fa@linux.intel.com>
 <20201012160144.GA466880@tassilo.jf.intel.com>
 <42d5395a-71f5-63e1-f7c9-fd76e2b8bee4@linux.intel.com>
Organization: Intel Corp.
Message-ID: <a1c21077-0383-aa29-cc79-a8921916c63f@linux.intel.com>
Date:   Tue, 20 Oct 2020 19:31:53 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <42d5395a-71f5-63e1-f7c9-fd76e2b8bee4@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12.10.2020 20:06, Alexey Budankov wrote:
> 
> On 12.10.2020 19:01, Andi Kleen wrote:
>> On Mon, Oct 12, 2020 at 11:54:24AM +0300, Alexey Budankov wrote:
>>> @@ -180,7 +183,8 @@ static int ordered_events__deliver_event(struct ordered_events *oe,
>>>  						    ordered_events);
>>>  
>>>  	return perf_session__deliver_event(session, event->event,
>>> -					   session->tool, event->file_offset);
>>> +					   session->tool, event->file_offset,
>>> +					   event->file_path);
>>
>> Wouldn't it be better to pass "event" around now, which would contain at least
>> four of the arguments.
>>
>> These functions are getting entirely too many arguments.
> 
> Well, either approach is possible, and even shrink of two arguments kept at session object.
> However changing function signature more than posted can cause bigger adjustments all over
> the code. So this needs more evaluation prior implementation. 

After brief evaluation it still doesn't look easy. The simplest thing
I could imagine is to probably combine file_path and file_offset at a
struct object on stack and then pass the object by the reference along
function calls. I expect it will roughly cause the same amount of changes
in the code and saves one argument (GP register). It is not that much
but still. However I don't see issues with passing even 6 args on stack.

Alexei
