Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624F02EA7BD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbhAEJil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:38:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:42126 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727260AbhAEJik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:38:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609839473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Oj2LtwzNk4kVeZ7p1DI+PAGVBBVlsl2cCgQyscMgUtI=;
        b=lcHFSZG/tHxYjJB4y3+ouF+b/MLQNIA9GI+Jn4p9bHowfeA7NNPcpXz/THrvfeT+CRPJoY
        Y2YlCDgPDkj5EAnxnRH96eN8TUtyb1BSeXQAexmljutJjxf2VhP4lSA8efnhMulA+8rW7T
        moMw8wJm1s/W1uPfLgymk6esFqN5+yE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8CF39AD0B;
        Tue,  5 Jan 2021 09:37:53 +0000 (UTC)
Date:   Tue, 5 Jan 2021 10:37:52 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurence Oberman <loberman@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: 3cc3ef45b2: RIP:version_proc_show
Message-ID: <X/QzcCw5/3xD4lgC@alley>
References: <20201210160038.31441-8-pmladek@suse.com>
 <20210103150323.GE30643@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210103150323.GE30643@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2021-01-03 23:03:23, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 3cc3ef45b202a39814f9ce979495d4cc130c2998 ("[PATCH v2 7/7] Test softlockup")
> url: https://github.com/0day-ci/linux/commits/Petr-Mladek/watchdog-softlockup-Report-overall-time-and-some-cleanup/20201211-004447
> base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git a2f5ea9e314ba6778f885c805c921e9362ec0420
> 
> in testcase: will-it-scale
> version: will-it-scale-x86_64-b695a1b-1_20201217
> with following parameters:
> 
> 	nr_task: 16
> 	mode: thread
> 	test: dup1
> 	cpufreq_governor: performance
> 	ucode: 0x2006a08
> 
> test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
> test-url: https://github.com/antonblanchard/will-it-scale
> 
> 
> on test machine: 104 threads Skylake with 192G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +----------------+------------+------------+
> |                | 36cc821a5c | 3cc3ef45b2 |
> +----------------+------------+------------+
> | boot_successes | 7          | 0          |
> +----------------+------------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> [   71.563905] watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [perf:2556]
> [   71.567713] watchdog: BUG: soft lockup - CPU#89 stuck for 26s! [perf:2463]
> [   71.812209] CPU: 1 PID: 2556 Comm: perf Not tainted 5.10.0-rc7-g3cc3ef45b202 #1
> [   71.814904]  acpi_power_meter ip_tables
> [   71.817550] Hardware name: Intel Corporation S2600BT/S2600BT, BIOS SE5C620.86B.1D.01.0147.121320181755 12/13/2018
> [   71.817559] RIP: 0010:version_proc_show+0x2f/0x6a

JFYI, it works as expected.

This patch is not intended for upstream. It allows to test the
rest of the patchset easily. And it causes exactly the above mentioned
softlockup.

Best Regards,
Petr
