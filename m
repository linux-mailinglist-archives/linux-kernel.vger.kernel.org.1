Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039A826DE1D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 16:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgIQOXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 10:23:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:3714 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727353AbgIQOMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 10:12:03 -0400
IronPort-SDR: lyZGGmDA/RUrWHYlBJM+higt8OEf/A7YZuqigtN5S/dkKS5cLzGHj9NHfNbuZMlDGCq44SgkhA
 us4P1T3LZ1aw==
X-IronPort-AV: E=McAfee;i="6000,8403,9746"; a="244532746"
X-IronPort-AV: E=Sophos;i="5.76,437,1592895600"; 
   d="scan'208";a="244532746"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 06:53:42 -0700
IronPort-SDR: pMGfDHgPVQRBhd6WjE2V3eyyBirHTbg/JzroCrn4S49eQoRkSK9g/+F3bUbDxHwyxeLuTgMmPl
 BnsnCGN4OZCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,437,1592895600"; 
   d="scan'208";a="380543143"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by orsmga001.jf.intel.com with ESMTP; 17 Sep 2020 06:53:42 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V7 4/4] perf/core: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
Date:   Thu, 17 Sep 2020 06:52:37 -0700
Message-Id: <20200917135237.2857-5-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200917135237.2857-1-kan.liang@linux.intel.com>
References: <20200917135237.2857-1-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

When studying code layout, it is useful to capture the page size of the
sampled code address.

Add a new sample type for code page size.
The new sample type requires collecting the ip. The code page size can
be calculated from the NMI-safe perf_get_page_size().

For large PEBS, it's very unlikely that the mapping is gone for the
earlier PEBS records. Enable the feature for the large PEBS. The worst
case is that page-size '0' is returned.

Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/perf_event.h    |  2 +-
 include/linux/perf_event.h      |  1 +
 include/uapi/linux/perf_event.h |  4 +++-
 kernel/events/core.c            | 11 ++++++++++-
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 345442410a4d..10629ef1b626 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -132,7 +132,7 @@ struct amd_nb {
 	PERF_SAMPLE_DATA_SRC | PERF_SAMPLE_IDENTIFIER | \
 	PERF_SAMPLE_TRANSACTION | PERF_SAMPLE_PHYS_ADDR | \
 	PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER | \
-	PERF_SAMPLE_PERIOD)
+	PERF_SAMPLE_PERIOD | PERF_SAMPLE_CODE_PAGE_SIZE)
 
 #define PEBS_GP_REGS			\
 	((1ULL << PERF_REG_X86_AX)    | \
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 7e3785dd27d9..e533b03af053 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1035,6 +1035,7 @@ struct perf_sample_data {
 	u64				phys_addr;
 	u64				cgroup;
 	u64				data_page_size;
+	u64				code_page_size;
 } ____cacheline_aligned;
 
 /* default value for data source */
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index cc6ea346e9f9..c2f20ee3124d 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -144,8 +144,9 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_AUX				= 1U << 20,
 	PERF_SAMPLE_CGROUP			= 1U << 21,
 	PERF_SAMPLE_DATA_PAGE_SIZE		= 1U << 22,
+	PERF_SAMPLE_CODE_PAGE_SIZE		= 1U << 23,
 
-	PERF_SAMPLE_MAX = 1U << 23,		/* non-ABI */
+	PERF_SAMPLE_MAX = 1U << 24,		/* non-ABI */
 
 	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
 };
@@ -898,6 +899,7 @@ enum perf_event_type {
 	 *	{ u64			size;
 	 *	  char			data[size]; } && PERF_SAMPLE_AUX
 	 *	{ u64			data_page_size;} && PERF_SAMPLE_DATA_PAGE_SIZE
+	 *	{ u64			code_page_size;} && PERF_SAMPLE_CODE_PAGE_SIZE
 	 * };
 	 */
 	PERF_RECORD_SAMPLE			= 9,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index dc0ae692e32b..51452d5edfac 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1898,6 +1898,9 @@ static void __perf_event_header_size(struct perf_event *event, u64 sample_type)
 	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
 		size += sizeof(data->data_page_size);
 
+	if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
+		size += sizeof(data->code_page_size);
+
 	event->header_size = size;
 }
 
@@ -6944,6 +6947,9 @@ void perf_output_sample(struct perf_output_handle *handle,
 	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
 		perf_output_put(handle, data->data_page_size);
 
+	if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
+		perf_output_put(handle, data->code_page_size);
+
 	if (sample_type & PERF_SAMPLE_AUX) {
 		perf_output_put(handle, data->aux_size);
 
@@ -7124,7 +7130,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 
 	__perf_event_header__init_id(header, data, event);
 
-	if (sample_type & PERF_SAMPLE_IP)
+	if (sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_CODE_PAGE_SIZE))
 		data->ip = perf_instruction_pointer(regs);
 
 	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
@@ -7252,6 +7258,9 @@ void perf_prepare_sample(struct perf_event_header *header,
 	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
 		data->data_page_size = perf_get_page_size(data->addr);
 
+	if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
+		data->code_page_size = perf_get_page_size(data->ip);
+
 	if (sample_type & PERF_SAMPLE_AUX) {
 		u64 size;
 
-- 
2.17.1

