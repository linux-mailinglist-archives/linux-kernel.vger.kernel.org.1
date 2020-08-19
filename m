Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195F224A54D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 19:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgHSRyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 13:54:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgHSRyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 13:54:10 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDB942067C;
        Wed, 19 Aug 2020 17:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597859649;
        bh=+lMEGCp5k/4W2mojZvtyfBE+r5nQiIYYlfpn6vSb4ZE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MMUT8j46k7Uvd2tGhO09R/5TjMjgqPb8V52uNie6ncFfyWFg4q6jAlr5u2QVuLI8z
         KTTJuWjKIrEexR1GUkhlZ5mhEGM2Qk5YXHRqMcEQC0hRDXBTgKW+vLtcih3Xnm23KB
         qP8zrLdz4w4hOwFaC8ECEnfV5fkXmP/2tsQnPCLo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [RESEND PATCH 5/5] iommu: qcom: Drop of_match_ptr to fix -Wunused-const-variable
Date:   Wed, 19 Aug 2020 19:53:45 +0200
Message-Id: <20200819175345.20833-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200819175345.20833-1-krzk@kernel.org>
References: <20200819175345.20833-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_device_id is included unconditionally by of.h header and used
in the driver as well.  Remove of_match_ptr to fix W=1 compile test
warning with !CONFIG_OF:

    drivers/iommu/qcom_iommu.c:910:34: warning: 'qcom_iommu_of_match' defined but not used [-Wunused-const-variable=]
      910 | static const struct of_device_id qcom_iommu_of_match[] = {

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index af6bec3ace00..9535a6af7553 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -752,7 +752,7 @@ static const struct of_device_id ctx_of_match[] = {
 static struct platform_driver qcom_iommu_ctx_driver = {
 	.driver	= {
 		.name		= "qcom-iommu-ctx",
-		.of_match_table	= of_match_ptr(ctx_of_match),
+		.of_match_table	= ctx_of_match,
 	},
 	.probe	= qcom_iommu_ctx_probe,
 	.remove = qcom_iommu_ctx_remove,
@@ -915,7 +915,7 @@ static const struct of_device_id qcom_iommu_of_match[] = {
 static struct platform_driver qcom_iommu_driver = {
 	.driver	= {
 		.name		= "qcom-iommu",
-		.of_match_table	= of_match_ptr(qcom_iommu_of_match),
+		.of_match_table	= qcom_iommu_of_match,
 		.pm		= &qcom_iommu_pm_ops,
 	},
 	.probe	= qcom_iommu_device_probe,
-- 
2.17.1

