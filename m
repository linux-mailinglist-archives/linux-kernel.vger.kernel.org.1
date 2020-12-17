Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6FE2DD470
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 16:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgLQPmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 10:42:44 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:57094 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726012AbgLQPmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 10:42:44 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BHFPi9A001634;
        Thu, 17 Dec 2020 09:41:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=YAEVmqUSTWxDxxY33QVvJnlnd8rBeoEIPPK9oM8cveE=;
 b=VqrlKQanNhvLFwxyiCKqkrwevjyjX6DmKmrSArTMftbgCXacgwl5/bkqLk3O34uxp4IU
 RZSJGdynfkC50Ib/Toth6eZnnD8KhGDO9wKqKjuZ77qjGUK7sQI/yXVNQc59E2i2mYjq
 LH7m8EUgXx81PPrSNrLM2tqtY2Z2DwSG8msvfmRT4md+7Em1+UwNLQazQ9SeFYgpeGPy
 Cfmfemqm5mY9jGyiCgINnYr8Fduecsqcmf1EztA/6CvDWVTh9ZTHhWaZtVHMHuBgEtyh
 6GiJZVHVn7q5Ld/ysQAWE/Rn6DjzFyNhWoyFrVmr7+Rq8aOjKdniFqQUFIOxDVekkrPD +A== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 35cu5rxy90-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 17 Dec 2020 09:41:49 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 17 Dec
 2020 15:41:47 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Thu, 17 Dec 2020 15:41:47 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.236])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 41F6D11CB;
        Thu, 17 Dec 2020 15:41:47 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <kuninori.morimoto.gx@renesas.com>, <nsaenzjulienne@suse.de>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v3 4/6] ASoC: madera: Allow codecs to be selected from kernel config
Date:   Thu, 17 Dec 2020 15:41:40 +0000
Message-ID: <20201217154142.24301-5-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201217154142.24301-1-rf@opensource.cirrus.com>
References: <20201217154142.24301-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 mlxlogscore=908 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012170108
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The codec Kconfig options were hidden and intended to be selected by
the machine driver that requires them. But that means having either a
dedicated machine driver or building all codecs.

This patch makes the Kconfig options visible so that they can be
selected independently of the machine driver, allowing the codec to be
used with simple-card and other machine drivers that are not hardcoded
to use a fixed set of codecs.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 34c6dd04b85a..e8a56f897cc8 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -658,23 +658,23 @@ config SND_SOC_CS4349
 	depends on I2C
 
 config SND_SOC_CS47L15
-	tristate
+	tristate "Cirrus Logic CS47L15 CODEC"
 
 config SND_SOC_CS47L24
 	tristate
 	depends on MFD_CS47L24
 
 config SND_SOC_CS47L35
-	tristate
+	tristate "Cirrus Logic CS47L35 CODEC"
 
 config SND_SOC_CS47L85
-	tristate
+	tristate "Cirrus Logic CS47L85 CODEC"
 
 config SND_SOC_CS47L90
-	tristate
+	tristate "Cirrus Logic CS47L90 CODEC"
 
 config SND_SOC_CS47L92
-	tristate
+	tristate "Cirrus Logic CS47L92 CODEC"
 
 # Cirrus Logic Quad-Channel ADC
 config SND_SOC_CS53L30
-- 
2.20.1

