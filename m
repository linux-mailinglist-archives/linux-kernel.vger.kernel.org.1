Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36BD29A802
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895712AbgJ0Jlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:41:36 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:21460 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895700AbgJ0Jlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:41:36 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 09R9VdVe016828;
        Tue, 27 Oct 2020 04:41:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=1phbf9nP/JdnVs9Te4TQSzfkG3pPtuHiUYXLQB0Q/Ss=;
 b=mkbXDw2n1Rsa9TncuDdvMC29k7VfasrjdeoGp69iV+KRQt26bi8ZpkfhXG9o7QJ5s+L3
 U3PeqOGmDnp3YEaeXgciPdRXlw9JRRQnA0C846kZGrLSwXZ1+yO9pHQfjdg1ZdV4PRAZ
 T5pTtv60Y4L2GfZ4KthS7677ppDgIihQvru/BJkxWWLc+AEWcUufN90iyt1eVRZUR7eM
 RZOJlkINaQJ/KlLreKUNslse46rwoLeUTqzTMQZhrKdUv8odXwv0gUEs5MRA9PTZlhjU
 5t7P2dyu6+7dQkpOshDcyZIBkkBf0WkhUKHpw1ZTG0wwDJniEXDeu5JS4nKZhEn2kVkm gA== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 34chp1m3me-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 27 Oct 2020 04:41:35 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 27 Oct
 2020 09:41:33 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Tue, 27 Oct 2020 09:41:33 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 033D42AA;
        Tue, 27 Oct 2020 09:41:33 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH RESEND 1/2] mfd: madera: Add reset as part of resume
Date:   Tue, 27 Oct 2020 09:41:31 +0000
Message-ID: <20201027094132.16472-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=1 priorityscore=1501 mlxlogscore=904
 mlxscore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010270063
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DCVDD supply does not always power down when the CODEC enters
suspend, for example shared regulators or always-on regulators. In
these cases if a register is written back to the default value whilst
the CODEC is in suspend that register will retain the previous value.
As DCVDD never powered down, the register retains its old value and
as the cache sync only synchronises registers that differ from the
default the new value is never written out.

Ensure the registers are in the expected state after suspend by always
resetting the CODEC on resume. This also has the benefit of being
recommended by the datasheet for DCVDD supplies that take longer than
2mS to rise.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/mfd/madera-core.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
index 4ed6ad8ce0020..a9c6f0833f327 100644
--- a/drivers/mfd/madera-core.c
+++ b/drivers/mfd/madera-core.c
@@ -291,6 +291,8 @@ static int __maybe_unused madera_runtime_resume(struct device *dev)
 
 	dev_dbg(dev, "Leaving sleep mode\n");
 
+	madera_enable_hard_reset(madera);
+
 	ret = regulator_enable(madera->dcvdd);
 	if (ret) {
 		dev_err(dev, "Failed to enable DCVDD: %d\n", ret);
@@ -300,7 +302,19 @@ static int __maybe_unused madera_runtime_resume(struct device *dev)
 	regcache_cache_only(madera->regmap, false);
 	regcache_cache_only(madera->regmap_32bit, false);
 
-	usleep_range(MADERA_RESET_MIN_US, MADERA_RESET_MAX_US);
+	madera_disable_hard_reset(madera);
+
+	if (!madera->pdata.reset) {
+		ret = madera_wait_for_boot(madera);
+		if (ret)
+			goto err;
+
+		ret = madera_soft_reset(madera);
+		if (ret) {
+			dev_err(dev, "Failed to reset: %d\n", ret);
+			goto err;
+		}
+	}
 
 	ret = madera_wait_for_boot(madera);
 	if (ret)
-- 
2.11.0

