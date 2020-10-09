Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E95A289BCA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 00:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389849AbgJIWfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 18:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388159AbgJIWfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 18:35:14 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C069C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 15:35:14 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id 67so8386966ybt.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 15:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NP7EwU7Wgi3GKoYOtUC4dl2ophm6HoyRW7fEMUmtnzE=;
        b=eyqAmq06cVJmWm0yKH3E9VMKkdcgK7AyWyd8HtlTQFmYC7LBk5vqu+65udfdzcbc0o
         xKoChhK97kDIGyS7uDQdmmBmsCwzGM/yUwm2tW/MjiNsMn4vaw3N6hNtqg6NTMLZwhTx
         gP2aiGWkl4IyhBcuRl4kfsbflrfzSbO+xE+GVdm4EJjb0ZECJfrm7U6F5FU42BT9rlQs
         82NrHN2FutgMXRwfD4J9Bnuw33PjQp2Xi3HaQnKYJUOjNbawMeUYOKdHW/almm4UIpNn
         kXVlVkRW/1pt0cRxB2al7trPI6n+rmfIZ5scYeJM/JMtR+w67Kkp/Xu8WFqq5oX4F1Q8
         Wf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NP7EwU7Wgi3GKoYOtUC4dl2ophm6HoyRW7fEMUmtnzE=;
        b=ogexVnOabbVngsEPbeXPk3wCZH/A5bnOvmeJXsyaXBn1kfZWN6TG5QjOOcAyeflESk
         InmA9CvWb5RfYZrWPVeF94GhSNoxMPIvTBX6b7d9ztc8KNW41M8V+SwY5/jDwnsfMq0B
         vwsJbEA9i991tBrwOhSICEOp+0MiD76Y5LTyl8q/iLaOElbodfJzHqPCeRxJluiqKQbk
         I3v21eFV4t/coRyA36kM9I3MdsGRvD0eoN+Zcp6DskvcWbQf2615P7RP4vG9w+JgA9jP
         BuN+AjgqGsRdnD0Or6IKCTGeXfbEJXF5MO2YaSwzaf+FLDvjWfdltquDiXQqMmbyW9pc
         P0mw==
X-Gm-Message-State: AOAM533p9uRl1d5S3fRtsSt3zFGo3J6391fuquQl8ZOtArIHi+OnY0r8
        Ly2RnqBI1B7lEpBFI5fVbtrVNzBN9gxdnXYD18b2fg==
X-Google-Smtp-Source: ABdhPJxzMYgtqhmZms+YU3oGvBBYXC5cxhBblMlch2sRtV/6PrjBZdx9b38bkVO0mi4OljexEeEtF7jucz7wXQyAWGc=
X-Received: by 2002:a5b:d51:: with SMTP id f17mr18525307ybr.298.1602282913113;
 Fri, 09 Oct 2020 15:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <20201009220524.485102-1-axelrasmussen@google.com> <20201009220524.485102-3-axelrasmussen@google.com>
In-Reply-To: <20201009220524.485102-3-axelrasmussen@google.com>
From:   Michel Lespinasse <walken@google.com>
Date:   Fri, 9 Oct 2020 15:35:00 -0700
Message-ID: <CANN689FYh6Uv+STH6f0oNHDwPdtg1etO8WM8GygFW55zH+ZrQQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mmap_lock: add tracepoints around lock acquisition
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

On Fri, Oct 9, 2020 at 3:05 PM Axel Rasmussen <axelrasmussen@google.com> wrote:
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

Reviewed-by: Michel Lespinasse <walken@google.com>

Looks good to me, thanks!
