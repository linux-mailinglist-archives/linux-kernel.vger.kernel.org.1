Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B445A1E0488
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 03:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388680AbgEYBzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 May 2020 21:55:44 -0400
Received: from gateway24.websitewelcome.com ([192.185.51.162]:48886 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388090AbgEYBzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 21:55:44 -0400
X-Greylist: delayed 1495 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 May 2020 21:55:43 EDT
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 12A66BF14
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 20:30:47 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id d1x1jCYObXVkQd1x1jFSXQ; Sun, 24 May 2020 20:30:47 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=E45E1Vj+A/NTDChq03v5v3U7lpRMI2oRWZNhEsEFnGQ=; b=a6KU2szuPIjfoOQt8Wu2X8q5VP
        LuAZEH+8p+NDoRRABl0NlePlU3NLsWKsM1Uh8wj2alIjrzDoRNibqMB3T4ko21Rvd7j+FxFLdCmb/
        DTtSMucvKYUvieP94F5iBe8bfOUHTcFgXksWgdAcBWcupioVeezVIzIm9sAAeWHCESv6gyqmjew1G
        jrVsG1XXEFecb3EAp43A20UWoul2WcUGT4xP3w7QgJ00HJGLnN7H9FCTbBi7E6qIpjAjFZjHNoG/u
        CxTKG5XQ4/0LBoPPssSBu3ZVvcCftDmlmZSYNUOdzYfEa+4MVLK34IvsNyHYo0YC8p1Uw1CjpDemk
        LGDYjOQA==;
Received: from [191.31.196.240] (port=34284 helo=castello.castello)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1jd1x0-004Dik-F5; Sun, 24 May 2020 22:30:46 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        mark.rutland@arm.com, robh+dt@kernel.org
Cc:     edgar.righi@lsitec.org.br, igor.lima@lsitec.org.br,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        Matheus Castello <matheus@castello.eng.br>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 2/3] dt-bindings: arm: actions: Document Caninos Loucos Labrador
Date:   Sun, 24 May 2020 22:30:07 -0300
Message-Id: <20200525013008.108750-3-matheus@castello.eng.br>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200525013008.108750-1-matheus@castello.eng.br>
References: <20200525013008.108750-1-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.31.196.240
X-Source-L: No
X-Exim-ID: 1jd1x0-004Dik-F5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (castello.castello) [191.31.196.240]:34284
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 26
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the documentation to add the Caninos Loucos Labrador. Labrador
project consists of a computer on module based on the Actions Semi S500
processor and the Labrador base board.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/actions.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/actions.yaml b/Documentation/devicetree/bindings/arm/actions.yaml
index ace3fdaa8396..2187e1c5bc73 100644
--- a/Documentation/devicetree/bindings/arm/actions.yaml
+++ b/Documentation/devicetree/bindings/arm/actions.yaml
@@ -19,6 +19,11 @@ properties:
               - allo,sparky # Allo.com Sparky
               - cubietech,cubieboard6 # Cubietech CubieBoard6
           - const: actions,s500
+      - items:
+          - enum:
+              - caninos,labrador-v2 # Labrador Core v2
+              - caninos,labrador-base-m # Labrador Base Board M v1
+          - const: actions,s500
       - items:
           - enum:
               - lemaker,guitar-bb-rev-b # LeMaker Guitar Base Board rev. B
--
2.26.2

