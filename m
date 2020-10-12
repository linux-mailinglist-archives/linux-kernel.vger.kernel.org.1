Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D45D28AE6A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 08:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgJLGu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 02:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgJLGuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 02:50:24 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6A8C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 23:50:24 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id qp15so21648780ejb.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 23:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vioP1tNDAwc//TCk7A/UlbXm8YsyMW81aBUSwcUWM5M=;
        b=O+439ox2/Jk704Wg3CCUuHHBA7dCtS4tZf+rbJq812ZTK0+aViDD/HY0/QxPd0NQUF
         ngHa2P6lniSz1x39IKz9kkJx3LLfC44s2/JJskJsdLcsascUYtB8fvFbW2NUKmgYpA5Q
         qL9WLDhxkbA2zZxRNrznWAIqkL2ei6gdtH+l382VbGUXGyDlZfX1JuQlmj8y4p6Pv7Ya
         PCb7RLzFG3YZKtxf36SIr0kXRSp+EPs53UzJcQpDQjjPS1FfrR29JMJjOQ8qQg6Vn8KF
         8bEv0NFsREh+8yHvWjRy47WCNFi88C5LcrjZPuN4J2StRjzSrBdFLJaQj2bNrzV9tws4
         /EJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vioP1tNDAwc//TCk7A/UlbXm8YsyMW81aBUSwcUWM5M=;
        b=Fh1QaXn+C+n8AvFawJ6OjIgkc7gqO3lZIrXxdedWBdHPUA9uTFUZmFi9386f6DuhsC
         4RGC2Jtz5eghrVYUjT6No1cLUJE3BacGeIEg6ySm4eEwmdXOqeRfy/az49aMmipURbsg
         Y6HxVqpA3Xwd10c1OE2C7rAKEG3A9Q8Ho8Lwhh2RDcOXAzlYpBm2dd/kTQ7prDUuo6YZ
         xFHj/Ki4gw5gXuJQEAqjxcWvROjS3A9PVAJYtjDdd6KZUSkl3BE/bl7QehKPk+ZM+63H
         SwafW3baEHDRaYdRyuph3siFTkgAUaqB/6k/kSRUtRSJL0+U+YS51ZgNachmsK/IFrwi
         JEsQ==
X-Gm-Message-State: AOAM530ByntwrVJRHJwMujE/UyhaJ5TphxM2N6xi91ypYrhH4I/iSTwW
        VSW2L2VtHT0cbK9OtuHDSm3TUdsN2SK8f/K7jF5euQ==
X-Google-Smtp-Source: ABdhPJzYaWjiwBqQdkgZXF5RmmS6lKqELWb+eu4uskyaPAI9Y5OYW6sBjC5cuQA2JEIpD6mhLt5FrKCkzBDIlZmzlPM=
X-Received: by 2002:a17:906:c0d1:: with SMTP id bn17mr15283227ejb.114.1602485422519;
 Sun, 11 Oct 2020 23:50:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602431034.git.yifeifz2@illinois.edu> <4706b0ff81f28b498c9012fd3517fe88319e7c42.1602431034.git.yifeifz2@illinois.edu>
In-Reply-To: <4706b0ff81f28b498c9012fd3517fe88319e7c42.1602431034.git.yifeifz2@illinois.edu>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 12 Oct 2020 08:49:56 +0200
Message-ID: <CAG48ez2rutKsgpvYeN+TqmhkJe4U7Sxr0oqyrjhUQaePGZg4uA@mail.gmail.com>
Subject: Re: [PATCH v5 seccomp 5/5] seccomp/cache: Report cache data through /proc/pid/seccomp_cache
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

On Sun, Oct 11, 2020 at 5:48 PM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> Currently the kernel does not provide an infrastructure to translate
> architecture numbers to a human-readable name. Translating syscall
> numbers to syscall names is possible through FTRACE_SYSCALL
> infrastructure but it does not provide support for compat syscalls.
>
> This will create a file for each PID as /proc/pid/seccomp_cache.
> The file will be empty when no seccomp filters are loaded, or be
> in the format of:
> <arch name> <decimal syscall number> <ALLOW | FILTER>
> where ALLOW means the cache is guaranteed to allow the syscall,
> and filter means the cache will pass the syscall to the BPF filter.
>
> For the docker default profile on x86_64 it looks like:
> x86_64 0 ALLOW
> x86_64 1 ALLOW
> x86_64 2 ALLOW
> x86_64 3 ALLOW
> [...]
> x86_64 132 ALLOW
> x86_64 133 ALLOW
> x86_64 134 FILTER
> x86_64 135 FILTER
> x86_64 136 FILTER
> x86_64 137 ALLOW
> x86_64 138 ALLOW
> x86_64 139 FILTER
> x86_64 140 ALLOW
> x86_64 141 ALLOW
> [...]
>
> This file is guarded by CONFIG_SECCOMP_CACHE_DEBUG with a default
> of N because I think certain users of seccomp might not want the
> application to know which syscalls are definitely usable. For
> the same reason, it is also guarded by CAP_SYS_ADMIN.
>
> Suggested-by: Jann Horn <jannh@google.com>
> Link: https://lore.kernel.org/lkml/CAG48ez3Ofqp4crXGksLmZY6=fGrF_tWyUCg7PBkAetvbbOPeOA@mail.gmail.com/
> Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>

Reviewed-by: Jann Horn <jannh@google.com>
