Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF1F204D84
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 11:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732213AbgFWJHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 05:07:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22642 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731973AbgFWJH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 05:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592903246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xUhedPr/j0Zt6HlxSwFeY7buhUrUP8KB8aI1O09bZl0=;
        b=O8JG556fKAX/wHTsqjad+ueQJH1Hsx4eb16YAhn/aP6T+Bku7oyblOzUm0JEKWvGc3FGz5
        V4jtKrEUCgaqgI6z8cNK8lkcBZchlXsh/tA8hB+bfN/yMeelDGHy9z5jKpBSMpCUkAuClI
        LVy/3oIWCXVeJn/4IWk7kX0iufuYvps=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-eZ4iTMOGNsak_3TE5F9RgA-1; Tue, 23 Jun 2020 05:07:24 -0400
X-MC-Unique: eZ4iTMOGNsak_3TE5F9RgA-1
Received: by mail-ed1-f72.google.com with SMTP id z8so9969122edr.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 02:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xUhedPr/j0Zt6HlxSwFeY7buhUrUP8KB8aI1O09bZl0=;
        b=ltcCnGFJ9F7r72MHBBKfUJU+yWS5KGR+7bGgf/eaBWUBlLxW+4OG92oam/IK9VsUtd
         CiQMOzKAnqHQVjPqpTbM6/xc/JV1JjHKYXQjf2PQfld4RXb6RKGZ8/0dJS/4EtfIXJjS
         m4shOeRiv0pSLJSoWtJlB1jSDQPxXiG1F/QjNB2CNufwe8mu/WPfbXVtlN9yFLgdQyZY
         sxKiHZD64nsgUNcM9CDvA1I6iumaaGN7FJLoM1f9tEZur5HuGA/F19DQrHchQcNFLl3E
         K5LNJTBI4aXzzGTNfcrqQvdylvgAlvSt9zWApuVAASjvEjmk+hDrqe2Cokeyv8Qe2M9u
         XJEg==
X-Gm-Message-State: AOAM530g7jSljQoHeAjlRUz0s0qa83pH5NecfXFfCYoXTv0/ujmI77AE
        NdwSMIfCdXKLeL7ihZrDcF4weanLhVYHNPW1Dk6Fe1aGQ0Y6i4a+HFKjWr/JGYaWhuhiD37W690
        ZpWWN1ky2JTC/pX06OLUwTD2x
X-Received: by 2002:a17:907:7283:: with SMTP id dt3mr19954359ejc.195.1592903243232;
        Tue, 23 Jun 2020 02:07:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw972fIHdUzv66dXpLtZVIXmYxb51SJLbr0O/Yf+RV8EuSjV+zcR4Y3hr8taeCbChsNVy6uCg==
X-Received: by 2002:a17:907:7283:: with SMTP id dt3mr19954335ejc.195.1592903242968;
        Tue, 23 Jun 2020 02:07:22 -0700 (PDT)
Received: from localhost ([2001:470:5b39:29:79fc:ff4e:48ab:b845])
        by smtp.gmail.com with ESMTPSA id z1sm13289301eji.92.2020.06.23.02.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 02:07:22 -0700 (PDT)
Date:   Tue, 23 Jun 2020 11:07:21 +0200
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        alexander.h.duyck@linux.intel.com, sj38.park@gmail.com,
        David Rientjes <rientjes@google.com>,
        Arjun Roy <arjunroy@google.com>
Subject: Re: [PATCH v8 0/4]  introduce memory hinting API for external process
Message-ID: <20200623090721.5owt4cxjji6isqe3@butterfly.localdomain>
References: <20200622192900.22757-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622192900.22757-1-minchan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 12:28:56PM -0700, Minchan Kim wrote:
> Now, we have MADV_PAGEOUT and MADV_COLD as madvise hinting API. With that,
> application could give hints to kernel what memory range are preferred to be
> reclaimed. However, in some platform(e.g., Android), the information
> required to make the hinting decision is not known to the app.
> Instead, it is known to a centralized userspace daemon(e.g., ActivityManagerService),
> and that daemon must be able to initiate reclaim on its own without any app
> involvement.
> 
> To solve the concern, this patch introduces new syscall - process_madvise(2).
> Bascially, it's same with madvise(2) syscall but it has some differences.
> 
> 1. It needs pidfd of target process to provide the hint
> 2. It supports only MADV_{COLD|PAGEOUT} at this moment.
>    Other hints in madvise will be opened when there are explicit requests from
>    community to prevent unexpected bugs we couldn't support.
> 3. Only privileged processes can do something for other process's address
>    space.
> 
> For more detail of the new API, please see "mm: introduce external memory hinting API"
> description in this patchset.
> 
> * from v7 -  http://lore.kernel.org/r/20200302193630.68771-1-minchan@kernel.org
>   * dropping pid support from new syscall and fold releated patches into syscall patch
>   * dropping KSM patch by discussion - Oleksandr, I lost the discussion.
>     Please resend the single patch against of the patchset if you resolves the discussion.
>     https://lore.kernel.org/linux-api/20200302193630.68771-8-minchan@kernel.org/

What "next" tag this (v8) submission is based on please?

> * from v6 - https://lore.kernel.org/linux-api/20200219014433.88424-1-minchan@kernel.org/
>   * fix comments and descriptions - Suren
>   * Add Reviewed-by - Suren
>   * fix build break reported by 0-day
> 
> * from v5 - https://lore.kernel.org/linux-mm/20200214170520.160271-1-minchan@kernel.org/
>   * use null task and requestor's mm for io_madvise - Jann and Jens
>   * use right commit description for moving pidfd_get_pid - Christoph
> 
> * from v4 - https://lore.kernel.org/linux-mm/20200212233946.246210-1-minchan@kernel.org/
>   * pass mm down to functions, not accessing task->mm - Jann
>   * clean up - Alexander
>   * add Reviewed-by - Alexander, SeongJae
>   * patch reordering
> 
> * from v3 - https://lore.kernel.org/linux-mm/20200128001641.5086-1-minchan@kernel.org/
>   * verify task->mm aftere access_mm - Oleg
>   * split some patches for easy review - Alexander
>   * clean up fatal signal checking - Suren
> 
> * from v2 - https://lore.kernel.org/linux-mm/20200116235953.163318-1-minchan@kernel.org/
>   * check signal callee and caller to bail out - Kirill Tkhai
>   * put more clarification for justification of new API
> 
> * from v1 - https://lore.kernel.org/linux-mm/20200110213433.94739-1-minchan@kernel.org/
>   * fix syscall number - SeongJae
>   * use get_pid_task - Kirill Tkhai
>   * extend API to support pid as well as pidfd - Kirill Tkhai
> 
> Minchan Kim (4):
>   mm/madvise: pass task and mm to do_madvise
>   pid: move pidfd_get_pid() to pid.c
>   mm/madvise: introduce process_madvise() syscall: an external memory
>     hinting API
>   mm/madvise: check fatal signal pending of target process
> 
>  arch/alpha/kernel/syscalls/syscall.tbl      |   1 +
>  arch/arm/tools/syscall.tbl                  |   1 +
>  arch/arm64/include/asm/unistd.h             |   2 +-
>  arch/arm64/include/asm/unistd32.h           |   2 +
>  arch/ia64/kernel/syscalls/syscall.tbl       |   1 +
>  arch/m68k/kernel/syscalls/syscall.tbl       |   1 +
>  arch/microblaze/kernel/syscalls/syscall.tbl |   1 +
>  arch/mips/kernel/syscalls/syscall_n32.tbl   |   1 +
>  arch/mips/kernel/syscalls/syscall_n64.tbl   |   1 +
>  arch/mips/kernel/syscalls/syscall_o32.tbl   |   1 +
>  arch/parisc/kernel/syscalls/syscall.tbl     |   1 +
>  arch/powerpc/kernel/syscalls/syscall.tbl    |   1 +
>  arch/s390/kernel/syscalls/syscall.tbl       |   1 +
>  arch/sh/kernel/syscalls/syscall.tbl         |   1 +
>  arch/sparc/kernel/syscalls/syscall.tbl      |   1 +
>  arch/x86/entry/syscalls/syscall_32.tbl      |   1 +
>  arch/x86/entry/syscalls/syscall_64.tbl      |   2 +
>  arch/xtensa/kernel/syscalls/syscall.tbl     |   1 +
>  fs/io_uring.c                               |   2 +-
>  include/linux/compat.h                      |   4 +
>  include/linux/mm.h                          |   3 +-
>  include/linux/pid.h                         |   1 +
>  include/linux/syscalls.h                    |   2 +
>  include/uapi/asm-generic/unistd.h           |   4 +-
>  kernel/exit.c                               |  17 --
>  kernel/pid.c                                |  17 ++
>  kernel/sys_ni.c                             |   2 +
>  mm/madvise.c                                | 190 +++++++++++++++++---
>  28 files changed, 217 insertions(+), 46 deletions(-)
> 
> -- 
> 2.27.0.111.gc72c7da667-goog
> 

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Principal Software Maintenance Engineer

