Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEE21B9716
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 08:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgD0GQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 02:16:03 -0400
Received: from foss.arm.com ([217.140.110.172]:56966 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbgD0GQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 02:16:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 218E331B;
        Sun, 26 Apr 2020 23:16:02 -0700 (PDT)
Received: from nicgas01-03-arm-vm.shanghai.arm.com (nicgas01-03-arm-vm.shanghai.arm.com [10.169.139.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0F423F73D;
        Sun, 26 Apr 2020 23:15:59 -0700 (PDT)
From:   Nick Gasson <nick.gasson@arm.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Nick Gasson <nick.gasson@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] perf jvmti: Various fixes to JVMTI agent
Date:   Mon, 27 Apr 2020 14:15:13 +0800
Message-Id: <20200427061520.24905-1-nick.gasson@arm.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These three patches fix a couple of issues I ran into while using the
jitdump JVMTI agent to profile the SPECjbb benchmark.

Tested with OpenJDK 8 and 14.

Thanks,
Nick


Nick Gasson (3):
  perf jvmti: Fix jitdump for methods without debug info
  perf jvmti: Do not report error when missing debug information
  perf jvmti: Fix demangling Java symbols

 tools/perf/jvmti/libjvmti.c           | 24 +++++++--------
 tools/perf/tests/Build                |  1 +
 tools/perf/tests/builtin-test.c       |  4 +++
 tools/perf/tests/demangle-java-test.c | 42 +++++++++++++++++++++++++++
 tools/perf/tests/tests.h              |  1 +
 tools/perf/util/demangle-java.c       | 13 +++++----
 6 files changed, 66 insertions(+), 19 deletions(-)
 create mode 100644 tools/perf/tests/demangle-java-test.c

-- 
2.26.1

