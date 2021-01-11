Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7F72F1840
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388724AbhAKO0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729893AbhAKO0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:26:42 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDA9C06179F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:26:01 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id n10so12595991pgl.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zNFSg/gDzhA6E0hdWLuhAagYvpS9P0ZytzExWg36Ouk=;
        b=LNmkWlZYdNFcKRatZlR15e+BrcECPblXXTYu0KAumxSWjwLUJZ5a2n0A4hFtBg2ta7
         bT1XnCCJqPBvrHVz+6pmPLJWyr624DF6LSx88JGFYNLIf21aS6evLclevBwfYeXX7AmQ
         EvFb0zELlWFbDEn3iXDsTtPwT95TZzBphevyMmwlPz7xBRSgeNwpwnjgBOX9DhnNYhQ7
         0q6dDRwBtsQSYbmjnShjswSa9Rfs5MLGVku78kCHMchffBdca1G0ssUQogHspHqdByNl
         aluvrxPgPybS+WhB3LEYhzoOqqiOB/uFL1Zd8TbKKZPVQJ6c25flJQ5taT0ERoK+lkwf
         iUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zNFSg/gDzhA6E0hdWLuhAagYvpS9P0ZytzExWg36Ouk=;
        b=JZoM75UWZ3ZMhw+4A3m3nVrF6EeKGa6UbIbsVtLKA4QFAfo1G8TLT5sRgkKWYVBs1v
         N3vfDXfsr0Mggvvz5+mWjXlQ7vEZ4FVnNN+DG0kczdIYnATPNduFOShqvk6FNddXfHmK
         zIDJxEeVm29iYRktH8DZO5Uh+ZeywN8XfH+J5Z2Btdz3EysRkYHpTyNe8RxpKlpT6WJQ
         bFxqPIQiqbbARc0O0ZfMJ1ibbvjIJSY0/wdok+WSysvhvP7EGRVdfChdZv3O+MHwo6N1
         IRZ+QNKmuVpN+xv5aViYaXlHw49lE1eb0RavUVQexEJUe3fp0OEiS7yC4vbRFqVJoe22
         /c7A==
X-Gm-Message-State: AOAM530V+KRij6UYE+bYGMALSgas0+zIgmft+gqJUlYg5mgAuJ9xiER5
        hO3cE/XUeCNP1WqrAsqMUQw7kQA3nNU=
X-Google-Smtp-Source: ABdhPJz5O6VhKkHpP4UFeJhLBCZVHLjSf6ETgTrMVHJ8HM5w7rf8oqDc6VRAerT1xl9DIw2XP1gDWQ==
X-Received: by 2002:a62:7fc1:0:b029:19f:1dab:5029 with SMTP id a184-20020a627fc10000b029019f1dab5029mr16288045pfd.13.1610375160929;
        Mon, 11 Jan 2021 06:26:00 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id e5sm18722665pfc.76.2021.01.11.06.25.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jan 2021 06:26:00 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Tejun Heo <tj@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hillf Danton <hdanton@sina.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>
Subject: [PATCH -tip V4 0/8] workqueue: break affinity initiatively
Date:   Mon, 11 Jan 2021 23:26:30 +0800
Message-Id: <20210111152638.2417-1-jiangshanlai@gmail.com>
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
It doesn't handle for worker attachement, especially worker creation
  which is handled by Valentin Schneider's patch [1].
It doesn't handle for unbound workers which might be possible
per-cpu-kthread.

We need to thoroughly update the way workqueue handles affinity
in cpu hot[un]plug, what is this patchset intends to do and
replace the Valentin Schneider's patch [1].  The equivalent patch
is patch 8 here.

The patchset is based on tip/master rather than workqueue tree,
because the patchset is a complement for 06249738a41a ("workqueue:
Manually break affinity on hotplug") which is only in tip/master by now.

And TJ acked to route the series through tip.

Changed from V3:
	split hotplug callbacks

	introduce break_unbound_workers_cpumask() rather than resuing
	restore_unbound_workers_cpumask().

Changed from V2:
	Drop V2's patch4, which causes warning about setting cpumask
	online&!active to kthread reported by several people:
		Dexuan Cui <decui@microsoft.com>
		kernel test robot <oliver.sang@intel.com>

	Drop V2's patch 1, which can also cause warning about setting
	cpumask online&!active to kthread.  restore_unbound_workers_cpumask()
	is changed when we are bring cpu online.  And it cause V2's patch7
	(V3's patch5) to be changed accordingly.

	Marked patch8 Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

Changed from V1:
	Add TJ's acked-by for the whole patchset

	Add more words to the comments and the changelog, mainly derived
	from discussion with Peter.

	Update the comments as TJ suggested.
	
	Update a line of code as Valentin suggested.

	Add Valentin's ack for patch 10 because "Seems alright to me." and
	add Valentin's comments to the changelog which is integral.

[1]: https://lore.kernel.org/r/ff62e3ee994efb3620177bf7b19fab16f4866845.camel@redhat.com
[V1 patchset]: https://lore.kernel.org/lkml/20201214155457.3430-1-jiangshanlai@gmail.com/
[V2 patchset]: https://lore.kernel.org/lkml/20201218170919.2950-1-jiangshanlai@gmail.com/
[V3 patchset]: https://lore.kernel.org/lkml/20201226025117.2770-1-jiangshanlai@gmail.com/

Lai Jiangshan (8):
  workqueue: split cpuhotplug callbacks for unbound workqueue
  workqueue: set pool->attr->cpumask to workers when cpu online
  workqueue: use cpu_possible_mask instead of cpu_active_mask to break
    affinity
  workqueue: Manually break affinity on pool detachment
  workqueue: introduce wq_unbound_online_cpumask
  workqueue: use wq_unbound_online_cpumask in
    restore_unbound_workers_cpumask()
  workqueue: Manually break affinity on hotplug for unbound pool
  workqueue: Fix affinity of kworkers when attaching into pool

 include/linux/cpuhotplug.h |   4 +
 include/linux/workqueue.h  |   2 +
 kernel/cpu.c               |   5 +
 kernel/workqueue.c         | 192 +++++++++++++++++++++++++++++--------
 4 files changed, 165 insertions(+), 38 deletions(-)

-- 
2.19.1.6.gb485710b

