Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA7C2D9CBA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 17:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440140AbgLNQ3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 11:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440242AbgLNQ2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 11:28:48 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9099C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 08:28:07 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id v14so14304331wml.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 08:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=51YsbQIYuq9kiX/Ezj5Ht0AVHuSlN5jsKWqnvhPG9kE=;
        b=iDHzsbT6UFubPP0i50ey89vA1UgdSoprtVon0iTpYV1cW+lOkGEWfqFwtngURquUz5
         B077Wh7OmIoJub+RoM+M1x6u85K6cAbUV1EjwYve6CQ9Aor5/hA0jWrFAR9CLuFrFXkz
         3C2jp8TLffbBwnwyp1NdC+MQFZvQRineyv56g4pvimfGyyIKlzCGmHTKHa4EmgyeVeiV
         mTw6lJyWtD1sScow0A6lE6kIX4apxVttPZd2oBVY/jNrebHSjsEaQOFQwg5VCtcYqqN0
         JcM99HgTBXlqpNWMFCze1PUVc0oWhq7eQUDbMfzWFsQpV5I2DugUwd6SmpwvpYAI8V9s
         ODvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=51YsbQIYuq9kiX/Ezj5Ht0AVHuSlN5jsKWqnvhPG9kE=;
        b=lw/weIt6CAKn3sZ5n5fJhkXvvU2x5+BgwzU6iZHN4ertP6ytww0n/Cc020aB4GhGgb
         J4NvQSCdFIP0gdkVdXR3xJReA+l15/h9bVHMMO2pzk6GvIwjDHIgnF1WR2fM6I57k/Gu
         B/qBSlxcelnWmxgjhheQllaGoJyCNKh/tggt5JssP4i5zFo+55e9z0btSS0dxDtRbntj
         zmZk7EMzoJ9K4ZD/hyZ/gOxW1p7E1BvDIAT3GFbr08kt8z8q1gxcoLe8dwnpziJPMr29
         AT14obREkzK+3oMsG9bFA4t90KMrjzGVttXnqlJy4KR0YO8AWowrIsun8KmfpblV0W9o
         PHfg==
X-Gm-Message-State: AOAM533ON82wjSZlqtIC8oBOAe0suOjukF5IFCm3tcA/ekIvw2f5nYu6
        TDU6Bcfz5QnxervkqkaK7adW+A==
X-Google-Smtp-Source: ABdhPJy/HD9Xc/p5LiC20sf0NJ5AuesdVQXZgve4vr1XtQmZ1M0zrGpdVf8En/HPezn6ogxD8VFYdQ==
X-Received: by 2002:a7b:cb0c:: with SMTP id u12mr28187914wmj.11.1607963286539;
        Mon, 14 Dec 2020 08:28:06 -0800 (PST)
Received: from Jessicas-MacBook.local (trinity-students-nat.trin.cam.ac.uk. [131.111.193.104])
        by smtp.gmail.com with ESMTPSA id v64sm30884456wme.25.2020.12.14.08.28.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Dec 2020 08:28:05 -0800 (PST)
Received: by Jessicas-MacBook.local (Postfix, from userid 501)
        id 53694209CCA69F; Mon, 14 Dec 2020 16:28:04 +0000 (GMT)
Date:   Mon, 14 Dec 2020 16:28:04 +0000
From:   Jessica Clarke <jrtc27@jrtc27.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Anatoly Pugachev <matorola@gmail.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [sparc64] ftrace: kernel startup-tests unaligned access
Message-ID: <20201214162804.GA27786@Jessicas-MacBook.local>
References: <CADxRZqzXQRYgKc=y-KV=S_yHL+Y8Ay2mh5ezeZUnpRvg+syWKw@mail.gmail.com>
 <20201214111512.415717ac@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214111512.415717ac@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 11:15:12AM -0500, Steven Rostedt wrote:
> On Mon, 14 Dec 2020 18:59:02 +0300
> Anatoly Pugachev <matorola@gmail.com> wrote:
> 
> > Hello!
> > 
> > Enabled ftrace startup tests on a sparc64 test VM/LDOM:
> > 
> > $ diff -u <(gzip -dc ~/dmesg/config-5.10.0.gz) <(gzip -dc /proc/config.gz)
> > --- /dev/fd/63  2020-12-14 16:19:38.239372599 +0300
> > +++ /dev/fd/62  2020-12-14 16:19:38.235372433 +0300
> > @@ -2842,7 +2842,10 @@
> >  # CONFIG_TRACEPOINT_BENCHMARK is not set
> >  # CONFIG_RING_BUFFER_BENCHMARK is not set
> >  # CONFIG_TRACE_EVAL_MAP_FILE is not set
> > -# CONFIG_FTRACE_STARTUP_TEST is not set
> > +CONFIG_FTRACE_SELFTEST=y
> > +CONFIG_FTRACE_STARTUP_TEST=y
> > +CONFIG_EVENT_TRACE_STARTUP_TEST=y
> > +# CONFIG_EVENT_TRACE_TEST_SYSCALLS is not set
> >  # CONFIG_RING_BUFFER_STARTUP_TEST is not set
> >  # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
> >  # CONFIG_KPROBE_EVENT_GEN_TEST is not set
> > 
> > 
> > Got the following results with kernel boot logs:
> > 
> > Dec 14 13:48:15 kernel: clocksource: jiffies: mask: 0xffffffff
> > max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
> > Dec 14 13:48:15 kernel: futex hash table entries: 65536 (order: 9,
> > 4194304 bytes, linear)
> > Dec 14 13:48:15 kernel: Running postponed tracer tests:
> > Dec 14 13:48:15 kernel: Testing tracer function:
> > Dec 14 13:48:15 kernel: Kernel unaligned access at TPC[552a20]
> > trace_function+0x40/0x140
> > Dec 14 13:48:15 kernel: Kernel unaligned access at TPC[552a24]
> > trace_function+0x44/0x140
> > Dec 14 13:48:15 kernel: Kernel unaligned access at TPC[552a20]
> > trace_function+0x40/0x140
> > Dec 14 13:48:15 kernel: Kernel unaligned access at TPC[552a24]
> > trace_function+0x44/0x140
> > Dec 14 13:48:15 kernel: Kernel unaligned access at TPC[552a20]
> > trace_function+0x40/0x140
> 
> Does sparc64 require 8 byte alignment for 8 byte words?

Yes, SPARC requires natural alignment for all primitive types (and that
even includes 8-byte alignment for 8-byte types on 32-bit SPARC as it
has load/store pair instructions the compiler is free to use).

Jess
