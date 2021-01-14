Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A9E2F68EE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 19:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbhANSFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 13:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbhANSFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 13:05:47 -0500
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35CDC061793
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 10:04:19 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id E5C951F4D3;
        Thu, 14 Jan 2021 19:04:16 +0100 (CET)
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
To:     agross@kernel.org
Cc:     linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, phone-devel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [PATCH v3 0/3] QCOM QUP I2C - Add noise rejection, convert to YAML
Date:   Thu, 14 Jan 2021 19:04:12 +0100
Message-Id: <20210114180415.404418-1-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series converts the i2c-qup bindings to YAML and then
adds support for noise rejection, which is needed for some noisy
hardware, like the touchscreen on the F(x)Tec Pro1.
After adding noise rejection, the touchscreen stopped showing
ghost touch issues and lockups.

Tested on F(x)Tec Pro1 (MSM8998).

Changes in v3, as per Bjorn's review:
 - Moved bitfield.h to maintain sort order
 - Removed useless variable initialization
 - Removed linebreak

Changes in v2:
 - Fixed ARM (32) build error (added bitfield.h inclusion)


AngeloGioacchino Del Regno (3):
  dt-bindings: i2c: qcom,i2c-qup: Convert txt to YAML schema
  i2c: qup: Introduce SCL/SDA noise rejection
  dt-bindings: i2c: qcom,i2c-qup: Document noise rejection properties

 .../devicetree/bindings/i2c/qcom,i2c-qup.txt  |  40 -------
 .../devicetree/bindings/i2c/qcom,i2c-qup.yaml | 101 ++++++++++++++++++
 drivers/i2c/busses/i2c-qup.c                  |  15 +++
 3 files changed, 116 insertions(+), 40 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/i2c/qcom,i2c-qup.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/qcom,i2c-qup.yaml

-- 
2.29.2

