Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD55C25C9C0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 21:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgICTxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 15:53:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729268AbgICTxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 15:53:49 -0400
Received: from localhost.localdomain (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85F7320767;
        Thu,  3 Sep 2020 19:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599162829;
        bh=nuVMH8zIxlrtluvxIgUKC509r2KZ2U51ZuPtejx+MFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u1UE/HMp3TRb8v5wXDV/HGeJWyI49Yunf/3F7JKoGaXjw1Xpu0IoDzrEo9o8EYd6U
         XhWXy0oIscA/k6ftDF5tCSLVgGx1jxg0PISPyBn39Zo6ijz1lloJqr+luuB6KAdbwN
         x7u8qxyTVaBqWjzGnGiHt6+XbQohdlhlz3Nlg9mM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 2/3] dt-bindings: mailbox: fsl,mu: Add missing power-domains
Date:   Thu,  3 Sep 2020 21:53:24 +0200
Message-Id: <20200903195325.5394-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903195325.5394-1-krzk@kernel.org>
References: <20200903195325.5394-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add quite common property - power-domains - to fix dtbs_check warnings
like:

  arch/arm64/boot/dts/freescale/imx8qxp-mek.dt.yaml:
    mailbox@5d280000: 'power-domains' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Add missing properties instead of unevaluatedProperties
---
 Documentation/devicetree/bindings/mailbox/fsl,mu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
index 7ed096360be2..e372dcce8037 100644
--- a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
@@ -72,6 +72,8 @@ properties:
     description: boolean, if present, means it is for side B MU.
     type: boolean
 
+  power-domains: true
+
 required:
   - compatible
   - reg
-- 
2.17.1

