Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F237E2B6F70
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 20:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731410AbgKQT5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 14:57:30 -0500
Received: from mga12.intel.com ([192.55.52.136]:48614 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731361AbgKQT53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 14:57:29 -0500
IronPort-SDR: BQ/cwaN9OEQrR0cLfG/ztkuY/8XYxoJHfTgCQT9oEq06ioYnvxy+MAT0sLKmVC1dcKvxZlKYJ+
 Mpmf3C9mFBGA==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="150270461"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="150270461"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 11:57:28 -0800
IronPort-SDR: LvHj2/1VAUv6DtKQVcXbQQ9ZeNF7U7Lg+kYqJynAneXbDx8yXGzwlTI5x1VYZzYC4AR1pQaGG+
 Q+KPS86tXKZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="544188119"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by orsmga005.jf.intel.com with ESMTP; 17 Nov 2020 11:57:27 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@kernel.org, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, namhyung@kernel.org,
        eranian@google.com, ak@linux.intel.com, mark.rutland@arm.com,
        will@kernel.org, mpe@ellerman.id.au,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 01/12] tools headers UAPI: Update tools's copy of linux/perf_event.h
Date:   Tue, 17 Nov 2020 11:56:26 -0800
Message-Id: <20201117195637.6499-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201117195637.6499-1-kan.liang@linux.intel.com>
References: <20201117195637.6499-1-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

To get the changes in:

   commit 8d97e71811aa ("perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE")
   commit 995f088efebe ("perf/core: Add support for PERF_SAMPLE_CODE_PAGE_SIZE")

This silences this perf tools build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/perf_event.h'
differs from latest version at 'include/uapi/linux/perf_event.h'
  diff -u tools/include/uapi/linux/perf_event.h
include/uapi/linux/perf_event.h

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/include/uapi/linux/perf_event.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 3e5dcdd48a49..fe404942f838 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -143,8 +143,10 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
 	PERF_SAMPLE_AUX				= 1U << 20,
 	PERF_SAMPLE_CGROUP			= 1U << 21,
+	PERF_SAMPLE_DATA_PAGE_SIZE		= 1U << 22,
+	PERF_SAMPLE_CODE_PAGE_SIZE		= 1U << 23,
 
-	PERF_SAMPLE_MAX = 1U << 22,		/* non-ABI */
+	PERF_SAMPLE_MAX = 1U << 24,		/* non-ABI */
 
 	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
 };
@@ -896,6 +898,8 @@ enum perf_event_type {
 	 *	{ u64			phys_addr;} && PERF_SAMPLE_PHYS_ADDR
 	 *	{ u64			size;
 	 *	  char			data[size]; } && PERF_SAMPLE_AUX
+	 *	{ u64			data_page_size;} && PERF_SAMPLE_DATA_PAGE_SIZE
+	 *	{ u64			code_page_size;} && PERF_SAMPLE_CODE_PAGE_SIZE
 	 * };
 	 */
 	PERF_RECORD_SAMPLE			= 9,
-- 
2.17.1

