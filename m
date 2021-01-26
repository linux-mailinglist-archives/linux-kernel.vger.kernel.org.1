Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7A5304346
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 17:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731383AbhAZQAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 11:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404403AbhAZP7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:59:16 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23CAC061A29
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 07:58:36 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id v19so11682233pgj.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 07:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fsw6hGeqNqkWE0sXzCbWAgSrspnYEYJvHKGPHR9Yhl8=;
        b=RvbzRsHSdJSqxzk+hPtIJio6oXA+S4K+1QUrMwSBgeVrs2TR24cw0c4AfjUnpgzdNn
         kNTFkjQa9YS1XvVY7Ja/xdOGjGRJ78eu0eVzl6lpp3GieDox15RfU/KhBlDXL4N3tkVF
         LwRFIxsvkpL9kACc5Xsgo3OTHUdC0f0laDuzFN46ZnU40CmWQb0ja3MfgxAcuq0YHUkV
         AULWEt+GCH7WvxVT4Q3YvL2WZkZ+BGmkFNKEQcK4UpCaY/i8GghjLBefrQSuvQINQa9F
         xpGpVpp83KmDSDHFJcV2eyv6YjzHhpoqin+YQtA/m6mgIFrSL8LqlKMikxaCDcnImcxW
         D5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fsw6hGeqNqkWE0sXzCbWAgSrspnYEYJvHKGPHR9Yhl8=;
        b=EQsdxwAXrhmeGaHUpXQNxhFb6VN0/qRILRmGCKGUn2XLsN8jB5McW+chpmONBKcaAs
         8Qj/D1maWofHgWusFbF1HkPc3ngEA64qtBsqLvMWmyE1MVBJZxMLInk1BpV5o4Sx39Lb
         i8FamRhAiwzjaK+cSlXAYJZXg19vpxGCIwhT/nolInn9v4xrICr7ZbdPwWM82sdr/cD4
         j7vqKaAgQ0HOCQ4gDoIHYsLfJA1Z1csFWzHb1TFkv+Je0W0D3kICl7kH1Z4U2fky4WZp
         Q1IJJ57cGBrF8EvJnLrVOyibqDOU3tCP/9wRCTHZK4pKmAUVmPM1uMabgwtQ3XED4cRF
         xRtA==
X-Gm-Message-State: AOAM533/I82uhNtaEU1k3HJPoe0lT192mcXg/0/0yQmqSp2uxgoGQOHK
        ELWN3AsWbC++KWT/iG1fqLVHwjgZsmOFJQ==
X-Google-Smtp-Source: ABdhPJxNlJayHSX8b+mSHAbM12rJgo+X+LgI8HadIw1Qq2NLbQdItCEU6oP/TXp6K3r+OWltEk98Sw==
X-Received: by 2002:a05:6a00:2353:b029:1ba:d824:f1dc with SMTP id j19-20020a056a002353b02901bad824f1dcmr5817556pfj.9.1611676716153;
        Tue, 26 Jan 2021 07:58:36 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id c5sm2658254pjo.4.2021.01.26.07.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 07:58:35 -0800 (PST)
Date:   Wed, 27 Jan 2021 00:58:33 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix BUG: Invalid wait context in hrtimer_interrupt()
Message-ID: <YBA8KTyANXe0v1kR@jagdpanzerIV.localdomain>
References: <20210123233741.3614408-1-qais.yousef@arm.com>
 <YA+em8XkTidYetGE@jagdpanzerIV.localdomain>
 <20210126145917.r64vzibgpiwyuake@e107158-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126145917.r64vzibgpiwyuake@e107158-lin>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/01/26 14:59), Qais Yousef wrote:
> On 01/26/21 13:46, Sergey Senozhatsky wrote:
> > On (21/01/23 23:37), Qais Yousef wrote:

[..]

> I reported it here: https://lore.kernel.org/lkml/20210114124512.mg3vexudfmoadef5@e107158-lin/
>
> 	# [67628.388606] hrtimer: interrupt took 304720 ns
> 	[67628.393546]
> 	[67628.393550] =============================
> 	[67628.393554] [ BUG: Invalid wait context ]
> 	[67628.393557] 5.11.0-rc3-00019-g86be331946f7 #37 Not tainted
> 	[67628.393560] -----------------------------
> 	[67628.393563] sugov:0/192 is trying to lock:
> 	[67628.393566] ffff000800b1d898 (&port_lock_key){-.-.}-{3:3}, at: pl011_console_write+0x138/0x218
> 	[67628.393581] other info that might help us debug this:
> 	[67628.393584] context-{2:2}
> 	[67628.393586] 4 locks held by sugov:0/192:
> 	[67628.393589]  #0: ffff0008059cb720 (&sg_policy->work_lock){+.+.}-{4:4}, at: sugov_work+0x58/0x88
> 	[67628.393603]  #1: ffff800015446f20 (prepare_lock){+.+.}-{4:4}, at: clk_prepare_lock+0x34/0xb0
> 	[67628.393618]  #2: ffff8000152aaa60 (console_lock){+.+.}-{0:0}, at: vprintk_emit+0x12c/0x310
> 	[67628.393632]  #3: ffff8000152aab88 (console_owner){-.-.}-{0:0}, at: console_unlock+0x190/0x6d8
> 	[67628.393646] stack backtrace:
> 	[67628.393649] CPU: 0 PID: 192 Comm: sugov:0 Not tainted 5.11.0-rc3-00019-g86be331946f7 #37
> 	[67628.393653] Hardware name: ARM Juno development board (r2) (DT)
> 	[67628.393656] Call trace:
> 	[67628.393659]  dump_backtrace+0x0/0x1b0
> 	[67628.393661]  show_stack+0x20/0x70
> 	[67628.393664]  dump_stack+0xf8/0x168
> 	[67628.393666]  __lock_acquire+0x964/0x1c88
> 	[67628.393669]  lock_acquire+0x26c/0x500
> 	[67628.393671]  _raw_spin_lock+0x64/0x88
> 	[67628.393674]  pl011_console_write+0x138/0x218
> 	[67628.393677]  console_unlock+0x2c4/0x6d8
> 	[67628.393680]  vprintk_emit+0x134/0x310
> 	[67628.393682]  vprintk_default+0x40/0x50
> 	[67628.393685]  vprintk_func+0xfc/0x2b0
> 	[67628.393687]  printk+0x68/0x90
> 	[67628.393690]  hrtimer_interrupt+0x24c/0x250
> 	[67628.393693]  arch_timer_handler_phys+0x3c/0x50
> 	[67628.393695]  handle_percpu_devid_irq+0xd8/0x460
> 	[67628.393698]  generic_handle_irq+0x38/0x50
> 	[67628.393701]  __handle_domain_irq+0x6c/0xc8
> 	[67628.393704]  gic_handle_irq+0xb0/0xf0
> 	[67628.393706]  el1_irq+0xb4/0x180
> 	[67628.393709]  _raw_spin_unlock_irqrestore+0x58/0xa8
> 	[67628.393712]  hrtimer_start_range_ns+0x1b0/0x420
> 	[67628.393715]  msg_submit+0x100/0x108
> 	[67628.393717]  mbox_send_message+0x84/0x128
> 	[67628.393720]  scpi_send_message+0x11c/0x2a8
> 	[67628.393723]  scpi_dvfs_set_idx+0x48/0x70
> 	[67628.393726]  scpi_dvfs_set_rate+0x60/0x78
> 	[67628.393728]  clk_change_rate+0x184/0x8a8
> 	[67628.393731]  clk_core_set_rate_nolock+0x1c0/0x280
> 	[67628.393734]  clk_set_rate+0x40/0x98
> 	[67628.393736]  scpi_cpufreq_set_target+0x40/0x68
> 	[67628.393739]  __cpufreq_driver_target+0x1a0/0x5d0

Thanks.

> > Why is it invalid? Is this... -rt kernel, perhaps?
> 
> No I was running on Linus master at the time.
> 
> AFAIU printk will hold the console lock which could sleep in interrupt context.
> 
> Did I miss something?

printk() is not permitted to sleep/schedule/etc and it never does.
Generally it should be OK to call it from IRQ (module recursion paths).

	-ss
