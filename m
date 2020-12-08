Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD8C2D370A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 00:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731751AbgLHXlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 18:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgLHXlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 18:41:31 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E266C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 15:40:50 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id m13so217463ljo.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 15:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SiRldqdmzeS1Mv5WIXPh/peTbx9BtSi92k54Z67KE4M=;
        b=J8WFN1IBnvwJjf12CXxBMDGUB3Y35X5pWzS6o8L22oagYz7MBuIqKJ8M3+uxSnnwBm
         Qu19kBkNmE+C0LfknE96xiDXXmhtG+u8kyfhxt8dQ593nkLH3ITnJMkIWnK14JzgSBby
         DCJOmGaR1qXvUi9NfH0pd00gvvLN3R8OAMXFHW7RKsD945aTqQzk+FRpyxj5XmZ02K7b
         H0ggvh86gYSgUGmJ/tlOgvZWXLYkifZ+Pjzy8ucCtSVXYw+IQZZRqkNq9yMsqRYHmWYt
         9HJGf1WAYXzgov4yYFec1982+NIcdtZPBf8Sy/LRPsvlZ/P+y8WShE//ElA4TAFmLI+z
         ZzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SiRldqdmzeS1Mv5WIXPh/peTbx9BtSi92k54Z67KE4M=;
        b=mSqk8cYY/nRZxd5RFZLGYEkBCrwQeTmJH1wuB6wfkCa4KOghkv62Et2E3Keman0xL3
         6JAr3t1c32fk/OjDrQSryUx/2iHNx16G9gUUbaRYa7f1Ul69vf/klzFOcr00gnWHjiz+
         DJJ/AJRtQ7QDynevGqpHCaBZ+Xq7dsZgSLCg/GDAeZb7GbMdmNKz2Df7JF8pVdGvA8UB
         UDt/uRwzC9yzeE4e7XveonXcA+rvPWvfIEhyAETgURmkd54b3/kXL9ov/8atZRdEEyuW
         gENlVAGAkf+mzO2c+OSPUsK/NZHJI9kpTwugMtmU+vk/IjNOgwA8j9UEGQXTh+8Fz1u7
         6+Rw==
X-Gm-Message-State: AOAM533Hig/FBt3sYqV4M8wToCpMGqrLO1Bk3gPR8RKyu01Ea+3Iri4C
        FeacOrq7jnVFIU0XrT052qzysiRBz9d5t5xwnPPMTw==
X-Google-Smtp-Source: ABdhPJzMw3FBB9dkB8UpPSjMu0vXES+Fd7QlsOOkEOw3dcInEyxdT6BtmJ4I838fJVgg/iRcwJCA3XFDJD8xaoO+mtg=
X-Received: by 2002:a2e:50c:: with SMTP id 12mr24546ljf.226.1607470848935;
 Tue, 08 Dec 2020 15:40:48 -0800 (PST)
MIME-Version: 1.0
References: <20201124053943.1684874-1-surenb@google.com> <20201124053943.1684874-3-surenb@google.com>
In-Reply-To: <20201124053943.1684874-3-surenb@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 9 Dec 2020 00:40:22 +0100
Message-ID: <CAG48ez1M5tT=4T2RREhs1U3yMJH2N7HPWySBnMJyMSg0WtdD2A@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/madvise: add process_madvise MADV_DONTNEER support
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 6:50 AM Suren Baghdasaryan <surenb@google.com> wrote:
> In modern systems it's not unusual to have a system component monitoring
> memory conditions of the system and tasked with keeping system memory
> pressure under control. One way to accomplish that is to kill
> non-essential processes to free up memory for more important ones.
> Examples of this are Facebook's OOM killer daemon called oomd and
> Android's low memory killer daemon called lmkd.
> For such system component it's important to be able to free memory
> quickly and efficiently. Unfortunately the time process takes to free
> up its memory after receiving a SIGKILL might vary based on the state
> of the process (uninterruptible sleep), size and OPP level of the core
> the process is running.
> In such situation it is desirable to be able to free up the memory of the
> process being killed in a more controlled way.
> Enable MADV_DONTNEED to be used with process_madvise when applied to a
> dying process to reclaim its memory. This would allow userspace system
> components like oomd and lmkd to free memory of the target process in
> a more predictable way.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
[...]
> @@ -1239,6 +1256,23 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
>                 goto release_task;
>         }
>
> +       if (madvise_destructive(behavior)) {
> +               /* Allow destructive madvise only on a dying processes */
> +               if (!signal_group_exit(task->signal)) {
> +                       ret = -EINVAL;
> +                       goto release_mm;
> +               }

Technically Linux allows processes to share mm_struct without being in
the same thread group, so I'm not sure whether this check is good
enough? AFAICS the normal OOM killer deals with this case by letting
__oom_kill_process() always kill all tasks that share the mm_struct.
