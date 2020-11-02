Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E592A3345
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 19:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgKBSsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 13:48:05 -0500
Received: from foss.arm.com ([217.140.110.172]:36206 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbgKBSsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 13:48:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CF47139F;
        Mon,  2 Nov 2020 10:48:05 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C94AA3F719;
        Mon,  2 Nov 2020 10:48:03 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH v4 0/3] sched: Get rid of select_task_rq()'s sd_flag parameter
Date:   Mon,  2 Nov 2020 18:45:11 +0000
Message-Id: <20201102184514.2733-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

This is v4 of that one series I've had stashed for a while [1]. I haven't
revisited the outstanding discussion bits, the most interesting part being that
we could get rid of the for_each_domain() loop in select_task_rq_fair() (or at
the very least simplify it). In any case, the first few patches are IMO a decent
cleanup on their own, hence me resubmitting them. 

Links
=====

[1]: https://lore.kernel.org/lkml/20200415210512.805-1-valentin.schneider@arm.com/

Revisions
=========

v3 -> v4
--------
o Dropped want_affine related patches
o Made WF_{TTWU, FORK, EXEC} and SD_BALANCE_{WAKE, FORK, EXEC} share a nibble
  (Peter)

v2 -> v3
--------
o Rebased on top of v5.7-rc1 (didn't re-run performance tests)
o Collected Reviewed-by (Dietmar)
o Updated changelog of 3/9 (Dietmar)

v1 -> v2
--------
o Removed the 'RFC' tag
o Made the sd_flags syctl read-only
o Removed the SD_LOAD_BALANCE flag
o Cleaned up ugly changes thanks to the above

Valentin Schneider (3):
  sched: Add WF_TTWU, WF_EXEC wakeup flags
  sched: Remove select_task_rq()'s sd_flag parameter
  sched/fair: Dissociate wakeup decisions from SD flag value

 kernel/sched/core.c      | 10 +++++-----
 kernel/sched/deadline.c  |  4 ++--
 kernel/sched/fair.c      | 13 +++++++------
 kernel/sched/idle.c      |  2 +-
 kernel/sched/rt.c        |  4 ++--
 kernel/sched/sched.h     | 23 +++++++++++++++--------
 kernel/sched/stop_task.c |  2 +-
 7 files changed, 33 insertions(+), 25 deletions(-)

--
2.27.0

