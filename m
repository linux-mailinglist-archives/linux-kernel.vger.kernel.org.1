Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19DE2A9EAF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 21:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgKFUq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 15:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgKFUqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 15:46:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ED6C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 12:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=MUfJwre5E6JfpSssfgPC5njfPaSBNYvDAExnUw65edk=; b=jlRzl2tqeKGVbPzs9KiVS7n+DU
        kUldjBGXOUUw4JFPwbxpJWzLzxyOtenrJsrMVpCXcql/RlicXfF4/Bm44Lu8BKi7Iwrzqmy7GJpcb
        blg8vfi50BAL26mJAV7D74lqycEXP0UqSNWBazefc3WIwF4TyfkAIJqZfO71RcjnkVOpONPpFVjrv
        gejTvpk5lcf6HiVRXcBwzSWNmIAhYCRueDokoVms5hHOhMSv4TRy6iBO7qG2n2Xy03kZGF2G5j2gy
        XskOqKrOoUqhVDca2k+tvG+7XGzmqgHpNxBHjQW6fEBkKS9YsSKcczQN+wQHpR5qbXelqowHvwSFW
        zNwKgwmg==;
Received: from [2601:1c0:6280:3f0::a1cb]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kb8dF-0001AO-Ob; Fri, 06 Nov 2020 20:46:50 +0000
Subject: Re: [PATCH] mm: introduce oom_kill_disable sysctl knob
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Michal Hocko <mhocko@suse.com>
References: <20201106203238.1375577-1-minchan@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <57a31f2e-bb08-7303-e5fc-fe00e832cee6@infradead.org>
Date:   Fri, 6 Nov 2020 12:46:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201106203238.1375577-1-minchan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Fix a few typos:

On 11/6/20 12:32 PM, Minchan Kim wrote:
> ---
>  Documentation/admin-guide/sysctl/vm.rst | 14 ++++++++++++++
>  include/linux/mm.h                      |  2 ++
>  include/linux/oom.h                     |  1 +
>  kernel/sysctl.c                         |  9 +++++++++
>  mm/oom_kill.c                           | 24 ++++++++++++++++++++++++
>  5 files changed, 50 insertions(+)
> 
> diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> index f455fa00c00f..49dcedfaf0c0 100644
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -694,6 +694,20 @@ is used in oom_kill_allocating_task.
>  
>  The default value is 0.
>  
> +oom_kill_disable
> +================
> +
> +This disables or enables OOM killing in out-of-memory situations.
> +
> +If this is set to one, the OOM killer is disabled so OOM kill never
> +hapens in out-of-memory situation. It could cause system dangerous

   happens                            It could cause a dangerous system

> +state due to memory allocation failure so user should be careful to

                                                            careful when
> +use it.

   using it.

> +
> +If this is set to zero, the OOM killer is enabled so OOM kill happens
> +in out-of-memory situations.
> +
> +The default value is 0.
>  
>  overcommit_kbytes
>  =================

> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 8b84661a6410..0f48cdeeb1e7 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c

>  #ifdef CONFIG_NUMA
>  /**
>   * oom_cpuset_eligible() - check task eligiblity for kill

                                         eligibility

but that's not in your patch, so don't bother with it. :)


-- 
~Randy

