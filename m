Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2FB27B874
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 01:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgI1Xu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 19:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgI1Xu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 19:50:56 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F343C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 16:50:54 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id l126so2738058pfd.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 16:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PCAUgmN81IcYAHnWNhW9isLm7rbDzjVGyanWkN6tKwA=;
        b=a3QFXOgMPz3RSiSDW47BSACzZ+lN+UDtHLgnGyi0Wz7PMmdNYaJpkYj6lhZU59Kqr9
         bZAn6moKqH/16Z2IjS4blzsuDT1bj+fTcnw2D2pLVimX/85VaK0/DUKZe5iixrWpSJcv
         n9czm3J4mpWUTcX7yUTXPm7wv8P/5++lyUF1rxOD/EHiIQRNSiF70LElCuT5VatFsJ/g
         QvhT9KMYQ/wBA6Nv3yA6PNRxd6YgxJzdpLxZrbzC6OQJHEcrY1YFv5b2B2VML9XK44eA
         8Odmukrz0Nnu5PPj9mXykyfNlQCO6BaKvZADoyXP3+7Y4N4tJTGtbyrEHzAhiJp83EFg
         v2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PCAUgmN81IcYAHnWNhW9isLm7rbDzjVGyanWkN6tKwA=;
        b=SeALMS2edoB5pWiBkaIbiSyW5HjjtOrh+5RWFYqeUioLr8zmDRIMmwzXScpphVGLPs
         NyYZUw+7G+k39tmqhtvX90zazwYaSKv9RKMPKwkXUJUYR40hMnAp/2U3L95S7pDHlB+M
         mU/v8wx5Y0C+oxKEkGAP1qwO7eEUXI8nlDVWBzfGuCXsloRXl9uCTebCcRfm+iiqMOu7
         YAWSjW7jPm8NsCz9Kx7rmKr4ZeMTxLLI6inu3Nm0t44bIsGC7Rl5WvD2QY5vKYdyFnD6
         KPFTD4NV6bcLpSTuK59DwetsmOD/syh9bdnsApxC+qCSp6bBlv351dFpqsp2U2HJM1Tc
         5o8w==
X-Gm-Message-State: AOAM530dMd7Nl2t11Qck1dGVdtk/SqsW1h1lbcZkMAvXW8L7BYIb4AIi
        M6HGSiP9wTsJmicgzDNpQDo=
X-Google-Smtp-Source: ABdhPJwXzc51MZz1CeTs+djanje5iH0/4kmI+KmxFurjdIf4ShczmfC1Fe92b9wOEEEd2ppFENX6mA==
X-Received: by 2002:a17:902:c14c:b029:d2:4345:5a9 with SMTP id 12-20020a170902c14cb02900d2434505a9mr1734375plj.0.1601337053781;
        Mon, 28 Sep 2020 16:50:53 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id w195sm2938435pff.74.2020.09.28.16.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 16:50:52 -0700 (PDT)
Date:   Tue, 29 Sep 2020 08:50:52 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, songmuchun@bytedance.com,
        john.ogness@linutronix.de
Subject: Re: [External] Re: [PATCH 2/2] sched: mark
 PRINTK_DEFERRED_CONTEXT_MASK in __schedule()
Message-ID: <20200928235052.GB871730@jagdpanzerIV.localdomain>
References: <20200927161130.33172-1-zhouchengming@bytedance.com>
 <20200927161130.33172-2-zhouchengming@bytedance.com>
 <20200928073202.GA2611@hirez.programming.kicks-ass.net>
 <40ab934e-5b8b-735b-da65-3043efab9fdc@bytedance.com>
 <20200928090143.GA2628@hirez.programming.kicks-ass.net>
 <688eadd7-4ca3-3e32-3520-25977ff059a6@bytedance.com>
 <20200928102559.GF2611@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200928102559.GF2611@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/09/28 12:25), Peter Zijlstra wrote:
[..]
> > printk
> >   vprintk_emit
> >     console_unlock
> >       vt_console_print
> >         hide_cursor
> >           bit_cursor
> >             soft_cursor
> >               queue_work_on
> >                 __queue_work
> >                   try_to_wake_up
> >                     _raw_spin_lock
> >                       native_queued_spin_lock_slowpath
> > 
> > Looks like it's introduced by this commit:
> > 
> > eaa434defaca1781fb2932c685289b610aeb8b4b
> > 
> > "drm/fb-helper: Add fb_deferred_io support"
> 
> Oh gawd, yeah, all the !serial consoles are utter batshit.
> 
> Please look at John's last printk rewrite, IIRC it farms all that off to
> a kernel thread instead of doing it from the printk() caller's context.

Not yet. Scheduler is still part of the printk() - either in the
form of !serial consoles or console_sem, or both.

	-ss
