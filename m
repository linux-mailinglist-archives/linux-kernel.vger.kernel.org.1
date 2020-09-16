Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB3626C6DD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbgIPR7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 13:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbgIPR6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:58:33 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CCAC0073E0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 06:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a5agFf1siRXinJ5YV6W+BponZG61lFw1RLtgF8Vvpbo=; b=SUxsvz78dRQgTh0/EhunUL12vG
        mUAZ7g2lDG3yghk0HrGEt2bBRSn9Vj2+kgz0eB0s0wgNU2D1zykJiIIEzNlYkMmOQfEu1TVY5TKuh
        YCmYIU1OsKoS1oR2CgAb7efXQxlh8wHcu1n7tMbhKKUW2jsb2xSgmteITZyKDVCLRqpP7RkwImsvo
        4e66wSYpa9xrEn7gh4SWQ2H0vrwS2MDtw340Fbnv8/vvMHEcuW5d38gefWqM2kfiPcMgMT+omGVnr
        HsurVMWqi+TSZKQ14zOxNjMGrMGjtc+8rOcDwVNRnfWUYQxiKz89AoJn4t67e39/231/wMUb5KXFc
        iWpOAPrA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIXss-0000MU-Od; Wed, 16 Sep 2020 13:54:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0844B3011FE;
        Wed, 16 Sep 2020 15:54:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EFD852B9285F7; Wed, 16 Sep 2020 15:54:02 +0200 (CEST)
Date:   Wed, 16 Sep 2020 15:54:02 +0200
From:   peterz@infradead.org
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Wade Mealing <wmealing@redhat.com>
Subject: Re: [PATCHv2] perf: Fix race in perf_mmap_close function
Message-ID: <20200916135402.GZ1362448@hirez.programming.kicks-ass.net>
References: <20200910104153.1672460-1-jolsa@kernel.org>
 <CAM9d7cjqq8+wcZWJ77oONKXu-FsaT_YvRxzaGbRT8PjLOw-AkQ@mail.gmail.com>
 <20200910144744.GA1663813@krava>
 <CAM9d7ciEAA_3Quo1-q7hU=Te+hBgJ2wYAjbDazXd7yS70HrhPA@mail.gmail.com>
 <20200911074931.GA1714160@krava>
 <CAM9d7cicyzZvkrXTvSrGrOE626==myvF2hnuUNiUoLXiOKHB+A@mail.gmail.com>
 <20200914205936.GD1714160@krava>
 <alpine.LRH.2.20.2009151734230.12057@Diego>
 <20200916115311.GE2301783@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916115311.GE2301783@krava>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 01:53:11PM +0200, Jiri Olsa wrote:
> There's a possible race in perf_mmap_close when checking ring buffer's
> mmap_count refcount value. The problem is that the mmap_count check is
> not atomic because we call atomic_dec and atomic_read separately.
> 
>   perf_mmap_close:
>   ...
>    atomic_dec(&rb->mmap_count);
>    ...
>    if (atomic_read(&rb->mmap_count))
>       goto out_put;
> 
>    <ring buffer detach>
>    free_uid
> 
> out_put:
>   ring_buffer_put(rb); /* could be last */
> 
> The race can happen when we have two (or more) events sharing same ring
> buffer and they go through atomic_dec and then they both see 0 as refcount
> value later in atomic_read. Then both will go on and execute code which
> is meant to be run just once.
> 
> The code that detaches ring buffer is probably fine to be executed more
> than once, but the problem is in calling free_uid, which will later on
> demonstrate in related crashes and refcount warnings, like:
> 
>   refcount_t: addition on 0; use-after-free.
>   ...
>   RIP: 0010:refcount_warn_saturate+0x6d/0xf
>   ...
>   Call Trace:
>   prepare_creds+0x190/0x1e0
>   copy_creds+0x35/0x172
>   copy_process+0x471/0x1a80
>   _do_fork+0x83/0x3a0
>   __do_sys_wait4+0x83/0x90
>   __do_sys_clone+0x85/0xa0
>   do_syscall_64+0x5b/0x1e0
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Using atomic decrease and check instead of separated calls.
> This fixes CVE-2020-14351.

I'm tempted to remove that line; I can never seem to find anything
useful in a CVE.

Fixes: ?

> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Tested-by: Michael Petlan <mpetlan@redhat.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
