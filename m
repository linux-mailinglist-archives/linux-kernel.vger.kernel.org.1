Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB99227ABCA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 12:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgI1K0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 06:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbgI1K0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 06:26:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0A5C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 03:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Vc5TPB8gzwYQ4bV3QPrFgoBi6Jlg1QoC2FUYpd7zyDo=; b=tcB2Ty+lP6MFCVih7DRU4PWnRS
        Aj3y4brI3ONLGXo3KFO88/n8Xd23Dme6MEQTMnJF+wZVw1d4XFzWhSNiM4eERDWiEkKK2vbdXV/Gn
        AUkrBfUJLW+EIoiPhBVPObIzyxGdaovissYnz9d3+yufRgPfCwqCyPvOWSl4b/J7w3x3K9IkNxdw2
        UuRtIEJTNpHdYg1pIe73yAEFhIq7OLQ9YcGfOJrLT0z7cfSrkepMEznzHXUcLlF3w/gLYyXgUmpz2
        4tk/HelTC06z3gm8jpz+9WGXLTpCrhpMCCazb98TqwREF2iWG+LGbaU89/w8Y5oe7oLUIw5aapLIG
        x8+munNA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kMqM5-0005Mm-GJ; Mon, 28 Sep 2020 10:26:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9002A300DB4;
        Mon, 28 Sep 2020 12:25:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6B41E2006F633; Mon, 28 Sep 2020 12:25:59 +0200 (CEST)
Date:   Mon, 28 Sep 2020 12:25:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, songmuchun@bytedance.com,
        john.ogness@linutronix.de
Subject: Re: [External] Re: [PATCH 2/2] sched: mark
 PRINTK_DEFERRED_CONTEXT_MASK in __schedule()
Message-ID: <20200928102559.GF2611@hirez.programming.kicks-ass.net>
References: <20200927161130.33172-1-zhouchengming@bytedance.com>
 <20200927161130.33172-2-zhouchengming@bytedance.com>
 <20200928073202.GA2611@hirez.programming.kicks-ass.net>
 <40ab934e-5b8b-735b-da65-3043efab9fdc@bytedance.com>
 <20200928090143.GA2628@hirez.programming.kicks-ass.net>
 <688eadd7-4ca3-3e32-3520-25977ff059a6@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <688eadd7-4ca3-3e32-3520-25977ff059a6@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 06:04:23PM +0800, Chengming Zhou wrote:

> Well, you are lucky. So it's a problem in our printk implementation.

Not lucky; I just kicked it in the groin really hard:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git debug/experimental

> The deadlock path is:
> 
> printk
>   vprintk_emit
>     console_unlock
>       vt_console_print
>         hide_cursor
>           bit_cursor
>             soft_cursor
>               queue_work_on
>                 __queue_work
>                   try_to_wake_up
>                     _raw_spin_lock
>                       native_queued_spin_lock_slowpath
> 
> Looks like it's introduced by this commit:
> 
> eaa434defaca1781fb2932c685289b610aeb8b4b
> 
> "drm/fb-helper: Add fb_deferred_io support"

Oh gawd, yeah, all the !serial consoles are utter batshit.

Please look at John's last printk rewrite, IIRC it farms all that off to
a kernel thread instead of doing it from the printk() caller's context.

I'm not sure where he hides his latests patches, but I'm sure he'll be
more than happy to tell you.
