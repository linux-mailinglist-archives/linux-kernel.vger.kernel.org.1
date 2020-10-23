Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68ACA2972C2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 17:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751044AbgJWPq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 11:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2902464AbgJWPq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 11:46:28 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78585C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 08:46:28 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id f21so1542040qko.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 08:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p9SFHHcOJsampx1Cl5KD5pxmm62xezQzkl2AgXwIg08=;
        b=nMYtmfd7Kd0yx5RlvYYLzj90UoXDci6rmRFq7EPOhF/dJ2LTfSJHSEkkB+1OSlNe+w
         GiqkvSr1GKKUiy4PC53Tq4qvdqDZ/pev7wi/gB2rav3NCiDDuTIEcQ2FHfFIzGBIbirm
         kbjdDjXHa8ed6K9qDRZ/mpdAhJ8cjKXgfPV66k7KSWtrPTx9z8iX4xcaOPJCp06KUevt
         ze/AJxkW/LqTiLVjD3Lqxgx8nyU4cByWSskhBd3vfPkjlE9YgVAPnHoA4R1kCoM2Rcj+
         BPBPV1UpX1SuDfLGu0eZSDNPNp3aM+tVNH+5rjnDPzwhm+lfy3ZcUwh1euuv8lXaVbqP
         eSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p9SFHHcOJsampx1Cl5KD5pxmm62xezQzkl2AgXwIg08=;
        b=AUylBWm+3VRPJiz2Et/+EK1p3OK0K0Yvp4DPXwZNXbII+TJWFYR6XNYWu9N1q2kZ41
         SvYfzeBF1Pw5SZ3tMcfmipAagJxK0MFIkHBjTrx01D68CBl7WjgFSuzXqgmQT9ttTIHR
         h+ZCaZ2HForAWAU1cYx6bWrz6SlSQDtIOj45Cnr0tXZNj9A+c7CTGGGEFPOJybKh4r/L
         KoSNMzFzkkoIQ4QMOSwabvAl3sG2pm/VEQSslFWT5QcUszQQJGEv8FGT7b/izePvXNk5
         7J4PozpXK8Xmfl9JTIMtgFIbAIl9O2aC9OY1X8oopRs/A7EHJHqSXMkqRZB8cteLPmTW
         1QPQ==
X-Gm-Message-State: AOAM531RbMlhr52vrBz4aWAcP1lCyxxK+kyHW0Q+lL3KSFjW2PzYplHL
        9glMVBYXGrGMwaN8H+gVdyHbXQ==
X-Google-Smtp-Source: ABdhPJwtvG2d9rSTATn31XuUhkceHwaPagnD81bc37HcvcRtjxv7m8kqirsNscOdOjRY92diI2gYow==
X-Received: by 2002:a05:620a:a41:: with SMTP id j1mr2893258qka.426.1603467987657;
        Fri, 23 Oct 2020 08:46:27 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:c400])
        by smtp.gmail.com with ESMTPSA id t12sm942096qkg.132.2020.10.23.08.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 08:46:26 -0700 (PDT)
Date:   Fri, 23 Oct 2020 11:44:47 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Richard Palethorpe <rpalethorpe@suse.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4] mm: memcg/slab: Stop reparented obj_cgroups from
 charging root
Message-ID: <20201023154447.GA535375@cmpxchg.org>
References: <87sga6vizp.fsf@suse.de>
 <20201022122858.8638-1-rpalethorpe@suse.com>
 <CALvZod4u79DSwyM=Kg8g5tR1L5eomHgUkaJmp6s9D3jC7OnN0A@mail.gmail.com>
 <20201022172508.GF300658@carbon.dhcp.thefacebook.com>
 <CALvZod5p-O72gCY-R+oLcDZjEkPRioz7e7p5Jg=nXxhmtiwKWw@mail.gmail.com>
 <20201023004026.GG300658@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023004026.GG300658@carbon.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 05:40:26PM -0700, Roman Gushchin wrote:
> From 19d66695f0ef1bf1ef7c51073ab91d67daa91362 Mon Sep 17 00:00:00 2001
> From: Roman Gushchin <guro@fb.com>
> Date: Thu, 22 Oct 2020 17:12:32 -0700
> Subject: [PATCH] mm: memcg: link page counters to root if use_hierarchy is false
> 
> Richard reported a warning which can be reproduced by running the LTP
> madvise6 test (cgroup v1 in the non-hierarchical mode should be used):
> 
> [    9.841552] ------------[ cut here ]------------
> [    9.841788] WARNING: CPU: 0 PID: 12 at mm/page_counter.c:57 page_counter_uncharge (mm/page_counter.c:57 mm/page_counter.c:50 mm/page_counter.c:156)
> [    9.841982] Modules linked in:
> [    9.842072] CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.9.0-rc7-22-default #77
> [    9.842266] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-48-gd9c812d-rebuilt.opensuse.org 04/01/2014
> [    9.842571] Workqueue: events drain_local_stock
> [    9.842750] RIP: 0010:page_counter_uncharge (mm/page_counter.c:57 mm/page_counter.c:50 mm/page_counter.c:156)
> [ 9.842894] Code: 0f c1 45 00 4c 29 e0 48 89 ef 48 89 c3 48 89 c6 e8 2a fe ff ff 48 85 db 78 10 48 8b 6d 28 48 85 ed 75 d8 5b 5d 41 5c 41 5d c3 <0f> 0b eb ec 90 e8 4b f9 88 2a 48 8b 17 48 39 d6 72 41 41 54 49 89
> [    9.843438] RSP: 0018:ffffb1c18006be28 EFLAGS: 00010086
> [    9.843585] RAX: ffffffffffffffff RBX: ffffffffffffffff RCX: ffff94803bc2cae0
> [    9.843806] RDX: 0000000000000001 RSI: ffffffffffffffff RDI: ffff948007d2b248
> [    9.844026] RBP: ffff948007d2b248 R08: ffff948007c58eb0 R09: ffff948007da05ac
> [    9.844248] R10: 0000000000000018 R11: 0000000000000018 R12: 0000000000000001
> [    9.844477] R13: ffffffffffffffff R14: 0000000000000000 R15: ffff94803bc2cac0
> [    9.844696] FS:  0000000000000000(0000) GS:ffff94803bc00000(0000) knlGS:0000000000000000
> [    9.844915] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    9.845096] CR2: 00007f0579ee0384 CR3: 000000002cc0a000 CR4: 00000000000006f0
> [    9.845319] Call Trace:
> [    9.845429] __memcg_kmem_uncharge (mm/memcontrol.c:3022)
> [    9.845582] drain_obj_stock (./include/linux/rcupdate.h:689 mm/memcontrol.c:3114)
> [    9.845684] drain_local_stock (mm/memcontrol.c:2255)
> [    9.845789] process_one_work (./arch/x86/include/asm/jump_label.h:25 ./include/linux/jump_label.h:200 ./include/trace/events/workqueue.h:108 kernel/workqueue.c:2274)
> [    9.845898] worker_thread (./include/linux/list.h:282 kernel/workqueue.c:2416)
> [    9.846034] ? process_one_work (kernel/workqueue.c:2358)
> [    9.846162] kthread (kernel/kthread.c:292)
> [    9.846271] ? __kthread_bind_mask (kernel/kthread.c:245)
> [    9.846420] ret_from_fork (arch/x86/entry/entry_64.S:300)
> [    9.846531] ---[ end trace 8b5647c1eba9d18a ]---
> 
> The problem occurs because in the non-hierarchical mode non-root page
> counters are not linked to root page counters, so the charge is not
> propagated to the root memory cgroup.
> 
> After the removal of the original memory cgroup and reparenting of the
> object cgroup, the root cgroup might be uncharged by draining a objcg
> stock, for example. It leads to an eventual underflow of the charge
> and triggers a warning.
> 
> Fix it by linking all page counters to corresponding root page
> counters in the non-hierarchical mode.
> 
> The patch doesn't affect how the hierarchical mode is working,
> which is the only sane and truly supported mode now.
> 
> Thanks to Richard for reporting, debugging and providing an
> alternative version of the fix!
> 
> Reported-by: ltp@lists.linux.it
> Debugged-by: Richard Palethorpe <rpalethorpe@suse.com>
> Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: stable@vger.kernel.org

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
