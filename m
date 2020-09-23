Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8375927639F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 00:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgIWWM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 18:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgIWWM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 18:12:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB28C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 15:12:56 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600899173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IJT0KTi9Uwt0dzzVbSXUWhE5zd+QFVukkr2QTwC/R9g=;
        b=wshH6CkeRFuR3TJDsnznUFW6Dnsl7CDDWt5ygYgLlCI6ajI3dQ5Z1UylrJabpS9/cCU4gj
        adryii76E5XovxbbmwuzAE00oSk0n+jdzWuHadTWv4n2CrgThpUrFXsZKjRiuGQKmEbi2f
        JaXWJe/8N+fvel066Gyyh1fJA8VmROoq1QchZiqFXoStzBdcw2bVMoyLvuo+Zh7tUH4IIm
        5ZDf+VNkpQYV2N/sH5qrAXVb/pLUWO+k+50igQLEso1iu/TheslfsGXsgl58TJ4pAMzCea
        tJKHDhsJwdcj9mF0rA2bkhDv6VgMWF2cSspLoGON/PcoY6PnnJ/OjabiCd0rvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600899173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IJT0KTi9Uwt0dzzVbSXUWhE5zd+QFVukkr2QTwC/R9g=;
        b=DHzfmJeeDTrKoKXzkyR/GRLHmzOu3+ccPyZ4K80DRyC42S1RdG2ECjbd6Zwiqk/diLUOzf
        JajWp78J0gvTHYAw==
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Prarit Bhargava <prarit@redhat.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Changki Kim <changki.kim@samsung.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 1/2] printk: Store all three timestamps
In-Reply-To: <20200923135617.27149-2-pmladek@suse.com>
References: <20200923135617.27149-1-pmladek@suse.com> <20200923135617.27149-2-pmladek@suse.com>
Date:   Thu, 24 Sep 2020 00:18:53 +0206
Message-ID: <87pn6cdtwa.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-23, Petr Mladek <pmladek@suse.com> wrote:
> printk() historically shows the timestamps from the monotonic clock.

printk() uses the local clock, not the monotonic clock.

> It is fast, available early during boot, in any context, and even
> without using any lock.
>
> There are repeated requests [1][2][3] to show the timestamps from other
> clocks. The main motivation is to make it easier to correlate the kernel
> and userspace logs. Where userspace logs usually use the real time
> clock.
>
> Unfortunately, it is not possible to simply replace the default clock.
> Userspace tools, like journalctl, dmesg, expect to get the timestamps
> from the mono via /dev/kmsg interface or syslog syscall [4].
> Also administrators would be confused when logs from different
> systems use different clocks depending on kernel version or
> build option [5].
>
> As a result, the mono clock has to stay as the default clock
> and has to be used in the current user interfaces.

Actually this series is changing the default clock from local to
monotonic. I for one welcome this change (and wish ftrace would do it as
well), but it is a change.

> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 1560649cbd35..0ed8901916f4 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -520,10 +522,10 @@ static int log_store(u32 caller_id, int facility, int level,
>  	r.info->facility = facility;
>  	r.info->level = level & 7;
>  	r.info->flags = flags & 0x1f;
> -	if (ts_nsec > 0)
> -		r.info->ts_nsec = ts_nsec;
> +	if (ts)
> +		r.info->ts = *ts;
>  	else
> -		r.info->ts_nsec = local_clock();
> +		ktime_get_fast_timestamps(&r.info->ts);

I am wondering if we still want to keep the local_clock() as well (and
as the default). ftrace also uses it by default, which means traces and
printk logs could be coordinated by default until now.

The two clocks can vary quite a bit. I have a laptop where the local
clock drifts away from monotonic at about 50us per second.

> diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
> index 0adaa685d1ca..09082c8472d3 100644
> --- a/kernel/printk/printk_ringbuffer.h
> +++ b/kernel/printk/printk_ringbuffer.h
> @@ -14,7 +15,7 @@
>   */
>  struct printk_info {
>  	u64	seq;		/* sequence number */
> -	u64	ts_nsec;	/* timestamp in nanoseconds */
> +	struct ktime_timestamps ts; /* timestamps */
>  	u16	text_len;	/* length of text message */
>  	u8	facility;	/* syslog facility */
>  	u8	flags:5;	/* internal record flags */

If we wanted to keep the local clock, should the local clock be a part
of struct ktime_timestamps? Or should struct printk_info maintain that
separately (either as @ts_nsec or @ts_local or whatever).

John Ogness
