Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529F727AB7C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 12:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgI1KEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 06:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgI1KEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 06:04:34 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EDBC061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 03:04:34 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id v14so347039pjd.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 03:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=RJCBm+SExKQXhoNNt6cZz3q3IYgQOBDeM3UdJw1s5TE=;
        b=JIVBTkvwa8dAIMVTumigP3fdPqsCfbZ05sZNj5b1m4wIQ13cUd/SubxMhe1dW7/tUU
         IEbC+DvmVAtjfZ22hd0NZ1cL5yS1scjk4ooWUBVcxqt0adDzXep9pTb1yjoHb0+7jfUy
         ImUNuH6JQO2CC9qomK13frrNdC+q2Kh0ySkpcyeHbx2ElKKL0Y9vN2izIVBiYhfe+mc+
         NCQ12LKOhMv1XAku4qjZK1K4b7H7/yQyHMcVhIwKfIrZWJ082ywQ1BLafO+cHak8KAlC
         Ek877Ee3OLWLrwjH/Prm2jyfGOCNwM7aiPlQq1VNMrXVyqy+YqgnoGsPCQ/Ogur7pDJa
         LsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=RJCBm+SExKQXhoNNt6cZz3q3IYgQOBDeM3UdJw1s5TE=;
        b=d80g94lG5bdkc7YsNafuZoAis/+j8jvTblhAWpXZEqU3U1+cY5rLhppA9lOP6uRCq7
         65Zt6SXAQV3C+92lQg3+GU2o82gV5fW3zQjqlbFSGYHhx2bXA6/R35iUD+L99CQ83Sa+
         VSjWkhmR3qEjZVNpE7qLkf0liwLIwNS49eGL3RDNuE+aFAlA+PQgTOOz/uYuivWg51l1
         ZV1Nu47tQAUOMZEWNR8e9kF9D6+/TkcT6YyEa5h9GU66xNkq6CoIdtusPxA97VXvHZK0
         RW8TH6zRXV0KzROTMPoBRVpS5S/jjlVLjBeJvLc5CxbOFIjd1sGaWwBI0UWXA2e6I5aO
         CZUA==
X-Gm-Message-State: AOAM533DmLMi07aZJDhEC3R3Fjbu1rK/mcqgPDPneM5bw2oElOQ/mDw6
        w/0LL9uBojvUu2eITW916+411g==
X-Google-Smtp-Source: ABdhPJyvu/DIOXRutdhbldQ+CUKy6EYFVMjphqk8vlLEsJopKhnoHBvXGS8LHhKNLPmhfG3ervbCgw==
X-Received: by 2002:a17:90b:f0b:: with SMTP id br11mr644868pjb.191.1601287473743;
        Mon, 28 Sep 2020 03:04:33 -0700 (PDT)
Received: from [10.86.118.224] ([103.136.221.71])
        by smtp.gmail.com with ESMTPSA id k11sm806168pjs.18.2020.09.28.03.04.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 03:04:33 -0700 (PDT)
Subject: Re: [External] Re: [PATCH 2/2] sched: mark
 PRINTK_DEFERRED_CONTEXT_MASK in __schedule()
To:     Peter Zijlstra <peterz@infradead.org>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, songmuchun@bytedance.com
References: <20200927161130.33172-1-zhouchengming@bytedance.com>
 <20200927161130.33172-2-zhouchengming@bytedance.com>
 <20200928073202.GA2611@hirez.programming.kicks-ass.net>
 <40ab934e-5b8b-735b-da65-3043efab9fdc@bytedance.com>
 <20200928090143.GA2628@hirez.programming.kicks-ass.net>
From:   Chengming Zhou <zhouchengming@bytedance.com>
Message-ID: <688eadd7-4ca3-3e32-3520-25977ff059a6@bytedance.com>
Date:   Mon, 28 Sep 2020 18:04:23 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200928090143.GA2628@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2020/9/28 下午5:01, Peter Zijlstra 写道:
> On Mon, Sep 28, 2020 at 04:54:53PM +0800, Chengming Zhou wrote:
>> 在 2020/9/28 下午3:32, Peter Zijlstra 写道:
>>> On Mon, Sep 28, 2020 at 12:11:30AM +0800, Chengming Zhou wrote:
>>>> The WARN_ON/WARN_ON_ONCE with rq lock held in __schedule() should be
>>>> deferred by marking the PRINTK_DEFERRED_CONTEXT_MASK, or will cause
>>>> deadlock on rq lock in the printk path.
>>> It also shouldn't happen in the first place, so who bloody cares.
>> Yes, but if our box deadlock just because a WARN_ON_ONCE, we have to
>> reboot : (
> You have to reboot anyway to get into the fixed kernel.

Mostly, WARN_ON_ONCE happened in the perf code on our machines, we actually

don't care too much about the perf function works : )   Looks like we
have to find and

fix that perf bug before go on...

>> So these WARN_ON_ONCE have BUG_ON effect ?  Or we should change to use
>> BUG_ON ?
> Or use a sane printk implementation, I never suffer this.

Well, you are lucky. So it's a problem in our printk implementation.

The deadlock path is:

printk

  vprintk_emit

    console_unlock

      vt_console_print

        hide_cursor

          bit_cursor

            soft_cursor

              queue_work_on

                __queue_work

                  try_to_wake_up

                    _raw_spin_lock

                      native_queued_spin_lock_slowpath

Looks like it's introduced by this commit:

eaa434defaca1781fb2932c685289b610aeb8b4b

"drm/fb-helper: Add fb_deferred_io support"

    This adds deferred io support to drm_fb_helper.
    The fbdev framebuffer changes are flushed using the callback
    (struct drm_framebuffer *)->funcs->dirty() by a dedicated worker
    ensuring that it always runs in process context.
   
    For those wondering why we need to be able to handle atomic calling
    contexts: Both panic paths and cursor code and fbcon blanking can run
    from atomic. See
   
    commit bcb39af4486be07e896fc374a2336bad3104ae0a
    Author: Dave Airlie <airlied@redhat.com>
    Date:   Thu Feb 7 11:19:15 2013 +1000
   
        drm/udl: make usage as a console safer
   
    for where this was originally discovered.

