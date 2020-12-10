Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84B02D622B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 17:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391783AbgLJQki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 11:40:38 -0500
Received: from foss.arm.com ([217.140.110.172]:52440 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391274AbgLJQj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 11:39:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B619B31B;
        Thu, 10 Dec 2020 08:39:13 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5A0A23F66B;
        Thu, 10 Dec 2020 08:39:11 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org, bigeasy@linutronix.de, qais.yousef@arm.com,
        swood@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org,
        ouwen210@hotmail.com, Qian Cai <cai@redhat.com>
Subject: [PATCH 0/2] workqueue: Fix migrate_disable hotplug changes vs kworker affinity
Date:   Thu, 10 Dec 2020 16:38:28 +0000
Message-Id: <20201210163830.21514-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

This should fix the issue reported by Qian at [1]. Dietmar mentioned some
other issue with hotplug & deadline tasks, but that's being investigated by
someone else ATM. 


I would like to mention I suspect this bug comes straight from $hell, as
I've never ever had to fight off so many (mostly unrelated) issues while
looking into it. Distro kernel being mangled, git tree corruption, periods of
heisenbugism...

Cheers,
Valentin

[1]: https://lore.kernel.org/r/ff62e3ee994efb3620177bf7b19fab16f4866845.camel@redhat.com

Valentin Schneider (2):
  stop_machine: Add caller debug info to queue_stop_cpus_work
  workqueue: Fix affinity of kworkers attached during late hotplug

 kernel/stop_machine.c |  1 +
 kernel/workqueue.c    | 24 +++++++++++++++++-------
 2 files changed, 18 insertions(+), 7 deletions(-)

--
2.27.0

