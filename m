Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F70D2EF34A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 14:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbhAHNm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 08:42:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:36552 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbhAHNm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 08:42:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610113300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vIiuK/wpdb0akmqoEm2pC/CdRsjvf61e0Abm1+FwZg0=;
        b=V1k3ZtkTeyNdUza0KvYJ6mwSqO20PfusCDmin8X8y3D6HmNEuKlnaZj59khmKMDi0v6OSD
        jSXg8gXcZIG08uSeS5RhUqo4pTXDKRmgos+HXO/821GoeC8cHgSjLWxEo/MrLOy1ZiUx09
        gkaXNkhczn73l5EOricoAQUoN+2ZuWE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D1FDAAD11;
        Fri,  8 Jan 2021 13:41:40 +0000 (UTC)
Date:   Fri, 8 Jan 2021 14:41:40 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Milan Broz <gmazyland@gmail.com>
Cc:     linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: Very slow unlockall()
Message-ID: <20210108134140.GA9883@dhcp22.suse.cz>
References: <70885d37-62b7-748b-29df-9e94f3291736@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70885d37-62b7-748b-29df-9e94f3291736@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 06-01-21 16:20:15, Milan Broz wrote:
> Hi,
> 
> we use mlockall(MCL_CURRENT | MCL_FUTURE) / munlockall() in cryptsetup code
> and someone tried to use it with hardened memory allocator library.
> 
> Execution time was increased to extreme (minutes) and as we found, the problem
> is in munlockall().
> 
> Here is a plain reproducer for the core without any external code - it takes
> unlocking on Fedora rawhide kernel more than 30 seconds!
> I can reproduce it on 5.10 kernels and Linus' git.
> 
> The reproducer below tries to mmap large amount memory with PROT_NONE (later never used).
> The real code of course does something more useful but the problem is the same.
> 
> #include <stdio.h>
> #include <stdlib.h>
> #include <fcntl.h>
> #include <sys/mman.h>
> 
> int main (int argc, char *argv[])
> {
>         void *p  = mmap(NULL, 1UL << 41, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> 
>         if (p == MAP_FAILED) return 1;
> 
>         if (mlockall(MCL_CURRENT | MCL_FUTURE)) return 1;
>         printf("locked\n");
> 
>         if (munlockall()) return 1;
>         printf("unlocked\n");
> 
>         return 0;
> }
> 
> In traceback I see that time is spent in munlock_vma_pages_range.
> 
> [ 2962.006813] Call Trace:
> [ 2962.006814]  ? munlock_vma_pages_range+0xe7/0x4b0
> [ 2962.006814]  ? vma_merge+0xf3/0x3c0
> [ 2962.006815]  ? mlock_fixup+0x111/0x190
> [ 2962.006815]  ? apply_mlockall_flags+0xa7/0x110
> [ 2962.006816]  ? __do_sys_munlockall+0x2e/0x60
> [ 2962.006816]  ? do_syscall_64+0x33/0x40
> ...
> 
> Or with perf, I see
> 
> # Overhead  Command  Shared Object      Symbol                               
> # ........  .......  .................  .....................................
> #
>     48.18%  lock     [kernel.kallsyms]  [k] lock_is_held_type
>     11.67%  lock     [kernel.kallsyms]  [k] ___might_sleep
>     10.65%  lock     [kernel.kallsyms]  [k] follow_page_mask
>      9.17%  lock     [kernel.kallsyms]  [k] debug_lockdep_rcu_enabled
>      6.73%  lock     [kernel.kallsyms]  [k] munlock_vma_pages_range
> ...
> 
> 
> Could please anyone check what's wrong here with the memory locking code?
> Running it on my notebook I can effectively DoS the system :)
> 
> Original report is https://gitlab.com/cryptsetup/cryptsetup/-/issues/617
> but this is apparently a kernel issue, just amplified by usage of munlockall().

Which kernel version do you see this with? Have older releases worked
better?
-- 
Michal Hocko
SUSE Labs
