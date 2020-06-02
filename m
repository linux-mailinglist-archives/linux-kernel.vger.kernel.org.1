Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDD41EB28B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 02:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgFBAIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 20:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgFBAIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 20:08:24 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB696C05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 17:08:22 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id d1so11151001ila.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 17:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4qSTDuQ2XQtSmeV/LAPLzj7XvkNy5WwmjK/nnsO0d68=;
        b=J2iW6d8m7Ke7vF+PXKBHA9VTbjuVevS/zdKM3SdveHF6zJhG7nBHrSB0zVIv/z5TQ2
         UEkT2xFBrPBtsl64b+Q627S8U7hst62liGFUsLT/nU/DTSsMuR7yWNTu9Nym/V0bvmB8
         IUqaA9Y9mFXJ+nvmcaDmt8TDrUnOnFpt59mBMg4ZRhMWuJXcQNlj2ikH1Opav1OvyfZd
         dDoNkbZgkFrD8rWUOwtNOsykd5CTx6in4wb7+yBmyT6eHEoBAk3sqsYVe1Pn7XYg9WZy
         zpJM9iVMCV72cVPB1mHejbM6OcUZleTFe661uOuof+9A8bFYWYZVLk2AYnk54GkiDrnx
         Zx2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4qSTDuQ2XQtSmeV/LAPLzj7XvkNy5WwmjK/nnsO0d68=;
        b=hy32/C9NWQ/9jul83zy3cA2Q3eyzyTBfNDpqedTCYWVMVA7izSjk8ks5wc8WSwSYYQ
         GloU89Jm1Nld+Pej9R3JAvOVVtRGRkKTiJqr5Aa26jGI93awChwSN4jSP1WqAGb6N+B4
         NvGUdNaiG+0+7VPKAGl/Xs0uUnADBL1FDMoJ1U++2LVVJhtUZIX4bVCy96MTrTUOIXks
         BnWLtrL73UPoAitOM75mRtLOsU+I5p+fZYbrxmD83He83uCjY4CxFW3c84vX7hglWqnn
         WwronDC0z8qiy1TgQxdFl9sNI2rWBIFWBDU2wHYdTFKJMMyx9war5+oYTM0bCu8tEODi
         IvRQ==
X-Gm-Message-State: AOAM531wmtosBVJlZfFHcnrvhqAEqbtRMm2JblbNmj5VibNsuDi/nCMJ
        AHo8oF4bsgYXN1YG61OGnSeD9VdRQmzu8R0pjUg=
X-Google-Smtp-Source: ABdhPJyqS+O3M3Pro3rZYH2vPxL5H00d5ySdTVr3sGsreIlSo1ji0MrydAbLbOlaLGDfGItxd5l4lqaObINsLcDAxPE=
X-Received: by 2002:a92:d38b:: with SMTP id o11mr22135075ilo.47.1591056502172;
 Mon, 01 Jun 2020 17:08:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200601084442.8284-1-laijs@linux.alibaba.com>
 <20200601084442.8284-5-laijs@linux.alibaba.com> <20200601150723.GA31548@mtj.thefacebook.com>
In-Reply-To: <20200601150723.GA31548@mtj.thefacebook.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Tue, 2 Jun 2020 08:08:10 +0800
Message-ID: <CAJhGHyCn4R-0rv2bDBWuYs1SE0PyJe8GoMEhHo4xwtUy23YpWg@mail.gmail.com>
Subject: Re: [PATCH 4/4] workqueue: slash half memory usage in 32bit system
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 11:07 PM Tejun Heo <tj@kernel.org> wrote:
>
> On Mon, Jun 01, 2020 at 08:44:42AM +0000, Lai Jiangshan wrote:
> > The major memory ussage in workqueue is on the pool_workqueue.
> > The pool_workqueue has alignment requirement which often leads
> > to padding.
> >
> > Reducing the memory usage for the pool_workqueue is valuable.
> >
> > And 32bit system often has less memory, less workqueues,
> > less works, less concurrent flush_workqueue()s, so we can
> > slash the flush color on 32bit system to reduce memory usage
> >
> > Before patch:
> > The sizeof the struct pool_workqueue is 256 bytes,
> > only 136 bytes is in use in 32bit system
> >
> > After patch:
> > The sizeof the struct pool_workqueue is 128 bytes,
> > only 104 bytes is in use in 32bit system, there is still
> > room for future usage.
> >
> > Setting WORK_STRUCT_COLOR_BITS to 3 can't reduce the sizeof
> > the struct pool_workqueue in 64bit system, unless combined
> > with big refactor for unbound pwq.
>
> Have you calculated how much memory is actually saved this way on a typical
> system?

It is not noticable from the "free" command.
By counting the number of allocated pwq (mainly percpu pwq),
it saves 20k in my simple kvm guest (4cpu).
I guess it highly various in different boxes with various
kernel modules loaded.

>
> Thanks.
>
> --
> tejun
