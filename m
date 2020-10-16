Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66174290AD3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 19:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391885AbgJPRgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 13:36:08 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:6990 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391536AbgJPRgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 13:36:04 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 09GHQNpN024410;
        Fri, 16 Oct 2020 12:35:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=9T+LsXyb9i7uI1E4HpwrFelai64CiEIwmAXKtnGXQt8=;
 b=K8sEWQL73uz/mscJPLGrNV+/J5uCbWyzu/0OQ6w9rDSXqd9gEjX5vK7RB6vwSaYHbxF/
 pZemWz0KD2uL/EdHNNJ4MSEEfnXzojUxGhK3s33I/hSoN4tFyo93cfe3L81Q98FGVdel
 RkB9vRHSlrDP+waqPMBM4pHAVRRaWfV9enWUBlM1EEULKuZthAmOC8AwFNoL4yfbcXnq
 Qwp2tDmlhJ4meRVopdehLQCXhk3kHROvAuFYB9S/Kj5xcXGrOkL9zdwgdc+r76VphZ4m
 FoYSM/iiJnSZGoTgOyv/Hi71jVN1DLBWSNF7CBrUhg53hnujngetpLj/QLjJmnKtrOcg Aw== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 343ac20jk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 16 Oct 2020 12:35:47 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 16 Oct
 2020 18:35:45 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 16 Oct 2020 18:35:45 +0100
Received: from AUSNPC0LSNW1-debian.ad.cirrus.com (ausnpc0lsnw1.ad.cirrus.com [198.61.64.143])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1641045;
        Fri, 16 Oct 2020 17:35:45 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <nsaenzjulienne@suse.de>
CC:     <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 2/7] ASoC: audio-graph-card: Add plls and sysclks DT bindings
Date:   Fri, 16 Oct 2020 18:35:36 +0100
Message-ID: <20201016173541.21180-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201016173541.21180-1-rf@opensource.cirrus.com>
References: <20201016173541.21180-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=629 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010160130
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the two new properties 'plls' and 'sysclks' to the dt bindings.
These add the ability to set values that will be
passed to snd_soc_component_set_sysclk() and snd_soc_component_set_pll().

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 .../bindings/sound/audio-graph-card.txt       | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-card.txt b/Documentation/devicetree/bindings/sound/audio-graph-card.txt
index d5f6919a2d69..59bbd5b55b59 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph-card.txt
+++ b/Documentation/devicetree/bindings/sound/audio-graph-card.txt
@@ -32,6 +32,19 @@ Required properties:
 Optional properties:
 - pa-gpios: GPIO used to control external amplifier.
 
+- plls: A list of component pll settings that will be applied with
+      snd_soc_component_set_pll. Each entry is a phandle to the node of the
+      codec or cpu component, followed by the four arguments id, source,
+      frequency_in, frequency_out. Multiple entries can have the same phandle
+      so that several plls can be set in the same component.
+
+- sysclks: A list of component sysclk settings that will be applied with
+      snd_soc_component_set_sysclk. Each entry is a phandle to the node of
+      the codec or cpu component, followed by the four arguments id, source,
+      frequency, direction. Direction is 0 if the clock is an input, 1 if it
+      is an output. Multiple entries can have the same phandle so that several
+      clocks can be set in the same component.
+
 -----------------------
 Example: Single DAI case
 -----------------------
@@ -335,3 +348,34 @@ Example: Multi DAI with DPCM
 			};
 		};
 	};
+
+-----------------------
+Example: Set component sysclks and PLLs
+-----------------------
+
+	sound {
+		compatible = "audio-graph-card";
+
+		sysclks = <
+			&cs47l15 1 4 98304000 0
+			&cs47l15 8 4 147456000 0
+		>;
+		plls = <
+			&cs47l15 1 0 24576000 98304000
+		>;
+
+		dais = <&cpu_i2s_port>;
+	};
+
+	cs47l15: codec@0 {
+		...
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cs47l15_aif1_port: port@0 {
+				reg = <0>;
+				cs47l15_aif1: endpoint {
+					remote-endpoint = <&cpu_i2s_endpoint>;
+				};
+			};
+	};
-- 
2.20.1

