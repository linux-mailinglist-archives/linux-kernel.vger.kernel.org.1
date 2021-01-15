Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA612F80C8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 17:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731995AbhAOQ2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 11:28:55 -0500
Received: from relay07.th.seeweb.it ([5.144.164.168]:58619 "EHLO
        relay07.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbhAOQ2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 11:28:53 -0500
Received: from localhost.localdomain (abaf224.neoplus.adsl.tpnet.pl [83.6.169.224])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id E9C2A3EBC2;
        Fri, 15 Jan 2021 17:27:54 +0100 (CET)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom: socinfo: Add MDM9607 IDs
Date:   Fri, 15 Jan 2021 17:27:28 +0100
Message-Id: <20210115162728.118249-1-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Along with IDs for its derivatives.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 drivers/soc/qcom/socinfo.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index d21530d24253..f8829e1e344d 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -217,8 +217,13 @@ static const struct soc_id soc_id[] = {
 	{ 250, "MSM8616" },
 	{ 251, "MSM8992" },
 	{ 253, "APQ8094" },
+	{ 290, "MDM9607" },
 	{ 291, "APQ8096" },
 	{ 293, "MSM8953" },
+	{ 296, "MDM8207" },
+	{ 297, "MDM9207" },
+	{ 298, "MDM9307" },
+	{ 299, "MDM9628" },
 	{ 304, "APQ8053" },
 	{ 305, "MSM8996SG" },
 	{ 310, "MSM8996AU" },
@@ -226,6 +231,7 @@ static const struct soc_id soc_id[] = {
 	{ 312, "APQ8096SG" },
 	{ 318, "SDM630" },
 	{ 321, "SDM845" },
+	{ 322, "MDM9206" },
 	{ 338, "SDM450" },
 	{ 341, "SDA845" },
 	{ 349, "SDM632" },
-- 
2.29.2

