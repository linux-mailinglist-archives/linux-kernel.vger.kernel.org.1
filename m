Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572532E8F03
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 01:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbhADAOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 19:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbhADAOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 19:14:08 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1BDC061574
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jan 2021 16:13:27 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id h22so60722128lfu.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2021 16:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=1CotyMvY+NgY0f7FpmZ95EvCRJUR01sOGrvyXdaZWbA=;
        b=KKFgEUR8ZlIXM+D/Eyy4A6WPRKcDzobdF06+PE541v66NeRRHHedVyNCIsZofEovk6
         f91PbdvdIkJOLCXxurVvi17GYjzw83NhTsIIQI3FEFisrkPmi3P5fVOehEl8aEdAUyOE
         u/c1755CZS1VONwzDt92tCwGVgGp+713QYyN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1CotyMvY+NgY0f7FpmZ95EvCRJUR01sOGrvyXdaZWbA=;
        b=oqt8UsraRODlApLMrQFjVXV2f/5wAmedA9TeBSB3vUXRLJro/plR9Nuj3q2KnA9ItQ
         JidrIt12+QextkiGCz5sd6pe6hx9XAplsBfol00BMdnqXVTZIQqdvqxkxVPDoIIYgFNc
         djGVFGZDmIkHVkk3cUZYuwyM3Ba8HZengwWruJY0qVV43qeNRQB0Dsz0l+8SY39Pt/MS
         6WpQOHWMcN/qXHXJpYY43upvkJFOuseONXSH/KMHvNtmQKQHP/+BvR+nq4HztHS/ph3L
         HVfyxGuT3Btl0kIHZVAYw22kthDYgR6HxOcvEt+2ly9FQc36Lgzy4YX6j9GRiALOXc76
         2j+Q==
X-Gm-Message-State: AOAM530aHg8hW/NO5Ra2ZXM1n8aukTes5tT4NusT22PRITWdVZP1yXmQ
        pCzRVnwOC2tiJ1IdRG7PTEIh16HhQ7nLjw==
X-Google-Smtp-Source: ABdhPJyOaQyiBnBt4AdBtl6KuAUQXmEVCk7EVPZPCGdNQlCchXE2JapEhfWUzTb8H9ay8Iv9AcJjDg==
X-Received: by 2002:a2e:8942:: with SMTP id b2mr35911256ljk.274.1609719205662;
        Sun, 03 Jan 2021 16:13:25 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 68sm8455220ljj.23.2021.01.03.16.13.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jan 2021 16:13:25 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id b26so60678773lff.9
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2021 16:13:24 -0800 (PST)
X-Received: by 2002:a2e:6f17:: with SMTP id k23mr36110754ljc.411.1609719204558;
 Sun, 03 Jan 2021 16:13:24 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 3 Jan 2021 16:13:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=whS+rzNMSsU6vRoLMzrm0JPN-OVg+BxhybMet3NpqpR-Q@mail.gmail.com>
Message-ID: <CAHk-=whS+rzNMSsU6vRoLMzrm0JPN-OVg+BxhybMet3NpqpR-Q@mail.gmail.com>
Subject: Linux 5.11-rc2
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, let's be honest - not a lot has happened in the last week or two.

The merge window itself may not have been hugely impacted by the
holiday season, but that's because all the new code should already
have been ready before the merge window even opened, so the holidays
just didn't end up affecting things all that much.

But people have (rightly) mostly been offline since, presumably
over-eating and doing all the other traditional holiday things. And
just generally not being hugely active. That very much shows in a tiny
rc2 release.

I expect next week to slowly start ramping up fixes, but I know some
people are still on vacation or just in an extended food coma, and
there's a delay from testing to fixes, so we'll see. Maybe rc3 ends up
being fairly small too.

It's much too early to say whether this will then end up causing some
delays in the final release - it's possible, but with 5.11 not being a
particularly big release maybe it doesn't even matter that we had a
fairly quiet week or two in the early rc series.

Anyway, for whatever reasons, the few fixes we _do_ have in rc2 tend
to be mostly in SCSI and block devices. But there's a random
smattering of other things too. For once, the shortlog is so small
that you might as well just read it.

Time to slowly crawl out from under all the xmas wrapping paper piles
and go test...

               Linus

---

Adrian Hunter (4):
      scsi: ufs-pci: Fix restore from S4 for Intel controllers
      scsi: ufs-pci: Ensure UFS device is in PowerDown mode for
suspend-to-disk ->poweroff()
      scsi: ufs-pci: Fix recovery from hibernate exit errors for Intel
controllers
      scsi: ufs-pci: Enable UFSHCD_CAP_RPM_AUTOSUSPEND for Intel controllers

Alan Stern (1):
      scsi: block: Do not accept any requests while suspended

Andres Freund (1):
      block: add debugfs stanza for QUEUE_FLAG_NOWAIT

Artem Bityutskiy (1):
      intel_idle: add SnowRidge C-state table

Baoquan He (1):
      mm: memmap defer init doesn't work as expected

Bart Van Assche (7):
      scsi: block: Fix a race in the runtime power management code
      scsi: block: Introduce BLK_MQ_REQ_PM
      scsi: ide: Do not set the RQF_PREEMPT flag for sense requests
      scsi: ide: Mark power management requests with RQF_PM instead of
RQF_PREEMPT
      scsi: scsi_transport_spi: Set RQF_PM for domain validation commands
      scsi: core: Only process PM requests if rpm_status != RPM_ACTIVE
      scsi: block: Remove RQF_PREEMPT and BLK_MQ_REQ_PREEMPT

Bean Huo (2):
      scsi: ufs: Remove unused macro definition POWER_DESC_MAX_SIZE
      scsi: ufs: Fix wrong print message in dev_err()

Bhaskar Chowdhury (1):
      kernel: cgroup: Mundane spelling fixes throughout the file

Dan Carpenter (1):
      scsi: mpt3sas: Signedness bug in _base_get_diag_triggers()

Harish (1):
      selftests/vm: fix building protection keys test

Heiko Carstens (2):
      s390: update defconfigs
      s390/Kconfig: sort config S390 select list once again

Huang Shijie (2):
      sizes.h: add SZ_8G/SZ_16G/SZ_32G macros
      lib/genalloc: fix the overflow when size is too big

Hui Su (1):
      cgroup/cgroup.c: replace 'of->kn->priv' with of_cft()

Ilya Dryomov (4):
      ceph: reencode gid_list when reconnecting
      libceph: fix auth_signature buffer allocation in secure mode
      libceph: align session_key and con_secret to 16 bytes
      libceph: add __maybe_unused to DEFINE_MSGR2_FEATURE

Ilya Leoshkevich (1):
      lib/zlib: fix inflating zlib streams on s390

Jens Axboe (1):
      io_uring: don't assume mm is constant across submits

Joe Perches (1):
      checkpatch: prefer strscpy to strlcpy

Josh Poimboeuf (1):
      kdev_t: always inline major/minor helper functions

Kalesh Singh (1):
      mm/mremap.c: fix extent calculation

Linus Torvalds (2):
      depmod: handle the case of /sbin/depmod without /sbin in PATH
      Linux 5.11-rc2

Lukas Bulwahn (1):
      MAINTAINERS: include governors into CPU IDLE TIME MANAGEMENT FRAMEWORK

Masahiro Yamada (1):
      Revert "kbuild: avoid static_assert for genksyms"

Mike Kravetz (1):
      mm/hugetlb: fix deadlock in hugetlb_cow error path

Mike Snitzer (1):
      Revert "dm crypt: export sysfs of kcryptd workqueue"

Nicholas Piggin (1):
      mm: generalise COW SMC TLB flushing race comment

Pavel Begunkov (3):
      io_uring: add a helper for setting a ref node
      io_uring: fix io_sqe_files_unregister() hangs
      kernel/io_uring: cancel io_uring before task works

Qinglang Miao (1):
      cgroup: Fix memory leak when parsing multiple source parameters

Quanyang Wang (1):
      opp: fix memory leak in _allocate_opp_table

Rafael J. Wysocki (1):
      cpufreq: intel_pstate: Fix fast-switch fallback path

Randall Huang (1):
      scsi: ufs: Clear UAC for RPMB after ufshcd resets

Randy Dunlap (4):
      scsi: cxgb4i: Fix TLS dependency
      local64.h: make <asm/local64.h> mandatory
      zlib: move EXPORT_SYMBOL() and MODULE_LICENSE() out of dfltcc_syms.c
      fs: block_dev.c: fix kernel-doc warnings from struct block_device changes

Roman Gushchin (1):
      mm: slub: call account_slab_page() after slab page initialization

Souptick Joarder (1):
      mm: add prototype for __add_to_page_cache_locked()

Stanley Chu (4):
      scsi: ufs: Allow regulators being always-on
      scsi: ufs-mediatek: Keep VCC always-on for specific devices
      scsi: ufs: Re-enable WriteBooster after device reset
      scsi: ufs: Un-inline ufshcd_vops_device_reset function

Viresh Kumar (1):
      opp: Call the missing clk_put() on error

Walter Wu (1):
      kasan: fix null pointer dereference in kasan_record_aux_stack

Yunfeng Ye (1):
      workqueue: Kick a worker based on the actual activation of delayed works

Zhen Lei (1):
      scsi: ufs-mediatek: Use correct path to fix compile error
