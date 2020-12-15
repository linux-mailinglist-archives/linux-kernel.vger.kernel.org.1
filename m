Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B3C2DA90B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 09:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgLOIPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 03:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgLOIPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 03:15:18 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472D7C06179C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 00:14:38 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id q137so19608036iod.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 00:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tFchL0u2jEFCYTATn+pUbI/NQnw6W0N/56aZSgxn7kU=;
        b=k2ivOXnYC+RLyd6OHVmQLaeez3G4cEftVEl8qsdi2f6OjPkCcQVmWj5yYYTljRlYK2
         m73o0DhcAMED97hq0gBA6spWQ5mAU5cOSiDzjNEnONET0/CJ9Q4drtt/3WX2lhmNQPsM
         KAz+GQlKIxxjKjVfnzFhhvrJIQftBFIPPLoLb52araMA64OZcme1Tq/wPLOg2v7a8suV
         tpPJvLzWKmpsy/QyKUOxEluKe/ngSRPxriD2xL4u/ZmTOu9vf3chD9rYF/uedd5g6mo6
         j7KH680GPoEUAxP70bgcjLnpnv7FhR6P6zmx/Z1LmBpPAQJ/P5txuVXPgnwN+NzgDvtf
         enAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tFchL0u2jEFCYTATn+pUbI/NQnw6W0N/56aZSgxn7kU=;
        b=muoUqYE+IH++AVfRxOGoqmfIcWcw3ZMn/OtsxU2A7L8SbQSXeqKNyWJZcAaqqWgbqt
         locn6uZ/NIU01nF5su/lQz4LqoX2gFX/4Pn/gL5kbR2OgtqWUDxGB2dQuhAwGjICt5eT
         sMXsT//sP8+FSo/MvWXaS89voGnsxTBVVWznxURoSLeGtOgR9IJ2ZgbA909QERAEsgI+
         bIUhYkHQ328Y2RxCk4XCbA37wDJASW49mhfZ7L2IzDaLMbZ81+/OSwW8cc0vwOnZycPP
         SK+vdgm6iw2c8ZyzrUa3CJS+eac+rtEVrRpI2zPBuXcZw9oXvfn6gbefivnNzMBNU/7W
         TcLA==
X-Gm-Message-State: AOAM530+7rmkPDdB6AxbMGwR6Wa+wEqibFxYcTNU63I2NKS1TWL1SaE6
        6/cYcXyHqHIoORr4XZt5rXtDSyL8QbuWAnDkoL4=
X-Google-Smtp-Source: ABdhPJzDa3ilBubActnQDkn0WlvB0j/rgr7LD49UZmZCNNa/zLEyJP3vChkwrucR9TZ6B2X/K97O9umAWY1ZFulENUw=
X-Received: by 2002:a05:6602:388:: with SMTP id f8mr2234073iov.56.1608020077551;
 Tue, 15 Dec 2020 00:14:37 -0800 (PST)
MIME-Version: 1.0
References: <20201214155457.3430-1-jiangshanlai@gmail.com> <X9eirnnrD/+VqqEo@hirez.programming.kicks-ass.net>
 <CAJhGHyDYbU2=dQyiyx-AC+wu9=B7mTvsbU=QYPyV4xTE8PFPog@mail.gmail.com> <20201215075044.GZ3040@hirez.programming.kicks-ass.net>
In-Reply-To: <20201215075044.GZ3040@hirez.programming.kicks-ass.net>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Tue, 15 Dec 2020 16:14:26 +0800
Message-ID: <CAJhGHyA=8vbamdFKwPGFHtL4iObJ929DR+iasVhmODV-u5UNfw@mail.gmail.com>
Subject: Re: [PATCH 00/10] workqueue: break affinity initiatively
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Hillf Danton <hdanton@sina.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 3:50 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Dec 15, 2020 at 01:44:53PM +0800, Lai Jiangshan wrote:
> > I don't know how the scheduler distinguishes all these
> > different cases under the "new assumption".
>
> The special case is:
>
>   (p->flags & PF_KTHREAD) && p->nr_cpus_allowed == 1
>
>

So unbound per-node workers can possibly match this test. So there is code
needed to handle for unbound workers/pools which is done by this patchset.

Is this the code of is_per_cpu_kthread()? I think I should have also
used this function in workqueue and don't break affinity for unbound
workers have more than 1 cpu.
