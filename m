Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5A228BD8E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 18:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390425AbgJLQXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 12:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390114AbgJLQXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 12:23:42 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F91C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 09:23:40 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id x7so13888750eje.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 09:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=+xMi2qtQOpW+KnS+qlIqi8dUXy3sEDMhpho4YWBiJwc=;
        b=OY+AxJS/aKLos0hLCz2TBb/MUmym4ZKcJe098iAjqLbu3wnIGnRb8VFN5y7f8AgdAm
         GrukxB7trx5gxHU1zopzRfFfbpxg4EPHLxCIM3NyC7HkTb4hL8E1Am8iJAW+hXPGJcX5
         IDEdIKciNwHIvsn+Ki4IxJvPtktCBmp5dzdB/+59BBYwRMCaBEPl9ny8aZ1Wt05D1dzl
         EhCabogjYoHp4TfOn4iNM+ms7IBImu26URd1NKvnADHN+CvOI8kGCt46vxe/QURByAfL
         lnzFPLw0WOV231lIoapvA18SU9PdDTxy8lPPUwpOpA0vi2LgGkuomhfzbA6U1iTMZK//
         7idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=+xMi2qtQOpW+KnS+qlIqi8dUXy3sEDMhpho4YWBiJwc=;
        b=B+e9iPfQMVPdk1rkNIoB7xeq6jvQnKRpunD+ObKe2ExAsb913O5XalnBE7M5wgmhmz
         jmUEFKgog65KDWptlcYh8m59t3E9ZomRVpynumO8UM+z8Ier1s7soisBAR3apRgoxFJp
         Fx+jREr8KJTkpa+RpSqDkpeqk0xWzeZk2r9x5kqx+VPgVcqCwK+pDS2fXDaKOJPd3SUt
         WHJg+2Ao65QKW/r+E14/++O+YQ4dZW/NHJnoMrUwzk/RHRvnuP5b8gJEpq8B/Rk+HbWQ
         e6p6N1ZkQB6IoPBtsj2ipErj+lHaKrrTulbPUgI+JkGa8Ozo+6p1nGi1Y7EWPvWjbEvl
         3Llw==
X-Gm-Message-State: AOAM530LLn5urYaJVp8Fo4azcvhWqLcZwrWvw5P9k42XxiFbpAeNV9ew
        4SDpUrjzzeK1m20qRWB8DiERnr4gTuI=
X-Google-Smtp-Source: ABdhPJwW2dgfIBdioKXULerlTdYg1jS4Yb0SDs5VGnOVe/XbYBwxfBtkcLMRs6a1Cq0Vjlk0ZtENeg==
X-Received: by 2002:a17:906:388:: with SMTP id b8mr27244921eja.62.1602519819523;
        Mon, 12 Oct 2020 09:23:39 -0700 (PDT)
Received: from gmail.com (563B81C8.dsl.pool.telekom.hu. [86.59.129.200])
        by smtp.gmail.com with ESMTPSA id h15sm3304076ejf.50.2020.10.12.09.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 09:23:38 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 12 Oct 2020 18:23:37 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf/kprobes changes for v5.10
Message-ID: <20201012162337.GA3751519@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf/kprobes git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-kprobes-2020-10-12

   # HEAD: bcb53209be5cb32d485507452edda19b78f31d84 kprobes: Fix to check probe enabled before disarm_kprobe_ftrace()

This tree prepares to unify the kretprobe trampoline handler and make
kretprobe lockless. (Those patches are still work in progress.)

 Thanks,

	Ingo

------------------>
Masami Hiramatsu (17):
      kprobes: Add generic kretprobe trampoline handler
      x86/kprobes: Use generic kretprobe trampoline handler
      arm: kprobes: Use generic kretprobe trampoline handler
      arm64: kprobes: Use generic kretprobe trampoline handler
      arc: kprobes: Use generic kretprobe trampoline handler
      csky: kprobes: Use generic kretprobe trampoline handler
      ia64: kprobes: Use generic kretprobe trampoline handler
      mips: kprobes: Use generic kretprobe trampoline handler
      parisc: kprobes: Use generic kretprobe trampoline handler
      powerpc: kprobes: Use generic kretprobe trampoline handler
      s390: kprobes: Use generic kretprobe trampoline handler
      sh: kprobes: Use generic kretprobe trampoline handler
      sparc: kprobes: Use generic kretprobe trampoline handler
      kprobes: Remove NMI context check
      kprobes: Free kretprobe_instance with RCU callback
      kprobes: Make local functions static
      kprobes: Fix to check probe enabled before disarm_kprobe_ftrace()


 arch/arc/kernel/kprobes.c          |  54 +--------------
 arch/arm/probes/kprobes/core.c     |  78 +---------------------
 arch/arm64/kernel/probes/kprobes.c |  78 +---------------------
 arch/csky/kernel/probes/kprobes.c  |  77 +--------------------
 arch/ia64/kernel/kprobes.c         |  77 +--------------------
 arch/mips/kernel/kprobes.c         |  54 +--------------
 arch/parisc/kernel/kprobes.c       |  76 ++-------------------
 arch/powerpc/kernel/kprobes.c      |  53 +--------------
 arch/s390/kernel/kprobes.c         |  79 +---------------------
 arch/sh/kernel/kprobes.c           |  58 +---------------
 arch/sparc/kernel/kprobes.c        |  51 +-------------
 arch/x86/kernel/kprobes/core.c     | 108 +-----------------------------
 include/linux/kprobes.h            |  51 ++++++++------
 kernel/kprobes.c                   | 133 +++++++++++++++++++++++++++++--------
 14 files changed, 169 insertions(+), 858 deletions(-)
