Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFB628F300
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 15:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgJONRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 09:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgJONRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 09:17:06 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3706CC061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 06:17:06 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id k6so4299566ior.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 06:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gEuPfz0KXA/MgwtC7gp17zj6T5fVm/x6kmNaSJMr43Q=;
        b=OneD/DqISQLZlkUKTVnoMywsjTnsmuOYCeMgQkiwvuxoUVL1kqucRTybCG7aq5Dk0U
         oIhoiAdebgUeWIjfx/T7/+BYoEHIUDXpRJ8lhlRv9RohB21XkQxzXv+GUzMdK9X0Tlmf
         zO9NmAcOcXz2q1wsXzDgT6gtbyd3vMVD5+KK/Ew0ZwmBUUSVD+q9JXU8HUeDuN3iGRCF
         GrYW9cCXEqzTEQXXeHDzn3zhxUK/+nNL/mR38bPfKfMM9HL3KG5KqacokZjRSzxcem7j
         PzJfQUeAkbUs18B+NiqEegv6eyVihxUi4LrBrsEn93OiUPMhxrFRneVb2/U7nBsh5NRc
         ZAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gEuPfz0KXA/MgwtC7gp17zj6T5fVm/x6kmNaSJMr43Q=;
        b=Fdbq/kMSJ1VURUq7SM41xs6B2WPYTHuEFPu+YBq8pl6Za21Dq1Mb4IED32yrq0TGi9
         TwfADk+sL3zF89MOnSc+3h5baqAhoe0YOJ7d19NYSJiuTX4XAdrbzrCI287Ew6zkUy7g
         urDZTlr1vQKXvLsnq156prUl9NAHTX8lC7FO01eDklO4dOCCrFdK0/8fXnM7CuD1XkNO
         /d0o6ViGmQ/fqdcdo6BbD9hAomeJPyLmhfdSQZa/oLpCMJw8HVeLQvMet0kKD8Qqv17e
         haa1F/sf2BTg7/Q9Jxox3UcBigV7TrzktGMVBu/NIqG2aX/jIsjaHPhQMOd4H4xagI6z
         2JyA==
X-Gm-Message-State: AOAM531Pn0jpMhY0zh91j1u7q8AJKI76Rd9nX65R4CuADqf6I8+dp6lr
        mzu32poPHTAomPtSZBNS+v8bK3jbXNBfhA==
X-Google-Smtp-Source: ABdhPJxY8t3WaBYb0mnx9DojoFwmc78wXA904V7SoKJjZdv30XRMpzPzuPkf/yhMuP3SVCZbgVk7Dw==
X-Received: by 2002:a5d:9693:: with SMTP id m19mr3120512ion.161.1602767825278;
        Thu, 15 Oct 2020 06:17:05 -0700 (PDT)
Received: from p1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m13sm2486736ioo.9.2020.10.15.06.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 06:17:04 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Cc:     peterz@infradead.org, oleg@redhat.com, tglx@linutronix.de
Subject: [PATCHSET v5] Add support for TIF_NOTIFY_SIGNAL
Date:   Thu, 15 Oct 2020 07:16:56 -0600
Message-Id: <20201015131701.511523-1-axboe@kernel.dk>
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
 arch/x86/kernel/signal.c           |  7 +++--
 arch/xtensa/kernel/signal.c        |  2 +-
 include/linux/entry-common.h       |  9 +++++--
 include/linux/entry-kvm.h          |  4 +--
 include/linux/sched/signal.h       | 20 ++++++++++++---
 include/linux/tracehook.h          | 31 ++++++++++++++++++++--
 kernel/entry/common.c              |  7 +++--
 kernel/entry/kvm.c                 |  7 ++---
 kernel/events/uprobes.c            |  2 +-
 kernel/signal.c                    |  8 +++---
 kernel/task_work.c                 | 41 +++++++++++++++++++++---------
 35 files changed, 118 insertions(+), 75 deletions(-)


Changes since v4:
- Change ifdef as per Thomas
- Split x86 change from generic entry code
- Pass in TIF flags for arch_do_signal() to avoid doing multiple bit
  tests

-- 
Jens Axboe


