Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17F329234E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 10:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgJSIDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 04:03:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:56640 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbgJSIDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 04:03:05 -0400
IronPort-SDR: Dokl+3vdgHVOGyKr1im+nNomy5q86SXKUTaCOCd7QcpL0D6Oyftj6NQ/BV7Z2wbYHAnEC3DSl3
 tAVEBBiZIM5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9778"; a="167102145"
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="167102145"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 01:03:04 -0700
IronPort-SDR: Clpl+gDWvlEyR+nyydLcDPkJjkrbCRKWDeutkXG3vo02PCEv86GksX4dUJGawPvQDsLviB+bZl
 O+UKFX81E5Uw==
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="532533598"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.83]) ([10.238.4.83])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 01:02:59 -0700
Subject: Re: [perf metricgroup] fcc9c5243c:
 perf-sanity-tests.Parse_and_process_metrics.fail
To:     Andi Kleen <ak@linux.intel.com>, Ian Rogers <irogers@google.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        John Garry <john.garry@huawei.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linuxarm@huawei.com, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        zhangshaokun@hisilicon.com, James Clark <james.clark@arm.com>,
        linux-imx@nxp.com, 0day robot <lkp@intel.com>, lkp@lists.01.org
References: <1602152121-240367-10-git-send-email-john.garry@huawei.com>
 <20201018085031.GK11647@shao2-debian>
 <CAP-5=fWg4W_fpu-uTZkh-ZoL_7nvqU4F_2LqQgKFvBkfn174HQ@mail.gmail.com>
 <20201019015225.GI466880@tassilo.jf.intel.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <0b84ddc4-ddba-34c2-0996-0d83c7008a6f@linux.intel.com>
Date:   Mon, 19 Oct 2020 16:02:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201019015225.GI466880@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/2020 9:52 AM, Andi Kleen wrote:
>> I believe this is a Skylake and there is a known bug in the Skylake
>> metric DRAM_Parallel_Reads as described here:
>> https://lore.kernel.org/lkml/CAP-5=fXejVaQa9qfW66cY77qB962+jbe8tT5bsLoOOcFmODnWQ@mail.gmail.com/
>> Fixing the bug needs more knowledge than what is available in manuals.
>> Hopefully Intel can take a look.
> 
> Oh I missed the original mail for some reason.  Yes it should be cmask instead of thresh
> for client.  I think thresh is used on the server uncore only, not on the client.
> 
> Jin Yao, can you send a patch please?
> 
> -Andi
> 

Yes, the DRAM_Parallel_Reads works on server but it's failed on client.

I will post a patch to fix that.

Thanks
Jin Yao

