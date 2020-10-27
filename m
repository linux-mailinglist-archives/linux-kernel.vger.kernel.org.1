Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9142B29BDF5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1813391AbgJ0Qt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:49:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:43608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1812177AbgJ0Qpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 12:45:36 -0400
Received: from localhost.localdomain (unknown [122.171.48.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB1F620727;
        Tue, 27 Oct 2020 16:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603817136;
        bh=GqUWm6xF5GBuf0/zHVEOJtyPNfCGlFBpDeqW3Onj7m4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vof4c6ZZeWHvEKbcwtTc52UYDraEiDhSeExtwSY6N8zVpRzZ6CFAiOJI53SeVKqM/
         HktcITO7tu0gV2C43ii9Ovqus7DgbzcR5AEhw+grdUtFljEAiukzbBMTxVf8Qm98m+
         eQlyjHCh7g0c9255Umi5H1R0/Fai11VigpXc+pVs=
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] arm64: dts: msm8916: Fix dma node name
Date:   Tue, 27 Oct 2020 22:15:06 +0530
Message-Id: <20201027164511.476312-5-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201027164511.476312-1-vkoul@kernel.org>
References: <20201027164511.476312-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA controller binding describes the node name should be dma-controller
and not dma, so fix the node name

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index aaa21899f1a6..478c1fadc5cc 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1391,7 +1391,7 @@ sdhc_2: sdhci@7864000 {
 			status = "disabled";
 		};
 
-		blsp_dma: dma@7884000 {
+		blsp_dma: dma-controller@7884000 {
 			compatible = "qcom,bam-v1.7.0";
 			reg = <0x07884000 0x23000>;
 			interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.26.2

