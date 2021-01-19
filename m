Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5172FC2F9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 23:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbhASWGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 17:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728632AbhASRqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 12:46:32 -0500
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F29FC061793;
        Tue, 19 Jan 2021 09:44:26 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 980D43F0B4;
        Tue, 19 Jan 2021 18:44:22 +0100 (CET)
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
Subject: [PATCH v4 0/7] Really implement Qualcomm LAB/IBB regulators
Date:   Tue, 19 Jan 2021 18:44:14 +0100
Message-Id: <20210119174421.226541-1-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, the title may be a little "aggressive"? However, the qcom-labibb
driver wasn't really .. doing much.
The current form of this driver is only taking care of enabling or
disabling the regulators, which is pretty useless if they were not
pre-set from the bootloader, which sets them only if continuous
splash is enabled.
Moreover, some bootloaders are setting a higher voltage and/or a higher
current limit compared to what's actually required by the attached
hardware (which is, in 99.9% of the cases, a display) and this produces
a higher power consumption, higher heat output and a risk of actually
burning the display if kept up for a very long time: for example, this
is true on at least some Sony Xperia MSM8998 (Yoshino platform) and
especially on some Sony Xperia SDM845 (Tama platform) smartphones.

In any case, the main reason why this change was necessary for us is
that, during the bringup of Sony Xperia MSM8998 phones, we had an issue
with the bootloader not turning on the display and not setting the lab
and ibb regulators before booting the kernel, making it impossible to
powerup the display.

With this said, this patchset enables setting voltage, current limiting,
overcurrent and short-circuit protection.. and others, on the LAB/IBB
regulators.
Each commit in this patch series provides as many informations as
possible about what's going on and testing methodology.

Changes in v4:
 - Remove already applied commit
 - Add commit to switch to regulator_{list,map}_voltage_linear
   which in v3 got squashed in the commit that got removed in v4.

Changes in v3:
 - Improved check for PBS disable and short-circuit condition:
   during the testing of short-circuit, coincidentally another
   register reading zero on the interesting bit was probed,
   which didn't trigger a malfunction of the SC logic, but was
   also wrong.
   After the change, the short-circuit test was re-done in the
   same way as described in the commit that is implementing it.
 - From Bjorn Andersson review:
   - Improved documentation about over-current and short-circuit
     protection in the driver
   - Improved maintainability of qcom_labibb_sc_recovery_worker()
   - Flipped around check for PBS vreg disabled in for loop of
     function labibb_sc_err_handler()
 - From Mark Brown (forgotten in v2):
   - Changed regulator_{list,map}_voltage_linear_range usages to
     regulator_{list,map}_voltage_linear (and fixed regulator
     descs to reflect the change).

Changes in v2:
 - From Mark Brown review:
   - Replaced some if branches with switch statements
   - Moved irq get and request in probe function
   - Changed short conditionals to full ones
   - Removed useless check for ocp_irq_requested
 -  Fixed issues with YAML documentation

AngeloGioacchino Del Regno (7):
  regulator: qcom-labibb: Switch voltage ops from linear_range to linear
  regulator: qcom-labibb: Implement current limiting
  regulator: qcom-labibb: Implement pull-down, softstart, active
    discharge
  dt-bindings: regulator: qcom-labibb: Document soft start properties
  regulator: qcom-labibb: Implement short-circuit and over-current IRQs
  dt-bindings: regulator: qcom-labibb: Document SCP/OCP interrupts
  arm64: dts: pmi8998: Add the right interrupts for LAB/IBB SCP and OCP

 .../regulator/qcom-labibb-regulator.yaml      |  30 +-
 arch/arm64/boot/dts/qcom/pmi8998.dtsi         |   8 +-
 drivers/regulator/qcom-labibb-regulator.c     | 720 +++++++++++++++++-
 3 files changed, 735 insertions(+), 23 deletions(-)

-- 
2.30.0

