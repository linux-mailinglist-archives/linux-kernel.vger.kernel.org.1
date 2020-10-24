Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BBC297F7E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 01:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762852AbgJXW5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 18:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762843AbgJXW5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 18:57:19 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26A9C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 15:57:19 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id q26so4061385qki.5
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 15:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=gpI1Ly7XHDYS1MZVdPOSrAYXd6+QIdTDNu4A4QUSllo=;
        b=DlDDqOT4DDn2uC367xpEuwzq0fDJx0qfgHXPBKifU8c/GABWNSc7pWBYt9eiylawwR
         V8Jt8dzLjoRf7Y4fRZjdwr3Oekk4rPDKw5Pum6jGMxfYMolUtjj125m8PKNDozmctcrx
         9/LrkQ/fjRd2buSjvoGV4oGEvIWWqWCTjeKNIQXRiHLXCNR3CAp2PJFj1mL+0Wpu1cO8
         XC4WJSGDrjXXMzwiKUp1Xu2CMY14nfHeO6sIHcbsv3CevZtj9xY1EeZikLBKivu1MLK5
         gDeBBYMEuyTi7oQO7/LxQmUTinJtE1VpOutH7uvmElGh0RqHthM2/SeUTppzIxK6nyaG
         zUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=gpI1Ly7XHDYS1MZVdPOSrAYXd6+QIdTDNu4A4QUSllo=;
        b=RocWc3q8nzJoG8P2Sw+aDV1oI5FMFjTY7efHEvrBfMyXyP5d+fMgZ1MVJxKnbIP4U/
         l1eRsX4VhL2Hbwfrq8oKqXTWnB1HEHFoBU7hdkL08KE6LCkWGFaBaHMWd7wSOEixcIsT
         zlVO8H6MYWCagdT87khcrPq14PINX8XAu03RRAM5+dms1DMKL+fW5/qgNSzATtnuEl7Z
         d7rsxcJRn+P68DJUAr1dUzbKF/wHI8yGuSIEYVLCTS/vfR/5FYD9W48kdvDYl+DmB6Eq
         zZ7XX1zDH3jEA4ZVwJNL4LKBp2CSu/w6n31hEFhkULM/oSpRO2GemJuele8BTgQYPOn/
         LpuA==
X-Gm-Message-State: AOAM532XuxPYqA3PO3Ni6+EuU5xiyr8SRZ5KVbYBCijXxjmrRde8p8pe
        v4lY4C9A8nBPRZiLo6nvsbuDusE=
X-Google-Smtp-Source: ABdhPJzlmOIITQtDbbtD1YCtemKcAPA7Z+k6fZHPkh0ToLSYM2Y6Dhd3zEpnIMsZ+6RMEVbB1/BbpKg=
Sender: "xii via sendgmr" <xii@hvdc.svl.corp.google.com>
X-Received: from hvdc.svl.corp.google.com ([2620:15c:2cd:202:cad3:ffff:feb5:feb4])
 (user=xii job=sendgmr) by 2002:a0c:a2a6:: with SMTP id g35mr9478368qva.4.1603580238580;
 Sat, 24 Oct 2020 15:57:18 -0700 (PDT)
Date:   Sat, 24 Oct 2020 15:57:15 -0700
Message-Id: <20201024225716.2854163-1-xii@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc2.309.g374f81d7ae-goog
Subject: gFrom 9667d5ddbb1dc230653e5f8cedb778e9c562d46c Mon Sep 17 00:00:00 2001
From:   Xi Wang <xii@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Don <joshdon@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of periodically resetting watchdogs from thread context,
this patch simply forces resched and checks rq->sched_count.
Watchdog is reset if the sched count increases. If the same thread
is picked by pick_next_task during resched, there is no context
switch.

With the new method we lose coverage on: a migration/n thread
actually gets picked and we actually context switch to the
migration/n thread. These steps are unlikely to silently fail.
The change would provide nearly the same level of protection with
less latency / jitter.

v3:
 - Removed the old method and boot option
 - Still need to check resched

v2:
 - Use sched_count instead of having sched calling into watchdog code
 - Remove the sysctl and add a boot option, which can be removed later
 - Changed the subject line

Xi Wang (1):
  sched: watchdog: Touch kernel watchdog with sched count

 include/linux/sched.h |  4 ++++
 kernel/sched/core.c   | 23 +++++++++++++++++++--
 kernel/sched/sched.h  |  6 +++++-
 kernel/watchdog.c     | 47 +++++++++++++------------------------------
 4 files changed, 44 insertions(+), 36 deletions(-)

-- 
2.29.0.rc2.309.g374f81d7ae-goog

