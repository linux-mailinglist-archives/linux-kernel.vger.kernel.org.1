Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D3D2D9A5C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 15:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405601AbgLNOzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 09:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731645AbgLNOzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 09:55:05 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A9CC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 06:54:25 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id v3so8730698plz.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 06:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i6xf6f4KGR9YLyoIsShEBffQPuuRhgNFYHSbUlZxnBc=;
        b=jqbUaBffG+NTEN9SJHy2r/2kdyT14H/rrbOh1MP9tn5PQqcdLf+6ssYTIJ5kUO5tPD
         xvjD14t+vvuBnnY6T/UgrbE3kyy2NOG5bMkRoIaz3bbE7oBA6kPTtc42qUhmAeCvmFtF
         ECF56BjDcZbVYNNifaEoI/R5UZATV2fsHo6M8DOYqM64MmSKVfW83KF9Gb04BhSZtRv6
         FiQu2Ls0qYJXxHimc3aQs7Iw3GYwedL+oL/30hRWDMaZfvWCis76VLnLyIDgISyxpReF
         ZfXTUeTE0hucwW6pW2qOCw6aOwxH/EHqu1eGdEIFqduybQVH2KfImWIyHCNGqhv9mZP1
         iuhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i6xf6f4KGR9YLyoIsShEBffQPuuRhgNFYHSbUlZxnBc=;
        b=cDKmzseHQOD16C0fu8Ye16LN1ydmErh+/CDp9Izg18Gj0ReM3ijZtgqNwx54WtdAoE
         l0Lk1lwgZURVQqTvAwR+DlhLDlBHNnYTnxoqUE9b/vTVjlMd7NhkyNce2pg9cKzRFh4W
         7/+xMkohzlGY4TftEzSSDkyYQQcrpGHAiU1i1xp3oMrkYA+AMNRBhE/kvtI2El1KsxIa
         y6X7LS+0KbPNZkta7bFo+FenT+Nb97ev2vWmiBIZrvd5P50RtG1eXV375bRvyaqZja5P
         Yi3axgc54XQau7gvDUhrU+ZIoLVEtZ7E+K4PezNHToVDS79hTHjWNXrgSYQ5637s7bd3
         Tcgg==
X-Gm-Message-State: AOAM5310KN+2DEgCTQaZplTB/el6r1b8PooYp1P4djTcLa4XZeo+w+/W
        EcLmipFQA+sIKWkNaWwwrbYI1Z2M2zEH1g==
X-Google-Smtp-Source: ABdhPJy0f/QfyqAEqDJIJavjHgDXPE3XYvG9C2fOfsRuUOV0H5Rx2GvTQlkb1XlgODWbsiK2YYcYrQ==
X-Received: by 2002:a17:90b:4d09:: with SMTP id mw9mr12232282pjb.140.1607957664371;
        Mon, 14 Dec 2020 06:54:24 -0800 (PST)
Received: from localhost ([198.11.176.14])
        by smtp.gmail.com with ESMTPSA id e5sm19256196pfc.76.2020.12.14.06.54.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Dec 2020 06:54:23 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Hillf Danton <hdanton@sina.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qian Cai <cai@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 00/10] workqueue: break affinity initiatively
Date:   Mon, 14 Dec 2020 23:54:47 +0800
Message-Id: <20201214155457.3430-1-jiangshanlai@gmail.com>
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

We need to thoroughly update the way workqueue handles affinity
in cpu hot[un]plug, what is this patchset intends to do and
replace the Valentin Schneider's patch [1].

Patch 1 fixes a flaw reported by Hillf Danton <hdanton@sina.com>.
I have to include this fix because later patches depends on it.

The patchset is based on tip/master rather than workqueue tree,
because the patchset is a complement for 06249738a41a ("workqueue:
Manually break affinity on hotplug") which is only in tip/master by now.

[1]: https://lore.kernel.org/r/ff62e3ee994efb3620177bf7b19fab16f4866845.camel@redhat.com

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

 kernel/workqueue.c | 212 +++++++++++++++++++++++++++------------------
 1 file changed, 130 insertions(+), 82 deletions(-)

-- 
2.19.1.6.gb485710b

