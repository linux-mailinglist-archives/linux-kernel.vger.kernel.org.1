Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3A22EFFDF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 14:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbhAINbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 08:31:09 -0500
Received: from relay02.th.seeweb.it ([5.144.164.163]:32833 "EHLO
        relay02.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbhAINae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 08:30:34 -0500
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 2AFB91F571;
        Sat,  9 Jan 2021 14:29:46 +0100 (CET)
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, sumit.semwal@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [PATCH 7/7] arm64: dts: pmi8998: Add the right interrupts for LAB/IBB SCP and OCP
Date:   Sat,  9 Jan 2021 14:29:21 +0100
Message-Id: <20210109132921.140932-8-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210109132921.140932-1-angelogioacchino.delregno@somainline.org>
References: <20210109132921.140932-1-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 208921bae696 ("arm64: dts: qcom: pmi8998: Add nodes for
LAB and IBB regulators") bindings for the lab/ibb regulators were
added to the pmi8998 dt, but the original committer has never
specified what the interrupts were for.
LAB and IBB regulators provide two interrupts, SC-ERR (short
circuit error) and VREG-OK but, in that commit, the regulators
were provided with two different types of interrupts;
specifically, IBB had the SC-ERR interrupt, while LAB had the
VREG-OK one, none of which were (luckily) used, since the driver
didn't actually use these at all.
Assuming that the original intention was to have the SC IRQ in
both LAB and IBB, as per the names appearing in documentation,
fix the SCP interrupt.

While at it, also add the OCP interrupt in order to be able to
enable the Over-Current Protection feature, if requested.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
 arch/arm64/boot/dts/qcom/pmi8998.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pmi8998.dtsi b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
index c8e21713cb9f..5742163d49b3 100644
--- a/arch/arm64/boot/dts/qcom/pmi8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
@@ -30,11 +30,15 @@ labibb {
 			compatible = "qcom,pmi8998-lab-ibb";
 
 			ibb: ibb {
-				interrupts = <0x3 0xdc 0x2 IRQ_TYPE_EDGE_RISING>;
+				interrupts = <0x3 0xdc 0x2 IRQ_TYPE_EDGE_RISING>,
+					     <0x3 0xdc 0x0 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "sc-err", "ocp";
 			};
 
 			lab: lab {
-				interrupts = <0x3 0xde 0x0 IRQ_TYPE_EDGE_RISING>;
+				interrupts = <0x3 0xde 0x1 IRQ_TYPE_EDGE_RISING>,
+					     <0x3 0xde 0x0 IRQ_TYPE_LEVEL_LOW>;
+				interrupt-names = "sc-err", "ocp";
 			};
 		};
 
-- 
2.29.2

