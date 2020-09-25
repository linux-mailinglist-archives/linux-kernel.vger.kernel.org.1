Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD03278378
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 11:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgIYJB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 05:01:57 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:50244 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727428AbgIYJB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 05:01:57 -0400
X-Greylist: delayed 1649 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Sep 2020 05:01:57 EDT
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 08P8WPlm026905;
        Fri, 25 Sep 2020 03:34:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=wph01T7UmRsyFJuRCiq74vVYOpu+avjXRH7hJzmc/J4=;
 b=ha1wC27vpaMv29ydzMTpRMxbLz2/R5WFUnL6ypB8nc9zkhAOmsHIx6YDXIDT/qNP8sk3
 ekvVOCMI6VPsMitLWHgpWCLViYZN7Fx9RGBbXiufv0TWOO2gLLzN/QxZ540iuO4viuHX
 6W+SZoPae9eHJ+B5jiZP/EmjEqb01sE+4LunjJNUeZvTwe6LVLhESBT+47wRJSGeJeVV
 YMdtr4UUAOvoxNd6vdXS9IFLntf0j21UyP1omxFl02yRi2EUt4Fv8W7pfRcxAPE7jxaS
 oIkA3k5vkTarOYsyxHCPusnCrWcggyPR7cdn6Waq2/BNJBGj1YEDtyVg7NpXkAddoR1t TA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 33nfd283rs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 25 Sep 2020 03:34:17 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 25 Sep
 2020 09:34:15 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 25 Sep 2020 09:34:15 +0100
Received: from AUSNPC0LSNW1-debian.ad.cirrus.com (ausnpc0lsnw1.ad.cirrus.com [198.61.64.158])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 87F2D2A1;
        Fri, 25 Sep 2020 08:34:15 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [RFC PATCH 1/2] ASoC: cs47l15: Fix EPOUT->HPOUT1 Mono Mux routing
Date:   Fri, 25 Sep 2020 09:34:09 +0100
Message-ID: <20200925083410.3987-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 suspectscore=1
 mlxlogscore=952 adultscore=0 clxscore=1011 malwarescore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009250058
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EPOUT is always mono so should have a permanent routing through the
HPOUT1 Mono Mux.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs47l15.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs47l15.c b/sound/soc/codecs/cs47l15.c
index a591e7457d11..254f9d96e766 100644
--- a/sound/soc/codecs/cs47l15.c
+++ b/sound/soc/codecs/cs47l15.c
@@ -1089,6 +1089,7 @@ static const struct snd_soc_dapm_route cs47l15_dapm_routes[] = {
 	{ "HPOUT1 Demux", NULL, "OUT1R" },
 
 	{ "OUT1R", NULL, "HPOUT1 Mono Mux" },
+	{ "HPOUT1 Mono Mux", "EPOUT", "OUT1L" },
 
 	{ "HPOUTL", "HPOUT", "HPOUT1 Demux" },
 	{ "HPOUTR", "HPOUT", "HPOUT1 Demux" },
@@ -1268,7 +1269,6 @@ static irqreturn_t cs47l15_adsp2_irq(int irq, void *data)
 
 static const struct snd_soc_dapm_route cs47l15_mono_routes[] = {
 	{ "HPOUT1 Mono Mux", "HPOUT", "OUT1L" },
-	{ "HPOUT1 Mono Mux", "EPOUT", "OUT1L" },
 };
 
 static int cs47l15_component_probe(struct snd_soc_component *component)
-- 
2.20.1

