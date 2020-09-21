Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964E527320F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 20:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727475AbgIUSim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 14:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgIUSim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 14:38:42 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8874C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 11:38:41 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id k14so13860994edo.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 11:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C7G6A5IlEG2WC0nmoX7XdAtZ+v2I/zqqDO0euVW1SNE=;
        b=GKj3LJZbIecljJchWIPsVbgqFMg87glRuzFxDZUSnJCVadINrRQoPekzrtKM6pXFG4
         jWmJoGWdPsML6lH9FjKOKPIrPw63/cKOhXUp5e0TPpKeUNin829jFNlYXC5LjVUi7psX
         Q8fipqI46lZkA3SDqje4ta/W4Eh+vI3SKfAi5yGK5526zHVe4lUCgrqmAQiiqMQXKcXP
         2qWHELpxN3jG2I/YmRVE/92CZfYkjr2vDdMUrejhZq+rTTRxVVnar1vEZXkj/I4Nld8N
         b5fF2BDFiRGJmzlxKgzu9iX8XLxJoLdMWZl0/TkOILYMjMeMo1Mmy0vuKiMc4RKUduOk
         a9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C7G6A5IlEG2WC0nmoX7XdAtZ+v2I/zqqDO0euVW1SNE=;
        b=MbHILcZ5n+jRSfvrGWWjFCNM+YQSqqASrP08FJS/Xw3NyS61pxFTy5XBd7UmLP7qLY
         8kHTcKVcVSdtDpsVofAZAHkCqqeTtrR6UwJ2JjoayCa/NcMzyTDRNhmCCoIE/ra9MtxH
         v3xAauXMXaopN5yeDvPCk00PBmtBqz7s0FKGuu6OWD/e7wvsjfC9G/IRmq0uRtEB8zV3
         T5LCBMbVuIdIT+A4ZUa+JDJsiIUwvFb1z4Gay6MrcrRJaP6oPCS8+Hr8RamSSuzk+QPI
         3G9YonaU0HJfDoLRzyxnbh82edn3zzJzWRxpkbQRv7rnT38a3bkfWURYNFWBBXHwudvE
         m1mA==
X-Gm-Message-State: AOAM531rbjy7M9DEZ9HwRvwVtzUOA6NHFUkkhRZiJecA9taTL/hKNjBu
        gbVq5fAPXYq8ELOeamKE5HXJi12ZYRyIMYk9uijMtg==
X-Google-Smtp-Source: ABdhPJw1S/OudX6ksjY6lypppCEWZ0hIJHznPBazJowA/vFH3Ctsk57UwDR5UNDwwwTnZIA6s/67nZwO+5kWeI/4UA0=
X-Received: by 2002:a05:6402:176c:: with SMTP id da12mr281928edb.386.1600713520102;
 Mon, 21 Sep 2020 11:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600661418.git.yifeifz2@illinois.edu> <6af89348c08a4820039e614a090d35aa1583acff.1600661419.git.yifeifz2@illinois.edu>
 <CAG48ez0OqZavgm0BkGjCAJUr5UfRgbeCbmLOZFJ=Rj46COcN3Q@mail.gmail.com>
In-Reply-To: <CAG48ez0OqZavgm0BkGjCAJUr5UfRgbeCbmLOZFJ=Rj46COcN3Q@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 21 Sep 2020 20:38:11 +0200
Message-ID: <CAG48ez0gBRvTEXX_L3881jQM8Aw6SURbMPafW18GihWe4ZmtmQ@mail.gmail.com>
Subject: Re: [RFC PATCH seccomp 1/2] seccomp/cache: Add "emulator" to check if
 filter is arg-dependent
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Valentin Rothberg <vrothber@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 7:47 PM Jann Horn <jannh@google.com> wrote:
> On Mon, Sep 21, 2020 at 7:35 AM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> > SECCOMP_CACHE_NR_ONLY will only operate on syscalls that do not
> > access any syscall arguments or instruction pointer. To facilitate
> > this we need a static analyser to know whether a filter will
> > access. This is implemented here with a pseudo-emulator, and
> > stored in a per-filter bitmap. Each seccomp cBPF instruction,
> > aside from ALU (which should rarely be used in seccomp), gets a
> > naive best-effort emulation for each syscall number.
> >
> > The emulator works by following all possible (without SAT solving)
> > paths the filter can take. Every cBPF register / memory position
> > records whether that is a constant, and of so, the value of the
> > constant. Loading from struct seccomp_data is considered constant
> > if it is a syscall number, else it is an unknown. For each
> > conditional jump, if the both arguments can be resolved to a
> > constant, the jump is followed after computing the result of the
> > condition; else both directions are followed, by pushing one of
> > the next states to a linked list of next states to process. We
> > keep a finite number of pending states to process.
>
> Is this actually necessary, or can we just bail out on any branch that
> we can't statically resolve?

Aaaah, now I get what's going on. You statically compute a bitmask
that says whether a given syscall number always has a fixed result
*per architecture number*, and then use that later to decide whether
results can be cached for the combination of a specific seccomp filter
and a specific architecture number. Which mostly works, except that it
means you end up with weird per-thread caches and you get interference
between ABIs (so if a process e.g. filters the argument numbers for
syscall 123 in ABI 1, the results for syscall 123 in ABI 2 also can't
be cached).

Anyway, even though this works, I think it's the wrong way to go about it.
