Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819D4286FAB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 09:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgJHHkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 03:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbgJHHkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:40:19 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E59AC061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 00:40:19 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id h9so3843507ybm.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 00:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Rp3My2L/roRnIDEi9kisQtYgeX2FwvYUO7ZV7SrOvU=;
        b=q5USTEPGaKtcH62zrMADCGgthfmfGu4Q0LxLhnuNjym9+D4SMw3X36j3KU7PUzr5Dl
         O3SJ/s06qAC48u4lXvaYATZ9of9OC8WEoI/ZlA3aPa7c1M/57tckvnl0uaHIHe5Xr2xi
         otnnoT8jMz+Jcjwqv/oBEMWHDvMowmhOOh+e12Fg2AUsu0gYGfWyU0zIy7TLanaRGLqM
         7D8tix2Bp8rO+xDRzZ3Jy541nYCFqdZsX3CNKZR+CkLyWwIHhRAiAE7w9HIlGJTvQEfT
         FNPcT1nKGBB2ie1x2KIjwAWWw9jrptHbuJOeQaGqo/n0tT+9ScOR7Zx3WNGnS5qhSeRT
         srBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Rp3My2L/roRnIDEi9kisQtYgeX2FwvYUO7ZV7SrOvU=;
        b=T0jFh4eUQnnLY1csuwvQz7D2Tcly6Te0lXZXr1fkixCHGloIRaQKrrwQXm/SAkNI5H
         1ti3QkWd9mTYcJVpFmIIvzfsnCTrUpiKbdk/DedPHIPDOpXvcJrjLoMXpmyH2hhvpiJw
         XOutaaB7xK3XpSqg3ZtR5/98kWnvNCYj0O2ei1CAhjKGFI9Mlub/i9PTGU0bXfhtzcql
         Z/cQYeAkeKlRAPiF8xgGRcLXkRE3Pma6pUY2Tyg3l+6VoWdWwjJRMmxjKYTq3AwcRQhi
         6c8gRDckzzQMUzQHWnaEk5oCwxRqalxqv+OLTbDVahAOQOPyBF5PXpZp9sf1kGFBLoGJ
         +x4g==
X-Gm-Message-State: AOAM533NCVMmLsKJEgp39GwLuAv7DHSq6H8Ukslau7VTQNe9L9gO9X9x
        GjiBXEaImfGOBeGQ29NpU8ZCqJ8vu2/vyOUy4vIGkQ==
X-Google-Smtp-Source: ABdhPJz8G0UzuxWD3kadRsINe7B0llIGw01vL0xbE8O4KhdvJJiDtB4CFJz7q0izUDi5LxJ7jREm6oqkxc9v//V3yp0=
X-Received: by 2002:a25:840d:: with SMTP id u13mr9231276ybk.7.1602142818150;
 Thu, 08 Oct 2020 00:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <20201007184403.1902111-1-axelrasmussen@google.com> <20201007184403.1902111-3-axelrasmussen@google.com>
In-Reply-To: <20201007184403.1902111-3-axelrasmussen@google.com>
From:   Michel Lespinasse <walken@google.com>
Date:   Thu, 8 Oct 2020 00:40:05 -0700
Message-ID: <CANN689F4jcm_rx3t8hwD7-F-kwJpMJRsi50ab9eh039ZzVBOQg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmap_lock: add tracepoints around lock acquisition
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 7, 2020 at 11:44 AM Axel Rasmussen <axelrasmussen@google.com> wrote:
> The goal of these tracepoints is to be able to debug lock contention
> issues. This lock is acquired on most (all?) mmap / munmap / page fault
> operations, so a multi-threaded process which does a lot of these can
> experience significant contention.
>
> We trace just before we start acquisition, when the acquisition returns
> (whether it succeeded or not), and when the lock is released (or
> downgraded). The events are broken out by lock type (read / write).
>
> The events are also broken out by memcg path. For container-based
> workloads, users often think of several processes in a memcg as a single
> logical "task", so collecting statistics at this level is useful.
>
> The end goal is to get latency information. This isn't directly included
> in the trace events. Instead, users are expected to compute the time
> between "start locking" and "acquire returned", using e.g. synthetic
> events or BPF. The benefit we get from this is simpler code.
>
> Because we use tracepoint_enabled() to decide whether or not to trace,
> this patch has effectively no overhead unless tracepoints are enabled at
> runtime. If tracepoints are enabled, there is a performance impact, but
> how much depends on exactly what e.g. the BPF program does.
>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Thanks for working on this.

I like that there is no overhead unless CONFIG_TRACING is set.
However, I think the __mmap_lock_traced_lock and similar functions are
the wrong level of abstraction, especially considering that we are
considering to switch away from using rwsem as the underlying lock
implementation. Would you consider something along the following lines
instead for include/linux/mmap_lock.h ?

#ifdef CONFIG_TRACING

DECLARE_TRACEPOINT(...);

void __mmap_lock_do_trace_start_locking(struct mm_struct *mm, bool write);

static inline void mmap_lock_trace_start_locking(struct mm_struct *mm,
bool write)
{
  if (tracepoint_enabled(mmap_lock_start_locking))
    __mmap_lock_do_trace_start_locking(mm, write);
}

#else

static inline void mmap_lock_trace_start_locking(struct mm_struct *mm,
bool write) {}

#endif

static inline void mmap_write_lock(struct mm_struct *mm)
{
  mmap_lock_trace_start_locking(mm, true);
  down_write(&mm->mmap_lock);
  mmap_lock_trace_acquire_returned(mm, true, true);
}

I think this is more straightforward, and also the
mmap_lock_trace_start_locking and similar functions don't depend on
the underlying lock implementation.

The changes to the other files look fine to me.

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
