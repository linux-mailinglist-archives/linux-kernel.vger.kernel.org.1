Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9DC289AAC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 23:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391635AbgJIVbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 17:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391615AbgJIVaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 17:30:55 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B3FC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 14:30:54 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id l16so10905548eds.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 14:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CSRAHb/axz17M+0sWNwy+ixadRZAMXlB5z5CiZ4OuV8=;
        b=HY0u+kX5HLC2Qd/hrbktWnWpqOSCxBXT3upvUFDtjn+PQwxihMAxO7b17zrilGpniu
         Z/H4JmecauoImC4n6z/XuMGPe9m/fKvi3HUsIaSIN5Vh0h9oJizzFej6p8VupLfSBpv1
         1DxoGx28bnw9wjP3qaVpNc+QqlJxc/NVthbUpnHP6rzn4hxdW9x4BmvgBCkwRxaV4uG3
         TvIrmUEl3tqjzHanRb36NzEAD3F/TD94mNKCpByd9hMTqtXQEnSbVMIkAALhyvoRTHJD
         dVE++0gF0w5nI42UG8NH4b76H/O3FzWMQwcPWdDfcJxiVuoQxs7pfn6hdE4zvJQarNUM
         +JGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CSRAHb/axz17M+0sWNwy+ixadRZAMXlB5z5CiZ4OuV8=;
        b=JdfNimV8XcygXAbBCHst80NIZ9lHHI6k85BEwwxfwlLYYM/rffJ9Ib5oRpsEe7Y5NI
         KU+H70sw45gKj9DvA6jHnXhZG7Wl31kwRrg5hZnQbJvPkC3YvwWemd5at8bWHGw2lBFC
         y/+txNomKfg/0qYbAgPqOP1lcHeAH1agThOQ4eSG1cbfeDsQ7bJrilM7Cv8AqCd2Gjfz
         jm07znFKKRE+/Hm0iYUFf+9K7FzStMs/KghPoJb3ZQ+j2jw3E8mgiTpkoHROAOQLw5QY
         K2tylVMG3IGj5TzBoYLxmJVnOEBSiqyoY89WjDeBFGklirCBg8TpPqzqEx6bGTxQXOGa
         qsog==
X-Gm-Message-State: AOAM530D4MHWxxWeOLTW5aamZXBGmLOxKs/p5SnOinyUL2/lf7DHl/aS
        T8Wqe5K1kYZZhC3TkF88bezY4/wPt6GGGT8lu8dLdQ==
X-Google-Smtp-Source: ABdhPJwkUG0xCEADMm4ps+nqQrIgOFcSR9FQBEPfpbKQHQBKUjESr+d/BbjnWhkO3OcRNdTt+3fk/bliCilbZoaGIB8=
X-Received: by 2002:a05:6402:32f:: with SMTP id q15mr1339366edw.230.1602279053404;
 Fri, 09 Oct 2020 14:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602263422.git.yifeifz2@illinois.edu> <896cd9de97318d20c25edb1297db8c65e1cfdf84.1602263422.git.yifeifz2@illinois.edu>
In-Reply-To: <896cd9de97318d20c25edb1297db8c65e1cfdf84.1602263422.git.yifeifz2@illinois.edu>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 9 Oct 2020 23:30:27 +0200
Message-ID: <CAG48ez3KEp2BNcDatRu1V0G-H7hUCF66HJ0BPf0uqTnK3toY4Q@mail.gmail.com>
Subject: Re: [PATCH v4 seccomp 1/5] seccomp/cache: Lookup syscall allowlist
 bitmap for fast path
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 9, 2020 at 7:15 PM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> The overhead of running Seccomp filters has been part of some past
> discussions [1][2][3]. Oftentimes, the filters have a large number
> of instructions that check syscall numbers one by one and jump based
> on that. Some users chain BPF filters which further enlarge the
> overhead. A recent work [6] comprehensively measures the Seccomp
> overhead and shows that the overhead is non-negligible and has a
> non-trivial impact on application performance.
>
> We observed some common filters, such as docker's [4] or
> systemd's [5], will make most decisions based only on the syscall
> numbers, and as past discussions considered, a bitmap where each bit
> represents a syscall makes most sense for these filters.
>
> The fast (common) path for seccomp should be that the filter permits
> the syscall to pass through, and failing seccomp is expected to be
> an exceptional case; it is not expected for userspace to call a
> denylisted syscall over and over.
>
> When it can be concluded that an allow must occur for the given
> architecture and syscall pair (this determination is introduced in
> the next commit), seccomp will immediately allow the syscall,
> bypassing further BPF execution.
>
> Each architecture number has its own bitmap. The architecture
> number in seccomp_data is checked against the defined architecture
> number constant before proceeding to test the bit against the
> bitmap with the syscall number as the index of the bit in the
> bitmap, and if the bit is set, seccomp returns allow. The bitmaps
> are all clear in this patch and will be initialized in the next
> commit.
[...]
> Co-developed-by: Dimitrios Skarlatos <dskarlat@cs.cmu.edu>
> Signed-off-by: Dimitrios Skarlatos <dskarlat@cs.cmu.edu>
> Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>

Reviewed-by: Jann Horn <jannh@google.com>
