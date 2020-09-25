Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFB52784A6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 12:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbgIYKCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 06:02:04 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:29946 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726255AbgIYKCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 06:02:04 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 08P9GBBf003459;
        Fri, 25 Sep 2020 04:18:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=J72k7oataLeTskram+R5dvF7s3C8RVc9QykzHum188Y=;
 b=KKLw2OZcr3tgf+C1fgM/ZVC1+vALW1FF8VJoxYzKw2FFdbg4DaxZqkFRmptWKd3/nGMj
 GemIPOXcjjXtXsLrBDhE4tSF/NPN2x333JsN3zQpuJLf4PEnbZBNcaR9FgbzGK1USZUP
 DwB9pxKW/brbrHxnZONKdSCuDzzBgOP3foWjd4teMqW1qsTRKM7IuDYM1R5cWrV9gOQG
 DMKi9Jbw4rIqcNBsvKGCpTdwTVQGAM8ox2n6/eyDmmO4mU/saf0l0OCgWxWqKX0lEoCG
 4ZPLcAsK6OaCCxuGOIdJyWTsE06G4I2/Be7gKMMrzLWsJgK1GuYgp9kkj1hAgMTitZlb Rg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 33nedn7te4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 25 Sep 2020 04:18:42 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 25 Sep
 2020 10:18:36 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 25 Sep 2020 10:18:36 +0100
Received: from AUSNPC0LSNW1-debian.ad.cirrus.com (ausnpc0lsnw1.ad.cirrus.com [198.61.64.158])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7DE2D2A1;
        Fri, 25 Sep 2020 09:18:36 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 2/2] ASoC: cs47l35: Fix EPOUT->HPOUT1 Mono Mux routing
Date:   Fri, 25 Sep 2020 10:18:30 +0100
Message-ID: <20200925091830.7675-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925091830.7675-1-rf@opensource.cirrus.com>
References: <20200925091830.7675-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 mlxlogscore=910 suspectscore=1 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009250065
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EPOUT is always mono so should have a permanent routing through the
HPOUT1 Mono Mux.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs47l35.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs47l35.c b/sound/soc/codecs/cs47l35.c
index 7f5dd01f40c9..e967609da8a3 100644
--- a/sound/soc/codecs/cs47l35.c
+++ b/sound/soc/codecs/cs47l35.c
@@ -1305,6 +1305,7 @@ static const struct snd_soc_dapm_route cs47l35_dapm_routes[] = {
 	{ "SPKOUTP", NULL, "OUT4L" },
 
 	{ "OUT1R", NULL, "HPOUT1 Mono Mux" },
+	{ "HPOUT1 Mono Mux", "EPOUT", "OUT1L" },
 
 	{ "HPOUTL", "HPOUT", "HPOUT1 Demux" },
 	{ "HPOUTR", "HPOUT", "HPOUT1 Demux" },
@@ -1550,7 +1551,6 @@ static irqreturn_t cs47l35_adsp2_irq(int irq, void *data)
 
 static const struct snd_soc_dapm_route cs47l35_mono_routes[] = {
 	{ "HPOUT1 Mono Mux", "HPOUT", "OUT1L" },
-	{ "HPOUT1 Mono Mux", "EPOUT", "OUT1L" },
 };
 
 static int cs47l35_component_probe(struct snd_soc_component *component)
-- 
2.20.1

