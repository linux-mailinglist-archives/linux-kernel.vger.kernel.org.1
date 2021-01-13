Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E8F2F4C45
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 14:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbhAMNfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 08:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbhAMNft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 08:35:49 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40353C061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 05:35:09 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id i9so2156743wrc.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 05:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=AxTIM6AGJEYj0Y8xaXknzhkI5SLoKlsZjTeI7Vy1uEQ=;
        b=E9jzZo71pECG6+R8UNUwz3uyt/WgN3jI02yTZhOor//G4QxYv0Bhm+iWlKiRpLFzkz
         e/spnP45hhb1WebLUWp/dxozxDCb62/q5acxCEDyMgF3lncb4/Uj8d8lZClgze74Sw78
         B7TcKICAkrYzXT6KrZTRGVRJq6puQp3dq+4jHFCJTw54X4pNUe7CTX+1B7FeEc9yLjG0
         XzwGymTw6TNLn7VsvSZsOBw2dnAD9YGB2DDKN/hiB6xA18nfbA5zqnlUSykoYlw6s+zD
         3cEgSqQZSU+SB7mQStgFYvx1TzBfL9SoV2OFOjljBtXaaKbDQwkKl6Oz916LwcLZ04eE
         i9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AxTIM6AGJEYj0Y8xaXknzhkI5SLoKlsZjTeI7Vy1uEQ=;
        b=IHhV00sqr9zBaU4pyibR0WJGVhidgVXKd7rk4roYGcEyEEIeds6WUDSzdGPdiZtgBZ
         JwzRGAk3+nlxGbnOGquuTv3P8ixUOZNdvZGk+pM1UV3aA3crVx0FCp5cS227w1KCH6mZ
         zyP6/E9uP0NjFrxpdg8vAmRVLU3l7bOsFUL/QSdTwMg+mALKLKo2SFgZVY11TaS56WxH
         khtgGoi5ykXmsng3K8L5Faoz7O2UUEJ1q/gXT0F/z4mHafZ7agPQAUluXd9yKz3ssQIX
         gadxEBT1/BIFJc7o/7lHykfnqar3qef27soBU2/kEFc5XqCLzuwRUbun4o3cIT3sFOzf
         5UjA==
X-Gm-Message-State: AOAM533suqgLEs2GNtKLxbfkHwGKfKsT4ULXmm8Hu8yZJD+Dzn5Ul690
        JwBDoqdyiozSx3iRm7StoQeQoA==
X-Google-Smtp-Source: ABdhPJyJMZg0kwlbu9qaPW3pXR/LvDouL+Z7NwYA+nKatatV3lJt0QuH8AFto0PkEy3MjxgEzF/z5Q==
X-Received: by 2002:adf:e512:: with SMTP id j18mr2671646wrm.52.1610544907962;
        Wed, 13 Jan 2021 05:35:07 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6801:1801:71bd:f6c9:f5ab:8baf])
        by smtp.gmail.com with ESMTPSA id o23sm3717983wro.57.2021.01.13.05.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 05:35:07 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        leo.yan@linaro.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        will@kernel.org, john.garry@huawei.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH] perf: cs-etm: update ETM metadata format
Date:   Wed, 13 Jan 2021 13:35:04 +0000
Message-Id: <20210113133504.13020-1-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current fixed metadata version format (version 0), means that adding
metadata parameter items renders files from a previous version of perf
unreadable. Per CPU parameters appear in a fixed order, but there is no
field to indicate the number of ETM parameters per CPU.

This patch updates the per CPU parameter blocks to include a NR_PARAMs
value which indicates the number of parameters in the block.

The header version is incremented to 1. Fixed ordering is retained,
new ETM parameters are added to the end of the list.

The reader code is updated to be able to read current version 0 files,
For version 1, the reader will read the number of parameters in the
per CPU block. This allows the reader to process older or newer files
that may have different numbers of parameters than in use at the
time perf was built.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c |   3 +-
 tools/perf/util/cs-etm.c          | 171 ++++++++++++++++++++++++------
 tools/perf/util/cs-etm.h          |  22 +++-
 3 files changed, 159 insertions(+), 37 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index bd446aba64f7..1876cdf146a0 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -629,6 +629,7 @@ static void cs_etm_get_metadata(int cpu, u32 *offset,
 	/* Build generic header portion */
 	info->priv[*offset + CS_ETM_MAGIC] = magic;
 	info->priv[*offset + CS_ETM_CPU] = cpu;
+	info->priv[*offset + CS_ETM_NR_PARAMS] = increment - CS_ETM_NR_PARAMS - 1;
 	/* Where the next CPU entry should start from */
 	*offset += increment;
 }
@@ -674,7 +675,7 @@ static int cs_etm_info_fill(struct auxtrace_record *itr,
 
 	/* First fill out the session header */
 	info->type = PERF_AUXTRACE_CS_ETM;
-	info->priv[CS_HEADER_VERSION_0] = 0;
+	info->priv[CS_HEADER_VERSION_0] = CS_HEADER_CURRENT_VERSION;
 	info->priv[CS_PMU_TYPE_CPUS] = type << 32;
 	info->priv[CS_PMU_TYPE_CPUS] |= nr_cpu;
 	info->priv[CS_ETM_SNAPSHOT] = ptr->snapshot_mode;
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index a2a369e2fbb6..394331aa058a 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2443,6 +2443,7 @@ static const char * const cs_etm_global_header_fmts[] = {
 static const char * const cs_etm_priv_fmts[] = {
 	[CS_ETM_MAGIC]		= "	Magic number		       %llx\n",
 	[CS_ETM_CPU]		= "	CPU			       %lld\n",
+	[CS_ETM_NR_PARAMS]	= "	NR_PARAMS		       %llx\n",
 	[CS_ETM_ETMCR]		= "	ETMCR			       %llx\n",
 	[CS_ETM_ETMTRACEIDR]	= "	ETMTRACEIDR		       %llx\n",
 	[CS_ETM_ETMCCER]	= "	ETMCCER			       %llx\n",
@@ -2452,6 +2453,7 @@ static const char * const cs_etm_priv_fmts[] = {
 static const char * const cs_etmv4_priv_fmts[] = {
 	[CS_ETM_MAGIC]		= "	Magic number		       %llx\n",
 	[CS_ETM_CPU]		= "	CPU			       %lld\n",
+	[CS_ETM_NR_PARAMS]	= "	NR_PARAMS		       %llx\n",
 	[CS_ETMV4_TRCCONFIGR]	= "	TRCCONFIGR		       %llx\n",
 	[CS_ETMV4_TRCTRACEIDR]	= "	TRCTRACEIDR		       %llx\n",
 	[CS_ETMV4_TRCIDR0]	= "	TRCIDR0			       %llx\n",
@@ -2461,24 +2463,127 @@ static const char * const cs_etmv4_priv_fmts[] = {
 	[CS_ETMV4_TRCAUTHSTATUS] = "	TRCAUTHSTATUS		       %llx\n",
 };
 
+static const char * const param_unk_fmt =
+	"	Unknown parameter [%d]	       %llx\n";
+static const char * const magic_unk_fmt =
+	"	Magic number Unknown	       %llx\n";
+
 static void cs_etm__print_auxtrace_info(__u64 *val, int num)
 {
-	int i, j, cpu = 0;
+	int i, j, cpu = 0, version, nr_params;
+	__u64 magic;
 
+	fprintf(stdout, "	Reader Header version	       %llx\n",
+		(__u64)CS_HEADER_CURRENT_VERSION);
 	for (i = 0; i < CS_HEADER_VERSION_0_MAX; i++)
 		fprintf(stdout, cs_etm_global_header_fmts[i], val[i]);
+	version = val[0];
 
 	for (i = CS_HEADER_VERSION_0_MAX; cpu < num; cpu++) {
-		if (val[i] == __perf_cs_etmv3_magic)
-			for (j = 0; j < CS_ETM_PRIV_MAX; j++, i++)
-				fprintf(stdout, cs_etm_priv_fmts[j], val[i]);
-		else if (val[i] == __perf_cs_etmv4_magic)
-			for (j = 0; j < CS_ETMV4_PRIV_MAX; j++, i++)
-				fprintf(stdout, cs_etmv4_priv_fmts[j], val[i]);
-		else
+		/* common header block */
+		magic = val[i];
+		fprintf(stdout, cs_etm_priv_fmts[0], val[i++]);
+		fprintf(stdout, cs_etm_priv_fmts[1], val[i++]);
+
+		/* nr param only present in version 1 */
+		if (version) {
+			nr_params = val[i];
+			fprintf(stdout, cs_etm_priv_fmts[2], val[i++]);
+		}
+
+		if (magic == __perf_cs_etmv3_magic) {
+			/* version 0 - fixed number of params */
+			if (!version)
+				nr_params =  CS_ETM_NR_PARAMS_V0;
+
+			/* after common block */
+			for (j = 3; j < nr_params + 3; j++, i++) {
+				/* if newer record - could be excess params */
+				if (j >= CS_ETM_PRIV_MAX)
+					fprintf(stdout, param_unk_fmt, j, val[i]);
+				else
+					fprintf(stdout, cs_etm_priv_fmts[j], val[i]);
+			}
+		} else if (magic == __perf_cs_etmv4_magic) {
+			/* version 0 - fixed number of params */
+			if (!version)
+				nr_params = CS_ETMV4_NR_PARAMS_V0;
+
+			/* after common block */
+			for (j = 3; j < nr_params + 3; j++, i++) {
+				/* if newer record - could be excess params */
+				if (j >= CS_ETMV4_PRIV_MAX)
+					fprintf(stdout, param_unk_fmt, j, val[i]);
+				else
+					fprintf(stdout, cs_etmv4_priv_fmts[j], val[i]);
+			}
+		} else {
 			/* failure.. return */
+			fprintf(stdout, magic_unk_fmt, magic);
 			return;
+		}
+	}
+}
+
+/*
+ * Read a single cpu parameter block from the auxtrace_info priv block.
+ *
+ * For version 1 there is a per cpu nr_params entry. If we are handling
+ * version 1 file, then there may be less, the same, or more params
+ * indicated by this value than the compile time number we understand.
+ *
+ * For a version 0 info block, there are a fixed number, and we need to
+ * fill out the nr_param value in the metadata we create.
+ */
+static u64 *cs_etm__create_meta_blk(u64 *buff_in, int *buff_in_offset,
+				    int out_blk_size, int nr_params_v0)
+{
+	u64 *metadata = NULL;
+	int hdr_version;
+	int nr_in_params, nr_out_params, nr_cmn_params;
+	int i, k;
+
+	metadata = zalloc(sizeof(*metadata) * out_blk_size);
+	if (!metadata)
+		return NULL;
+
+	/* read block current index & version */
+	i = *buff_in_offset;
+	hdr_version = buff_in[CS_HEADER_VERSION_0];
+
+	if (!hdr_version) {
+	/* read version 0 info block into a version 1 metadata block  */
+		nr_in_params = nr_params_v0;
+		metadata[CS_ETM_MAGIC] = buff_in[i + CS_ETM_MAGIC];
+		metadata[CS_ETM_CPU] = buff_in[i + CS_ETM_CPU];
+		metadata[CS_ETM_NR_PARAMS] = nr_in_params;
+		/* remaining block params at offset +1 from source */
+		for (k = 2; k < nr_in_params; k++)
+			metadata[k+1] = buff_in[i + k];
+		/* version 0 has 2 common params */
+		nr_cmn_params = 2;
+	} else {
+	/* read version 1 info block - input and output nr_params may differ */
+		/* version 1 has 3 common params */
+		nr_cmn_params = 3;
+		nr_in_params = buff_in[i + CS_ETM_NR_PARAMS];
+
+		/* if input has more params than output - skip excess */
+		nr_out_params = nr_in_params + nr_cmn_params;
+		if (nr_out_params > out_blk_size)
+			nr_out_params = out_blk_size;
+
+		for (k = 0; k < nr_out_params; k++)
+			metadata[k] = buff_in[i + k];
+
+		/* record the actual nr params we copied */
+		metadata[CS_ETM_NR_PARAMS] = nr_out_params - nr_cmn_params;
 	}
+
+	/* adjust in offset by number of in params used */
+	i += nr_in_params + nr_cmn_params;
+	*buff_in_offset = i;
+	return metadata;
 }
 
 int cs_etm__process_auxtrace_info(union perf_event *event,
@@ -2492,11 +2597,12 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	int info_header_size;
 	int total_size = auxtrace_info->header.size;
 	int priv_size = 0;
-	int num_cpu;
-	int err = 0, idx = -1;
-	int i, j, k;
+	int num_cpu, trcidr_idx;
+	int err = 0;
+	int i, j;
 	u64 *ptr, *hdr = NULL;
 	u64 **metadata = NULL;
+	u64 hdr_version;
 
 	/*
 	 * sizeof(auxtrace_info_event::type) +
@@ -2512,8 +2618,9 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	/* First the global part */
 	ptr = (u64 *) auxtrace_info->priv;
 
-	/* Look for version '0' of the header */
-	if (ptr[0] != 0)
+	/* Look for version of the header */
+	hdr_version = ptr[0];
+	if (hdr_version > CS_HEADER_CURRENT_VERSION)
 		return -EINVAL;
 
 	hdr = zalloc(sizeof(*hdr) * CS_HEADER_VERSION_0_MAX);
@@ -2552,35 +2659,31 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	 */
 	for (j = 0; j < num_cpu; j++) {
 		if (ptr[i] == __perf_cs_etmv3_magic) {
-			metadata[j] = zalloc(sizeof(*metadata[j]) *
-					     CS_ETM_PRIV_MAX);
-			if (!metadata[j]) {
-				err = -ENOMEM;
-				goto err_free_metadata;
-			}
-			for (k = 0; k < CS_ETM_PRIV_MAX; k++)
-				metadata[j][k] = ptr[i + k];
+			metadata[j] =
+				cs_etm__create_meta_blk(ptr, &i,
+							CS_ETM_PRIV_MAX,
+							CS_ETM_NR_PARAMS_V0);
 
 			/* The traceID is our handle */
-			idx = metadata[j][CS_ETM_ETMTRACEIDR];
-			i += CS_ETM_PRIV_MAX;
+			trcidr_idx = CS_ETM_ETMTRACEIDR;
+
 		} else if (ptr[i] == __perf_cs_etmv4_magic) {
-			metadata[j] = zalloc(sizeof(*metadata[j]) *
-					     CS_ETMV4_PRIV_MAX);
-			if (!metadata[j]) {
-				err = -ENOMEM;
-				goto err_free_metadata;
-			}
-			for (k = 0; k < CS_ETMV4_PRIV_MAX; k++)
-				metadata[j][k] = ptr[i + k];
+			metadata[j] =
+				cs_etm__create_meta_blk(ptr, &i,
+							CS_ETMV4_PRIV_MAX,
+							CS_ETMV4_NR_PARAMS_V0);
 
 			/* The traceID is our handle */
-			idx = metadata[j][CS_ETMV4_TRCTRACEIDR];
-			i += CS_ETMV4_PRIV_MAX;
+			trcidr_idx = CS_ETMV4_TRCTRACEIDR;
+		}
+
+		if (!metadata[j]) {
+			err = -ENOMEM;
+			goto err_free_metadata;
 		}
 
 		/* Get an RB node for this CPU */
-		inode = intlist__findnew(traceid_list, idx);
+		inode = intlist__findnew(traceid_list, metadata[j][trcidr_idx]);
 
 		/* Something went wrong, no need to continue */
 		if (!inode) {
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index 4ad925d6d799..fffc6b50beb9 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -24,16 +24,28 @@ enum {
 	CS_HEADER_VERSION_0_MAX,
 };
 
+/*
+ * Update the version for new format.
+ *
+ * New version 1 format adds a param count to the per cpu metadata.
+ * This allows easy adding of new metadata parameters.
+ * Requires that new params always added after current ones.
+ * Also allows client reader to handle file versions that are different by
+ * checking the number of params in the file vs the number expected.
+ */
+#define CS_HEADER_CURRENT_VERSION 1
+
 /* Beginning of header common to both ETMv3 and V4 */
 enum {
 	CS_ETM_MAGIC,
 	CS_ETM_CPU,
+	CS_ETM_NR_PARAMS,
 };
 
 /* ETMv3/PTM metadata */
 enum {
 	/* Dynamic, configurable parameters */
-	CS_ETM_ETMCR = CS_ETM_CPU + 1,
+	CS_ETM_ETMCR = CS_ETM_NR_PARAMS + 1,
 	CS_ETM_ETMTRACEIDR,
 	/* RO, taken from sysFS */
 	CS_ETM_ETMCCER,
@@ -41,10 +53,13 @@ enum {
 	CS_ETM_PRIV_MAX,
 };
 
+/* define fixed version 0 length - allow new format reader to read old files. */
+#define CS_ETM_NR_PARAMS_V0 (CS_ETM_ETMIDR - CS_ETM_ETMCR + 1)
+
 /* ETMv4 metadata */
 enum {
 	/* Dynamic, configurable parameters */
-	CS_ETMV4_TRCCONFIGR = CS_ETM_CPU + 1,
+	CS_ETMV4_TRCCONFIGR = CS_ETM_NR_PARAMS + 1,
 	CS_ETMV4_TRCTRACEIDR,
 	/* RO, taken from sysFS */
 	CS_ETMV4_TRCIDR0,
@@ -55,6 +70,9 @@ enum {
 	CS_ETMV4_PRIV_MAX,
 };
 
+/* define fixed version 0 length - allow new format reader to read old files. */
+#define CS_ETMV4_NR_PARAMS_V0 (CS_ETMV4_TRCAUTHSTATUS - CS_ETMV4_TRCCONFIGR + 1)
+
 /*
  * ETMv3 exception encoding number:
  * See Embedded Trace Macrocell spcification (ARM IHI 0014Q)
-- 
2.17.1

