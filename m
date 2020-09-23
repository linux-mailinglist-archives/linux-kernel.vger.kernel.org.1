Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46658275ECF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 19:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgIWRj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 13:39:57 -0400
Received: from mga04.intel.com ([192.55.52.120]:17159 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbgIWRj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 13:39:57 -0400
IronPort-SDR: NDTaTnuJ3ILZ9YTmimWaVdttVMRythLhNlxEmSEUfZNXdmQxw1L6KqHBEBOSoQbUOWHj+YZnJ4
 dyrll37KKYtA==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="158372081"
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="158372081"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 10:39:57 -0700
IronPort-SDR: l/p7iSt4D/0o7SpwXtXWSrDNVwVnREFcqk9shbPX11s02ofuyv57DcHWdIF87fDkIrTiMrnvG8
 rXC6RVZcGEEw==
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="309992887"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.212.14.213])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 10:39:53 -0700
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     keescook@chromium.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     arjan@linux.intel.com, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com, rick.p.edgecombe@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH v5 02/10] x86/boot: Allow a "silent" kaslr random byte fetch
Date:   Wed, 23 Sep 2020 10:38:56 -0700
Message-Id: <20200923173905.11219-3-kristen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200923173905.11219-1-kristen@linux.intel.com>
References: <20200923173905.11219-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

Under earlyprintk, each RNG call produces a debug report line. When
shuffling hundreds of functions, this is not useful information (each
line is identical and tells us nothing new). Instead, allow for a NULL
"purpose" to suppress the debug reporting.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 arch/x86/lib/kaslr.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/x86/lib/kaslr.c b/arch/x86/lib/kaslr.c
index a53665116458..2b3eb8c948a3 100644
--- a/arch/x86/lib/kaslr.c
+++ b/arch/x86/lib/kaslr.c
@@ -56,11 +56,14 @@ unsigned long kaslr_get_random_long(const char *purpose)
 	unsigned long raw, random = get_boot_seed();
 	bool use_i8254 = true;
 
-	debug_putstr(purpose);
-	debug_putstr(" KASLR using");
+	if (purpose) {
+		debug_putstr(purpose);
+		debug_putstr(" KASLR using");
+	}
 
 	if (has_cpuflag(X86_FEATURE_RDRAND)) {
-		debug_putstr(" RDRAND");
+		if (purpose)
+			debug_putstr(" RDRAND");
 		if (rdrand_long(&raw)) {
 			random ^= raw;
 			use_i8254 = false;
@@ -68,7 +71,8 @@ unsigned long kaslr_get_random_long(const char *purpose)
 	}
 
 	if (has_cpuflag(X86_FEATURE_TSC)) {
-		debug_putstr(" RDTSC");
+		if (purpose)
+			debug_putstr(" RDTSC");
 		raw = rdtsc();
 
 		random ^= raw;
@@ -76,7 +80,8 @@ unsigned long kaslr_get_random_long(const char *purpose)
 	}
 
 	if (use_i8254) {
-		debug_putstr(" i8254");
+		if (purpose)
+			debug_putstr(" i8254");
 		random ^= i8254();
 	}
 
@@ -86,7 +91,8 @@ unsigned long kaslr_get_random_long(const char *purpose)
 	    : "a" (random), "rm" (mix_const));
 	random += raw;
 
-	debug_putstr("...\n");
+	if (purpose)
+		debug_putstr("...\n");
 
 	return random;
 }
-- 
2.20.1

