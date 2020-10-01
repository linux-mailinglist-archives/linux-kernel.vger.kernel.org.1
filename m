Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A68F2807E9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 21:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733009AbgJATm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 15:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732931AbgJATmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 15:42:17 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3B3C0613E4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 12:42:16 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id k25so3667310ioh.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 12:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Xf9F6UGNaiLG5H3YRSBPm6b9L4CcWmTNfiW9AANHnQ=;
        b=bV2f4yXxPht1ORgAZbL+26LUq3j6/+meqvYDo3OiiVlm8PoQQ7LK0gSy3has1kGbwT
         FLFOHSQi2YZjxnQ33QvdLk/x9Rm175KTVzKx1kiZtIslEDlpYIngERmsIx3pak+pXqJn
         c2oOqWAi/Tmg6OQXmQxaGr42zj7bbYzyW/nam0Z/xpPGdak5gdfNdTZVvC7yZGKnG8yJ
         V4bIV83uzV/oB4dl4SRQ620jWjbzjsnJIDqPE9oHCzwCU+X1eNcZOpJweR4z7JcCyrng
         z7kZKAEKdmJU4UovQ9mSTJdNm0mm7zZVBzqy+6uhsNJRPspxVJ62OPjSlwLsYaQOx+a3
         uq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Xf9F6UGNaiLG5H3YRSBPm6b9L4CcWmTNfiW9AANHnQ=;
        b=Vzkixmof2M8BibURI/CIVkLPxt4qL0G343FKNY+6xT2P0ljKlzvGTUpdqsCJCfySNx
         bc/+PCVPDKsVevghMFUScCcYg9yhLRJjYUzfRN3f2f4qixlg5wXDFu6Mf0AL8Ae8/cxd
         7F0hmDCmojHvvM3y6NffC61YF9WpZpoj+BGzKRfd+X97Di/UtdzAIAs5ufdnzF6B1UXT
         ix/7npaUjOg43TGtZEa1eR9DFBw7Ne9XVpP37skMFc9T79KNiDfgqbXqtqm+kfGfDxi6
         RShmTtakD1HWtAOPvJA2PLi4QMfH+4+UpHEMPUyyZj0NYDW2dYdkS8VMyZdBylAZU3oF
         jFPA==
X-Gm-Message-State: AOAM532n/MJRsrIS2vL8dZlBoT/xlT+XKVv3Wzx6XPHJpiZcPzJlgfvp
        H8TvVIpFfTohMNDxDljViq/O8rXA5MAQ7w==
X-Google-Smtp-Source: ABdhPJyyzY9YdiPTxsCObl8ukT4pWzeiXFcI57sXQik+Qzyt7trv1gaUwlW2RBKM9Q14WwloQm5VLA==
X-Received: by 2002:a6b:244:: with SMTP id 65mr6591713ioc.7.1601581332210;
        Thu, 01 Oct 2020 12:42:12 -0700 (PDT)
Received: from p1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t11sm739609ill.61.2020.10.01.12.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 12:42:11 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Cc:     peterz@infradead.org, oleg@redhat.com, tglx@linutronix.de
Subject: [PATCHSET RFC 0/3] kernel: decouple TASK_WORK TWA_SIGNAL handling from signals
Date:   Thu,  1 Oct 2020 13:42:05 -0600
Message-Id: <20201001194208.1153522-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I split this up into 3 pieces instead of the messy single patch, hope
this helps with review.

Patch 1 adds task_sigpending(), which tests TIF_SIGPENDING. Core use
cases that need to check for an actual signal pending are switched to
using task_sigpending() instead of signal_pending(). This should fix
Oleg's concern on signal_pending() == true, but no signals pending,
for actual signal delivery.

Patch 2 adds x86 and generic entry code support for TIF_TASKWORK.

Patch 3 adds task_work support for TIF_TASKWORK, if the arch supports it.

There's no need for any io_uring specific changes, so I've dropped those.
If TIF_TASKWORK is used, then JOBCTL_TASK_WORK will never be true and
hence we won't enter that case. If TIF_TASKWORK isn't available, then
we still need that code.

I've run this through my usual liburing test, and it passes. I also ran
it through all the ltp signal testing, and no changes from mainline in
terms of all tests passing.

 arch/x86/include/asm/thread_info.h |  2 ++
 arch/x86/kernel/signal.c           | 32 +++++++++++---------
 include/linux/entry-common.h       | 20 +++++++++++--
 include/linux/sched/signal.h       | 32 ++++++++++++++++----
 kernel/entry/common.c              | 14 +++++++--
 kernel/events/uprobes.c            |  2 +-
 kernel/ptrace.c                    |  2 +-
 kernel/signal.c                    | 12 ++++----
 kernel/task_work.c                 | 48 ++++++++++++++++++++++--------
 9 files changed, 118 insertions(+), 46 deletions(-)

Changes can also be viewed/pulled from this branch:

git://git.kernel.dk/linux-block tif-task_work

https://git.kernel.dk/cgit/linux-block/log/?h=tif-task_work

-- 
Jens Axboe


