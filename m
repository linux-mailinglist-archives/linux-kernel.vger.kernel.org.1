Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC2E3039D1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391904AbhAZKG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731384AbhAYSzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 13:55:32 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42351C061573
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 10:54:51 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id kg20so19102229ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 10:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=90w6LArqW+QxMvkgHdpj+y3+bk3Wxq/JZX2Zy2yg0+Y=;
        b=GumZw5hJ3Og7ER863YKk58sl2N79o4wOWJ4OE0VjHvfAMxgxLUKxJhOfMZ/lIXiNoE
         a6iQHzXvzQf9FmyewX9y/9zcMXsW0d5r/soLO5mFNhsvPeMrkHk7Vau0tVyNRrp8PzMA
         TBmYrme+dY8EZHt2dgqE9gh5hOw5doTu2PuCsDHbCygq+5oIPiyLOKQuGIpjgPxNVHTx
         Pxh1lC63iW5bZipCaww+sGdAXLxv4LSa0wxCeu+lVJE8jmaqt2D9YEl0r82U7o1UnGoH
         lZipTefXpIArORkj/N5Y/frAFMy2FZ49ic3vry3x2QLZDib7ivFufGbj7sWPaU0gOaUm
         83hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=90w6LArqW+QxMvkgHdpj+y3+bk3Wxq/JZX2Zy2yg0+Y=;
        b=Up+zAeXiPfCQwBBwJlvm9gfpsTov+ZQ7X7hj4I+pjMaTSN/qbpR7foEa3Wh0uBUGq5
         eGmQGObK1yXn/2icEcPKaTWw877s3fVJOgf4fhbhdhfgeA5N4gbZX82L06BaDlZHyI5n
         LUg+3nTon1ogKVizwPlTimshatC3If5pkXyj7ghqNhnj+xzjwHl1DfiACClnkdXKHKxd
         Bxmapl0RksYXEYf3qspAbvYUETYO2gbwwR2E5Vst4rJ8Ik8KFXQyZeh/zDB1/Q2FtK+x
         ouuXjMQVWMkvVcpbB5/qDRgnUDvEB+H8WwwxxOnNmCQjgXk2/vIRRb08VH6qRVncdWdw
         V1nw==
X-Gm-Message-State: AOAM531/+NVGB1TMCGqswP7XYmi1aisvVtj0H1wRoqWAR9XqcXOZRiZs
        IiKuJ1eXYG6S9L1Ytq7yn+Q=
X-Google-Smtp-Source: ABdhPJwIjz8Heuit3bpVZECVdU4EOJeWEUx8vOYQcJwIEn6j8RVBmG2bm2OZC14ahakipLUBFVLroA==
X-Received: by 2002:a17:906:9497:: with SMTP id t23mr1240804ejx.523.1611600890041;
        Mon, 25 Jan 2021 10:54:50 -0800 (PST)
Received: from tibiarch (2a01-036d-0103-0de8-02cc-acf3-5d9f-e723.pool6.digikabel.hu. [2a01:36d:103:de8:2cc:acf3:5d9f:e723])
        by smtp.gmail.com with ESMTPSA id qk1sm8690484ejb.86.2021.01.25.10.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 10:54:49 -0800 (PST)
Date:   Mon, 25 Jan 2021 19:54:38 +0100
From:   Tibor Bana <bana.tibor@gmail.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     valdis.kletnieks@vt.edu, Jan Kara <jack@suse.cz>,
        Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>, vbabka@suse.cz,
        aarcange@redhat.com, rientjes@google.com, mhocko@kernel.org,
        zi.yan@cs.rutgers.edu, hannes@cmpxchg.org
Subject: Re: [regression -next0117] What is kcompactd and why is he eating
 100% of my cpu?
Message-Id: <20210125195438.c8d0e7980da0c2931d4f3056@gmail.com>
In-Reply-To: <20190130104020.GE9565@techsingularity.net>
References: <20190126200005.GB27513@amd>
        <12171.1548557813@turing-police.cc.vt.edu>
        <20190127141556.GB9565@techsingularity.net>
        <20190127160027.GA9340@amd>
        <13417.1548624994@turing-police.cc.vt.edu>
        <20190128091627.GA27972@quack2.suse.cz>
        <14875.1548810399@turing-police.cc.vt.edu>
        <9618.1548822577@turing-police.cc.vt.edu>
        <20190130104020.GE9565@techsingularity.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings!

I don't know if it still actual, but I am strugling with this problem right now and searching the internet for solutions.
I read the thread and saw that you are strugling to reproduce the problem, and I can reproduce it almost every day.

- Install vmware player, and a linux guest. 
- Configure the virtual machine to have a good amount of memory and cpu
- run resource intensive tasks on the guest
- when the host used up almost it's all memory and start to reuse caches kcompactd will kick in.

As I know the problem is related to transparent huge pages, but I tried to disable it. 
Today I saw the problem again and kcompactd shown an interesting status in top. It hasn't used any memory, all zeroes but it used up one core completely. 

My machine is a core-i7 with 4 physical cores and hyper threading and 24GB Memory
5.9.11-arch2-1 #1 SMP PREEMPT Sat, 28 Nov 2020 02:07:22 +0000 x86_64 GNU/Linux

Hope this can help, to point out the problem.

Tibor Bana

On Wed, 30 Jan 2019 10:40:20 +0000
Mel Gorman <mgorman@techsingularity.net> wrote:

> On Tue, Jan 29, 2019 at 11:29:37PM -0500, valdis.kletnieks@vt.edu wrote:
> > On Tue, 29 Jan 2019 20:06:39 -0500, valdis.kletnieks@vt.edu said:
> > > On Mon, 28 Jan 2019 10:16:27 +0100, Jan Kara said:
> > >
> > > > So my buffer_migrate_page_norefs() is certainly buggy in its current
> > > > incarnation (as a result block device page cache is not migratable at all).
> > > > I've sent Andrew a patch over week ago but so far it got ignored. The patch
> > > > is attached, can you give it a try whether it changes something for you?
> > > > Thanks!
> > >
> > > Been running with the patch for about 24 hours, haven't seen kcompactd
> > > misbehave.  I even fired up a Chrome with a lot of tabs open, a Firefox, and a
> > > kernel build, intentionally drove the system into swapping, and kcompactd
> > > didn't make it into the top 10 on 'top'.
> > >
> > > I'm willing to say put a "tested-by:" on that one,  it looks fixed from here.
> > > If there's any remaining bugs, they're ones I can't seem to trigger...
> > 
> > Spoke too soon.  Sitting here not stressing the laptop at all, plenty of free
> > memory, and ka-blam.
> > 
> > Will keep my eyes open and do the data gathering Mel Gorban wanted - I discovered
> > too late that trace-cmd wasn't installed, and things broke free by themselves (probably
> > not coincidence that I launched a terminal window and then it cleared....)
> > 
> 
> That's unfortunate. I also note that linux-next still has not been
> updated with the latest version of the compaction series. Nevertheless,
> it might be helpful to get the output of
> 
> grep -r . /sys/kernel/mm/transparent_hugepage/*
> 
> and the trace when the system is in normal use but kcompactd has not
> pegged at 100%. At minimum, I'd like to see what the sources of high-order
> allocations are and the likely causes of wakeups of kcompactd in case
> there are any hints there. Your Kconfig is also potentially useful.
> 
> Thanks.
> 
> -- 
> Mel Gorman
> SUSE Labs


-- 
Tibor Bana <bana.tibor@gmail.com>
