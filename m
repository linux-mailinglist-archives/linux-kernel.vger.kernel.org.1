Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068C32FE821
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbhAUKxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729839AbhAUKt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:49:28 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D81C061575
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 02:48:46 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id a8so1865091lfi.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 02:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Ier3JxTZHCJDYEQcjpwf7m9INPX4qO9DRZJZVH43cY=;
        b=gfULL5MIuBFoS5q6PkTtjGLlOB2s17CQwYZ/9KB3vNhGC7rAe6nQDF7tD09UEazptP
         XZiDXFxkUKCpOMttLmlJaV42SQqYjRrHBT4adkWmybsJlYhb53DmORNhxFz7lvrPmBxq
         +TVN/jNSUU32RQQRucdLOckXz405gRmEoIa5LUp3lCE1RYkylrY4KOxgUYG4gOF+RRkO
         +QxBDjitf6rDbfqCK5PJ4QpHTqr50wHV40bfplQEoYmVeEKNmzPtJuewTFUg7W2ihcqq
         aOASjt8WBLtcj4F8b0tGIZGlTb+FaW8Tn37iIKpo8E4VWR+CpGrIVaio5lwq7ckHhNQp
         nFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Ier3JxTZHCJDYEQcjpwf7m9INPX4qO9DRZJZVH43cY=;
        b=hDT6F0bOMtTze/521pQIxuZ1VeX9U6xi8tHiHGREmSTzaj6w4igYV6LgKom8KrhsZK
         6H5YICztDTk0y0gtwWdwztsYHCBzeGYfrMZWBWb0Y6s+KMybHHB6gNXD8gfxcvawQHLt
         vQM4PkTjpOID26ROn9DEQv+ai2Y7Bll4izUrkRLPJD0WKNBnl/CEPVDhUnTJPZ5rFzcW
         7Ha8XzSWkBApc48/+qu8dQkIUWo0ze9kj1Q+rOoUeTvRmS1pGo7av7SjnVfUz5OrG2vD
         Jpojwx/zrlaxu9fy60Sem9iGYKVEXAwTWwJY+S3+b2jz0LgaG+yB/wjvynHEB0noVj3t
         lorA==
X-Gm-Message-State: AOAM532/87GS6pl0f/jBjmiwiSmEz/Ns9SGB0NyOG6eLeG0oM3NhlR6n
        q8fksiRImIFENwms/zkPtg7XSImytrVJxs0i7T5+0A==
X-Google-Smtp-Source: ABdhPJwXWFvu2Wz8A+pMf1ZfbO3tePCKxAtal/1iFAxvc5oAIep/7TbKNpVOKIq4CEKHOoaAnv6V+NKleZdia7IwxPc=
X-Received: by 2002:a19:2d0a:: with SMTP id k10mr6729312lfj.286.1611226124818;
 Thu, 21 Jan 2021 02:48:44 -0800 (PST)
MIME-Version: 1.0
References: <20201118082759.1413056-1-bharata@linux.ibm.com>
 <CAKfTPtA_JgMf_+zdFbcb_V9rM7JBWNPjAz9irgwFj7Rou=xzZg@mail.gmail.com>
 <20210121053003.GB2587010@in.ibm.com> <alpine.DEB.2.22.394.2101210959060.100764@www.lameter.com>
In-Reply-To: <alpine.DEB.2.22.394.2101210959060.100764@www.lameter.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 21 Jan 2021 11:48:33 +0100
Message-ID: <CAKfTPtDtTkuKRJH-otGM1ZUP1tZUAfLMr5prRiN_T68bZ5m5Bw@mail.gmail.com>
Subject: Re: [RFC PATCH v0] mm/slub: Let number of online CPUs determine the
 slub page order
To:     Christoph Lameter <cl@linux.com>
Cc:     Bharata B Rao <bharata@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, guro@fb.com,
        vbabka@suse.cz, Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        aneesh.kumar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jan 2021 at 11:01, Christoph Lameter <cl@linux.com> wrote:
>
> On Thu, 21 Jan 2021, Bharata B Rao wrote:
>
> > > The problem is that calculate_order() is called a number of times
> > > before secondaries CPUs are booted and it returns 1 instead of 224.
> > > This makes the use of num_online_cpus() irrelevant for those cases
> > >
> > > After adding in my command line "slub_min_objects=36" which equals to
> > > 4 * (fls(num_online_cpus()) + 1) with a correct num_online_cpus == 224
> > > , the regression diseapears:
> > >
> > > 9 iterations of hackbench -l 16000 -g 16: 3.201sec (+/- 0.90%)
> >
> > Should we have switched to num_present_cpus() rather than
> > num_online_cpus()? If so, the below patch should address the
> > above problem.
>
> There is certainly an initcall after secondaries are booted where we could
> redo the calculate_order?
>
> Or the num_online_cpus needs to be up to date earlier. Why does this issue
> not occur on x86? Does x86 have an up to date num_online_cpus earlier?

I have added a printk in calculate_order() :
        pr_info(" SLUB calculate_order cmd  %d min %d online %d
present %d possible %d cpus %d", slub_min_objects, min_objects,
num_online_cpus(), num_present_cpus(), num_possible_cpus(),
nr_cpu_ids);

And checked with
qemu-system-x86_64 -kernel bzImage -nographic -smp 4 -append "console=ttyS0"

[    0.064927]  SLUB calculate_order cmd  0 min 8 online 1 present 4
possible 4 cpus 4
[    0.064970] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1

The num_online_cpus has the same behavior as on my platform and
num_online_cpus =  1 when kmem_cache_init() is called

Only the num_present_cpus = 4 from the beginning but that's probably
just because it runs in a VM

Also it's interesting to notice that num_possible_cpus and nr_cpu_ids
are set to the correct value

>
>
