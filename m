Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DDF28BEA4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 19:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403994AbgJLRGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 13:06:20 -0400
Received: from mga01.intel.com ([192.55.52.88]:31819 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403884AbgJLRGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 13:06:19 -0400
IronPort-SDR: CUyWRHs2Kqbt2HD8VbUR4v6sPtXjJaojOHOpLGI9UmFMk058oSuzBJv4hsARksgpghjGqghma9
 DtPcbxkrbqSQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="183236879"
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="scan'208";a="183236879"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 10:06:16 -0700
IronPort-SDR: 9bCfN0O/vVV/V9sUwAW/u/uCF+QHkZ0idHh68ea2z+U2n09PmlOJBWQkjiMe+dEl5RxHPLGIFi
 T/Pxsa+avAug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="scan'208";a="350816045"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 12 Oct 2020 10:06:16 -0700
Received: from [10.249.225.186] (abudanko-mobl.ccr.corp.intel.com [10.249.225.186])
        by linux.intel.com (Postfix) with ESMTP id C3C3D5807A3;
        Mon, 12 Oct 2020 10:06:09 -0700 (PDT)
Subject: Re: [PATCH v1 02/15] perf report: output trace file name in raw trace
 dump
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
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <42d5395a-71f5-63e1-f7c9-fd76e2b8bee4@linux.intel.com>
Date:   Mon, 12 Oct 2020 20:06:07 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201012160144.GA466880@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12.10.2020 19:01, Andi Kleen wrote:
> On Mon, Oct 12, 2020 at 11:54:24AM +0300, Alexey Budankov wrote:
>> @@ -180,7 +183,8 @@ static int ordered_events__deliver_event(struct ordered_events *oe,
>>  						    ordered_events);
>>  
>>  	return perf_session__deliver_event(session, event->event,
>> -					   session->tool, event->file_offset);
>> +					   session->tool, event->file_offset,
>> +					   event->file_path);
> 
> Wouldn't it be better to pass "event" around now, which would contain at least
> four of the arguments.
> 
> These functions are getting entirely too many arguments.

Well, either approach is possible, and even shrink of two arguments kept at session object.
However changing function signature more than posted can cause bigger adjustments all over
the code. So this needs more evaluation prior implementation. 

Alexei
