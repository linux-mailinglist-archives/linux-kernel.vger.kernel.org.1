Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A2F283F63
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 21:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgJETOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 15:14:06 -0400
Received: from mga18.intel.com ([134.134.136.126]:51941 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgJETOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 15:14:06 -0400
IronPort-SDR: 0Popd5/pSk4OR+5X7bcXDlpfJmGx/DH+CZI3SDgVLqjuvRHz+sckQF+SpzRdiFQ0uxN50yB/PQ
 0auWBNGxaBqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="151646159"
X-IronPort-AV: E=Sophos;i="5.77,340,1596524400"; 
   d="scan'208";a="151646159"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP; 05 Oct 2020 12:07:58 -0700
IronPort-SDR: kdsXKpSKidRHOVCfk6kIHXFh+U6tZUg/+QO16UtMuVUULNg+Z9brYP4bU/VH7A2SaUhL7fdfdJ
 oVhj50NWXIcg==
X-IronPort-AV: E=Sophos;i="5.77,340,1596524400"; 
   d="scan'208";a="459867950"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 10:47:28 -0700
Date:   Mon, 5 Oct 2020 10:47:14 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Youquan Song <youquan.song@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] x86/mce: Recover from poison found while copying
 from user space
Message-ID: <20201005174714.GA30330@agluck-desk2.amr.corp.intel.com>
References: <20200921113144.GD5901@zn.tnic>
 <20200930232611.15355-1-tony.luck@intel.com>
 <20200930232611.15355-7-tony.luck@intel.com>
 <20201005163247.GE21151@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005163247.GE21151@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 06:32:47PM +0200, Borislav Petkov wrote:
> On Wed, Sep 30, 2020 at 04:26:10PM -0700, Tony Luck wrote:
> >  arch/x86/kernel/cpu/mce/core.c | 33 +++++++++++++++++++++------------
> >  include/linux/sched.h          |  2 ++
> >  2 files changed, 23 insertions(+), 12 deletions(-)
> 
> Isn't that just simpler?

Yes. A helper function avoids making the code a mess of if/else with subtle
fall through cases.

> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 4d2cf08820af..dc6c83aa2ec1 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1261,6 +1261,21 @@ static void kill_me_maybe(struct callback_head *cb)
>  	kill_me_now(cb);
>  }
>  
> +static inline void queue_task_work(struct mce *m, int kill_it)

Does it need to be "inline" though? I hope machine check processing
is never in the critical code path for anyone!

> +{
> +	current->mce_addr = m->addr;
> +	current->mce_kflags = m->kflags;
> +	current->mce_ripv = !!(m->mcgstatus & MCG_STATUS_RIPV);
> +	current->mce_whole_page = whole_page(m);
> +
> +	if (kill_it)
> +		current->mce_kill_me.func = kill_me_now;
> +	else
> +		current->mce_kill_me.func = kill_me_maybe;
> +
> +	task_work_add(current, &current->mce_kill_me, true);
> +}
> +
>  /*
>   * The actual machine check handler. This only handles real
>   * exceptions when something got corrupted coming in through int 18.
> @@ -1402,13 +1417,8 @@ noinstr void do_machine_check(struct pt_regs *regs)
>  		/* If this triggers there is no way to recover. Die hard. */
>  		BUG_ON(!on_thread_stack() || !user_mode(regs));
>  
> -		current->mce_addr = m.addr;
> -		current->mce_ripv = !!(m.mcgstatus & MCG_STATUS_RIPV);
> -		current->mce_whole_page = whole_page(&m);
> -		current->mce_kill_me.func = kill_me_maybe;
> -		if (kill_it)
> -			current->mce_kill_me.func = kill_me_now;
> -		task_work_add(current, &current->mce_kill_me, true);
> +		queue_task_work(&m, kill_it);
> +
>  	} else {
>  		/*
>  		 * Handle an MCE which has happened in kernel space but from
> @@ -1423,6 +1433,9 @@ noinstr void do_machine_check(struct pt_regs *regs)
>  			if (!fixup_exception(regs, X86_TRAP_MC, 0, 0))
>  				mce_panic("Failed kernel mode recovery", &m, msg);
>  		}
> +
> +		if (m.kflags & MCE_IN_KERNEL_COPYIN)
> +			queue_task_work(&m, kill_it);
>  	}
>  out:
>  	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);

-Tony
