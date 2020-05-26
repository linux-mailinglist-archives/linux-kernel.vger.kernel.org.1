Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933CB1B8FB6
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Apr 2020 14:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgDZMGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Apr 2020 08:06:54 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:63183 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726135AbgDZMGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 08:06:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TwgSATO_1587902800;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TwgSATO_1587902800)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 26 Apr 2020 20:06:41 +0800
Subject: Re: [PATCH 1/2] locking/rtmutex: Remove unused
 rt_mutex_cmpxchg_relaxed()
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
References: <1587135032-188866-1-git-send-email-alex.shi@linux.alibaba.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <42e577e3-1509-ebb6-dd93-662575af3dac@linux.alibaba.com>
Date:   Sun, 26 Apr 2020 20:05:21 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1587135032-188866-1-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This 2 small patches may missed for a few time.

Is it ok to be merged?

Thanks
Alex

�� 2020/4/17 ����10:50, Alex Shi д��:
> This macro isn't interested by anyone, so remove it.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> ---
>  kernel/locking/rtmutex.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index c9f090d64f00..cfdd5b93264d 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -141,7 +141,6 @@ static void fixup_rt_mutex_waiters(struct rt_mutex *lock)
>   * set up.
>   */
>  #ifndef CONFIG_DEBUG_RT_MUTEXES
> -# define rt_mutex_cmpxchg_relaxed(l,c,n) (cmpxchg_relaxed(&l->owner, c, n) == c)
>  # define rt_mutex_cmpxchg_acquire(l,c,n) (cmpxchg_acquire(&l->owner, c, n) == c)
>  # define rt_mutex_cmpxchg_release(l,c,n) (cmpxchg_release(&l->owner, c, n) == c)
>  
> @@ -202,7 +201,6 @@ static inline bool unlock_rt_mutex_safe(struct rt_mutex *lock,
>  }
>  
>  #else
> -# define rt_mutex_cmpxchg_relaxed(l,c,n)	(0)
>  # define rt_mutex_cmpxchg_acquire(l,c,n)	(0)
>  # define rt_mutex_cmpxchg_release(l,c,n)	(0)
>  
> 
