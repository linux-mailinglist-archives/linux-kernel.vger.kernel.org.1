Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D48273617
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 00:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbgIUW61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 18:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728662AbgIUW6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 18:58:25 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA51C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 15:58:25 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id l17so14353891edq.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 15:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F406dxOGL4KIyo3r913T2qYQFJYxNBYaxUNYOkHvtJo=;
        b=LOgAOhIuOtK3NEGs5lfUfr3Z1we8cm+fSTqcM/nC5XdWVc8G8zUtABSkKkmAQ52+H1
         1c+W8yeUe6zOPyRAQkzv3YmZ68wzpCBSZbYpsAWqo96ic0X65rNdGYH8LmIb255U+BxI
         AcFVi2WBYPbN5eWFHSV+GoQejC0hhUjgTozpchXclGf2pMYARIw5Nn8kswl3yTi8QH3C
         /ZfNRcxgNstUkYZjsvuhuq1/CuGAyIibmjz/JC+desNVgZG3j59Jh+dsDzUufv5E4g2T
         7ubxNAIyknRIdYm8G4IcLOiL79DsMCINz7MAtuidpGEXowsl8CAhQTvDIVfsZbFNiQOz
         m26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F406dxOGL4KIyo3r913T2qYQFJYxNBYaxUNYOkHvtJo=;
        b=mJCugIBkMA5wZ6i9rLEXGehtGDpySvoIWjeJ0wYNSvf3f1FftnumoIZTBmtnHONiWU
         js3x5Sqp5EjXNtxzatGoocBJXczj35a/yw3LGMS7O0Abowdrxn76ehal8UQGwq5H+gE6
         PM4Q2OKLmq8KrLjBm/lHVIZTsM7dPCitsWw2ZqCivwkdTqyYvVMgzSgBkRvyZ7fxDWZJ
         OHXBNyhhafIdq7HO3iBlH488jRFsQom6O5MHUF7HcbF9AT7bvNjdMghEwCuJ62+QSpWU
         09Q9Qi0wS4TAfUOCVYlIngdj/eDgvFiReNbTsbZLo6DSB8jEFm1ndncYzZgKn1Gv5IRv
         vb5g==
X-Gm-Message-State: AOAM530aq6k/+SU+uRVp+z1dIJYbzO3ulQRszhNYH6pqEjsN4Oe+qoaW
        rlLNCMaJ2KieXQjJOpsyWj5oQfGqGSIyN++zLB9g4A==
X-Google-Smtp-Source: ABdhPJzKQ8pt68rKwhcn6462p221HnYSc7PT1gfTLQQr7Dyyt5sp+3GSHllwhbLNcRdd6ZR5P19GP5X7qwPc+u0bf/A=
X-Received: by 2002:a05:6402:cba:: with SMTP id cn26mr1188410edb.230.1600729104142;
 Mon, 21 Sep 2020 15:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600661418.git.yifeifz2@illinois.edu> <b792335294ee5598d0fb42702a49becbce2f925f.1600661419.git.yifeifz2@illinois.edu>
 <CAG48ez3k0_7Vev_O=uV_WVuUGK6BPA0RyrYXMYSDV4DTMMe26g@mail.gmail.com> <CABqSeAROcwq0ZGzWaxyPm+LDHu6T_8CD7_1c-hdhaMikr_ECCA@mail.gmail.com>
In-Reply-To: <CABqSeAROcwq0ZGzWaxyPm+LDHu6T_8CD7_1c-hdhaMikr_ECCA@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 22 Sep 2020 00:57:58 +0200
Message-ID: <CAG48ez2HytqFaJ6V9iA6YZrbZU3kG4bB7nETMfHPt0-wd5D1jg@mail.gmail.com>
Subject: Re: [RFC PATCH seccomp 2/2] seccomp/cache: Cache filter results that
 allow syscalls
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

On Tue, Sep 22, 2020 at 12:51 AM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> On Mon, Sep 21, 2020 at 1:09 PM Jann Horn <jannh@google.com> wrote:
> >
> > On Mon, Sep 21, 2020 at 7:35 AM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> > [...]
> > > We do this by creating a per-task bitmap of permitted syscalls.
> > > If seccomp filter is invoked we check if it is cached and if so
> > > directly return allow. Else we call into the cBPF filter, and if
> > > the result is an allow then we cache the results.
> >
> > What? Why? We already have code to statically evaluate the filter for
> > all syscall numbers. We should be using the results of that instead of
> > re-running the filter and separately caching the results.
> >
> > > The cache is per-task
> >
> > Please don't. The static results are per-filter, so the bitmask(s)
> > should also be per-filter and immutable.
>
> I do agree that an immutable bitmask is faster and easier to reason
> about its correctness. However, I did not find the "code to statically
> evaluate the filter for all syscall numbers" while reading seccomp.c.
> Would you give me a pointer to that and I will see how to best make
> use of it?

I'm talking about the code you're adding in the other patch ("[RFC
PATCH seccomp 1/2] seccomp/cache: Add "emulator" to check if filter is
arg-dependent"). Sorry, that was a bit unclear.
