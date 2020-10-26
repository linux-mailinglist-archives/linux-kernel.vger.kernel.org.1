Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C024429991F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 22:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390985AbgJZVwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 17:52:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390424AbgJZVwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 17:52:12 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC8FE2084C;
        Mon, 26 Oct 2020 21:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603749131;
        bh=v6OsJivCdqa8FhOgFvDk5JK3W+zbBx3yaUVMWwwWQvc=;
        h=From:To:Cc:Subject:Date:From;
        b=BxA2YZqjTyWIqNjLHBHj2zO4GoKKXVxgO0rzh5dgmrUaNu/HjVIdq1k+yR+7C1m3P
         Qdfg12ta7m5CbYf7Ynz7yEtIpAejDD9EIEhe51afSRPCZbglz7OZx4L6B9oIiAsTfo
         btwvYqcrqMSjaOZzd20QSXW5bG86OEmLpfq+ZdoI=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Vaibhav Shankar <vaibhav.shankar@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] perf/x86/intel/uncore: fix Add BW copypasta
Date:   Mon, 26 Oct 2020 22:51:57 +0100
Message-Id: <20201026215203.3893972-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc -Wextra points out a duplicate initialization of one array
member:

arch/x86/events/intel/uncore_snb.c:478:37: warning: initialized field overwritten [-Woverride-init]
  478 |  [SNB_PCI_UNCORE_IMC_DATA_READS]  = { SNB_UNCORE_PCI_IMC_DATA_WRITES_BASE,

The only sensible explanation is that a duplicate 'READS' was used
instead of the correct 'WRITES', so change it back.

Fixes: 24633d901ea4 ("perf/x86/intel/uncore: Add BW counters for GT, IA and IO breakdown")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/events/intel/uncore_snb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 39e632ed6ca9..bbd1120ae161 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -475,7 +475,7 @@ enum perf_snb_uncore_imc_freerunning_types {
 static struct freerunning_counters snb_uncore_imc_freerunning[] = {
 	[SNB_PCI_UNCORE_IMC_DATA_READS]		= { SNB_UNCORE_PCI_IMC_DATA_READS_BASE,
 							0x0, 0x0, 1, 32 },
-	[SNB_PCI_UNCORE_IMC_DATA_READS]		= { SNB_UNCORE_PCI_IMC_DATA_WRITES_BASE,
+	[SNB_PCI_UNCORE_IMC_DATA_WRITES]	= { SNB_UNCORE_PCI_IMC_DATA_WRITES_BASE,
 							0x0, 0x0, 1, 32 },
 	[SNB_PCI_UNCORE_IMC_GT_REQUESTS]	= { SNB_UNCORE_PCI_IMC_GT_REQUESTS_BASE,
 							0x0, 0x0, 1, 32 },
-- 
2.27.0

