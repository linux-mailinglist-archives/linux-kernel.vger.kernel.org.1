Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C443B2E2CD5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 02:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgLZBvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 20:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgLZBvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 20:51:23 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6D2C061757
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 17:50:43 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id h186so3181619pfe.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 17:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AgPKMI6JCKlv/JqbH3+fppHd+Fxs38deZuK+qJdIg48=;
        b=RhbiOiOP0xX1NfFGWe3CUtWFvNatsuDObIRu4qY7N7DZs+rio0k9jhVXXqlrOtntKq
         KoSdxRtrKnSwR5autkFi148yAO/sAxLL7o1jMpm4nb8P7e3opj/qLGPUDVI6LigIcjVu
         Rt7JfNlX8BniEJCevowOOMP58JeozXkvFpm5+qzSVR0F97jaQvmo5LMbwNUSzbhn+c3T
         u+LN6aOCI0dtBtxZHA/FDJod6Vo2qgD07vhZKWH5gsL13kzGgeaWEeH8dRNcQAB5IWs4
         RRImYLMDJT2+mgYoKilHM2KWJAhC+wNJVRyISelSzqmF6FY2vGA0rwBYNszVT5trGwvE
         f2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AgPKMI6JCKlv/JqbH3+fppHd+Fxs38deZuK+qJdIg48=;
        b=CCJUaHbtsPMx7amYJEW57KHqQsaH87nzsVY6GbMTPiG8eBNGOTTYZVKdqkdeQXT9tw
         oRIcsBZGkO0inUS+DPfuZaPS09Xgzts71V8+1pT0lqsZxKWE6spjqiti2hEJCeZvLphW
         Jxe4/3lCO6iL/i/HZiOek55sxFSWN3BNmX+FSDrZ1CtCbUeqIG+dMDLWyU0jCwkXNMVp
         Y0pREwWXj+xGSX7ChOjwM4jmjsYHXfyip8ikWd3O33qKn0fBrwQk6OtGXPN1/W7LZGpZ
         aOVq7Vad3E6hcZM4i2eL1vvBsA0BNi8fvnIrdUKabzjZ3ERRAqez3Q1KGsJBOp7D2m/h
         DGHw==
X-Gm-Message-State: AOAM533gnUFvtxAsBughdvqkWJiRYxsc4smTUybU2rK3xOvJ5q/JBoM5
        IlfogDVVMHEV2DIKMvHMwfgVLU8ycRU=
X-Google-Smtp-Source: ABdhPJysLHqWMVJPNYz6pzWogYDjmoJ0UrfeAhXmtEXUN1mO/SPvLkxI9Dqy6pSBDgI8sni4eCeTdQ==
X-Received: by 2002:a63:ed54:: with SMTP id m20mr33949624pgk.401.1608947442516;
        Fri, 25 Dec 2020 17:50:42 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id g30sm29647708pfr.152.2020.12.25.17.50.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Dec 2020 17:50:41 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>
Subject: [PATCH -tip V3 0/8] workqueue: break affinity initiatively
Date:   Sat, 26 Dec 2020 10:51:08 +0800
Message-Id: <20201226025117.2770-1-jiangshanlai@gmail.com>
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
is patch 10.

The patchset is based on tip/master rather than workqueue tree,
because the patchset is a complement for 06249738a41a ("workqueue:
Manually break affinity on hotplug") which is only in tip/master by now.

And TJ acked to route the series through tip.

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

Lai Jiangshan (8):
  workqueue: use cpu_possible_mask instead of cpu_active_mask to break
    affinity
  workqueue: Manually break affinity on pool detachment
  workqueue: introduce wq_online_cpumask
  workqueue: use wq_online_cpumask in restore_unbound_workers_cpumask()
  workqueue: Manually break affinity on hotplug for unbound pool
  workqueue: reorganize workqueue_online_cpu()
  workqueue: reorganize workqueue_offline_cpu() unbind_workers()
  workqueue: Fix affinity of kworkers when attaching into pool

 kernel/workqueue.c | 207 ++++++++++++++++++++++++++++-----------------
 1 file changed, 129 insertions(+), 78 deletions(-)

-- 
2.19.1.6.gb485710b

