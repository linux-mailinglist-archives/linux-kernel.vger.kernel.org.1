Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3839C2E7B89
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 18:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgL3RZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 12:25:22 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:55072 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726168AbgL3RZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 12:25:22 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BUHHJba022267;
        Wed, 30 Dec 2020 11:24:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=nHfeDmUdDzzSQruILSReW1tu+QSdBTHweUHxHjYb7hQ=;
 b=GEKin0jN1G/ffhlw6Io2EM2Ribit5RxAcANYkZ2e2tyjfmbOrZFs2BxIaNG0RWiL/6D2
 x1XTHGbNfZPIyCeZgCF5czUWJ+MRiCw8y/aLHTxhU7lrppgA2TYl0cBZWEefeK5t3+9M
 9DPGOpQypc4FQRhfVBRvsjr4hC/LcAz11K+XAF3+WAIDcrlgddR6nR3prNG4IQ83GHTR
 Gu2lgNyH2K+CV8l0Lnbl/JtnYtX41HvzDItxjVn+/4qJW12u2eIOCFb8Q7fSwGNU3Qbv
 MHb2ksSjIKyZPVl1bU3SPfxKZDOINOvVDlbrlOOMZwR/2ce6/ZazQitgB0Ooa/UuWnoI Lw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 35p2fs3gmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 30 Dec 2020 11:24:33 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 30 Dec
 2020 17:24:32 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Wed, 30 Dec 2020 17:24:32 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.77])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4DD4345;
        Wed, 30 Dec 2020 17:24:31 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 1/2] ASoC: wm_adsp: Only use __be32 for big-endian data
Date:   Wed, 30 Dec 2020 17:24:26 +0000
Message-ID: <20201230172427.13865-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012300108
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes some minor cases where u32 or unsigned int types were used
to store big-endian data, and __be32 types used to store both big-endian
and cpu-endian data. This was producing sparse warnings.

Most cases resulted from using the same variable to hold the big-endian
value and its converted cpu-endian value. These can be simply fixed by
introducing another local variable, or avoiding storing the intermediate
value back into the original variable.

One special case is the raw_buf used in the compressed streams to transfer
data from DSP to user-side. The endian conversion happens in-place (as
there's no point introducing another buffer) so a cast to (__be32 *) is
added when passing it to wm_adsp_read_raw_data_block().

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 5b7d81a91df3..8cfa8ac1b8c4 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -980,7 +980,7 @@ static int wm_coeff_write_acked_control(struct wm_coeff_ctl *ctl,
 					unsigned int event_id)
 {
 	struct wm_adsp *dsp = ctl->dsp;
-	u32 val = cpu_to_be32(event_id);
+	__be32 val = cpu_to_be32(event_id);
 	unsigned int reg;
 	int i, ret;
 
@@ -3704,6 +3704,7 @@ static int wm_adsp_write_data_word(struct wm_adsp *dsp, int mem_type,
 				   unsigned int mem_addr, u32 data)
 {
 	struct wm_adsp_region const *mem = wm_adsp_find_region(dsp, mem_type);
+	__be32 val = cpu_to_be32(data & 0x00ffffffu);
 	unsigned int reg;
 
 	if (!mem)
@@ -3711,9 +3712,7 @@ static int wm_adsp_write_data_word(struct wm_adsp *dsp, int mem_type,
 
 	reg = dsp->ops->region_to_reg(mem, mem_addr);
 
-	data = cpu_to_be32(data & 0x00ffffffu);
-
-	return regmap_raw_write(dsp->regmap, reg, &data, sizeof(data));
+	return regmap_raw_write(dsp->regmap, reg, &val, sizeof(val));
 }
 
 static inline int wm_adsp_buffer_read(struct wm_adsp_compr_buf *buf,
@@ -3870,7 +3869,8 @@ static int wm_adsp_buffer_parse_coeff(struct wm_coeff_ctl *ctl)
 {
 	struct wm_adsp_host_buf_coeff_v1 coeff_v1;
 	struct wm_adsp_compr_buf *buf;
-	unsigned int val, reg;
+	unsigned int reg, version;
+	__be32 bufp;
 	int ret, i;
 
 	ret = wm_coeff_base_reg(ctl, &reg);
@@ -3878,17 +3878,17 @@ static int wm_adsp_buffer_parse_coeff(struct wm_coeff_ctl *ctl)
 		return ret;
 
 	for (i = 0; i < 5; ++i) {
-		ret = regmap_raw_read(ctl->dsp->regmap, reg, &val, sizeof(val));
+		ret = regmap_raw_read(ctl->dsp->regmap, reg, &bufp, sizeof(bufp));
 		if (ret < 0)
 			return ret;
 
-		if (val)
+		if (bufp)
 			break;
 
 		usleep_range(1000, 2000);
 	}
 
-	if (!val) {
+	if (!bufp) {
 		adsp_err(ctl->dsp, "Failed to acquire host buffer\n");
 		return -EIO;
 	}
@@ -3898,7 +3898,7 @@ static int wm_adsp_buffer_parse_coeff(struct wm_coeff_ctl *ctl)
 		return -ENOMEM;
 
 	buf->host_buf_mem_type = ctl->alg_region.type;
-	buf->host_buf_ptr = be32_to_cpu(val);
+	buf->host_buf_ptr = be32_to_cpu(bufp);
 
 	ret = wm_adsp_buffer_populate(buf);
 	if (ret < 0)
@@ -3918,14 +3918,13 @@ static int wm_adsp_buffer_parse_coeff(struct wm_coeff_ctl *ctl)
 	if (ret < 0)
 		return ret;
 
-	coeff_v1.versions = be32_to_cpu(coeff_v1.versions);
-	val = coeff_v1.versions & HOST_BUF_COEFF_COMPAT_VER_MASK;
-	val >>= HOST_BUF_COEFF_COMPAT_VER_SHIFT;
+	version = be32_to_cpu(coeff_v1.versions) & HOST_BUF_COEFF_COMPAT_VER_MASK;
+	version >>= HOST_BUF_COEFF_COMPAT_VER_SHIFT;
 
-	if (val > HOST_BUF_COEFF_SUPPORTED_COMPAT_VER) {
+	if (version > HOST_BUF_COEFF_SUPPORTED_COMPAT_VER) {
 		adsp_err(ctl->dsp,
 			 "Host buffer coeff ver %u > supported version %u\n",
-			 val, HOST_BUF_COEFF_SUPPORTED_COMPAT_VER);
+			 version, HOST_BUF_COEFF_SUPPORTED_COMPAT_VER);
 		return -EINVAL;
 	}
 
@@ -3935,9 +3934,9 @@ static int wm_adsp_buffer_parse_coeff(struct wm_coeff_ctl *ctl)
 			      (char *)&coeff_v1.name);
 
 	compr_dbg(buf, "host_buf_ptr=%x coeff version %u\n",
-		  buf->host_buf_ptr, val);
+		  buf->host_buf_ptr, version);
 
-	return val;
+	return version;
 }
 
 static int wm_adsp_buffer_init(struct wm_adsp *dsp)
@@ -4269,7 +4268,7 @@ static int wm_adsp_buffer_capture_block(struct wm_adsp_compr *compr, int target)
 
 	/* Read data from DSP */
 	ret = wm_adsp_read_raw_data_block(buf->dsp, mem_type, adsp_addr,
-					  nwords, compr->raw_buf);
+					  nwords, (__be32 *)compr->raw_buf);
 	if (ret < 0)
 		return ret;
 
-- 
2.20.1

