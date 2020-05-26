Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5B51B5470
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 07:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgDWFyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 01:54:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:50371 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbgDWFyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 01:54:00 -0400
IronPort-SDR: eoEl5hik0hhyypfWO1zx2qN+yseWw2sZdKul6MDme1APYt5FBW7B6LDWrG9qw3O51WhBi1+Gkw
 mhwEqt36i3kA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 22:53:59 -0700
IronPort-SDR: 1jkKg9WIy60a1ZERGAhk8WqRoWE0s8S6vCMQi2XvnQfFzum74J85wJsaXBLn2OfcC4DSpUpUS2
 kS3w2L6gYa4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,305,1583222400"; 
   d="scan'208";a="365903246"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.151]) ([10.238.4.151])
  by fmsmga001.fm.intel.com with ESMTP; 22 Apr 2020 22:53:55 -0700
Subject: Re: [PATCH 2/8] perf metrics: fix parse errors in cascade lake
 metrics
From:   "Jin, Yao" <yao.jin@linux.intel.com>
To:     Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
References: <20200422074809.160248-1-irogers@google.com>
 <20200422074809.160248-3-irogers@google.com>
 <20200422143840.GJ608746@tassilo.jf.intel.com>
 <CAP-5=fUnWAycQehCJ9=btquV2c3DVDX+tTEc85H8py9Kfehq4w@mail.gmail.com>
 <CAP-5=fUMFqiSFLbKA-XWStrePwxiYfq7Jk6mS9=F56Q9y-KVsA@mail.gmail.com>
 <46e803f3-80a4-0d37-9d39-b625b947ac7f@linux.intel.com>
Message-ID: <cb5fcb4b-3ac6-66b5-9f9e-7943f4a6dadf@linux.intel.com>
Date:   Thu, 23 Apr 2020 13:53:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <46e803f3-80a4-0d37-9d39-b625b947ac7f@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

Bisected to this commit which introduced the regression.

26226a97724d ("perf expr: Move expr lexer to flex")

Would you like to look at that?

Thanks
Jin Yao

On 4/23/2020 9:08 AM, Jin, Yao wrote:
> 
> 
> On 4/23/2020 12:18 AM, Ian Rogers wrote:
>> On Wed, Apr 22, 2020 at 8:34 AM Ian Rogers <irogers@google.com> wrote:
>>>
>>> On Wed, Apr 22, 2020 at 7:38 AM Andi Kleen <ak@linux.intel.com> wrote:
>>>>
>>>> On Wed, Apr 22, 2020 at 12:48:03AM -0700, Ian Rogers wrote:
>>>>> Remove over escaping with \\.
>>>>> Remove extraneous if 1 if 0 == 1 else 0 else 0.
>>>>
>>>> So where do these parse errors happen exactly? Some earlier
>>>> patches introduced them as regressions?
>>>
>>> I'll work to track down a Fixes tag. I can repro the Skylakex errors
>>> without the test in this series, by doing:
>>>
>>> $ perf stat -M DRAM_Read_Latency sleep 1
>>> Error:
>>> The sys_perf_event_open() syscall returned with 22 (Invalid argument)
>>> for event (cha/event=0x36\,uma
>>> sk=0x21/).
>>> /bin/dmesg | grep -i perf may provide additional information.
>>>
> 
> I also think some patches introduced this regression. When we rollback 
> to commit 61ec07f5917e (perf vendor events intel: Update all the Intel 
> JSON metrics from TMAM 3.6.), there is no this error on CLX.
> 
> Thanks
> Jin Yao
> 
>>> This was just the escaping issue. I'm less clear on the other cascade
>>> lake issue, and it is a bit more work for me to test on cascade lake.
>>> What is "if 1 if 0 == 1 else 0 else 0" trying to do? Perhaps hunting
>>> for the Fixes will let me know, but it looks like a copy-paste error.
>>>
>>>> The original metrics worked without parse errors as far as I know.
>>>
>>> The skylake issue above repros on 5.2.17 and so it seems like it is
>>> broken for a while. The test in this series will prevent this in the
>>> future, but without this patch that test fails.
>>
>> The parse errors were introduced with the metrics, so they've never 
>> worked:
>> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=fd5500989c8f3c3944ac0a144be04bae2506f7ba 
>>
>>
>> I will send out a v2 with Fixes in the commit message but wanted to
>> wait in case there was any more feedback. In particular the fixes to
>> the new test and expr parser lex code. The lex code wasn't broken at
>> the time the metrics were added and should be working again after this
>> patch set.
>>
>> Thanks,
>> Ian
>>
>>>> If it fixes something earlier it would need Fixes: tags.
>>>
>>> Working on it. Thanks for the input!
>>>
>>> Ian
>>>
>>>> -Andi
