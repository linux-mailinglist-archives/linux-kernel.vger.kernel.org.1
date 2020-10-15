Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D977E28F029
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 12:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389285AbgJOK1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 06:27:16 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:4674 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726678AbgJOK1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 06:27:15 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 09FAQWiA029366;
        Thu, 15 Oct 2020 05:27:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=YZmqXR2DnD/3dyGb5tJzBz6gDCu6t5gNmbcyFzK2RDQ=;
 b=HCCcasdWBJJMgiZH+2Y1XZfgcm5UUejXWhNaclN4e0W+2v+amX4kFUWPTgsj/Pfjq3TM
 r2DNJ0ZnvaHtRHGTABlRUeQ/3GFFjMWnX3G0Q1Bt6aqn2Arnu1SomHcUXYxFPSpUqrrG
 VX1Mxlom80rzJNCvjS2bGTmapM+Z+s6u6iubdYfGyyU98Eb5l2Z1LAi7X1fJrAUIlA7t
 LgwsQ3WdcpeYAkF8IK4heAJq+Va427LWjLHkU4k1kWnhsczuAT8Ia2GrTiXXi3VDmIOx
 iuzzkOx0pSOhRF2WX6oaNt/zS2llY9u+6dVDKQ5iQhiC2KaqZdffiZ0Bfqu2ZwRuyZGV xg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3439cnefpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 15 Oct 2020 05:27:09 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 15 Oct
 2020 11:27:07 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Thu, 15 Oct 2020 11:27:07 +0100
Received: from AUSNPC0LSNW1-debian.ad.cirrus.com (ausnpc0lsnw1.ad.cirrus.com [198.61.64.143])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6B4292A1;
        Thu, 15 Oct 2020 10:27:07 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: wm5102: Use get_unaligned_be16() for dac_comp_coeff
Date:   Thu, 15 Oct 2020 11:27:03 +0100
Message-ID: <20201015102703.24622-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 mlxlogscore=629 lowpriorityscore=0 phishscore=0 clxscore=1015
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010150074
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the two-step copy-and-convert in
wm5102_out_comp_coeff_put() with get_unaligned_be16(). Apart from
looking nicer, it avoids this sparse warning:

wm5102.c:687:35: sparse: sparse: cast to restricted __be16

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/wm5102.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 2ed3fa67027d..70d353b63fe0 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -682,9 +682,7 @@ static int wm5102_out_comp_coeff_put(struct snd_kcontrol *kcontrol,
 	struct arizona *arizona = dev_get_drvdata(component->dev->parent);
 
 	mutex_lock(&arizona->dac_comp_lock);
-	memcpy(&arizona->dac_comp_coeff, ucontrol->value.bytes.data,
-	       sizeof(arizona->dac_comp_coeff));
-	arizona->dac_comp_coeff = be16_to_cpu(arizona->dac_comp_coeff);
+	arizona->dac_comp_coeff = get_unaligned_be16(ucontrol->value.bytes.data);
 	mutex_unlock(&arizona->dac_comp_lock);
 
 	return 0;

base-commit: 2ebefde9de62a0828936e47b62975501993b5ee9
-- 
2.20.1

