Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4772E7B8A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 18:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgL3RZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 12:25:24 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:42052 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726336AbgL3RZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 12:25:23 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BUHHJbb022267;
        Wed, 30 Dec 2020 11:24:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=Bdh4mzSs1oTc3kIhJNbwM+rKg4yZ64YLCtzSvA9YfaE=;
 b=TCKm14mmJ7btn6NmNfx3cnOx/xvAYh9uTqPEQByrr+Z9tR9UMpc20LggV35Sl/SSeDHR
 La2+YsJwbl8gMP1h5QXRJuSjFubn831ogl3mwPUJb7r34f3HEHTkqELQ6yehOeD3bez0
 iY+8vNgwXfxb3VckmnNoFPBf0cpN/YWgiXwD0XtLMVdkbMOlwoUfWo5S22DNuxchjmIg
 LNKe5o/NK9nGyM8LzXpal4DqjqO3ZN2bZSUr/eOsfc4JqQoERk660UJ8sB2mL9B1MQWY
 +n6v61aZqH8qylclyADgZ3Jx9TtxgVGvE9XVxk/PPPFWCDVNWCBXLG+GyCPimvdgvJdB KQ== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 35p2fs3gmx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 30 Dec 2020 11:24:34 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 30 Dec
 2020 17:24:32 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Wed, 30 Dec 2020 17:24:32 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.77])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 22DFD11CC;
        Wed, 30 Dec 2020 17:24:32 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 2/2] ASoC: wm_adsp: Use snd_ctl_elem_type_t for control types
Date:   Wed, 30 Dec 2020 17:24:27 +0000
Message-ID: <20201230172427.13865-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201230172427.13865-1-rf@opensource.cirrus.com>
References: <20201230172427.13865-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 mlxlogscore=912 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012300108
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse will complain about trying to convert between values declared
as snd_ctl_elem_type_t and other types. This patch converts to
consistently use snd_ctl_elem_type_t for control type values. A __force
cast is needed in a couple of cases where the control type value is
parsed out of a DSP data block.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 12 +++++++-----
 sound/soc/codecs/wmfw.h    |  6 +++---
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 8cfa8ac1b8c4..f8ad768364c2 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -619,7 +619,7 @@ struct wm_coeff_ctl {
 	unsigned int set:1;
 	struct soc_bytes_ext bytes_ext;
 	unsigned int flags;
-	unsigned int type;
+	snd_ctl_elem_type_t type;
 };
 
 static const char *wm_adsp_mem_region_name(unsigned int type)
@@ -1420,7 +1420,7 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 				  const struct wm_adsp_alg_region *alg_region,
 				  unsigned int offset, unsigned int len,
 				  const char *subname, unsigned int subname_len,
-				  unsigned int flags, unsigned int type)
+				  unsigned int flags, snd_ctl_elem_type_t type)
 {
 	struct wm_coeff_ctl *ctl;
 	struct wmfw_ctl_work *ctl_work;
@@ -1554,7 +1554,7 @@ struct wm_coeff_parsed_coeff {
 	int mem_type;
 	const u8 *name;
 	int name_len;
-	int ctl_type;
+	snd_ctl_elem_type_t ctl_type;
 	int flags;
 	int len;
 };
@@ -1649,7 +1649,7 @@ static inline void wm_coeff_parse_coeff(struct wm_adsp *dsp, const u8 **data,
 		blk->mem_type = le16_to_cpu(raw->hdr.type);
 		blk->name = raw->name;
 		blk->name_len = strlen(raw->name);
-		blk->ctl_type = le16_to_cpu(raw->ctl_type);
+		blk->ctl_type = (__force snd_ctl_elem_type_t)le16_to_cpu(raw->ctl_type);
 		blk->flags = le16_to_cpu(raw->flags);
 		blk->len = le32_to_cpu(raw->len);
 		break;
@@ -1662,7 +1662,9 @@ static inline void wm_coeff_parse_coeff(struct wm_adsp *dsp, const u8 **data,
 						      &blk->name);
 		wm_coeff_parse_string(sizeof(u8), &tmp, NULL);
 		wm_coeff_parse_string(sizeof(u16), &tmp, NULL);
-		blk->ctl_type = wm_coeff_parse_int(sizeof(raw->ctl_type), &tmp);
+		blk->ctl_type =
+			(__force snd_ctl_elem_type_t)wm_coeff_parse_int(sizeof(raw->ctl_type),
+									&tmp);
 		blk->flags = wm_coeff_parse_int(sizeof(raw->flags), &tmp);
 		blk->len = wm_coeff_parse_int(sizeof(raw->len), &tmp);
 
diff --git a/sound/soc/codecs/wmfw.h b/sound/soc/codecs/wmfw.h
index 7423272c30e9..f3d51602f85c 100644
--- a/sound/soc/codecs/wmfw.h
+++ b/sound/soc/codecs/wmfw.h
@@ -24,9 +24,9 @@
 #define WMFW_CTL_FLAG_READABLE    0x0001
 
 /* Non-ALSA coefficient types start at 0x1000 */
-#define WMFW_CTL_TYPE_ACKED       0x1000 /* acked control */
-#define WMFW_CTL_TYPE_HOSTEVENT   0x1001 /* event control */
-#define WMFW_CTL_TYPE_HOST_BUFFER 0x1002 /* host buffer pointer */
+#define WMFW_CTL_TYPE_ACKED       ((__force snd_ctl_elem_type_t)0x1000) /* acked control */
+#define WMFW_CTL_TYPE_HOSTEVENT   ((__force snd_ctl_elem_type_t)0x1001) /* event control */
+#define WMFW_CTL_TYPE_HOST_BUFFER ((__force snd_ctl_elem_type_t)0x1002) /* host buffer pointer */
 
 struct wmfw_header {
 	char magic[4];
-- 
2.20.1

