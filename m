Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F729246E37
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 19:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390033AbgHQRZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 13:25:32 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52578 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389788AbgHQRWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 13:22:21 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07HHLwj3048900;
        Mon, 17 Aug 2020 12:21:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1597684918;
        bh=5uErLWQl1ay7zziSwLpJ3cgDOcpRBisZrpOH7Xl0MWU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=LjpEho8V1QDdkylr6K5wgnffPh0d0JcKydNvQwIQm3wr3UiOWJZiyLJa+B5pItlsL
         YNvuur9R3kWGh4v8DdiWRcoCE7yW+SiV8VBlKKyZSE9uJweeYaYvaRrmTF/fXEckAy
         Vod84poQhCbSTyZLljUFIGfSKDQz4KRKvMP7+W34=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07HHLwES007744
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Aug 2020 12:21:58 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 17
 Aug 2020 12:21:57 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 17 Aug 2020 12:21:57 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07HHLvCv073438;
        Mon, 17 Aug 2020 12:21:57 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <robh@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 2/2] dt-bindings: tas2562: Add device specification links
Date:   Mon, 17 Aug 2020 12:21:51 -0500
Message-ID: <20200817172151.26564-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200817172151.26564-1-dmurphy@ti.com>
References: <20200817172151.26564-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device specification links for the TAS2562 and TAS2563.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 Documentation/devicetree/bindings/sound/tas2562.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/tas2562.yaml b/Documentation/devicetree/bindings/sound/tas2562.yaml
index 8d75a798740b..c3b7e19a0d44 100644
--- a/Documentation/devicetree/bindings/sound/tas2562.yaml
+++ b/Documentation/devicetree/bindings/sound/tas2562.yaml
@@ -16,6 +16,10 @@ description: |
   Integrated speaker voltage and current sense provides for
   real time monitoring of loudspeaker behavior.
 
+  Specifications about the audio amplifier can be found at:
+    https://www.ti.com/lit/gpn/tas2562
+    https://www.ti.com/lit/gpn/tas2563
+
 properties:
   compatible:
     enum:
-- 
2.28.0

