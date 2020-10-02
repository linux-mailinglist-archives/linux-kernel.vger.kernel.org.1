Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C86AD28121E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 14:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387822AbgJBMR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 08:17:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:60488 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbgJBMR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 08:17:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601641047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T5VRuOobckpxCZmXsUhACoyGA9F/sGGhXqVSt9nLXo4=;
        b=H9zPqjDT8p9Tztm+OaO/q1yuWw1BxmuhF58NHI6tvRxmQO1+FLGPrlrrpbZ77HFNbiDlQ9
        sOd6LhkTCV/C2kPMMuhEGcZpIJ9LjDBodeuVfwcPKk4a9Aj4cyxLvkjJnCC/sU3WqPu9Xg
        dta+HeDfxEvDH0XXSvrOHKmATCqmSwU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0E183B470;
        Fri,  2 Oct 2020 12:17:27 +0000 (UTC)
Date:   Fri, 2 Oct 2020 14:17:26 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Pintu Kumar <pintu@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, pintu.ping@gmail.com
Subject: Re: [PATCH] mm/util.c: Add error logs for commitment overflow
Message-ID: <20201002121726.GF4555@dhcp22.suse.cz>
References: <1601639861-32171-1-git-send-email-pintu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601639861-32171-1-git-send-email-pintu@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 02-10-20 17:27:41, Pintu Kumar wrote:
> The headless embedded devices often come with very limited amount
> of RAM such as: 256MB or even lesser.
> These types of system often rely on command line interface which can
> execute system commands in the background using the fork/exec combination.
> There could be even many child tasks invoked internally to handle multiple
> requests.
> In this scenario, if the parent task keeps committing large amount of
> memory, there are chances that this commitment can easily overflow the
> total RAM available in the system. Now if the parent process invokes fork
> or system commands (using system() call) and the commitment ratio is at
> 50%, the request fails with the following, even though there are large
> amount of free memory available in the system:
> fork failed: Cannot allocate memory
> 
> If there are too many 3rd party tasks calling fork, it becomes difficult to
> identify exactly which parent process is overcommitting memory.
> Since, free memory is also available, this "Cannot allocate memory" from
> fork creates confusion to application developer.
> 
> Thus, I found that this simple print message (even once) is helping in
> quickly identifying the culprit.
> 
> This is the output we can see on a 256MB system and with a simple malloc
> and fork program.
> 
> [root@ ~]# cat /proc/meminfo
> MemTotal:         249520 kB   ==> 243MB
> MemFree:          179100 kB
> 
> PPID	PID	USER	RSS	VSZ	STAT	ARGS
>  150	164	root	1440	250580	S	./consume-and-fork.out 243
> 
> __vm_enough_memory: commitment overflow: ppid:150, pid:164, pages:62451
> fork failed[count:0]: Cannot allocate memory

While I understand that fork failing due to overrcomit heuristic is non
intuitive and I have seen people scratching heads due to this in the
past I am not convinced this is a right approach to tackle the problem.
First off, referencing pids is not really going to help much if process
is short lived. Secondly, __vm_enough_memory is about any address space
allocation. Why would you be interested in parent when doing mmap?

Last but not least _once is questionable as well. The first instance
might happen early during the system lifetime and you will not learn
about future failures so the overall point of debuggability is seriously
inhibited.

Maybe what you want is to report higher up the call chain (fork?) and
have it ratelimited rather than _once? Or maybe just try to live with
the confusing situation?

> Signed-off-by: Pintu Kumar <pintu@codeaurora.org>
> ---
>  mm/util.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/util.c b/mm/util.c
> index 5ef378a..9431ce7a 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -895,6 +895,9 @@ int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin)
>  error:
>  	vm_unacct_memory(pages);
>  
> +	pr_err_once("%s: commitment overflow: ppid:%d, pid:%d, pages:%ld\n",
> +			__func__, current->parent->pid, current->pid, pages);
> +
>  	return -ENOMEM;
>  }
>  
> -- 
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
> is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

-- 
Michal Hocko
SUSE Labs
