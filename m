Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961B92764D3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 02:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgIXAAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 20:00:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41578 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgIXAAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 20:00:15 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600905613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vIokpfgOjjX2X94R8YgU9FBZEr1sCciKtz6BI9Dgjr4=;
        b=NuBed+CbyPTz6q6GkbY+oo0HurFi64GYR3KAtvuNulbCDm4ymNlJORDPxiRRrerqpDF2pn
        pr4xdGvfruwgiA6SCWTxCwe3DQ5de/zEeMwOW8WI6EHZDsFEcYl8r66MQkKb+o2fve68iZ
        YaDlEiQgevwI8X7b++T7MyAx+/XPiD0tGHNbiZo4jmyS3EYwH4aANo5/yuJkdARQfhDXo8
        Gn9pKndifKWa0kKEMAdb+sZv1KO+TR3OmGFmGSTnSL+UalV17O4AUIMMpl7jjufVyxAXJV
        yhemvIvo0IhOFcmClevGSmY01yDkSgzDOJaHGXbmgD2SLSqZAMcITRVNmjMDjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600905613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vIokpfgOjjX2X94R8YgU9FBZEr1sCciKtz6BI9Dgjr4=;
        b=41KO66NtD7BI13oS/ON6Z+pyQiFW41ScEgrFPva5Reb+E3Ny4P1Ze/VDV6N95eIR98qQB4
        UjPQepo1Ue/1SEBA==
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
Date:   Thu, 24 Sep 2020 02:06:12 +0206
Message-ID: <878sd0m4c3.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-23, Petr Mladek <pmladek@suse.com> wrote:
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

Until now struct printk_info has contained generic types. If we add
struct ktime_timestamps, we may start storing more than we need. For
example, if more (possibly internal) fields are added to struct
ktime_timestamps that printk doesn't care about. We may prefer to
generically and explicitly store the information we care about:

    u64 ts_mono;
    u64 ts_boot;
    u64 ts_real;

Or create our own struct printk_ts to copy the fields of interest to.

John Ogness
