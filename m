Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4322666B6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 19:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgIKRbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 13:31:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:23278 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgIKMzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:55:50 -0400
IronPort-SDR: kjrLjr50rIKr/KiFU5yN0dKvFHDxxYU7dL1SwRgEE+GffwDDSnUY6/TRJnFaaGg7J7LUyICvux
 W4YtHSdufZQQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="138263396"
X-IronPort-AV: E=Sophos;i="5.76,415,1592895600"; 
   d="scan'208";a="138263396"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 05:55:49 -0700
IronPort-SDR: Dqeh+Uve2W/lkceNpuBbi5M4LkBUiEYaR7alYHHNt1/7XRrwTZlahVgTxTzzL2GlJiosKwvzx3
 CC7GL1IuYBKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,415,1592895600"; 
   d="scan'208";a="329771680"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.190]) ([10.237.72.190])
  by fmsmga004.fm.intel.com with ESMTP; 11 Sep 2020 05:55:47 -0700
Subject: Re: [PATCH] ftrace: Fix missing synchronize_rcu() removing trampoline
 from kallsyms
To:     peterz@infradead.org
Cc:     rostedt@goodmis.org, mingo@redhat.com, mhiramat@kernel.org,
        mbenes@suse.cz, linux-kernel@vger.kernel.org,
        Paul McKenney <paulmck@kernel.org>
References: <20200901091617.31837-1-adrian.hunter@intel.com>
 <20200911114132.GH1362448@hirez.programming.kicks-ass.net>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <ba8eaca9-c207-f1b1-9cf7-e2765533645c@intel.com>
Date:   Fri, 11 Sep 2020 15:55:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200911114132.GH1362448@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/20 2:41 pm, peterz@infradead.org wrote:
> On Tue, Sep 01, 2020 at 12:16:17PM +0300, Adrian Hunter wrote:
>> Add synchronize_rcu() after list_del_rcu() in
>> ftrace_remove_trampoline_from_kallsyms() to protect readers of
>> ftrace_ops_trampoline_list (in ftrace_get_trampoline_kallsym)
>> which is used when kallsyms is read.
>>
>> Fixes: fc0ea795f53c8d ("ftrace: Add symbols for ftrace trampolines")
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  kernel/trace/ftrace.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
>> index 275441254bb5..4e64367c9774 100644
>> --- a/kernel/trace/ftrace.c
>> +++ b/kernel/trace/ftrace.c
>> @@ -2782,6 +2782,7 @@ static void ftrace_remove_trampoline_from_kallsyms(struct ftrace_ops *ops)
>>  {
>>  	lockdep_assert_held(&ftrace_lock);
>>  	list_del_rcu(&ops->list);
>> +	synchronize_rcu();
>>  }
> 
> 
> Hurmph, we've just done a ton of that:
> 
> 
> 	ftrace_shutdown()
> 	  synchronize_rcu_tasks_rude()
> 	  ftrace_trampoline_free()
> 	    ftrace_remove_trampoline_from_kallsyms()
> 
> 
> So would it not be better to move that call before the existing
> synchronize_rcu_tasks stuff rather than adding another synchronize_rcu()
> call?

Doesn't that mean removing the symbol while the trampoline is potentially
still in use?

Could follow up the fix with a patch to allocate list nodes instead, and use
call_rcu() to free it, so another synchronize_rcu() is not needed.

