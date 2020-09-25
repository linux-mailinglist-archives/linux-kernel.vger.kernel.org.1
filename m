Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A8C278412
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 11:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgIYJcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 05:32:13 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:58410 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727679AbgIYJcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 05:32:12 -0400
X-Greylist: delayed 801 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Sep 2020 05:32:12 EDT
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 08P9GBBe003459;
        Fri, 25 Sep 2020 04:18:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=wph01T7UmRsyFJuRCiq74vVYOpu+avjXRH7hJzmc/J4=;
 b=ICAL8fn0AjdGbk+XShwhPQcf6TkLh2oLoqBRS8vy1gPPPkwdCmydrVnoO1oocgpkFb6Y
 OVuuKstsoo0j+JSX2Ff3vmE4xiQUqS5ewspzBXpfic0bgexn/jNlxiwpA+1zACF/xi32
 zghCx/5qY9evourpXsDKmLipamIR0UIkvXkvP+MlbZ64F2TFnMbTiYEfttiEX+YyCvP6
 JoCorMEeTqfUDTKPxbfpFkVzB1cvbANzMDS2MBAZ2yQyP2lVlwB7XaU13XSia4uokoRh
 q13LaAHod+FVlj73kDDPbZdRlBnt6BIMXSyTOAPV0jyknFcynJ5GLKfOyZj5ceXam5Me zA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 33nedn7te4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 25 Sep 2020 04:18:37 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 25 Sep
 2020 10:18:36 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 25 Sep 2020 10:18:36 +0100
Received: from AUSNPC0LSNW1-debian.ad.cirrus.com (ausnpc0lsnw1.ad.cirrus.com [198.61.64.158])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id AACF345;
        Fri, 25 Sep 2020 09:18:35 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 1/2] ASoC: cs47l15: Fix EPOUT->HPOUT1 Mono Mux routing
Date:   Fri, 25 Sep 2020 10:18:29 +0100
Message-ID: <20200925091830.7675-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 mlxlogscore=952 suspectscore=1 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009250065
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

