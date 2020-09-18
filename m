Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE58126EDC5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 04:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgIRCXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 22:23:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:11120 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbgIRCXO (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 22:23:14 -0400
IronPort-SDR: EzpGYxTDpm7dcxU583gD10RKh4IrIFmUedfIoPpWAMLoOgNQLZXwpkShhI0H87volds190Ds23
 uPh9Kki96KIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="147524596"
X-IronPort-AV: E=Sophos;i="5.77,273,1596524400"; 
   d="scan'208";a="147524596"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 19:23:11 -0700
IronPort-SDR: qOjG3B373K81LXTLbPcHwRunkEKe5MNWvC4jV91q+IK5YSJ4RgvxZe5KRCApaQHcTz1/VqsVL7
 /zpVaEW8c3dQ==
X-IronPort-AV: E=Sophos;i="5.77,273,1596524400"; 
   d="scan'208";a="483998939"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.5.239]) ([10.238.5.239])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 19:23:07 -0700
Subject: Re: [PATCH 0/2] Update CascadelakeX and SkylakeX events list
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <Linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>, kan.liang@intel.com,
        "Jin, Yao" <yao.jin@intel.com>,
        Stephane Eranian <eranian@google.com>
References: <20200603021818.27028-1-yao.jin@linux.intel.com>
 <911b4132-d1a1-f3c4-a2ed-2fcfe9a28fc6@linux.intel.com>
 <CAP-5=fW3OCuVkQ8csYfHXj5c_pCSY5-6vDrj2r=MNDZmpo0f8g@mail.gmail.com>
 <c7edd282-f58a-4efe-5961-6c1369b6b77b@linux.intel.com>
 <20200616193856.GC6393@kernel.org>
 <681a333b-e4dc-9481-715e-a65a34e10f83@linux.intel.com>
 <82271c45-4a7d-d892-eccd-ed042b86a333@linux.intel.com>
 <8ed53667-8241-1c58-ac2c-ecc9e9870afd@linux.intel.com>
 <CAP-5=fX7faeJWqDwjzOA51ipfJufYDxh=ErF0tiN18y2bBx9dA@mail.gmail.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <bc7de5c2-9739-507f-d30b-1978458a0fd3@linux.intel.com>
Date:   Fri, 18 Sep 2020 10:23:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAP-5=fX7faeJWqDwjzOA51ipfJufYDxh=ErF0tiN18y2bBx9dA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On 9/18/2020 9:36 AM, Ian Rogers wrote:
> On Thu, Sep 17, 2020, 6:21 PM Jin, Yao <yao.jin@linux.intel.com> wrote:
> 
>> Hi Arnaldo,
>>
>> On 9/7/2020 4:01 PM, Jin, Yao wrote:
>>> Hi Arnaldo,
>>>
>>> On 7/17/2020 2:06 PM, Jin, Yao wrote:
>>>> Hi,
>>>>
>>>> On 6/17/2020 3:38 AM, Arnaldo Carvalho de Melo wrote:
>>>>> Em Tue, Jun 16, 2020 at 02:27:40PM +0800, Jin, Yao escreveu:
>>>>>> On 6/16/2020 2:16 PM, Ian Rogers wrote:
>>>>>>> On Mon, Jun 15, 2020 at 6:00 PM Jin, Yao <yao.jin@linux.intel.com>
>> wrote:
>>>>>>>> Can I get an ACK for this patchset?
>>>>>>>> On 6/3/2020 10:18 AM, Jin Yao wrote:
>>>>>>>>> This patchset updates CascadelakeX events to v1.08 and
>>>>>>>>> updates SkylakeX events to v1.21.
>>>>>
>>>>>>>>> The events have been tested on CascadelakeX and SkylakeX
>>>>>>>>> servers with latest perf/core branch.
>>>>>
>>>>>>> could you rebase this on Arnaldo's tmp.perf/core tree?
>>>>>>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=tmp.perf/core
>>>>>>> I tried using git am but get:
>>>>>>> Applying: perf vendor events: Update CascadelakeX events to v1.08
>>>>>>> error: patch fragment without header at line 279: @@ -213,14 +220,14
>> @@
>>>>>>> error: could not build fake ancestor
>>>>>>> Patch failed at 0001 perf vendor events: Update CascadelakeX events
>> to v1.08
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Ian
>>>>>>>
>>>>>>
>>>>>> The patchset are applied OK on perf/core branch.
>>>>>>
>>>>>> As far as I understand, the patch for posting should be based on
>> perf/core branch, is it right?
>>>>>
>>>>> Sorry, I've been testing with using tmp.perf/core as a way to more
>>>>> quickly make available what I've processed, before I test it thoroughly
>>>>> both with container builds and with manual testing, so the bleeding
>> edge
>>>>> is there, perf/core becoming a bit more stable, as I'll try not to
>>>>> rebase it like before.
>>>>>
>>>>> - Arnaldo
>>>>>
>>>>
>>>> Can this event update be accepted?
>>>>
>>>> Thanks
>>>> Jin Yao
>>>
>>> Can this event list update be accepted?
>>>
>>> Thanks
>>> Jin Yao
>>
>> Ping again. :)
>>
>> Can this event update patchset be accepted?
>>
>> @Ian, I remembered you had tried this patchset and it's OK right?
>>
> 
> The previous patch didn't apply cleanly. I tested what I had and it solved
> a problem with metrics derived from recent the most recent tma metrics -
> which is great! I will retest with the latest patch.
> 

This patchset can be applied on perf/core. I double checked with the latest perf/core branch.

> Did you have a chance to look at the skylake parallel reads metric? The arb
> thresh modifier isn't present. There are issues with other metrics where
> the units are scaled twice. Have these been resolved?
> 

I will look at the SKL/KBL desktop metric issues. If it needs, I will post another patchset for 
desktop event update.

Thanks
Jin Yao

> Thanks!
> Ian
> 
> 
> Thanks
>> Jin Yao
>>
> 
