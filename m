Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7229F273918
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 05:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbgIVDH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 23:07:56 -0400
Received: from gateway34.websitewelcome.com ([192.185.148.196]:28992 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727388AbgIVDHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 23:07:53 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id CE5E71409D7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 21:45:49 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id KYJRk4DzZBD8bKYJRkFlUv; Mon, 21 Sep 2020 21:45:49 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FaRE6vH2JAwJ9KGeJOLRvgBT4V+7OmNZ3eKCXVu43L4=; b=IRv9J/e3z3vFqgUiaQmHZy9I2s
        ve4JY5TC5a0MsgmvzdmERFgncZx+4J4JsF1wNQ9kvYy4vYMIGOkv6Pcqu81fnlDhlckxHKHNFMLXd
        ftW2B4PFOLUIBA9S2D2zBxO9jZuKSThPyqo+w9wsd9CmOgYpoKNhGKbC3YnGEMbnKRVyUivohBvHA
        u1mw+dxuT8tMGk+UKLsu7krzJ/xOLzbB4mP63PMZsVDQEpcQw0Rx3HapR7hWapIdta5qpHnOSF0VE
        hwYpqoCCWkrMqvfQYMDaM0u9M4D2TMvoM1PZnrMqTnWxhSrAS2HGvGzio3CNM9X+2QXQWlF/ciKAQ
        Cewea/Tw==;
Received: from 179-197-124-241.user.veloxzone.com.br ([179.197.124.241]:43534 helo=localhost.localdomain)
        by br164.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <matheus@castello.eng.br>)
        id 1kKYJR-000jSR-2h; Mon, 21 Sep 2020 23:45:49 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     manivannan.sadhasivam@linaro.org, afaerber@suse.de,
        mark.rutland@arm.com, robh+dt@kernel.org
Cc:     edgar.righi@lsitec.org.br, igor.lima@lsitec.org.br,
        helen.koike@collabora.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-actions@lists.infradead.org,
        Matheus Castello <matheus@castello.eng.br>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v7 1/4] dt-bindings: Add vendor prefix for Caninos Loucos
Date:   Mon, 21 Sep 2020 23:42:59 -0300
Message-Id: <20200922024302.205062-2-matheus@castello.eng.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922024302.205062-1-matheus@castello.eng.br>
References: <20200922024302.205062-1-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 179.197.124.241
X-Source-L: No
X-Exim-ID: 1kKYJR-000jSR-2h
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 179-197-124-241.user.veloxzone.com.br (localhost.localdomain) [179.197.124.241]:43534
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 16
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Caninos Loucos Program develops Single Board Computers with an open
structure. The Program wants to form a community of developers to use
IoT technologies and disseminate the learning of embedded systems in
Brazil.

It is an initiative of the Technological Integrated Systems Laboratory
(LSI-TEC) with the support of Polytechnic School of the University of
São Paulo (Poli-USP) and Jon "Maddog" Hall.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Andreas Färber <afaerber@suse.de>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 63996ab03521..aac0dc3caf3b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -179,6 +179,8 @@ patternProperties:
     description: CALAO Systems SAS
   "^calxeda,.*":
     description: Calxeda
+  "^caninos,.*":
+    description: Caninos Loucos Program
   "^capella,.*":
     description: Capella Microsystems, Inc
   "^cascoda,.*":
--
2.28.0

