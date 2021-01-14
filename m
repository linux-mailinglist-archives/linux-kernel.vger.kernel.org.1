Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACCE2F6C18
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 21:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbhANUcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 15:32:55 -0500
Received: from mail-40134.protonmail.ch ([185.70.40.134]:38431 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728099AbhANUcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 15:32:53 -0500
Date:   Thu, 14 Jan 2021 20:32:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1610656331;
        bh=ZjEeyA413RNzpU9DT+FNrhe0K3Gvid9ETDUGt0k6xos=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=FQtJcXyrSzOzQhCejPr+Moq0CVLEOGugaxaLGZttMZzQkR99WOVg7Vq5T8sSuvQx4
         QZTOB8nq3TtFm4ahmKS2ib8YutPvZ4NQYmd67EqJRWPy3ePeai9HpI3WN0Wdtrnvsd
         rNJajI6e+ymDq6H4qlpFP+QdmgQcOBCZpThTBoHk=
To:     caleb@connolly.tech, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: Caleb Connolly <caleb@connolly.tech>
Subject: [PATCH v4 2/2] dt-bindings: Document bindings for new SDM845 devices
Message-ID: <20210114203057.64541-3-caleb@connolly.tech>
In-Reply-To: <20210114203057.64541-1-caleb@connolly.tech>
References: <20210114203057.64541-1-caleb@connolly.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document compatible bindings for the new OnePlus 6/6T devices.

Signed-off-by: Caleb Connolly <caleb@connolly.tech>
---
 Documentation/devicetree/bindings/arm/qcom.yaml        | 5 +++++
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentatio=
n/devicetree/bindings/arm/qcom.yaml
index c97d4a580f47..f3ad845754d3 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -171,6 +171,11 @@ properties:
           - enum:
               - qcom,ipq6018-cp01-c1
           - const: qcom,ipq6018
+      - items:
+          - enum:
+              - oneplus,enchilada
+              - oneplus,fajita
+          - const: qcom,sdm845
=20
       - items:
           - enum:
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Docum=
entation/devicetree/bindings/vendor-prefixes.yaml
index 041ae90b0d8f..aff440b18293 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -800,6 +800,8 @@ patternProperties:
     description: OLIMEX Ltd.
   "^olpc,.*":
     description: One Laptop Per Child
+  "^oneplus,.*":
+    description: One Plus Technology (Shenzhen) Co., Ltd.
   "^onion,.*":
     description: Onion Corporation
   "^onnn,.*":
--=20
2.29.2


