Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE89290ACF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 19:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391669AbgJPRgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 13:36:03 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:46280 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391536AbgJPRgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 13:36:02 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 09GHQLpc024369;
        Fri, 16 Oct 2020 12:35:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=PfQTmtHq+WI6K5BmMwZ1tOrR7fNGk/HI3b3fMtqo+rw=;
 b=i9NdhYrHIU/N4aatrFpWk7AmkW0YnTVCD6M4csYwOvLZ9w1TgBVOoAsEnPRJZeiDMVX8
 Tx2+BupabcUI3FW1Ggei42PMGV34SNmjhBMbi88EaKtAYbeOF7fhtudUGOmaxe4Qp5LV
 TnHr30S/O82giN+Z1ixhGcinMOamUVRu5Le/UzcG4ZHWeDSUtiKYuEeuJOIc8kn5a3XP
 oUrxjl01tgi8PRZ0Crd0VnZhkjRUtwsNhjJNvzsngQGnu8momg4xquM/0Dm96r0Asyql
 F6cH8JfGCtFxXtOLgrwjtRGSD8pMG76F7YwGZtxBbGnYaakKG1RHCOJ2oqC6DnmfOpgp ew== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 343ac20jk8-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 16 Oct 2020 12:35:47 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 16 Oct
 2020 18:35:46 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 16 Oct 2020 18:35:46 +0100
Received: from AUSNPC0LSNW1-debian.ad.cirrus.com (ausnpc0lsnw1.ad.cirrus.com [198.61.64.143])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 089D22A1;
        Fri, 16 Oct 2020 17:35:45 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <nsaenzjulienne@suse.de>
CC:     <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 4/7] ASoC: arizona: Allow codecs to be selected from kernel config
Date:   Fri, 16 Oct 2020 18:35:38 +0100
Message-ID: <20201016173541.21180-5-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201016173541.21180-1-rf@opensource.cirrus.com>
References: <20201016173541.21180-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=746 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010160130
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
 sound/soc/codecs/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 34c6dd04b85a..4a8d503bdd38 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -661,7 +661,7 @@ config SND_SOC_CS47L15
 	tristate
 
 config SND_SOC_CS47L24
-	tristate
+	tristate "Cirrus Logic CS47L24 CODEC"
 	depends on MFD_CS47L24
 
 config SND_SOC_CS47L35
@@ -1484,11 +1484,11 @@ config SND_SOC_WM5100
 	depends on I2C
 
 config SND_SOC_WM5102
-	tristate
+	tristate "Cirrus Logic WM5102 CODEC"
 	depends on MFD_WM5102
 
 config SND_SOC_WM5110
-	tristate
+	tristate "Cirrus Logic WM5110 CODEC"
 	depends on MFD_WM5110
 
 config SND_SOC_WM8350
@@ -1657,7 +1657,7 @@ config SND_SOC_WM8997
 	depends on MFD_WM8997
 
 config SND_SOC_WM8998
-	tristate
+	tristate "Cirrus Logic WM8998 CODEC"
 	depends on MFD_WM8998
 
 config SND_SOC_WM9081
-- 
2.20.1

