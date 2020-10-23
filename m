Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3BDE296869
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 04:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374466AbgJWCEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 22:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374459AbgJWCEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 22:04:53 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4BFC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 19:04:51 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id e7so2539073pfn.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 19:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=2fAeKHh9JKsOxZXlFouiLN5+1PtxGwNugM9KVzVzxgs=;
        b=kujgMAUW6e5vfESr3Gf67ASvKV/U4UEFXquWAYgOSdadds92ZQCSHVvICBZPM+LnzO
         3F/dPrDJAcEaNMatCTJtkYwHEWaHr6uuiUUDOzdwRLZvQ05lgVFBZPh9fbaw7laEOQNw
         NpLeJQ8gi8WkCHvxfm7wbwF+ppPngjEih7ZYTA1VXjlUp7QDTyDAf90uMVceT5kYUsOz
         f7xwqt05S0R169HNerq83nnTeFWbNZib+DKXkIxOzYvXN4PnwRc4Yu2B4ZTlQhY5Hb17
         SnPYYBvvx2gfLMLrb30oWsi6VNCPePuUfaw5L3WOA1HUYF7bjeSsQmB5mvt9JUo7KadY
         a+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=2fAeKHh9JKsOxZXlFouiLN5+1PtxGwNugM9KVzVzxgs=;
        b=JEn1c7TU1ZZ0GsgJy9MoueXpAC5R2Kv5us0pTdy+99gqewEgkZ6dW9G9BWpIkhQsqn
         l3IrI6Hq9PTeQiq7oFBMlJ9QtXEj0iWuneuPZBHqDXQI7aOUzKl49TifY01uRmEjzqEF
         cOM3e+wTB9c8fH6QyyiQqUJmlrULUSdvFvtIRm7DkBnzNk0Z/dTK6MWrKMKYfXsGFC8X
         aHThSsz3tUlIrW3hKSpxAWGcFBfEid7IOggwZXt7yjpzEhziiSv/8YHzAM4BT2mjqbj+
         6UiJFymbRNAXonOdMfcK+3S76Y+bug6lwNzhvfWgBuky/ubAVJvrTQ2A0xjM2AqQ9+Jf
         /oQw==
X-Gm-Message-State: AOAM532a8I3xGduGWrPow/U8PBbEeGhZGeQ0Dbl8uicXR+JwLd4HQD10
        GNe1sPWUCYTh6+MePlujk1g57O2Ov9PWFQ==
X-Google-Smtp-Source: ABdhPJxiwBukwybiBDZkZZNUetvX6OFjmD04zabz39/lbm3Fb3y7liaxjipdcsAC1wLI2IT9mSwc5g==
X-Received: by 2002:a17:90a:430a:: with SMTP id q10mr226845pjg.45.1603418690744;
        Thu, 22 Oct 2020 19:04:50 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id w187sm36067pfb.93.2020.10.22.19.04.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2020 19:04:50 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Arch/task_work cleanup
Message-ID: <e1e0acc8-1859-bd37-80ab-612a122a334f@kernel.dk>
Date:   Thu, 22 Oct 2020 20:04:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Two cleanups that don't fit other categories:

- Finally get the task_work_add() cleanup done properly, so we don't
  have random 0/1/false/true/TWA_SIGNAL confusing use cases. Updates all
  callers, and also fixes up the documentation for task_work_add().

- While working on some TIF related changes for 5.11, this
  TIF_NOTIFY_RESUME cleanup fell out of that. Remove some arch
  duplication for how that is handled.

Please pull!


The following changes since commit 324bcf54c449c7b5b7024c9fa4549fbaaae1935d:

  mm: use limited read-ahead to satisfy read (2020-10-17 13:49:08 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/arch-cleanup-2020-10-22

for you to fetch changes up to 91989c707884ecc7cd537281ab1a4b8fb7219da3:

  task_work: cleanup notification modes (2020-10-17 15:05:30 -0600)

----------------------------------------------------------------
arch-cleanup-2020-10-22

----------------------------------------------------------------
Jens Axboe (2):
      tracehook: clear TIF_NOTIFY_RESUME in tracehook_notify_resume()
      task_work: cleanup notification modes

 arch/alpha/kernel/signal.c             |  1 -
 arch/arc/kernel/signal.c               |  2 +-
 arch/arm/kernel/signal.c               |  1 -
 arch/arm64/kernel/signal.c             |  1 -
 arch/c6x/kernel/signal.c               |  4 +---
 arch/csky/kernel/signal.c              |  1 -
 arch/h8300/kernel/signal.c             |  4 +---
 arch/hexagon/kernel/process.c          |  1 -
 arch/ia64/kernel/process.c             |  2 +-
 arch/m68k/kernel/signal.c              |  2 +-
 arch/microblaze/kernel/signal.c        |  2 +-
 arch/mips/kernel/signal.c              |  1 -
 arch/nds32/kernel/signal.c             |  4 +---
 arch/nios2/kernel/signal.c             |  2 +-
 arch/openrisc/kernel/signal.c          |  1 -
 arch/parisc/kernel/signal.c            |  4 +---
 arch/powerpc/kernel/signal.c           |  1 -
 arch/riscv/kernel/signal.c             |  4 +---
 arch/s390/kernel/signal.c              |  1 -
 arch/sh/kernel/signal_32.c             |  4 +---
 arch/sparc/kernel/signal_32.c          |  4 +---
 arch/sparc/kernel/signal_64.c          |  4 +---
 arch/um/kernel/process.c               |  2 +-
 arch/x86/kernel/cpu/mce/core.c         |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  2 +-
 arch/xtensa/kernel/signal.c            |  2 +-
 drivers/acpi/apei/ghes.c               |  2 +-
 drivers/android/binder.c               |  2 +-
 fs/file_table.c                        |  2 +-
 fs/io_uring.c                          | 13 +++++++------
 fs/namespace.c                         |  2 +-
 include/linux/task_work.h              | 11 ++++++++---
 include/linux/tracehook.h              |  4 ++--
 kernel/entry/common.c                  |  1 -
 kernel/entry/kvm.c                     |  4 +---
 kernel/events/uprobes.c                |  2 +-
 kernel/irq/manage.c                    |  2 +-
 kernel/sched/fair.c                    |  2 +-
 kernel/task_work.c                     | 30 ++++++++++++++++++++----------
 security/keys/keyctl.c                 |  2 +-
 security/yama/yama_lsm.c               |  2 +-
 41 files changed, 64 insertions(+), 76 deletions(-)

-- 
Jens Axboe

