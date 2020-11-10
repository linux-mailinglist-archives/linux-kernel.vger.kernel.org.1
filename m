Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118962AD265
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 10:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbgKJJZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 04:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729149AbgKJJZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 04:25:16 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639D5C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 01:25:14 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id u18so16477622lfd.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 01:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oB1EvD98yGtMgMToaF8cXp5dTfWo4uYoDDWzcDmuaYE=;
        b=kDp1flA35/wPceVcIHZ+CLVWPG2dcSPmNW1LiWWhELdiO7MyZTWIM0qh7DvPEZ1+aT
         CCW4r3tAUb8GnjeSiQGhkGJodAxumwRLo2uQpCGEVmAYWfeORTU+2aVyiMyL88v97lOw
         jisScqc6bBKJM/N8uLUVoPdqwp/4cISGLcxSTRszqZNpT8FobkZAIp/Boht7k+Lk4CH4
         5jQ3DaNlLQyXlZECUO5v2xxuwCxWdSkGV00myqfKz9jKN+mkRRaFWCYLJsYSR4b6R4AC
         CVt4xsk6o3oLSVdqf2x7D6fQseFNYM4ZE4FtSBXs8fzO16FasoNhZYtdlnpQkqC4f6nj
         ZH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oB1EvD98yGtMgMToaF8cXp5dTfWo4uYoDDWzcDmuaYE=;
        b=cwwYJ0LVbTFSz4i23/boUpn60+ANDGP5EtZdxkeDGNZIgPLY+qKLZf2R56B0gtHZTy
         zFmo2mhKD/IUEiqQ3XfVaNzq/IAv37niCYfObfgaJ8XT7VyJciLvaM5kblGVaz9bM9Ic
         hdy4igh1W0zGshvy+zzSIQDfBgDAEc0RDHbK4cQvoR0MwHOTGnL6DnG0CEFs+kyp7n6a
         vIDB8IVsMtYxPQKVDSQTe3vzN+0b746hdxS9p0VZJCKskhnw35NVTYXqUwuSe3OSOx9c
         KFVTvWw4b+DzYnQoFvzzb0nzvFWItn7Uadot6vCEkCLScmLAh6sy8iZMDGohkhkdUEyC
         0dEg==
X-Gm-Message-State: AOAM532IyXGJsPum++43/mkE8eJEQliRtl0BWoiexWrCdB8ULIe6kl5e
        48egbwYE3D5uKkctfA7wU4u8xPPLspCFjq1zsSBCjw==
X-Google-Smtp-Source: ABdhPJx0U5KC4evBwOS95rEMUCnTL8BYxxni8KZawPPzGycie/xhfizMQjKA+JlZRRZasAnICaTX0VUe4N51HxngBdM=
X-Received: by 2002:a19:fc03:: with SMTP id a3mr5555841lfi.472.1605000312794;
 Tue, 10 Nov 2020 01:25:12 -0800 (PST)
MIME-Version: 1.0
References: <20201105170604.6588a06e@canb.auug.org.au> <CADYN=9J0DQhizAGB0-jz4HOBBh+05kMBXb4c0cXMS7Qi5NAJiw@mail.gmail.com>
 <CACT4Y+ZA5tv4siG7JsXqmrk2J5WOQOtW51g0DPNMPSGHKkixDw@mail.gmail.com>
In-Reply-To: <CACT4Y+ZA5tv4siG7JsXqmrk2J5WOQOtW51g0DPNMPSGHKkixDw@mail.gmail.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 10 Nov 2020 10:25:02 +0100
Message-ID: <CADYN=9K4MY+zfB-0acmOQMyiqFnnt+CqiwZJK=-7ZvvztxdetA@mail.gmail.com>
Subject: Re: linux-next: Tree for Nov 5
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020 at 10:17, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Tue, Nov 10, 2020 at 8:50 AM Anders Roxell <anders.roxell@linaro.org> wrote:
> >
> > On Thu, 5 Nov 2020 at 07:06, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > Hi all,
> > >
> > > Changes since 20201104:
> >
> > When building an arm64 allmodconfig and booting up that in qemu I see
> >
> > [10011.092394][   T28] task:kworker/0:2     state:D stack:26896 pid:
> > 1840 ppid:     2 flags:0x00000428
> > [10022.368093][   T28] Workqueue: events toggle_allocation_gate
> > [10024.827549][   T28] Call trace:
> > [10027.152494][   T28]  __switch_to+0x1cc/0x1e0
> > [10031.378073][   T28]  __schedule+0x730/0x800
> > [10032.164468][   T28]  schedule+0xd8/0x160
> > [10033.886807][   T28]  toggle_allocation_gate+0x16c/0x220
> > [10038.477987][   T28]  process_one_work+0x5c0/0x980
> > [10039.900075][   T28]  worker_thread+0x428/0x720
> > [10042.782911][   T28]  kthread+0x23c/0x260
> > [10043.171725][   T28]  ret_from_fork+0x10/0x18
> > [10046.227741][   T28] INFO: lockdep is turned off.
> > [10047.732220][   T28] Kernel panic - not syncing: hung_task: blocked tasks
> > [10047.741785][   T28] CPU: 0 PID: 28 Comm: khungtaskd Tainted: G
> >   W         5.10.0-rc2-next-20201105-00006-g7af110e4d8ed #1
> > [10047.755348][   T28] Hardware name: linux,dummy-virt (DT)
> > [10047.763476][   T28] Call trace:
> > [10047.769802][   T28]  dump_backtrace+0x0/0x420
> > [10047.777104][   T28]  show_stack+0x38/0xa0
> > [10047.784177][   T28]  dump_stack+0x1d4/0x278
> > [10047.791362][   T28]  panic+0x304/0x5d8
> > [10047.798202][   T28]  check_hung_uninterruptible_tasks+0x5e4/0x640
> > [10047.807056][   T28]  watchdog+0x138/0x160
> > [10047.814140][   T28]  kthread+0x23c/0x260
> > [10047.821130][   T28]  ret_from_fork+0x10/0x18
> > [10047.829181][   T28] Kernel Offset: disabled
> > [10047.836274][   T28] CPU features: 0x0240002,20002004
> > [10047.844070][   T28] Memory Limit: none
> > [10047.853599][   T28] ---[ end Kernel panic - not syncing: hung_task:
> > blocked tasks ]---
> >
> > if I build with KFENCE=n it boots up eventually, here's my .config file [2].
> >
> > Any idea what may happen?
> >
> > it happens on next-20201109 also, but it takes longer until we get the
> > "Call trace:".
> >
> > Cheers,
> > Anders
> > [1] http://ix.io/2Ddv
> > [2] https://people.linaro.org/~anders.roxell/allmodconfig-next-20201105.config
>
> Hi Anders,

Hi Dmitry,

>
> Does it happen during boot or afterwards?

During boot, since it runs a lot of boot selftests.

> 10047 are seconds after boot, right?

No

> So this is like 3 hours after boot, no?

This is a boot log where I actually get to the boot prompt.
https://people.linaro.org/~anders.roxell/output-next-20201109-nokfence.log

> Also, is there anything useful before that part of the log?

oh I missed to say that this is the full boot log with the kernel
panic http://ix.io/2Ddv

Cheers,
Anders
