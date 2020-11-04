Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A23D2A5B59
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 01:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbgKDA4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 19:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729163AbgKDA4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 19:56:13 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DB4C040203
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 16:56:13 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w4so19888728ybq.21
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 16:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=fEgHoEwH/Qn4FmtMQAK1i8tQpW1NQPuJnI+u+2FH2KM=;
        b=FPor5ao+bC4TgCl1QyGqGMAkqS4F3BnFzzHIHy73yy1gvN3Jzs7nmoLnollXBLFeM/
         X/DTngmWYrti7gw3skF3RfMr+899UDUFeGiYvO5fMEeJ6cwa6WuXwblz1U4PyAz3V0PV
         VN9QYVMoaNb7iwwtoZlMPqljXJUpS2NSvyE2F0WQ8JWMvm61lrgzlFemct7gLV8izChC
         k4+1j2ql4iO/zGW/QIvgw1ksmH5V7X+I0uW8VPvQDlar/pKAk/ghv7U6qv8Bohv+Sddd
         LhVsjdwavyTOeBeQUJc7HVQmFS4vStNv4tgoo4vywf597CeO9q32VfHbH/baP915sbgD
         HPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=fEgHoEwH/Qn4FmtMQAK1i8tQpW1NQPuJnI+u+2FH2KM=;
        b=g2VcJKhkt2IZIGZDSmYxYm4zN+Dqqu5y8a/4rLbKzhfcNTjQyDR/fRSh+ZMadW/Hxz
         FPrc66cvXvLxMuOZSiBobTz0DikKJDB/XQoWAbmcIow487Qn4eohJNbO6NoZuUuTRnR9
         o21+8SioJVjIXMKSplF7wl5on85b9Wxe5jgme0PHQRU6ay69/V1sM2TdN9XMuZDE+KHV
         9ViYNi+qXWhVUM43uKJJsU2Fjy+uaC+UHWTvWlDLJmRoDxXUOAYYI8m/Q+2ObHfX0G0H
         QbISGvmtk99qNKr1sGBgWqwmKSeKSzcLY/ujYCY+IOdy9HpoDR5K4e2G6Tr5kvu2TDkO
         uFbg==
X-Gm-Message-State: AOAM532dZ0NWQ91g35YzuGIsWROKnXqOAKkpnViLQI2gUxTpUFasd2Eg
        8nB9K8kzWuZjzEjgbXCRfxWsh6kOrx/1
X-Google-Smtp-Source: ABdhPJxTDYntbdBa8z/I//1SXC9BqU8aYd/pz62IV7aOFDPluvC5odEUl+fxTAmsj1hFXNn9HHVKCoGqn/WE
Sender: "maskray via sendgmr" <maskray@maskray1.svl.corp.google.com>
X-Received: from maskray1.svl.corp.google.com ([2620:15c:2ce:0:a6ae:11ff:fe11:4abb])
 (user=maskray job=sendgmr) by 2002:a25:57d6:: with SMTP id
 l205mr31348808ybb.117.1604451372895; Tue, 03 Nov 2020 16:56:12 -0800 (PST)
Date:   Tue,  3 Nov 2020 16:56:09 -0800
Message-Id: <20201104005609.1316230-1-maskray@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH] perf bench: Update arch/x86/lib/mem{cpy,set}_64.S
From:   Fangrui Song <maskray@google.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Ian Rogers <irogers@google.com>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In memset_64.S, the macros expand to `.weak MEMSET ... .globl MEMSET`
which will produce a STB_WEAK MEMSET with GNU as but STB_GLOBAL MEMSET
with LLVM's integrated assembler before LLVM 12. LLVM 12 (since
https://reviews.llvm.org/D90108) will error on such an overridden symbol
binding. memcpy_64.S is similar.

Port http://lore.kernel.org/r/20201103012358.168682-1-maskray@google.com
("x86_64: Change .weak to SYM_FUNC_START_WEAK for arch/x86/lib/mem*_64.S")
to fix the issue. Additionally, port SYM_L_WEAK and SYM_FUNC_START_WEAK
from include/linux/linkage.h to tools/perf/util/include/linux/linkage.h

Fixes: 7d7d1bf1d1da ("perf bench: Copy kernel files needed to build mem{cpy,set} x86_64 benchmarks")
Link: https://lore.kernel.org/r/20201103012358.168682-1-maskray@google.com
Signed-off-by: Fangrui Song <maskray@google.com>
---
 tools/arch/x86/lib/memcpy_64.S          | 4 +---
 tools/arch/x86/lib/memset_64.S          | 4 +---
 tools/perf/util/include/linux/linkage.h | 7 +++++++
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/arch/x86/lib/memcpy_64.S b/tools/arch/x86/lib/memcpy_64.S
index 0b5b8ae56bd9..9428f251df0f 100644
--- a/tools/arch/x86/lib/memcpy_64.S
+++ b/tools/arch/x86/lib/memcpy_64.S
@@ -16,8 +16,6 @@
  * to a jmp to memcpy_erms which does the REP; MOVSB mem copy.
  */
 
-.weak memcpy
-
 /*
  * memcpy - Copy a memory block.
  *
@@ -30,7 +28,7 @@
  * rax original destination
  */
 SYM_FUNC_START_ALIAS(__memcpy)
-SYM_FUNC_START_LOCAL(memcpy)
+SYM_FUNC_START_WEAK(memcpy)
 	ALTERNATIVE_2 "jmp memcpy_orig", "", X86_FEATURE_REP_GOOD, \
 		      "jmp memcpy_erms", X86_FEATURE_ERMS
 
diff --git a/tools/arch/x86/lib/memset_64.S b/tools/arch/x86/lib/memset_64.S
index fd5d25a474b7..1f9b11f9244d 100644
--- a/tools/arch/x86/lib/memset_64.S
+++ b/tools/arch/x86/lib/memset_64.S
@@ -5,8 +5,6 @@
 #include <asm/cpufeatures.h>
 #include <asm/alternative-asm.h>
 
-.weak memset
-
 /*
  * ISO C memset - set a memory block to a byte value. This function uses fast
  * string to get better performance than the original function. The code is
@@ -18,7 +16,7 @@
  *
  * rax   original destination
  */
-SYM_FUNC_START_ALIAS(memset)
+SYM_FUNC_START_WEAK(memset)
 SYM_FUNC_START(__memset)
 	/*
 	 * Some CPUs support enhanced REP MOVSB/STOSB feature. It is recommended
diff --git a/tools/perf/util/include/linux/linkage.h b/tools/perf/util/include/linux/linkage.h
index b8a5159361b4..0e493bf3151b 100644
--- a/tools/perf/util/include/linux/linkage.h
+++ b/tools/perf/util/include/linux/linkage.h
@@ -25,6 +25,7 @@
 
 /* SYM_L_* -- linkage of symbols */
 #define SYM_L_GLOBAL(name)			.globl name
+#define SYM_L_WEAK(name)			.weak name
 #define SYM_L_LOCAL(name)			/* nothing */
 
 #define ALIGN __ALIGN
@@ -78,6 +79,12 @@
 	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN)
 #endif
 
+/* SYM_FUNC_START_WEAK -- use for weak functions */
+#ifndef SYM_FUNC_START_WEAK
+#define SYM_FUNC_START_WEAK(name)			\
+	SYM_START(name, SYM_L_WEAK, SYM_A_ALIGN)
+#endif
+
 /* SYM_FUNC_END_ALIAS -- the end of LOCAL_ALIASed or ALIASed function */
 #ifndef SYM_FUNC_END_ALIAS
 #define SYM_FUNC_END_ALIAS(name)			\
-- 
2.29.1.341.ge80a0c044ae-goog

