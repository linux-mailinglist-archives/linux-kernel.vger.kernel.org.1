Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6402CE164
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 23:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbgLCWMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 17:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLCWMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 17:12:42 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC48C061A51
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 14:12:02 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id f18so4282539ljg.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 14:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QF1ANqOQBqZLcWlpFbE2WrA4M94QqjKls+F32sntMMY=;
        b=T1kC1Kg7NGIo6tMwYyuuSIkbUM2VuNQz7qLiEEJZtDFibEewJn1anNB9g2y80hPxkX
         iuvhJivzZgd6XEn3oUb3bwhkxuLp8C0ke4zyslQ0f29RT2lbodQCYp6n1erOyIs4LoZy
         EUqgqNTRaA9IbgSoFHG/SrrM2zc5q8yCV93/QpCAmfQCi2kdb6q8EmgwRQYRFCvDvS8t
         Bg2+nLT7Gmk2KOP7TRTnEDvSGvD7h+4Nk1weYi2DWGEOEuqKcxzWnMnngV0S8DBlk/Kk
         ToaYG83BoQojs0cXLtz/RJ3CPGKDOIbfzrgK58ch/RGfQUP/Kdm39CIG8jJOESnFVjs8
         0gIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QF1ANqOQBqZLcWlpFbE2WrA4M94QqjKls+F32sntMMY=;
        b=BL2zW16kmEIPej0dl9OR5cay94wpKEGUe+qpZtihtUP4V4HwFzBle4yTwVs1rvKXuS
         mPPT9BYav2BcEzB/hC4GuEaWE76vx630lca0DYuHd8+uKiJ0n2NO/4MqKSnr+MS/bK/d
         N2wGYmI6lLfl8dYEr1bYmsMEGxvPk03q/kGgNsFVqLvB+/wFHkEklgDeUNAXREMmY6sn
         yH3LHLT0wh/He1ydhV8WStKfqtsYePZ96kOl8foybmQ/w719kpiqZ3xZmdZKE1ynvD5e
         qycrwNjXC37Gk0xUIdANrGPTxxEY1zGiihMHRjft0tPYIQlNZzsq7Ia8XEADEIGa0Cxl
         sDAQ==
X-Gm-Message-State: AOAM533JJmFXD8UalUELQzuasxxGygJzUBgNUsuLjoI9ZgJPgztDlcyI
        IAAh6R1x3aXvJtMRUW8jnWVVSBct/bfouOLjl5TRSA==
X-Google-Smtp-Source: ABdhPJxZcU+lCfn5RqsAVafhGSLZ7zVxw6S18ukw3rg0CDcwpepwRKN8lz8uLajcxg5pr4bmkUNKYM+C/v1mj2n/svs=
X-Received: by 2002:a2e:b16a:: with SMTP id a10mr2083994ljm.446.1607033520505;
 Thu, 03 Dec 2020 14:12:00 -0800 (PST)
MIME-Version: 1.0
References: <20201203220242.158165-1-mike.kravetz@oracle.com>
In-Reply-To: <20201203220242.158165-1-mike.kravetz@oracle.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 3 Dec 2020 14:11:49 -0800
Message-ID: <CALvZod44ZLA8U=ormvuKZhJ1vCJf8qOHMRSouih4E-oaLihV=Q@mail.gmail.com>
Subject: Re: [PATCH] hugetlb_cgroup: fix offline of hugetlb cgroup with reservations
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>,
        Adrian Moreno <amorenoz@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 2:04 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> Adrian Moreno was ruuning a kubernetes 1.19 + containerd/docker workload
> using hugetlbfs.  In this environment the issue is reproduced by:
> 1 - Start a simple pod that uses the recently added HugePages medium
>     feature (pod yaml attached)
> 2 - Start a DPDK app. It doesn't need to run successfully (as in transfer
>     packets) nor interact with real hardware. It seems just initializing
>     the EAL layer (which handles hugepage reservation and locking) is
>     enough to trigger the issue
> 3 - Delete the Pod (or let it "Complete").
>
> This would result in a kworker thread going into a tight loop (top output):
>  1425 root      20   0       0      0      0 R  99.7   0.0   5:22.45
> kworker/28:7+cgroup_destroy
>
> 'perf top -g' reports:
> -   63.28%     0.01%  [kernel]                    [k] worker_thread
>    - 49.97% worker_thread
>       - 52.64% process_one_work
>          - 62.08% css_killed_work_fn
>             - hugetlb_cgroup_css_offline
>                  41.52% _raw_spin_lock
>                - 2.82% _cond_resched
>                     rcu_all_qs
>                  2.66% PageHuge
>       - 0.57% schedule
>          - 0.57% __schedule
>
> We are spinning in the do-while loop in hugetlb_cgroup_css_offline.
> Worse yet, we are holding the master cgroup lock (cgroup_mutex) while
> infinitely spinning.  Little else can be done on the system as the
> cgroup_mutex can not be acquired.
>
> Do note that the issue can be reproduced by simply offlining a hugetlb
> cgroup containing pages with reservation counts.
>
> The loop in hugetlb_cgroup_css_offline is moving page counts from the
> cgroup being offlined to the parent cgroup.  This is done for each hstate,
> and is repeated until hugetlb_cgroup_have_usage returns false.  The routine
> moving counts (hugetlb_cgroup_move_parent) is only moving 'usage' counts.
> The routine hugetlb_cgroup_have_usage is checking for both 'usage' and
> 'reservation' counts.  Discussion about what to do with reservation
> counts when reparenting was discussed here:
>
> https://lore.kernel.org/linux-kselftest/CAHS8izMFAYTgxym-Hzb_JmkTK1N_S9tGN71uS6MFV+R7swYu5A@mail.gmail.com/
>
> The decision was made to leave a zombie cgroup for with reservation
> counts.  Unfortunately, the code checking reservation counts was
> incorrectly added to hugetlb_cgroup_have_usage.
>
> To fix the issue, simply remove the check for reservation counts.  While
> fixing this issue, a related bug in hugetlb_cgroup_css_offline was noticed.
> The hstate index is not reinitialized each time through the do-while loop.
> Fix this as well.
>
> Fixes: 1adc4d419aa2 ("hugetlb_cgroup: add interface for charge/uncharge hugetlb reservations")
> Cc: <stable@vger.kernel.org>
> Reported-by: Adrian Moreno <amorenoz@redhat.com>
> Tested-by: Adrian Moreno <amorenoz@redhat.com>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
