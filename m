Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215DC2EFE53
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 08:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbhAIHpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 02:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbhAIHpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 02:45:44 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4A7C0613C1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 23:45:03 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id j13so7505250pjz.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 23:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ur+i5mnXVMoiLpNfSuPbVvw5IIiW/Rm/SXsCiDAi43M=;
        b=DR0seVr8sXp6H3nk/nzWCyYbPkQz/Tq3x6qlgDrW+0tLUk6RgRd8089mjP2r+xAcuh
         5Q0opjHzngmvlXI9NttaXeb28QUUY3UtDHRpyM1Oxfyvtje8fpGw2CBXlCnqcNYWY0jW
         hdj+zKqGJv655lAVyKqOmcBuvRDzxK173X+w3+OHo/8XkYoDC8Cxw0WdelDW2ErM6sym
         Fkf5wNSmCk5Hsfz9+TyVjx+YU6MPbmR7gXvpiKM6PcUu+lzTN8h8SCE5mH0jaxYmbcsu
         nadx/gLunFxRhE9qbPrlRhUJvXQMWBr6GjQiilQtaFSQnnI7QZMel69qRGIdbRKqsPCL
         wi6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ur+i5mnXVMoiLpNfSuPbVvw5IIiW/Rm/SXsCiDAi43M=;
        b=skP5al41hlq0mNt0s3DlOwFJEzv8QfVwS+I9cDfGkmQInpMmt+WhLhQv8afc03mb4J
         9p6PqStq6gXk674sW3ZI++D3ibxcg9W6SgdUCcmK4t/UH4BJfsxnWnPc/bhn/cYcfRzh
         o+SpbO+zUzwbzi3cZ3MxMYCNUihdxApguLrCqkOPVRyW8yXdByckN/iRu1T5v4yd1gFJ
         o1xpwj5A1zYv9yNBG5bRwdGyIqd74yHypQKB5Vn8/mt219JBHhLjR2judglQJIEMr9gz
         ch6u6khKA6tynEo2PpxNabvyabhT4NaRj777v+3E9bHgPrlpAK0ByQYzPOuBDh5VZZpA
         tpEA==
X-Gm-Message-State: AOAM531c39e4CWN0697y352pS46EdnXi4wDaRfPj3XoE1RhUel0b0cfz
        IUpHnSDTlv8fZOiM/CUBLyDCxr1aoVy9LBcn
X-Google-Smtp-Source: ABdhPJwMeGp+OT+EQHGNAS2ppjZBBcNAneyegbBDDUcJJFrAzQIDYJ4KXHZGH97MQZ+yfsIyw5wGgQ==
X-Received: by 2002:a17:90a:31c3:: with SMTP id j3mr7483579pjf.25.1610178303366;
        Fri, 08 Jan 2021 23:45:03 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id t22sm12873711pgm.18.2021.01.08.23.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 23:45:02 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <Daniel.Kiss@arm.com>,
        Denis Nikitin <denik@chromium.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 3/7] perf cs-etm: Calculate per CPU metadata array size
Date:   Sat,  9 Jan 2021 15:44:31 +0800
Message-Id: <20210109074435.626855-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210109074435.626855-1-leo.yan@linaro.org>
References: <20210109074435.626855-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The metadata array can be extended over time and the tool, if using the
predefined macro (like CS_ETMV4_PRIV_MAX for ETMv4) as metadata array
size to copy data, it can cause compatible issue within different
versions of perf tool.

E.g. we recorded a data file with an old version tool, afterwards if
use the new version perf tool to parse the file, since the metadata
array has been extended and the macro CS_ETMV4_PRIV_MAX has been
altered, if use it to parse the perf data with old format, this will
lead to mismatch.

To maintain backward compatibility, this patch calculates per CPU
metadata array size on the runtime, the calculation is based on the
info stored in the data file so that it's reliable.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index a2a369e2fbb6..5e284725dceb 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2497,6 +2497,7 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	int i, j, k;
 	u64 *ptr, *hdr = NULL;
 	u64 **metadata = NULL;
+	int metadata_cpu_array_size;
 
 	/*
 	 * sizeof(auxtrace_info_event::type) +
@@ -2544,6 +2545,19 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 		goto err_free_traceid_list;
 	}
 
+	/*
+	 * The metadata is a two dimensional array, the first dimension uses CPU
+	 * number as index and the second dimension is the metadata array per
+	 * CPU.  Since the metadata array can be extended over time, the
+	 * predefined macros (CS_ETM_PRIV_MAX or CS_ETMV4_PRIV_MAX) might
+	 * mismatch within different versions of tool, this can lead to copy
+	 * wrong data.  To maintain backward compatibility, calculate CPU's
+	 * metadata array size on the runtime.
+	 */
+	metadata_cpu_array_size =
+		(auxtrace_info->header.size -
+		 sizeof(struct perf_record_auxtrace_info)) / num_cpu / sizeof(u64);
+
 	/*
 	 * The metadata is stored in the auxtrace_info section and encodes
 	 * the configuration of the ARM embedded trace macrocell which is
@@ -2558,12 +2572,12 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 				err = -ENOMEM;
 				goto err_free_metadata;
 			}
-			for (k = 0; k < CS_ETM_PRIV_MAX; k++)
+			for (k = 0; k < metadata_cpu_array_size; k++)
 				metadata[j][k] = ptr[i + k];
 
 			/* The traceID is our handle */
 			idx = metadata[j][CS_ETM_ETMTRACEIDR];
-			i += CS_ETM_PRIV_MAX;
+			i += metadata_cpu_array_size;
 		} else if (ptr[i] == __perf_cs_etmv4_magic) {
 			metadata[j] = zalloc(sizeof(*metadata[j]) *
 					     CS_ETMV4_PRIV_MAX);
@@ -2571,12 +2585,12 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 				err = -ENOMEM;
 				goto err_free_metadata;
 			}
-			for (k = 0; k < CS_ETMV4_PRIV_MAX; k++)
+			for (k = 0; k < metadata_cpu_array_size; k++)
 				metadata[j][k] = ptr[i + k];
 
 			/* The traceID is our handle */
 			idx = metadata[j][CS_ETMV4_TRCTRACEIDR];
-			i += CS_ETMV4_PRIV_MAX;
+			i += metadata_cpu_array_size;
 		}
 
 		/* Get an RB node for this CPU */
-- 
2.25.1

