Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F76E2FFF59
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 10:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbhAVJkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 04:40:18 -0500
Received: from relay.sw.ru ([185.231.240.75]:60730 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727393AbhAVJSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 04:18:43 -0500
Received: from [192.168.15.248]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1l2sZN-000ASk-6f; Fri, 22 Jan 2021 12:17:29 +0300
Subject: Re: [PATCH] prctl: allow to setup brk for et_dyn executables
To:     Cyrill Gorcunov <gorcunov@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Keno Fischer <keno@juliacomputing.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrey Vagin <avagin@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>
References: <20210121221207.GB2174@grain>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <98915534-2309-cbbd-b77e-354dd274ed00@virtuozzo.com>
Date:   Fri, 22 Jan 2021 12:17:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210121221207.GB2174@grain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC: Pavel and Alexander

On 22.01.2021 01:12, Cyrill Gorcunov wrote:
> Keno Fischer reported that when a binray loaded via
> ld-linux-x the prctl(PR_SET_MM_MAP) doesn't allow to
> setup brk value because it lays before mm:end_data.
> 
> For example a test program shows
> 
>  | # ~/t
>  |
>  | start_code      401000
>  | end_code        401a15
>  | start_stack     7ffce4577dd0
>  | start_data	   403e10
>  | end_data        40408c
>  | start_brk	   b5b000
>  | sbrk(0)         b5b000
> 
> and when executed via ld-linux
> 
>  | # /lib64/ld-linux-x86-64.so.2 ~/t
>  |
>  | start_code      7fc25b0a4000
>  | end_code        7fc25b0c4524
>  | start_stack     7fffcc6b2400
>  | start_data	   7fc25b0ce4c0
>  | end_data        7fc25b0cff98
>  | start_brk	   55555710c000
>  | sbrk(0)         55555710c000
> 
> This of course prevent criu from restoring such programs.
> Looking into how kernel operates with brk/start_brk inside
> brk() syscall I don't see any problem if we allow to setup
> brk/start_brk without checking for end_data. Even if someone
> pass some weird address here on a purpose then the worst
> possible result will be an unexpected unmapping of existing
> vma (own vma, since prctl works with the callers memory) but
> test for RLIMIT_DATA is still valid and a user won't be able
> to gain more memory in case of expanding VMAs via new values
> shipped with prctl call.
> 
> Reported-by: Keno Fischer <keno@juliacomputing.com>
> Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: Dmitry Safonov <0x7f454c46@gmail.com>
> CC: Andrey Vagin <avagin@gmail.com>
> CC: Kirill Tkhai <ktkhai@virtuozzo.com>
> CC: Eric W. Biederman <ebiederm@xmission.com>
> ---
> Guys, take a look please once time permit. Hopefully I didn't
> miss something 'cause made this patch via code reading only.
> 
> Andrey, do we still have a criu container which tests new kernels,
> right? Would be great to run criu tests with this patch applied
> to make sure everything is intact.
> 
>  kernel/sys.c |    7 -------
>  1 file changed, 7 deletions(-)
> 
> Index: linux-tip.git/kernel/sys.c
> ===================================================================
> --- linux-tip.git.orig/kernel/sys.c
> +++ linux-tip.git/kernel/sys.c
> @@ -1943,13 +1943,6 @@ static int validate_prctl_map_addr(struc
>  	error = -EINVAL;
>  
>  	/*
> -	 * @brk should be after @end_data in traditional maps.
> -	 */
> -	if (prctl_map->start_brk <= prctl_map->end_data ||
> -	    prctl_map->brk <= prctl_map->end_data)
> -		goto out;
> -
> -	/*
>  	 * Neither we should allow to override limits if they set.
>  	 */
>  	if (check_data_rlimit(rlimit(RLIMIT_DATA), prctl_map->brk,
> 

