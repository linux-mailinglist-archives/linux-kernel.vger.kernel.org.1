Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068C929400F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 17:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436996AbgJTP6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 11:58:06 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:18334 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436986AbgJTP6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 11:58:06 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09KFfsqI008231;
        Tue, 20 Oct 2020 17:57:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=AJvF9/JFTz1FhLaB94FzcVX/0E99nQwQ1rJ9Dmzl8T8=;
 b=inGVilx2xfegbyLNBtrtH2fDigZLIwQrjxRWmkApuhXPBVlqbO6G/bksC+F5E9biDUyl
 ytw3iyLz++e4gE2yuPFFYresuANV4zFdiBw2v9qAKgI7qVRwXeItMKX+mSJ8q1b15ws6
 TPhT4iPKcEaJY7leOslJ7RN3eE0irv7kL50DJru4VXmDfBGDK4RdzdRm9zgE2tWDRPJk
 N3JJmMiff75nUG1UoSSavTBfATEK+9gYPLosNtFW/G8pEcLbDYpxzi0ORbLfW0gzspPR
 MnyEkq3PKj2iFdV4jsViHeFr9YWMLi7pGWd2a5cVngBxXy33xL6uFzTXU+FhwgvNZ991 4Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 347pcwuuw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Oct 2020 17:57:15 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7E095100034;
        Tue, 20 Oct 2020 17:57:14 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6905A206291;
        Tue, 20 Oct 2020 17:57:14 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 20 Oct 2020 17:57:13
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <alexandre.torgue@st.com>, <robh@kernel.org>,
        <mark.rutland@arm.com>, <olivier.moysan@st.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <arnaud.pouliquen@st.com>
Subject: [PATCH v2 1/2] dt-bindings: stm32: dfsdm: update audio properties
Date:   Tue, 20 Oct 2020 17:57:08 +0200
Message-ID: <20201020155709.2621-2-olivier.moysan@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201020155709.2621-1-olivier.moysan@st.com>
References: <20201020155709.2621-1-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-20_08:2020-10-20,2020-10-20 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add missing compatible property in audio node.
- Remove obsolete "st,stm32-dfsdm-pdm" compatible.
- Remove useless comment in adc io-channels description.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 .../devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml    | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
index d61bc011e820..6f2398cdc82d 100644
--- a/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
@@ -199,8 +199,6 @@ patternProperties:
               description:
                 From common IIO binding. Used to pipe external sigma delta
                 modulator or internal ADC output to DFSDM channel.
-                This is not required for "st,stm32-dfsdm-pdm" compatibility as
-                PDM microphone is binded in Audio DT node.
 
           required:
             - io-channels
@@ -235,6 +233,10 @@ patternProperties:
               description: child node
 
               properties:
+                compatible:
+                  enum:
+                    - st,stm32h7-dfsdm-dai
+
                 "#sound-dai-cells":
                   const: 0
 
@@ -244,6 +246,7 @@ patternProperties:
                     modulator or internal ADC output to DFSDM channel.
 
               required:
+                - compatible
                 - "#sound-dai-cells"
                 - io-channels
 
-- 
2.17.1

