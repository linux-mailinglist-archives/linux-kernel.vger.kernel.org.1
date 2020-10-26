Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD852992FB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786593AbgJZQxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:53:18 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:43465 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1786584AbgJZQxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:53:17 -0400
Received: by mail-qv1-f67.google.com with SMTP id bl9so4605868qvb.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 09:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tRGzOr0ebxa8PA89MZHTDFpEs7q7Dz3b2th/oGGJY/I=;
        b=B1PoPwPmVENh9APWJE9yBymBpwfHajobryt05CnlXJl+v5q5n7ClEUHus5RDVAmF/b
         5qzeta/rkT/M9pbNKoD/6DJNpqFfhYeq5UDdD+hLk/xtwoYXGyOGUqgBmX+8TXg51ozK
         cpJsw52UzryS42fK2g71D3NDf6X7i9DEyWm7ipdzAjKevscnD560PcDVd0arGY3lpg4K
         4+u3bjBKcFczN6wqnSq4ymxRTp5ZMfC/jLhcT/1qJ5pUVVKnWk79h53OFWBC5fmHCrfG
         F/Jz1pTm7BW6fSXLHT55tlnNZvSeOqBXcfTlH2LVRJso4A4hnMOpdxq/9E75vX5qKf7X
         9+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=tRGzOr0ebxa8PA89MZHTDFpEs7q7Dz3b2th/oGGJY/I=;
        b=AcWhk/hb+Fwpl0ACZ/zd8+cyb/gKMfFzsghEimrJl8UXEfYHeKCwuR6CcwYhJn19jL
         8LKmNJmmhrcU2Zksl1u6RF3AfDOCc1L2warYNm7TXzNXZQaPQYY9eo7Pp70VVkI14cZ6
         fnJOAd0M0mKTCOs2ybfOMFzTEsr64Fzu7WhfWejhoGEFlzbcoE1ZHPzLa6/1JgQeLW1Y
         iSqQaDD5CXbM9VyXkrNxu/9AQiJrqSCWVntH0qhJ3terwwnPXx1eHjHIVX914biGR6oa
         +7+dSX/y8nqPXuQPRwnmhj4IK3SITEK5xUX16tVDkKPV/OWcEtexrc1qNBI7xSzp8dJH
         NWbw==
X-Gm-Message-State: AOAM5318BjJjp+0bSVK6bPDWDyXgp/vZCOGrOr2FOSZu5RjrINOXFiFM
        M5gVWVqXWSqNYTCV6ZBbomjIVd6UzOj/Gg==
X-Google-Smtp-Source: ABdhPJzT9a0QQE8CYV+cIfwLyXKbu3bBCHITSkRTe6isI7Sk32lRpJw2KKqpaWDA5kE8Wc6XBP5+mA==
X-Received: by 2002:a0c:a482:: with SMTP id x2mr18539898qvx.47.1603731195996;
        Mon, 26 Oct 2020 09:53:15 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:c37])
        by smtp.gmail.com with ESMTPSA id d188sm7141118qkb.10.2020.10.26.09.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 09:53:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 26 Oct 2020 12:53:11 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     qiang.zhang@windriver.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] kthread_worker: re-set CPU affinities if CPU come online
Message-ID: <20201026165311.GA97873@mtj.duckdns.org>
References: <20201026065213.30477-1-qiang.zhang@windriver.com>
 <20201026135011.GC73258@mtj.duckdns.org>
 <20201026164555.GA7544@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026164555.GA7544@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Petr.

On Mon, Oct 26, 2020 at 05:45:55PM +0100, Petr Mladek wrote:
> > I don't think this works. The kthread may have changed its binding while
> > running using set_cpus_allowed_ptr() as you're doing above. Besides, when a
> > cpu goes offline, the bound kthread can fall back to other cpus but its cpu
> > mask isn't cleared, is it?
> 
> If I get it correctly, select_fallback_rq() calls
> do_set_cpus_allowed() explicitly or in cpuset_cpus_allowed_fallback().
> It seems that the original mask gets lost.

Oh, I see.

> It would make sense to assume that kthread_worker API will take care of
> the affinity when it was set by kthread_create_worker_on_cpu().

I was for some reason thinking this was for all kthreads. Yeah, for
kthread_workers it does make sense.

> But is it safe to assume that the work can be safely proceed also
> on another CPU? We should probably add a warning into
> kthread_worker_fn() when it detects wrong CPU.

Per-cpu workqueues behave like that too. When the CPU goes down, per-cpu
workers on that CPU are unbound and may run anywhere. They get rebound when
CPU comes back up.

> BTW: kthread_create_worker_on_cpu() is currently used only by
>      start_power_clamp_worker(). And it has its own CPU hotplug
>      handling. The kthreads are stopped and started again
>      in powerclamp_cpu_predown() and  powerclamp_cpu_online().

And users which have hard dependency on CPU binding are expected to
implement hotplug events so that e.g. per-cpu work items are flushed when
CPU goes down and scheduled back when it comes back online.

There are pros and cons to the current workqueue behavior but it'd be a good
idea to keep kthread_worker's behavior in sync.

> I havn't checked all details yet. But in principle, the patch looks
> sane to me.

Yeah, agreed.

Thanks.

-- 
tejun
