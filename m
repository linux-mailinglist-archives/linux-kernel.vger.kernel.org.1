Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076ED2802D1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 17:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732516AbgJAPeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 11:34:19 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:8278 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732104AbgJAPeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 11:34:16 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 091FLNLf002767;
        Thu, 1 Oct 2020 10:34:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=1phbf9nP/JdnVs9Te4TQSzfkG3pPtuHiUYXLQB0Q/Ss=;
 b=ErF3PtQmoTLkEvA7BHHV1cqwGTcCIXhbeFWc9ejKmJcSWcElzm3DnzWqjQtI7l7QZd5h
 YqIKpra4IQO/PSxcb0EwCNFjKmMMSbWvPndPpqO5xYHCJ3ZySIIQw//9Da4Kr20PQhnZ
 Q4339DqecN/liBHGoD/yyr0BJ1R0cL5PZGBRNfgZHQLxV1D5k3gd5PXIqRyFK2cvm0aH
 V6Rkcmmoq815CBR/xlpU1Pq/5Yfi41EBSMTdujUcJF3v0C5Gc8VhX9dYrOjlsYvuospd
 gv2Ld5M5zUfJV/t9BzmMhu8kbrCxMGq12L5FO+aOTTT76UlWUsjEeGi6tJ7iJOReR5po LA== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 33t22p7c7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 01 Oct 2020 10:34:14 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 1 Oct 2020
 16:34:13 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Thu, 1 Oct 2020 16:34:13 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 439142A1;
        Thu,  1 Oct 2020 15:34:13 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 1/2] mfd: madera: Add reset as part of resume
Date:   Thu, 1 Oct 2020 16:34:12 +0100
Message-ID: <20201001153413.22948-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=894
 impostorscore=0 suspectscore=1 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010010132
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

