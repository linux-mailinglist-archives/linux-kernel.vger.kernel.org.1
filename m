Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94ABA2958F6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 09:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508396AbgJVHUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 03:20:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:17996 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506110AbgJVHUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 03:20:18 -0400
IronPort-SDR: y+oTQj4MGj2zZ2du1t81kDe1Ze2tA2ngSTvW1jNKT7W/jlOM53bjz/+FHdWVXeE7shPMGQkGJh
 C3SHx3irjbvA==
X-IronPort-AV: E=McAfee;i="6000,8403,9781"; a="164891588"
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="164891588"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 00:20:18 -0700
IronPort-SDR: HKPUXsdiojHBq+Kxn/wWaHAytaZKtSQLPWdo/PK45+s6KBAv2H1kNLcXEygAC5XTkZp47LviMT
 MGMzIKOkyE3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="533839360"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 22 Oct 2020 00:20:17 -0700
Received: from [10.249.225.194] (abudanko-mobl.ccr.corp.intel.com [10.249.225.194])
        by linux.intel.com (Postfix) with ESMTP id 97C7758058B;
        Thu, 22 Oct 2020 00:20:15 -0700 (PDT)
Subject: Re: [PATCH v2 05/15] perf session: introduce decompressor into trace
 reader object
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
 <b3c73389-7b4c-89cd-423c-68b00fcc61c9@linux.intel.com>
 <CAM9d7cgr11TD-cACYbsxa=sUyStH_TGUDbdw9dsBuKAH43uQow@mail.gmail.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <f9647ad1-1c3d-f9f3-bfa9-a924c9beef49@linux.intel.com>
Date:   Thu, 22 Oct 2020 10:20:14 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAM9d7cgr11TD-cACYbsxa=sUyStH_TGUDbdw9dsBuKAH43uQow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22.10.2020 7:36, Namhyung Kim wrote:
> On Thu, Oct 22, 2020 at 1:00 AM Alexey Budankov
> <alexey.budankov@linux.intel.com> wrote:
>>
>>
>> Introduce decompressor to trace reader object so that decompression
>> could be executed on per trace file basis separately for every
>> trace file located in trace directory.
> 
> I'm slightly uncomfortable with the word 'trace' here as it's
> used for other cases like perf trace and ftrace.  Maybe we can
> change it to 'profile' and/or 'data file'?

Let's use "data file" and "data directory" terms then.

Thanks,
Alexei
