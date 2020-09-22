Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4EC27391A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 05:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbgIVDIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 23:08:02 -0400
Received: from gateway34.websitewelcome.com ([192.185.148.196]:30291 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727348AbgIVDHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 23:07:52 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 223C3467B73
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 21:46:12 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id KYJokraeiCjCVKYJokOrHj; Mon, 21 Sep 2020 21:46:12 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qRs+UEH1wmwM31ASXLHKsq2CTWlssoqaIB7/r5mLnlI=; b=qI+GdOOVVENXGe0FOeYefZhomX
        E3i+z402rkHDr/lPao3OLiwp48fdAEWJWm8Egj3asT53uMUk9GU+SXgegtZYN97cevclm0l6gg4v8
        2dQs5VJhgCnGA+txLwizEwJa9BGrNvyMDc8MwexmtKluSdHbhctFkwKg9Diirw+EAan/7YmaA9Qwj
        l7l7j2NJt+BYi2yfvHXGLwX+322fl0l0COiUZquwyfQNZuJ1mJdEJb2KXy3P8IiKqUj65eqXSVfdR
        yWbmLGnngW//MAUzmZQ8lIjBxqiSpqfleZ8M8BoXhIO1edBofchcf8sv2Uyfx1oKo0W+oYzzmNFyH
        HZbo7acA==;
Received: from 179-197-124-241.user.veloxzone.com.br ([179.197.124.241]:43534 helo=localhost.localdomain)
        by br164.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <matheus@castello.eng.br>)
        id 1kKYJn-000jSR-DL; Mon, 21 Sep 2020 23:46:11 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     manivannan.sadhasivam@linaro.org, afaerber@suse.de,
        mark.rutland@arm.com, robh+dt@kernel.org
Cc:     edgar.righi@lsitec.org.br, igor.lima@lsitec.org.br,
        helen.koike@collabora.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-actions@lists.infradead.org,
        Matheus Castello <matheus@castello.eng.br>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v7 2/4] dt-bindings: arm: actions: Document Caninos Loucos Labrador
Date:   Mon, 21 Sep 2020 23:43:00 -0300
Message-Id: <20200922024302.205062-3-matheus@castello.eng.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922024302.205062-1-matheus@castello.eng.br>
References: <20200922024302.205062-1-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 179.197.124.241
X-Source-L: No
X-Exim-ID: 1kKYJn-000jSR-DL
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 179-197-124-241.user.veloxzone.com.br (localhost.localdomain) [179.197.124.241]:43534
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 30
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the documentation to add the Caninos Loucos Labrador. Labrador
project consists of the computer on module Core v2 based on the Actions
Semi S500, computer on module Core v3 based on the Actions Semi S700
and the Labrador base boards.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/actions.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/actions.yaml b/Documentation/devicetree/bindings/arm/actions.yaml
index ace3fdaa8396..1cc66803ce2a 100644
--- a/Documentation/devicetree/bindings/arm/actions.yaml
+++ b/Documentation/devicetree/bindings/arm/actions.yaml
@@ -19,6 +19,11 @@ properties:
               - allo,sparky # Allo.com Sparky
               - cubietech,cubieboard6 # Cubietech CubieBoard6
           - const: actions,s500
+      - items:
+          - enum:
+              - caninos,labrador-base-m # Labrador Base Board M v1
+          - const: caninos,labrador-v2  # Labrador Core v2
+          - const: actions,s500
       - items:
           - enum:
               - lemaker,guitar-bb-rev-b # LeMaker Guitar Base Board rev. B
@@ -26,6 +31,11 @@ properties:
           - const: actions,s500

       # The Actions Semi S700 is a quad-core ARM Cortex-A53 SoC.
+      - items:
+          - enum:
+              - caninos,labrador-base-m2 # Labrador Base Board M v2
+          - const: caninos,labrador-v3   # Labrador Core v3
+          - const: actions,s700
       - items:
           - enum:
               - cubietech,cubieboard7 # Cubietech CubieBoard7
--
2.28.0

