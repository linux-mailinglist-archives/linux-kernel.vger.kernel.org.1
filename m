Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5BA2AD0A4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 08:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbgKJHuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 02:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgKJHuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 02:50:46 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3DBC0613D1
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 23:50:46 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id v18so13610249ljc.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 23:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gCQTBISeM8F0h0Qe5RUOEH0sBtlqO623QclFC2nsxbM=;
        b=j9qT/nRdGO3nnRDW7iGdNc4pqWh2epUDkAigs6JLkvBGKQqKlKlx1uy5DCAa8BtAqE
         6n+cKBQ2sw3Dvw/ECqfh7GJNNhLEDLktJAmsPMIG5V6fLxkvGX+CpitK7yoKrdr6LTzj
         0xHA800SbrNv13eMWOfe7GLix1XmJckM8oXYA2aqe4LRAfSGxWbd8qr0NFLIqihQj8Em
         066vvRAlszLeaZhK3oWI12LjpGG9BedizSxIzHm5U+RV+NFoQZhXxze11+tV20Oa0pf7
         TAcf0CpBAMtzVNxaYsnw6WYwU5CaAjYwY0yD0PUAJ47AIAly1PHSZ47Lqxp1NPITAyyi
         4B1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gCQTBISeM8F0h0Qe5RUOEH0sBtlqO623QclFC2nsxbM=;
        b=i+sUS35LknD9q8GJmheb3y0vbTsWqemjlfFy829s1gkLJTKzxqsVhNRAbifvVmpFQU
         amWIgJ8Ztpl9qhS5UdpvFbe7WNfB2yrzmd1vHrcYCuhP1uNRtmYa6WdDMaQWVFt3Zrk3
         RsxMO0RL5OSi8hhWFnfUHqi5xysdjG87UKZD2Caq+2vw20N7mmk0QQiGAI5qVoZz8VaB
         TIyD/c9zi29tt6S4/F2VF/IUQQoCoEA/O/JpGsP0XPfBiwG1NRnvUuB3fqpIs7EhqYR8
         zf+8/znDmUfHvdkt11kUYYQMgEZI1ip8p1KsOTSM9n86vYlHsnXMiO81jNIj47j1COKS
         AyYg==
X-Gm-Message-State: AOAM530tBCVuIMGLkg08hLYph0PrNtLx3EaQJO26QchGTdfh8WN3J726
        JkqHOZTXNXozTUOk3VozS6t4sexa9dxERMInSg/QvQ==
X-Google-Smtp-Source: ABdhPJwLd9+ZEQ4mQ9u87UtljFHUVbkN/PdpWQxxjLpAul19lUOZVQzfA3BUSTP9uFYFLg+PljMSrmDY3dijsMe1BCs=
X-Received: by 2002:a05:651c:30d:: with SMTP id a13mr3887173ljp.386.1604994644397;
 Mon, 09 Nov 2020 23:50:44 -0800 (PST)
MIME-Version: 1.0
References: <20201105170604.6588a06e@canb.auug.org.au>
In-Reply-To: <20201105170604.6588a06e@canb.auug.org.au>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 10 Nov 2020 08:50:33 +0100
Message-ID: <CADYN=9J0DQhizAGB0-jz4HOBBh+05kMBXb4c0cXMS7Qi5NAJiw@mail.gmail.com>
Subject: Re: linux-next: Tree for Nov 5
To:     Stephen Rothwell <sfr@canb.auug.org.au>, glider@google.com,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, jannh@google.com
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Nov 2020 at 07:06, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Changes since 20201104:

When building an arm64 allmodconfig and booting up that in qemu I see

[10011.092394][   T28] task:kworker/0:2     state:D stack:26896 pid:
1840 ppid:     2 flags:0x00000428
[10022.368093][   T28] Workqueue: events toggle_allocation_gate
[10024.827549][   T28] Call trace:
[10027.152494][   T28]  __switch_to+0x1cc/0x1e0
[10031.378073][   T28]  __schedule+0x730/0x800
[10032.164468][   T28]  schedule+0xd8/0x160
[10033.886807][   T28]  toggle_allocation_gate+0x16c/0x220
[10038.477987][   T28]  process_one_work+0x5c0/0x980
[10039.900075][   T28]  worker_thread+0x428/0x720
[10042.782911][   T28]  kthread+0x23c/0x260
[10043.171725][   T28]  ret_from_fork+0x10/0x18
[10046.227741][   T28] INFO: lockdep is turned off.
[10047.732220][   T28] Kernel panic - not syncing: hung_task: blocked tasks
[10047.741785][   T28] CPU: 0 PID: 28 Comm: khungtaskd Tainted: G
  W         5.10.0-rc2-next-20201105-00006-g7af110e4d8ed #1
[10047.755348][   T28] Hardware name: linux,dummy-virt (DT)
[10047.763476][   T28] Call trace:
[10047.769802][   T28]  dump_backtrace+0x0/0x420
[10047.777104][   T28]  show_stack+0x38/0xa0
[10047.784177][   T28]  dump_stack+0x1d4/0x278
[10047.791362][   T28]  panic+0x304/0x5d8
[10047.798202][   T28]  check_hung_uninterruptible_tasks+0x5e4/0x640
[10047.807056][   T28]  watchdog+0x138/0x160
[10047.814140][   T28]  kthread+0x23c/0x260
[10047.821130][   T28]  ret_from_fork+0x10/0x18
[10047.829181][   T28] Kernel Offset: disabled
[10047.836274][   T28] CPU features: 0x0240002,20002004
[10047.844070][   T28] Memory Limit: none
[10047.853599][   T28] ---[ end Kernel panic - not syncing: hung_task:
blocked tasks ]---

if I build with KFENCE=n it boots up eventually, here's my .config file [2].

Any idea what may happen?

it happens on next-20201109 also, but it takes longer until we get the
"Call trace:".

Cheers,
Anders
[1] http://ix.io/2Ddv
[2] https://people.linaro.org/~anders.roxell/allmodconfig-next-20201105.config
