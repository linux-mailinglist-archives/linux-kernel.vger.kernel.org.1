Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776492E6F95
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 11:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgL2KN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 05:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgL2KNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 05:13:55 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF99C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 02:13:14 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id r9so11677371ioo.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 02:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nxxJyUupuOipVqoTejX62ILCfA+vlGogryHhEKFbgXA=;
        b=t1vAvkOIrQvUJghsdAHef/mFBJZBONF/ibczwETWJLN3/kF4IfMjuQOCHJHekhrkIi
         xOzlmW8/H8d78dMmVRhZYAXF3TUEx3AcYZ7b7oBFfrgOXg2ddz2HMnaeJB7Yb+UiyqUY
         hGlKOfLSJh7Ty+pNEnOLdUhEgsJB6Pqw/6vFH6mA5QKwncUrcArrSGO3h5AMPT9muhUh
         4nheWbatKfjfbHuUglzEGy56676J/tAprsaa92Jo2OUdRkD+jjDE/8ajnX6KaCtiPGSI
         nLUzD1VnQMcUUWcEIWdHg/eGaaxCfy+RPQj3yLRfL9CR632O7ekqqSmcHLnf6HxwN6Pz
         bv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nxxJyUupuOipVqoTejX62ILCfA+vlGogryHhEKFbgXA=;
        b=T7qBUZgxU/tGDuresCbjQ8fs6gEOiup7KtpTrP4y+dQkFfGrO2do3pW3mZ7jOZfEHl
         p6Beg+FyNoPQ/EbHA7e72GUPnvU0pwNvDztQo/P0rD0WNoxv26aL8ln4YSvrqnaWSQbE
         Fdw27Z19Vbf/pZZhjwsK9eqep7gNcgkZl1VXtj6MuN3Owc1O2SFZxEfhIdTdhVLi1/q9
         rcYBCUHOwcJmGXsj71uMXoawHe1JzvbOx3ZKpCZN5+qeiGBcjK5bNoIWzC7b10hXY+Sf
         d6bQUiJgv3FZWIMNWj6LI10wma3Mo7WcYjburVPuGk7UEYGl0FKhRNGqoJaxj6Cg7wAg
         FI6g==
X-Gm-Message-State: AOAM531jIoA+YNzQdqdGgPkxuayR+y7yyE83U5kh3oqJ2f1cgedbVUnf
        LFYQ1kKnBqTCpHrcZ3lZ5cNiM2yManyGkGiK+jM=
X-Google-Smtp-Source: ABdhPJwlTBEKPyfmkrUYRDeAWuKw00YOIdDpHcmwcJ7RJfKRylbhO8ivnv06n3ne9ROff/Vi0IXpYin2XPt4EPlRc0A=
X-Received: by 2002:a02:2444:: with SMTP id q4mr42147387jae.43.1609236793860;
 Tue, 29 Dec 2020 02:13:13 -0800 (PST)
MIME-Version: 1.0
References: <20201226025117.2770-1-jiangshanlai@gmail.com> <20201226025117.2770-9-jiangshanlai@gmail.com>
 <20201229100639.2086-1-hdanton@sina.com>
In-Reply-To: <20201229100639.2086-1-hdanton@sina.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Tue, 29 Dec 2020 18:13:03 +0800
Message-ID: <CAJhGHyCvnj1w=yO45_HxD8dgy=Xa1vUw9wsnJKtfDX2Jkm5FsQ@mail.gmail.com>
Subject: Re: [PATCH -tip V3 8/8] workqueue: Fix affinity of kworkers when
 attaching into pool
To:     Hillf Danton <hdanton@sina.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 6:06 PM Hillf Danton <hdanton@sina.com> wrote:
>
> On Sat, 26 Dec 2020 10:51:16 +0800
> > From: Lai Jiangshan <laijs@linux.alibaba.com>
> >
> > When worker_attach_to_pool() is called, we should not put the workers
> > to pool->attrs->cpumask when there is not CPU online in it.
> >
> > We have to use wq_online_cpumask in worker_attach_to_pool() to check
> > if pool->attrs->cpumask is valid rather than cpu_online_mask or
> > cpu_active_mask due to gaps between stages in cpu hot[un]plug.
>
> In 5/8 pool->attrs->cpumask is not restored to avoid triggering
> the warning added in e9d867a67fd03ccc ("sched: Allow
> per-cpu kernel threads to run on online && !active"), is it likely
> needed to repeat that trick here?
> Is the above gap no longer existing here at the presence of
> wq_online_cpumask?

It still exists. When online, wq_online_cpumask is always
cpu_online_mask, no thing changed.

An alternative way is to move the code into a work item, which adds
the proper protection against cpu hotlug and does the work.

I don't want to add too much complex in this patchset.
