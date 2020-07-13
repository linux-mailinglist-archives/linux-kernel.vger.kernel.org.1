Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56C9219792
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 06:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgGIE4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 00:56:02 -0400
Received: from mga17.intel.com ([192.55.52.151]:30715 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgGIE4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 00:56:01 -0400
IronPort-SDR: uotb+ZhqJL9rl/MQMbS/xLuIWnTtRh04zccGY1FPGG01aJoSNQ8VZbKx+6mR8R17pcjFdsIAvD
 vAuxvZ0hv9gQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="128007830"
X-IronPort-AV: E=Sophos;i="5.75,330,1589266800"; 
   d="scan'208";a="128007830"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 21:56:01 -0700
IronPort-SDR: IvPR29umbfUPvj6t7MskItNErhnlcuvlpD0Z46MoNFUW0F7nsB0ThPBjBGlkrk+cqbze4bMXTT
 ALuhRsnTCu0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,330,1589266800"; 
   d="scan'208";a="324103571"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by orsmga007.jf.intel.com with ESMTP; 08 Jul 2020 21:55:55 -0700
Date:   Thu, 9 Jul 2020 12:55:54 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Huang, Ying" <ying.huang@intel.com>,
        Andi Kleen <andi.kleen@intel.com>, Qian Cai <cai@lca.pw>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, tim.c.chen@intel.com,
        dave.hansen@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, lkp@lists.01.org
Subject: Re: [mm] 4e2c82a409: ltp.overcommit_memory01.fail
Message-ID: <20200709045554.GA56190@shbuild999.sh.intel.com>
References: <FAAE2B23-2565-4F36-B278-018A5AD219EE@lca.pw>
 <20200705125854.GA66252@shbuild999.sh.intel.com>
 <20200705155232.GA608@lca.pw>
 <20200706014313.GB66252@shbuild999.sh.intel.com>
 <20200706023614.GA1231@lca.pw>
 <20200706132443.GA34488@shbuild999.sh.intel.com>
 <20200706133434.GA3483883@tassilo.jf.intel.com>
 <20200707023829.GA85993@shbuild999.sh.intel.com>
 <87zh8c7z5i.fsf@yhuang-dev.intel.com>
 <20200707054120.GC21741@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707054120.GC21741@shbuild999.sh.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 01:41:20PM +0800, Feng Tang wrote:
> On Tue, Jul 07, 2020 at 12:00:09PM +0800, Huang, Ying wrote:
> > Feng Tang <feng.tang@intel.com> writes:
> > 
> > > On Mon, Jul 06, 2020 at 06:34:34AM -0700, Andi Kleen wrote:
> > >> >  	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> > >> > -	if (ret == 0 && write)
> > >> > +	if (ret == 0 && write) {
> > >> > +		if (sysctl_overcommit_memory == OVERCOMMIT_NEVER)
> > >> > +			schedule_on_each_cpu(sync_overcommit_as);
> > >> 
> > >> The schedule_on_each_cpu is not atomic, so the problem could still happen
> > >> in that window.
> > >> 
> > >> I think it may be ok if it eventually resolves, but certainly needs
> > >> a comment explaining it. Can you do some stress testing toggling the
> > >> policy all the time on different CPUs and running the test on
> > >> other CPUs and see if the test fails?
> > >
> > > For the raw test case reported by 0day, this patch passed in 200 times
> > > run. And I will read the ltp code and try stress testing it as you
> > > suggested.
> > >
> > >
> > >> The other alternative would be to define some intermediate state
> > >> for the sysctl variable and only switch to never once the schedule_on_each_cpu
> > >> returned. But that's more complexity.
> > >
> > > One thought I had is to put this schedule_on_each_cpu() before
> > > the proc_dointvec_minmax() to do the sync before sysctl_overcommit_memory
> > > is really changed. But the window still exists, as the batch is
> > > still the larger one. 
> > 
> > Can we change the batch firstly, then sync the global counter, finally
> > change the overcommit policy?
> 
> These reorderings are really head scratching :)
> 
> I've thought about this before when Qian Cai first reported the warning
> message, as kernel had a check: 
> 
> 	VM_WARN_ONCE(percpu_counter_read(&vm_committed_as) <
> 			-(s64)vm_committed_as_batch * num_online_cpus(),
> 			"memory commitment underflow");
> 
> If the batch is decreased first, the warning will be easier/earlier to be
> triggered, so I didn't brought this up when handling the warning message.
> 
> But it might work now, as the warning has been removed.

I tested the reorder way, and the test could pass in 100 times run. The
new order when changing policy to OVERCOMMIT_NEVER:
  1. re-compute the batch ( to the smaller one)
  2. do the on_each_cpu sync
  3. really change the policy to NEVER.

It solves one of previous concern, that after the sync is done on cpuX,
but before the whole sync on all cpus are done, there is a window that
the percpu-counter could be enlarged again.

IIRC Andi had concern about read side cost when doing the sync, my
understanding is most of the readers (malloc/free/map/unmap) are using
percpu_counter_read_positive, which is a fast path without involving lock.

As for the problem itself, I agree with Michal's point, that usually there
is no normal case that will change the overcommit_policy too frequently.

The code logic is mainly in overcommit_policy_handler(), based on the
previous sync fix. please help to review, thanks!

int overcommit_policy_handler(struct ctl_table *table, int write, void *buffer,
		size_t *lenp, loff_t *ppos)
{
	int ret;

	if (write) {
		int new_policy;
		struct ctl_table t;

		t = *table;
		t.data = &new_policy;
		ret = proc_dointvec_minmax(&t, write, buffer, lenp, ppos);
		if (ret)
			return ret;

		mm_compute_batch(new_policy);
		if (new_policy == OVERCOMMIT_NEVER)
			schedule_on_each_cpu(sync_overcommit_as);
		sysctl_overcommit_memory = new_policy;
	} else {
		ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
	}

	return ret;
}

- Feng


