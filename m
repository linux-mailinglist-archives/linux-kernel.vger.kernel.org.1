Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E22F29720B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 17:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465629AbgJWPNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 11:13:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:54962 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S465622AbgJWPNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 11:13:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9C90AB945;
        Fri, 23 Oct 2020 15:13:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 250871E1348; Fri, 23 Oct 2020 17:13:29 +0200 (CEST)
Date:   Fri, 23 Oct 2020 17:13:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     kernel test robot <lkp@intel.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [fsnotify] 9b93f33105:
 WARNING:missing_R10_value_at__fsnotify_parent/0x
Message-ID: <20201023151329.GA9119@quack2.suse.cz>
References: <20201023003842.GC31092@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023003842.GC31092@shao2-debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri 23-10-20 08:38:42, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 9b93f33105f5f9bd3d016ff870eb6000c9d89eff ("fsnotify: send event with parent/name info to sb/mount/non-dir marks")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> 
> in testcase: will-it-scale
> version: will-it-scale-x86_64-b695a1b-1_20201007
> with following parameters:
> 
> 	nr_task: 192
> 	mode: process
> 	test: read2
> 	cpufreq_governor: performance
> 	ucode: 0x11
> 
...
> [  117.801209] perf version 5.9.rc8.gc85fb28b6f99
> [  117.801219] 
> [  182.458747] perf: interrupt took too long (2668 > 2500),perf: interrupt took too long (4516 > 4352), lowering kernel.perf_event_max_sample_rate to 44000
>  lowering kernel.perf_event_max_sample_rperf: interrupt took too long (5950 > 5645), lowering kernel.perf_event_max_sample_rate to 33000
> ate to 74000
> perf: interrupt took too long (7658 > 7437), lowering kernel.perf_event_max_sample_rate to 26000
> [  182.502968] perf: interrupt took too long (7658 > 7437), lowering kernel.perf_event_max_sample_rate to 26000
> [  182.525840] perf: interrupt took too long (9889 > 9572), lowering kernel.perf_event_max_sample_rate to 20000
> f_event_max_sample_rate to 12000
> [  182.560905] perf: interrupt took too long (21827 > 20585), lowering kernel.perf_event_max_sample_rate to 9000
> [  182.609949] perf: interrupt took too long (30149 > 27283), lowering kernel.perf_event_max_sample_rate to 6000
> [  182.622872] perf: interrupt took too long (38986 > 37686), lowering kernel.perf_event_max_sample_rate to 5000
> [  182.672850] perf: interrupt took too long (50874 > 48732), lowering kernel.perf_event_max_sample_rate to 3000
> [  182.732849] perf: interrupt took too long (63885 > 63592), lowering kernel.perf_event_max_sample_rate to 3000
> [  182.751847] perf: interrupt took too long (80901 > 79856), lowering kernel.perf_event_max_sample_rate to 2000
> [  188.527603] WARNING: missing R10 value at __fsnotify_parent+0x25/0x280

OK, that's an unwinder warning but we don't do anything special in
__fsnotify_parent(). Let's CC x86 guys if they have idea what's going on.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
