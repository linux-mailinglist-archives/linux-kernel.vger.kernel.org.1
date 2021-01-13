Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89AEB2F40E2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 02:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbhAMBBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 20:01:06 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:10959 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727187AbhAMBBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 20:01:03 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DFpxY3GRPzj5fy;
        Wed, 13 Jan 2021 08:59:29 +0800 (CST)
Received: from huawei.com (10.174.28.241) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Wed, 13 Jan 2021
 09:00:10 +0800
From:   Bixuan Cui <cuibixuan@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <john.wanghui@huawei.com>
Subject: [PATCH 0/2] perf tools: add 'perf irq' to measure the hardware interrupts
Date:   Wed, 13 Jan 2021 08:59:16 +0800
Message-ID: <20210113005918.73685-1-cuibixuan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.28.241]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the hardware interrupt processing function is executed, the interrupt and 
preemption of current cpu are disabled. As a result, the task is suspended.
The execution of the hardware processing function takes a long time
(for example 5 ms), will affect the task scheduling performance.

This patches provides the 'perf irq' command to trace and calculate the time
consumed of the hardware irq function.


[verse]
'perf irq' {record|timeconsume|script}

There are several variants of 'perf irq':

  'perf irq record <command>' to record the irq handler events
  of an arbitrary workload.

  'perf irq script' to see a detailed trace of the workload that
   was recorded (aliased to 'perf script' for now).

  'perf irq timeconsume' to calculate the time consumed by each
   hardware interrupt processing function.

    Example usage:
        perf irq record -- sleep 1
        perf irq timeconsume

   By default it shows the individual irq events, including the irq name,
   cpu(execute the hardware interrupt processing function), time consumed,
   entry time and exit time for the each hardware irq:

   -------------------------------------------------------------------------------------------------------------------------------------------
     Irq name         |  CPU   | Time consume us | Handler entry time | Handler exit time
   -------------------------------------------------------------------------------------------------------------------------------------------
     enp2s0f2-tx-0    | [0006] |      0.000001 s |   6631263.313329 s |   6631263.313330 s

   -------------------------------------------------------------------------------------------------------------------------------------------
     Irq name         |  CPU   | Time consume us | Handler entry time | Handler exit time
   -------------------------------------------------------------------------------------------------------------------------------------------
     megasas          | [0013] |      0.000003 s |   6631263.209564 s |   6631263.209567 s

   -------------------------------------------------------------------------------------------------------------------------------------------
     Irq name         |  CPU   | Time consume us | Handler entry time | Handler exit time
   -------------------------------------------------------------------------------------------------------------------------------------------
     acpi             | [0016] |      0.000018 s |   6631263.085787 s |   6631263.085805 s

Bixuan Cui (2):
  perf tools: add 'perf irq' to measure the hardware interrupts
  perf tools: Add documentation for 'perf irq' command

 tools/perf/Build                      |   1 +
 tools/perf/Documentation/perf-irq.txt |  58 ++++++
 tools/perf/builtin-irq.c              | 288 ++++++++++++++++++++++++++
 tools/perf/builtin.h                  |   1 +
 tools/perf/command-list.txt           |   1 +
 tools/perf/perf.c                     |   1 +
 6 files changed, 350 insertions(+)
 create mode 100644 tools/perf/Documentation/perf-irq.txt
 create mode 100644 tools/perf/builtin-irq.c

-- 
2.17.1

