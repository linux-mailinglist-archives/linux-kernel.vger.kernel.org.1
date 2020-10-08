Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFEE287715
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 17:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730986AbgJHP15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 11:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730958AbgJHP14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 11:27:56 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAACC0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 08:27:56 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id u19so6615933ion.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 08:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kf1FHcscdRPc5Run8iqbfToPP1jlTdzpFNUhRWFKvq8=;
        b=eYrIc4DKiojP3lwG3IPCBV8LMMb4cffXdyL4ngIrVpvRzeUq+7RJO4ggvSr5oq3PH+
         9R5/J3k0eSpWrwe9oQl6dEOM1xMkNmNTCQ81bMxRRnydgDx+nsn3xsq5DAbU5UE7F3iC
         oUy5jC8M7b5N/aL4BFL2YOavkNQ7bqXveYSgK/57ErT4ZfrcnGXDvN1KerT2oE27cLaa
         zU7OTlgAr6BHrFX1LyHCDC3JCpknJddQyblZxkA1nVYEYcI/q7lr8nNTr3bjbF3oLM7P
         x7ZTutF7y0Af9ieWXhFaSYTec5l+a380qOK7Y2yaDTda/KCVYlsKDiBFhpQFpw8kbGac
         EOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kf1FHcscdRPc5Run8iqbfToPP1jlTdzpFNUhRWFKvq8=;
        b=l4+7t7B0rb+ypo2H0K1g20lVaQv9VqksL4aJ+aDWUxzr6liavY5HlSHH/SmQe0qHag
         s9f+OHXy3Ft1BPFX56RPaXPc2nFzVIvtl1xYN9Ij+VorzIvNUOYl+RkXOhgislpRtOwE
         DQ1lx2VwunO5YLSGI62BoMvRtKYIWWxJZ7x0tJvZ6z3ZvroARU6lrnSH4L2S5SeOsj8L
         qmk2CGSPdNfLt6DH1Y162JUcAsr/i3K9251wz3OidY9snBN6J+DzIZ/9Ae8nFxruiKX+
         VeRdyv7FW6Etv8Zj7vhnN9j2e+YWmFCqZlEWUoOp8g6Ax6sO3tzeRVmKz5ULKiLk3QBm
         47Tg==
X-Gm-Message-State: AOAM530DjfGvQ68AHqp6nDsyxULHpFEqPV6MPXSaGv5qwvKBxqh4VNzL
        jllJmgOCQU8VhXr8h/iwFEjaia3RIv8qaQ==
X-Google-Smtp-Source: ABdhPJxS38WsptZEv2BWRJ7clN9DvJ5Lqor+vrAgcuBuwv1RTMrhVhavYM519/V3o3lz7GRRKxeEOg==
X-Received: by 2002:a5d:8188:: with SMTP id u8mr6754266ion.66.1602170875610;
        Thu, 08 Oct 2020 08:27:55 -0700 (PDT)
Received: from p1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l77sm2866260ill.4.2020.10.08.08.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 08:27:54 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Cc:     peterz@infradead.org, oleg@redhat.com, tglx@linutronix.de
Subject: [PATCHSET v4] Add support for TIF_NOTIFY_SIGNAL
Date:   Thu,  8 Oct 2020 09:27:48 -0600
Message-Id: <20201008152752.218889-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The goal is this patch series is to decouple TWA_SIGNAL based task_work
from real signals and signal delivery. The motivation is speeding up
TWA_SIGNAL based task_work, particularly for threaded setups where
->sighand is shared across threads. See the last patch for numbers.

v4 is nicely reduced, thanks to feedback from Oleg, dropping two of the
core patches and resulting in something that is easier to adopt in other
archs as well.

 arch/alpha/kernel/signal.c         |  1 -
 arch/arc/kernel/signal.c           |  2 +-
 arch/arm/kernel/signal.c           |  1 -
 arch/arm64/kernel/signal.c         |  1 -
 arch/c6x/kernel/signal.c           |  4 +--
 arch/csky/kernel/signal.c          |  1 -
 arch/h8300/kernel/signal.c         |  4 +--
 arch/hexagon/kernel/process.c      |  1 -
 arch/ia64/kernel/process.c         |  2 +-
 arch/m68k/kernel/signal.c          |  2 +-
 arch/microblaze/kernel/signal.c    |  2 +-
 arch/mips/kernel/signal.c          |  1 -
 arch/nds32/kernel/signal.c         |  4 +--
 arch/nios2/kernel/signal.c         |  2 +-
 arch/openrisc/kernel/signal.c      |  1 -
 arch/parisc/kernel/signal.c        |  4 +--
 arch/powerpc/kernel/signal.c       |  1 -
 arch/riscv/kernel/signal.c         |  4 +--
 arch/s390/kernel/signal.c          |  1 -
 arch/sh/kernel/signal_32.c         |  4 +--
 arch/sparc/kernel/signal_32.c      |  4 +--
 arch/sparc/kernel/signal_64.c      |  4 +--
 arch/um/kernel/process.c           |  2 +-
 arch/x86/include/asm/thread_info.h |  2 ++
 arch/x86/kernel/signal.c           |  5 +++-
 arch/xtensa/kernel/signal.c        |  2 +-
 include/linux/entry-common.h       |  6 ++++-
 include/linux/entry-kvm.h          |  4 +--
 include/linux/sched/signal.h       | 20 ++++++++++++---
 include/linux/tracehook.h          | 31 ++++++++++++++++++++--
 kernel/entry/common.c              |  3 +--
 kernel/entry/kvm.c                 |  7 ++---
 kernel/events/uprobes.c            |  2 +-
 kernel/signal.c                    |  8 +++---
 kernel/task_work.c                 | 41 +++++++++++++++++++++---------
 35 files changed, 113 insertions(+), 71 deletions(-)

Also find the changes here:

https://git.kernel.dk/cgit/linux-block/log/?h=tif-task_work

Changes since v3:

- Drop not needed io_uring change
- Drop syscall restart split, handle TIF_NOTIFY_SIGNAL from the arch
  signal handling, using task_sigpending() to see if we need to care
  about real signals.
- Fix a few over-zelaous task_sigpending() changes
- Cleanup WARN_ON() in restore_saved_sigmask_unless()

-- 
Jens Axboe


