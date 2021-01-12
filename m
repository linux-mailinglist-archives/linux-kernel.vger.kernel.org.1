Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD992F31BD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 14:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbhALN3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 08:29:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:40892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728100AbhALN3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 08:29:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06EF922E03;
        Tue, 12 Jan 2021 13:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610458106;
        bh=BgmXOmhB4SO2UGr1hcUsI1jWHWhAohBufvGcpIqsYlc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tA5sL9LxMoOr4UX5ETiwJ11S1yUVLKDtVP6PygWPVz18jfURemuvCenp7Df0JdFUN
         9nhIV6NzqpAF7tM8nV/Zw3x3UNmtgOLBDGH1IgS96JbPClwcqoQBu24qwrqr3V02QO
         +i4udaOb+TRTB/PBfPmiyb3/K0H7euC/VZoPdrUmj2PsMkxjHWkl1kIgtgLOa4WHVI
         ETSwZK5IYQ9ASMvRq0NONKfekizdz8Gawi1kscOKAitAIPCaS6M8x2MwHAvTTRzpP4
         bCplgnZotPS6PL/YSSf51/3fyugTAT1BMMgc4uu5lCRzRsnAn7y3Azyu9xo2KfPbdz
         lQq2ov2bDI9aQ==
Date:   Tue, 12 Jan 2021 13:28:22 +0000
From:   Will Deacon <will@kernel.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/rtmutex: add missed kernel-doc markup
Message-ID: <20210112132821.GA9087@willie-the-truck>
References: <1605257895-5536-1-git-send-email-alex.shi@linux.alibaba.com>
 <1605257895-5536-2-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605257895-5536-2-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 04:58:11PM +0800, Alex Shi wrote:
> To fix the following issues:
> kernel/locking/rtmutex.c:1612: warning: Function parameter or member
> 'lock' not described in '__rt_mutex_futex_unlock'
> kernel/locking/rtmutex.c:1612: warning: Function parameter or member
> 'wake_q' not described in '__rt_mutex_futex_unlock'
> kernel/locking/rtmutex.c:1675: warning: Function parameter or member
> 'name' not described in '__rt_mutex_init'
> kernel/locking/rtmutex.c:1675: warning: Function parameter or member
> 'key' not described in '__rt_mutex_init'
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Peter Zijlstra <peterz@infradead.org> 
> Cc: Ingo Molnar <mingo@redhat.com> 
> Cc: Will Deacon <will@kernel.org> 
> Cc: linux-kernel@vger.kernel.org 
> ---
>  kernel/locking/rtmutex.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index cfdd5b93264d..50fa521fe767 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -1604,8 +1604,11 @@ void __sched rt_mutex_unlock(struct rt_mutex *lock)
>  EXPORT_SYMBOL_GPL(rt_mutex_unlock);
>  
>  /**
> - * Futex variant, that since futex variants do not use the fast-path, can be
> - * simple and will not need to retry.
> + * __rt_mutex_futex_unlock - Futex variant, that since futex variants
> + * do not use the fast-path, can be simple and will not need to retry.
> + *
> + * @lock: the rt_mutex to be unlocked
> + * @wake_q: wake queue head from which get the next lock waiter

missing word: from which *to* get

With that fixed,

Acked-by: Will Deacon <will@kernel.org>

Will
