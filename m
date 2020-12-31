Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7432E8221
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 22:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgLaVaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 16:30:11 -0500
Received: from mail-il1-f170.google.com ([209.85.166.170]:38960 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgLaVaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 16:30:11 -0500
Received: by mail-il1-f170.google.com with SMTP id q1so18264913ilt.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Dec 2020 13:29:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s3PoZ0PHUx1hgtai3jyNcYrrctOineum5xKahaAQuf0=;
        b=ZE7bunhKLudMglU1usokm8L/S0Ra9ttJt5NgOmGBbUUPQVcqiA4WpYVQlqt/xA1rkJ
         U/sVpr0yfIk2tDG8yT+QE4WAmycSiiT4Z9PjNiXgO11mUBax4RudNCwzhwe9du+Ifibz
         hB6bt7GClrmNn1RykhMotDlz7QzXseogbpL83NnX+fp/sb7281CjXGOr4f+FIF5BnaK0
         exsMDTKaWQSGrLbXEZbMxccPSempDSncRoTWxG5EI7czMv0YieBFoJplnKBtCacM4llf
         9d4FA+gaony8Iq6JkvPIBc3fTl0qPgG6+vkPXJ8d83b9hi8jw8fuDbyYl2Zva198q5rr
         fcZQ==
X-Gm-Message-State: AOAM530ii3dlPuj9lLLfk89t2hbNBgj+0LWWIYCBA9VLCBo3R0rZXUSS
        BSDtAjbydHyj2tcyXhI8SB8=
X-Google-Smtp-Source: ABdhPJwEYHZ/2q0xIq0QPy5lZGzubep2jTAG3l806YSYcy6yUgLb+jOITjXbV94qdLlalD73g7rGwA==
X-Received: by 2002:a05:6e02:10c8:: with SMTP id s8mr33393800ilj.13.1609450170050;
        Thu, 31 Dec 2020 13:29:30 -0800 (PST)
Received: from abasin.c.googlers.com.com (110.41.72.34.bc.googleusercontent.com. [34.72.41.110])
        by smtp.gmail.com with ESMTPSA id g13sm33454498iln.12.2020.12.31.13.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 13:29:29 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        Dennis Zhou <dennis@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] percpu: fix clang modpost warning in pcpu_build_alloc_info()
Date:   Thu, 31 Dec 2020 21:28:52 +0000
Message-Id: <20201231212852.3175381-1-dennis@kernel.org>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an unusual situation so I thought it best to explain it in a
separate patch.

"percpu: reduce the number of cpu distance comparisons" introduces a
dependency on cpumask helper functions in __init code. This code
references a struct cpumask annotated __initdata. When the function is
inlined (gcc), everything is fine, but clang decides not to inline these
function calls. This causes modpost to warn about an __initdata access
by a function not annotated with __init [1].

Ways I thought about fixing it:
1. figure out why clang thinks this inlining is too costly.
2. create a wrapper function annotated __init (this).
3. annotate cpumask with __refdata.

Ultimately it comes down to if it's worth saving the cpumask memory and
allowing it to be freed. IIUC, __refdata won't be freed, so option 3 is
just a little wasteful. 1 is out of my depth, leaving 2. I don't feel
great about this behavior being dependent on inlining semantics, but
cpumask helpers are small and probably should be inlined.

modpost complaint:
  WARNING: modpost: vmlinux.o(.text+0x735425): Section mismatch in reference from the function cpumask_clear_cpu() to the variable .init.data:pcpu_build_alloc_info.mask
  The function cpumask_clear_cpu() references
  the variable __initdata pcpu_build_alloc_info.mask.
  This is often because cpumask_clear_cpu lacks a __initdata
  annotation or the annotation of pcpu_build_alloc_info.mask is wrong.

clang output:
  mm/percpu.c:2724:5: remark: cpumask_clear_cpu not inlined into pcpu_build_alloc_info because too costly to inline (cost=725, threshold=325) [-Rpass-missed=inline]

[1] https://lore.kernel.org/linux-mm/202012220454.9F6Bkz9q-lkp@intel.com/

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
This is on top of percpu#for-5.12.

 mm/percpu.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 80f8f885a990..357977c4cb00 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2642,6 +2642,18 @@ early_param("percpu_alloc", percpu_alloc_setup);
 
 /* pcpu_build_alloc_info() is used by both embed and page first chunk */
 #if defined(BUILD_EMBED_FIRST_CHUNK) || defined(BUILD_PAGE_FIRST_CHUNK)
+
+/*
+ * This wrapper is to avoid a warning where cpumask_clear_cpu() is not inlined
+ * when compiling with clang causing modpost to warn about accessing __initdata
+ * from a non __init function.  By doing this, we allow the struct cpumask to be
+ * freed instead of it taking space by annotating with __refdata.
+ */
+static void __init pcpu_cpumask_clear_cpu(int cpu, struct cpumask *mask)
+{
+	cpumask_clear_cpu(cpu, mask);
+}
+
 /**
  * pcpu_build_alloc_info - build alloc_info considering distances between CPUs
  * @reserved_size: the size of reserved percpu area in bytes
@@ -2713,7 +2725,7 @@ static struct pcpu_alloc_info * __init pcpu_build_alloc_info(
 		cpu = cpumask_first(&mask);
 		group_map[cpu] = group;
 		group_cnt[group]++;
-		cpumask_clear_cpu(cpu, &mask);
+		pcpu_cpumask_clear_cpu(cpu, &mask);
 
 		for_each_cpu(tcpu, &mask) {
 			if (!cpu_distance_fn ||
@@ -2721,7 +2733,7 @@ static struct pcpu_alloc_info * __init pcpu_build_alloc_info(
 			     cpu_distance_fn(tcpu, cpu) == LOCAL_DISTANCE)) {
 				group_map[tcpu] = group;
 				group_cnt[group]++;
-				cpumask_clear_cpu(tcpu, &mask);
+				pcpu_cpumask_clear_cpu(tcpu, &mask);
 			}
 		}
 	}
-- 
2.29.2.729.g45daf8777d-goog

