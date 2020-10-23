Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A20629686A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 04:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374479AbgJWCGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 22:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374472AbgJWCGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 22:06:37 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9565FC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 19:06:35 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t4so32358plq.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 19:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z/yeAGcBPMGJ7wXSXQ/nz7qrdo5sTv1FqSZ7yT/QmoA=;
        b=YRTZftdPPt0d40caYdFxN0JlV5+ojRSNp1GurRiRoHUZVTqRH2N6hsArflPHsID33Z
         o+OunPjLZswUzKC1rCIXwhW7KzI2fu2j0Q+0GQCdn5ppLJKH/YqtztUxmSZgKAupuJNm
         qN+XIr5UcYSP56QTmRgYY5IXYW78MGDBfrZtXboEhUc/SoFrD+uFXf1bcDUBEgLlN09a
         hooPZUU0q/Oa5VinKOmWMmAK427Ig0hV0p45zcjJBYv5c2sOv2yUVaiSPtfFxQxrAG8N
         nT82Wcd1LpNKl4dkAnupXF/Ny90GCPU2s9aDiLiFzu51y+Ab0vznGaKYLWxKGr2Ky0vT
         mzqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Z/yeAGcBPMGJ7wXSXQ/nz7qrdo5sTv1FqSZ7yT/QmoA=;
        b=E3PgZtjzEbX5Va2FvLWPsECfpdGy0oap07dHpUOIkq7wHIur33Nmaccoc4q++NYLoJ
         7JuhhUKVFWS5z3Z7n82pS9boVaVY8OWmOlJvK4yX0Qltw5sXBgel0PRgeUraTOjfp45R
         tCD6eGuD+SaN5sGpOGtBnKI9uWyfqLe6psZ3AzRz417A8HtUHVIfhZcR6EOxEHQSHnhO
         BloAvB/IGEGKSyvu37a5unK3+esak8lmm2wzTs3QANMndhePiQKi4DqFxlUGhmELqIDy
         IeX3cnxXzEv6VIAOxNTiAtnWqYLJm/r84d8MSiSFC+XBsxzvVJBwuqJCnCp04H0V0Nct
         53jA==
X-Gm-Message-State: AOAM532uo6GXv2UhA7G0Iaa7GIjFBKYKHVP4wxCG+NF3xjuM2g8MBLtU
        euVhX/J3vChbhvtxvkjE0BI=
X-Google-Smtp-Source: ABdhPJyAaFlk/W1q2mHSOqMljUN2fAPjQt/kFoH4EmPCVvGV4Ol9BLxCcNduSgEM7Y+HOx6sL4V8Xg==
X-Received: by 2002:a17:902:7794:b029:d5:ced2:cc20 with SMTP id o20-20020a1709027794b02900d5ced2cc20mr102275pll.25.1603418795147;
        Thu, 22 Oct 2020 19:06:35 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([112.159.19.5])
        by smtp.gmail.com with ESMTPSA id ga19sm143978pjb.3.2020.10.22.19.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 19:06:34 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH] perf trace beauty: Allow header files in a different path
Date:   Fri, 23 Oct 2020 11:06:28 +0900
Message-Id: <20201023020628.346257-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current script to generate mmap flags and prot checks headers from the
uapi/asm-generic directory but it might come from a different
directory in some environment.  So change the pattern to accept it.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/trace/beauty/mmap_flags.sh | 4 ++--
 tools/perf/trace/beauty/mmap_prot.sh  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/trace/beauty/mmap_flags.sh b/tools/perf/trace/beauty/mmap_flags.sh
index 39eb2595983b..76825710c725 100755
--- a/tools/perf/trace/beauty/mmap_flags.sh
+++ b/tools/perf/trace/beauty/mmap_flags.sh
@@ -28,12 +28,12 @@ egrep -q $regex ${linux_mman} && \
 	egrep -vw 'MAP_(UNINITIALIZED|TYPE|SHARED_VALIDATE)' | \
 	sed -r "s/$regex/\2 \1 \1 \1 \2/g" | \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n#ifndef MAP_%s\n#define MAP_%s %s\n#endif\n")
-([ ! -f ${arch_mman} ] || egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.*' ${arch_mman}) &&
+([ ! -f ${arch_mman} ] || egrep -q '#[[:space:]]*include[[:space:]]+.*uapi/asm-generic/mman.*' ${arch_mman}) &&
 (egrep $regex ${header_dir}/mman-common.h | \
 	egrep -vw 'MAP_(UNINITIALIZED|TYPE|SHARED_VALIDATE)' | \
 	sed -r "s/$regex/\2 \1 \1 \1 \2/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n#ifndef MAP_%s\n#define MAP_%s %s\n#endif\n")
-([ ! -f ${arch_mman} ] || egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.h>.*' ${arch_mman}) &&
+([ ! -f ${arch_mman} ] || egrep -q '#[[:space:]]*include[[:space:]]+.*uapi/asm-generic/mman.h>.*' ${arch_mman}) &&
 (egrep $regex ${header_dir}/mman.h | \
 	sed -r "s/$regex/\2 \1 \1 \1 \2/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n#ifndef MAP_%s\n#define MAP_%s %s\n#endif\n")
diff --git a/tools/perf/trace/beauty/mmap_prot.sh b/tools/perf/trace/beauty/mmap_prot.sh
index 28f638f8d216..664d8d534a50 100755
--- a/tools/perf/trace/beauty/mmap_prot.sh
+++ b/tools/perf/trace/beauty/mmap_prot.sh
@@ -17,7 +17,7 @@ prefix="PROT"
 
 printf "static const char *mmap_prot[] = {\n"
 regex=`printf '^[[:space:]]*#[[:space:]]*define[[:space:]]+%s_([[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*' ${prefix}`
-([ ! -f ${arch_mman} ] || egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.*' ${arch_mman}) &&
+([ ! -f ${arch_mman} ] || egrep -q '#[[:space:]]*include[[:space:]]+.*uapi/asm-generic/mman.*' ${arch_mman}) &&
 (egrep $regex ${common_mman} | \
 	egrep -vw PROT_NONE | \
 	sed -r "s/$regex/\2 \1 \1 \1 \2/g"	| \
-- 
2.29.0.rc1.297.gfa9743e501-goog

