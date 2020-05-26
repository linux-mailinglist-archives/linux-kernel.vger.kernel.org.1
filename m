Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761C31BBC8A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 13:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgD1LjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 07:39:00 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:17455 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726450AbgD1Li7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 07:38:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588073939; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=POwfgFIOxtbPju7wD7/s3JdH07w592RY3CAWHfQJRRs=; b=tZF877IXCvQHEcAinGmhiQLwpqv+8c91MCHUQs5O21/ht4KDdXDUzTjb3vuZck8DXDfK18Hd
 0RxF+wD/16KOyOqwS/zY0ZlnYSKwVok3IA5/9GTVg82PqpY3O7wphpIRzLwxDbyyScnXnBxg
 nA7uJmTGq0D90AnPPCPVSWpYALg=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea815c5.7efd193598b8-smtp-out-n02;
 Tue, 28 Apr 2020 11:38:45 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C4DAFC43637; Tue, 28 Apr 2020 11:38:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from smasetty-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: smasetty)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BFEC2C433D2;
        Tue, 28 Apr 2020 11:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BFEC2C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=smasetty@codeaurora.org
From:   Sharat Masetty <smasetty@codeaurora.org>
To:     freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     dri-devel@freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        dianders@chromium.org, robh@kernel.org, robin.murphy@arm.com,
        saiprakash.ranjan@codeaurora.org,
        Sharat Masetty <smasetty@codeaurora.org>
Subject: [PATCH] dt-bindings: arm-smmu: Add a new compatible string and a clock
Date:   Tue, 28 Apr 2020 17:08:34 +0530
Message-Id: <1588073914-15712-1-git-send-email-smasetty@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new compatible string for sc7180 and also an
additional clock listing needed to power the TBUs and the TCU.

Signed-off-by: Sharat Masetty <smasetty@codeaurora.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 6515dbe..15946ac 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -28,6 +28,7 @@ properties:
           - enum:
               - qcom,msm8996-smmu-v2
               - qcom,msm8998-smmu-v2
+              - qcom,sc7180-smmu-v2
               - qcom,sdm845-smmu-v2
           - const: qcom,smmu-v2
 
@@ -113,16 +114,22 @@ properties:
       present in such cases.
 
   clock-names:
+    minItems: 2
+    maxItems: 3
     items:
       - const: bus
       - const: iface
+      - const: mem_iface_clk
 
   clocks:
+    minItems: 2
+    maxItems: 3
     items:
       - description: bus clock required for downstream bus access and for the
           smmu ptw
       - description: interface clock required to access smmu's registers
           through the TCU's programming interface.
+      - description: clock required for the SMMU TBUs and the TCU
 
   power-domains:
     maxItems: 1
-- 
1.9.1
