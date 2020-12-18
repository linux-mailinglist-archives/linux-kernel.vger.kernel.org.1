Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FDB2DE73D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 17:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgLRQJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 11:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgLRQJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 11:09:30 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FC3C0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 08:08:50 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id i7so1593097pgc.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 08:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0qQqjkXFpRpucptQcYeqqNeENZYyy0lQ03KPSItsaVQ=;
        b=rbfxeuQl2HWDvRHO/S31kL4xqCD77T8mWHFQJrlUYqbBwMgnuqROkpS/Um699mrPQO
         MBRASTRXuv+OqeWywUcWsXjHjrDlgXCwRX4Q7SVdHsR/9+dwViDir1vfZEreu5HA/Fzf
         esGNh4gv58cjNZ9sTH1yEv9/Wo58XhWb0P9r6iXz6pUzzQY7qkA05cTKnwSZRbEPXAqb
         MD/BJkltFCvB79nuoyCHQjBRTYKo+tCojQqPCPpd7T1eiJSH6peKMjVNwiqZo64K7F6x
         VOQV1mIOhLlv8RDAiyXbQFIQ0nCVOCg3Wvqj6twMPMzRyVkY3MMJ9gzL3887zu8K0TEq
         Le8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0qQqjkXFpRpucptQcYeqqNeENZYyy0lQ03KPSItsaVQ=;
        b=Psp8QrDCmPY62c3JRyBeerr27qWwm+b5V5wsP2AR+aU2WQ0Mms10V2CIQ6IbHr2091
         IwhnM/w4MWicMKUIqFRKZrQoz/NkiYbfVlzWuRh2pebkkWFBE5t5JPWfN0TBuqrM3Tdg
         6rTI6EZNNeXF/cKw0HectDJIFb44ws4B8dHGofWgTzceUwxOKLi0xioJkPzU/0jpDnNx
         aMpUxSfD9Uq20z+synlJ7HI94MzQkFdBL/ijFz3LHLPr0J+e1ACwnFtlUvZAnzT+QvJv
         Zj+RfloJQom5R2qsvqknew104ANny8WgF+MyCde50Vb0DZz9OnfF9YxioTfbdSC5Rs08
         xhpA==
X-Gm-Message-State: AOAM530NofdnAc55QXZseim2ESFPBXfbSKl9ozICPgI8+4ThJAJfESNg
        s+XtdTm2MMlHaeSYgKDQF3MKTSX6EBo=
X-Google-Smtp-Source: ABdhPJzcgWowLRRtd1dgek1+PnRDZcmowGiBrdWKQZKRhsSG/7oEIwI+13q0XacUsApBXsPDyiOwwA==
X-Received: by 2002:a62:84ca:0:b029:19e:6f95:11b1 with SMTP id k193-20020a6284ca0000b029019e6f9511b1mr4551170pfd.68.1608307729291;
        Fri, 18 Dec 2020 08:08:49 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id t9sm2541704pgh.41.2020.12.18.08.08.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Dec 2020 08:08:48 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Hillf Danton <hdanton@sina.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH -tip V2 00/10] workqueue: break affinity initiatively
Date:   Sat, 19 Dec 2020 01:09:09 +0800
Message-Id: <20201218170919.2950-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

06249738a41a ("workqueue: Manually break affinity on hotplug")
said that scheduler will not force break affinity for us.

But workqueue highly depends on the old behavior. Many parts of the codes
relies on it, 06249738a41a ("workqueue: Manually break affinity on hotplug")
is not enough to change it, and the commit has flaws in itself too.

It doesn't handle for worker detachment.
It doesn't handle for worker attachement, mainly worker creation
  which is handled by Valentin Schneider's patch [1].
It doesn't handle for unbound workers which might be possible
per-cpu-kthread.

We need to thoroughly update the way workqueue handles affinity
in cpu hot[un]plug, what is this patchset intends to do and
replace the Valentin Schneider's patch [1].  The equivalent patch
is patch 10.

Patch 1 fixes a flaw reported by Hillf Danton <hdanton@sina.com>.
I have to include this fix because later patches depends on it.

The patchset is based on tip/master rather than workqueue tree,
because the patchset is a complement for 06249738a41a ("workqueue:
Manually break affinity on hotplug") which is only in tip/master by now.

And TJ acked to route the series through tip.

Changed from V1:
	Add TJ's acked-by for the whole patchset

	Add more words to the comments and the changelog, mainly derived
	from discussion with Peter.

	Update the comments as TJ suggested.
	
	Update a line of code as Valentin suggested.

	Add Valentin's ack for patch 10 because "Seems alright to me." and
	add Valentin's comments to the changelog which is integral.

[1]: https://lore.kernel.org/r/ff62e3ee994efb3620177bf7b19fab16f4866845.camel@redhat.com
[V1 patcheset]: https://lore.kernel.org/lkml/20201214155457.3430-1-jiangshanlai@gmail.com/

Cc: Hillf Danton <hdanton@sina.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Qian Cai <cai@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Donnefort <vincent.donnefort@arm.com>
Cc: Tejun Heo <tj@kernel.org>

Lai Jiangshan (10):
  workqueue: restore unbound_workers' cpumask correctly
  workqueue: use cpu_possible_mask instead of cpu_active_mask to break
    affinity
  workqueue: Manually break affinity on pool detachment
  workqueue: don't set the worker's cpumask when kthread_bind_mask()
  workqueue: introduce wq_online_cpumask
  workqueue: use wq_online_cpumask in restore_unbound_workers_cpumask()
  workqueue: Manually break affinity on hotplug for unbound pool
  workqueue: reorganize workqueue_online_cpu()
  workqueue: reorganize workqueue_offline_cpu() unbind_workers()
  workqueue: Fix affinity of kworkers when attaching into pool

 kernel/workqueue.c | 214 ++++++++++++++++++++++++++++-----------------
 1 file changed, 132 insertions(+), 82 deletions(-)

-- 
2.19.1.6.gb485710b

