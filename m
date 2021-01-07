Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2A22ED545
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 18:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbhAGRQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 12:16:21 -0500
Received: from mga14.intel.com ([192.55.52.115]:54640 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbhAGRQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 12:16:21 -0500
IronPort-SDR: RJDtVfWOD2blekj20qclO6jBeVTO+ezNq0WCg9hoXSzCvi4Jm9EonrDlqoJQqN0V2kKGHyoqbp
 apaFPaC+cf7w==
X-IronPort-AV: E=McAfee;i="6000,8403,9857"; a="176682586"
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="176682586"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 09:15:39 -0800
IronPort-SDR: tjNLgNlYhW8IhFXn6o1pqzN9UJfr5wKFra1o377BEM/elVgQ1Tzx6TU82nbGa7oKVEJLCPoeaN
 AXcw2igPCxog==
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="422647515"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 09:15:39 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>
Subject: [RFC PATCH] x86/mce: Add ppin and microcode to mce trace
Date:   Thu,  7 Jan 2021 09:12:25 -0800
Message-Id: <20210107171225.21903-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven,

I've been remiss about updating the mce_record trace as new fields
have been added to "struct mce". What are the ABI implications of a
patch like the one below (sample only ... there are a couple more fields
that may need to be added)?

Are there any size limitations that I might hit adding more items to
this record?

Thanks

-Tony

---
 include/trace/events/mce.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/mce.h b/include/trace/events/mce.h
index 1391ada0da3b..cf0e8b9920b7 100644
--- a/include/trace/events/mce.h
+++ b/include/trace/events/mce.h
@@ -33,6 +33,8 @@ TRACE_EVENT(mce_record,
 		__field(	u8,		cs		)
 		__field(	u8,		bank		)
 		__field(	u8,		cpuvendor	)
+		__field(	u64,		ppin		)
+		__field(	u32,		microcode	)
 	),
 
 	TP_fast_assign(
@@ -53,9 +55,11 @@ TRACE_EVENT(mce_record,
 		__entry->cs		= m->cs;
 		__entry->bank		= m->bank;
 		__entry->cpuvendor	= m->cpuvendor;
+		__entry->ppin		= m->ppin;
+		__entry->microcode	= m->microcode;
 	),
 
-	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PROCESSOR: %u:%x, TIME: %llu, SOCKET: %u, APIC: %x",
+	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PROCESSOR: %u:%x, TIME: %llu, SOCKET: %u, APIC: %x, PPIN: %llx, MICROCODE: %x",
 		__entry->cpu,
 		__entry->mcgcap, __entry->mcgstatus,
 		__entry->bank, __entry->status,
@@ -66,7 +70,7 @@ TRACE_EVENT(mce_record,
 		__entry->cpuvendor, __entry->cpuid,
 		__entry->walltime,
 		__entry->socketid,
-		__entry->apicid)
+		__entry->apicid, __entry->ppin, __entry->microcode)
 );
 
 #endif /* _TRACE_MCE_H */
-- 
2.21.1

