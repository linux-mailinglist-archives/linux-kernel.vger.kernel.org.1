Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87AAA2EF579
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 17:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbhAHQGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 11:06:11 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:31040 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727966AbhAHQGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 11:06:07 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 108G2EoY011561;
        Fri, 8 Jan 2021 10:05:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=kOekwXaZfSzN5B1r/aiMtLh+hLUch+Y8pXk00v7FV8I=;
 b=oJ5K4MITbPRuVJtx9dPXSS661PHDCyQCrnd23VoiyFcfqPtvWjFD6vXGOghK5aFkh4t0
 4ySW1Rnyj8zU1lr1yMNIwBlrGILAOTLyhdlFTGxsfqvonQdMHVCED3H0q1i3/vk9Ff3c
 PQOqVqy+w7CSViB2V7LYFB30/h6LnEp0OSZ406zbFopfYNkISh0OqhKayejVfRvCrCEG
 +pMgabUx+uMEcxFnUpA61NMytQk8vfqXsrr/qBrAP9J1sY5l4vrgB9GhEjlWHGyd5aOF
 GjNjmVAo9SHH3FlXgweDUXQlOrVh1jGycqq32xCr6f/D2iJI8rZ2ihb0F7pckeIAQufz GQ== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 35wqjka90t-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 08 Jan 2021 10:05:09 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 8 Jan 2021
 16:05:07 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 8 Jan 2021 16:05:07 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.226])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0395C11CE;
        Fri,  8 Jan 2021 16:05:06 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <kuninori.morimoto.gx@renesas.com>, <nsaenzjulienne@suse.de>,
        <f.fainelli@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v4 2/6] dt-bindings: audio-graph-card: Add plls and sysclks properties
Date:   Fri, 8 Jan 2021 16:04:57 +0000
Message-ID: <20210108160501.7638-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210108160501.7638-1-rf@opensource.cirrus.com>
References: <20210108160501.7638-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101080091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The audio-graph-card driver has properties for configuring the clocking
for DAIs within a component, but is missing properties for setting
up the PLLs and sysclks of the component.

This patch adds the two new properties 'plls' and 'sysclks' so that the
audio-graph-driver can fully configure the component clocking.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 .../bindings/sound/audio-graph.yaml           | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/audio-graph.yaml b/Documentation/devicetree/bindings/sound/audio-graph.yaml
index 4b46794e5153..9e0819205a17 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph.yaml
+++ b/Documentation/devicetree/bindings/sound/audio-graph.yaml
@@ -39,6 +39,52 @@ properties:
   mic-det-gpio:
     maxItems: 1
 
+  plls:
+    description: |
+      A list of component pll settings. There are 4 cells per PLL setting:
+        - phandle to the node of the codec or cpu component,
+        - component PLL id,
+        - component clock source id,
+        - frequency (in Hz) of the PLL output clock.
+      The PLL id and clock source id are specific to the particular component
+      so see the relevant component driver for the ids. Typically the
+      clock source id indicates the pin the source clock is connected to.
+      The same phandle can appear in multiple entries so that several plls
+      can be set in the same component.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+
+  plls-clocks:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description: |
+      A list of clock names giving the source clock for each setting
+      in the plls property.
+
+  sysclks:
+    description: |
+      A list of component sysclk settings. There are 4 cells per sysclk
+      setting:
+        - phandle to the node of the codec or cpu component,
+        - component sysclk id,
+        - component clock source id,
+        - direction of the clock: 0 if the clock is an input to the component,
+          1 if it is an output.
+      The sysclk id and clock source id are specific to the particular
+      component so see the relevant component driver for the ids. Typically
+      the clock source id indicates the pin the source clock is connected to.
+      The same phandle can appear in multiple entries so that several sysclks
+      can be set in the same component.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+
+  sysclks-clocks:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description: |
+      A list of clock names giving the source clock for each setting
+      in the sysclks property.
+
+dependencies:
+  plls: [ plls-clocks ]
+  sysclks: [ sysclks-clocks ]
+
 required:
   - dais
 
-- 
2.20.1

