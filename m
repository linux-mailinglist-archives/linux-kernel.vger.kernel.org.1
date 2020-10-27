Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5972C29B078
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 15:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757456AbgJ0OTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 10:19:40 -0400
Received: from mga07.intel.com ([134.134.136.100]:23038 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757215AbgJ0OQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 10:16:50 -0400
IronPort-SDR: JBo4E2vxG8nJDKl9/tmzQ5+hpMWlWHmbsbLS7hSTogwmLPd163o9dSjKKLsfswQS4VnZc6nzHP
 PxEEZOf6/RAw==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="232272101"
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="232272101"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 07:16:49 -0700
IronPort-SDR: T0y2qF8NNkQs2vYMglbUHnHxKh7TKeyRDOQQFhI3Ob1K5RpkTngQONUWKLULRKH1etLmos963O
 ccpynm68JGug==
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="535812090"
Received: from abudanko-mobl.ccr.corp.intel.com (HELO [10.249.227.194]) ([10.249.227.194])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 07:16:46 -0700
Subject: Re: [PATCH v2 12/15] perf record: introduce thread local variable for
 trace streaming
To:     Jiri Olsa <jolsa@redhat.com>,
        Alexei Budankov <budankov.lore@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
 <b1a2fc8c-1106-63d6-40f1-376165490a59@linux.intel.com>
 <20201024154357.GD2589351@krava>
 <6eb97205-4d13-6487-8e15-a85f63d3f0cc@gmail.com>
 <20201026103426.GC2726983@krava>
 <78ca09c2-50da-3206-2dff-19523699d82b@gmail.com>
 <20201027120130.GD2900849@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <ebfb865f-ded3-41c7-b679-7fc50a258a8c@linux.intel.com>
Date:   Tue, 27 Oct 2020 17:16:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201027120130.GD2900849@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27.10.2020 15:01, Jiri Olsa wrote:
> On Mon, Oct 26, 2020 at 05:11:30PM +0300, Alexei Budankov wrote:
<SNIP>
>> Why do you complain about per thread variable in this case?
>> It looks like ideally fits these specific needs.
> 
> I think there's misunderstanding.. I think we should move
> samples to per thread 'thread' object and have just one
> copy of that.. and do not increase separate variables for
> thread and non-thread cases

Aw, I see. Using the same __thread object by main thread in
serial and threaded modes. That makes sense.
I will correct in v3.

Alexei
