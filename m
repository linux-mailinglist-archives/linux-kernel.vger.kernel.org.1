Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43142EA37C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 03:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbhAECym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 21:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbhAECyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 21:54:41 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335A5C061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 18:54:01 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id v3so27309929ilo.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 18:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QX74IH083298QrakUccwmO1Zcui+sRLicgSnpdm7S5g=;
        b=EIIixaxHpiD8z+9zCyaCq9EGSdCnbz6axeRwpIuqb9TwXBvnKbPOVvApO35s6qNoUe
         P742vUhZf2jQlZI5w+bl7t4QBkF1hxifzX+hIp6MPQZ3CqrhwzRLMNFJTrzRIeVy4xHP
         iLyVVPIjG8RT6iJoGUZwi/yDH9uosAKLhF+Z7SS+1HkPNEBLTk5UYcbd6o5UCom7SnkW
         f0zsAGntbL+0fAQdFunwUzmB79JL9WDCWC/QxHUNQTPbXeOjm9Nms7hJz6FypYVfG+U/
         KSXDwQUpblCFXs3fSA0PTks/NmM2TsSPgpK90EyuO3F3bi63+Se13kbxda8zdvTq74GE
         VBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QX74IH083298QrakUccwmO1Zcui+sRLicgSnpdm7S5g=;
        b=WB1JB0kLleB16JFDa5/qcwkcIH3gSrDL7P1WQDGRVdhmyMFvyJWpGqvBwIF4xoF16l
         UZ3X2RvHqXsGNaHeVcQBmZY3180QkAvcBCJPVQrY6/yTRXXQONLXrgndmphFz0jU0yJk
         LroQleI70LxaLWb85DLGTz9r7Mn78xjBFUhnbbi+t/2x+hUeQoY9Nz1b4g84b6gTMy6P
         MOZyqtqtEOICyYgWfTJ9YC85OVHvb2fdnmVj/YGjvu5pcOFI5Q22ZyUGEifty9eXGO1a
         NbqIWlQYMiQbcNCGI3vuXjODaej9hTv/+u3DqW+AyT/LDLPJdNuMVYSTXFCVRUHrXef4
         Bjfg==
X-Gm-Message-State: AOAM531lcX+Fo/TzYQCExAZ23AYuWADBWlzss65mx2gx7uVpg6tD5AeY
        XIh4N+gNOFxaWpekqJtX7c1yLLAdmwPqjeQ2diU=
X-Google-Smtp-Source: ABdhPJwr8mAdNhOQYfye1O7U1M9cZ6URd6vLF3TXjn2+yXD7w5wS9v9fGUe49/bdra1/f9VOtO7iCoMEwEiwsUuh0pc=
X-Received: by 2002:a92:c26d:: with SMTP id h13mr72177335ild.52.1609815240656;
 Mon, 04 Jan 2021 18:54:00 -0800 (PST)
MIME-Version: 1.0
References: <20201226025117.2770-1-jiangshanlai@gmail.com> <20201226025117.2770-4-jiangshanlai@gmail.com>
 <20210104135649.GO3021@hirez.programming.kicks-ass.net> <CAJhGHyB_MUHG8GGANcN9sQbjY7M5m8WPHQgXp-PmkGK481M5Tg@mail.gmail.com>
In-Reply-To: <CAJhGHyB_MUHG8GGANcN9sQbjY7M5m8WPHQgXp-PmkGK481M5Tg@mail.gmail.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Tue, 5 Jan 2021 10:53:49 +0800
Message-ID: <CAJhGHyBc+Fo07=CLLopgcQOyZFKk+vVcxcYkPXSPf3suzRC7ZQ@mail.gmail.com>
Subject: Re: [PATCH -tip V3 3/8] workqueue: introduce wq_online_cpumask
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 10:41 AM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
>
> On Mon, Jan 4, 2021 at 9:56 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Sat, Dec 26, 2020 at 10:51:11AM +0800, Lai Jiangshan wrote:
> > > From: Lai Jiangshan <laijs@linux.alibaba.com>
> > >
> > > wq_online_cpumask is the cached result of cpu_online_mask with the
> > > going-down cpu cleared.
> >
> > You can't use cpu_active_mask ?
>
>
> When a cpu is going out:
> (cpu_active_mask is not protected by workqueue mutexs.)
>
> create_worker() for unbound pool  |  cpu offlining
> check cpu_active_mask             |
>                                   |  remove bit from cpu_active_mask
>                                   |  no cpu in pool->attrs->cpumask is active
> set pool->attrs->cpumask to worker|
> and hit the warning
>
>
> And when a cpu is onlining, there may be some workers which were just created
> after the workqueue hotplug callback is finished but before cpu_active_mask
> was updated. workqueue has not call back after cpu_active_mask updated and
> these workers' cpumask is not updated.
>
> For percpu workers, these problems can be handled with the help of
> POOL_DISASSOCIATED which is protected by workqueue mutexs and the
> help of sched/core.c which doesn't warn when per-cpu-kthread.
>
> For unbound workers, the way to handle it without using wq_online_cpumask
> is much more complex when a cpu is going out.

To have replied too soon, let me think about it again.
