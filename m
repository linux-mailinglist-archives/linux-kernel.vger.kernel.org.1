Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4A42B893A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 02:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbgKSBFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 20:05:49 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56752 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbgKSBFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 20:05:48 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AJ15fnv069950;
        Wed, 18 Nov 2020 19:05:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605747941;
        bh=1gRjiKyj/jZJizdpNerB6Rxx3miu2PjfU9zpoj7KcHQ=;
        h=From:To:CC:Subject:Date;
        b=eozVu1Ay3gX0vgWvy6YYxZlmgCsgdOPDXjqfVDo3lYHfMcuO3g71vlaCRXaIE92qa
         K5QFB7WwfvmHJLF/CGPFUMeviLgT8YrkDI7tAo3gJnXTvOU5PvOHY0BTv62P46heqp
         e07ZPoXDFFp+1fXLWXvUTuHGzBqXMsEKpHmTQSRo=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AJ15f3H054074
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Nov 2020 19:05:41 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 18
 Nov 2020 19:05:41 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 18 Nov 2020 19:05:41 -0600
Received: from fllv0103.dal.design.ti.com (fllv0103.dal.design.ti.com [10.247.120.73])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AJ15f3d074558;
        Wed, 18 Nov 2020 19:05:41 -0600
Received: from localhost ([10.250.38.244])
        by fllv0103.dal.design.ti.com (8.14.7/8.14.7) with ESMTP id 0AJ15fmd076042;
        Wed, 18 Nov 2020 19:05:41 -0600
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH 0/3] TI K3 R5F remoteproc support on J7200 SoCs
Date:   Wed, 18 Nov 2020 19:05:28 -0600
Message-ID: <20201119010531.21083-1-s-anna@ti.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The following series enhances the K3 R5F remoteproc driver to add support
for the R5F clusters on the newer TI K3 J7200 SoC family. The J7200 SoCs
have 2 R5FSS clusters, and both clusters are capable of supporting either
the LockStep or Split-modes like on the existing AM65x and J721E SoCs.

The R5FSS IP though is revised compared to K3 AM65x and J721E SoCs and has
two new features: 
 1. TCMs are auto-initialized during module power-up, and the behavior
    is programmable through a SEC_MMR register bit.
 2. The LockStep-mode allows the Core1 TCMs to be combined with the 
    Core0 TCMs effectively doubling the amount of TCMs available.
    The LockStep-mode on previous SoCs could only use the Core0 TCMs.
    This combined TCMs appear contiguous at the respective Core0 TCM
    addresses.

The series is based on 5.10-rc1, and can apply on top of the current rproc-next
branch as well. Following is the patch summary:
 - Patch 1 updates the dt-bindings
 - Patch 2 introduces new SoC data logic and handles the TCM auto-init
   feature
 - Patch 3 handles the TCM adjustment logic in Split-mode

regards
Suman

Suman Anna (3):
  dt-bindings: remoteproc: k3-r5f: Update bindings for J7200 SoCs
  remoteproc: k3-r5: Extend support to R5F clusters on J7200 SoCs
  remoteproc: k3-r5: Adjust TCM sizes in Split-mode on J7200 SoCs

 .../bindings/remoteproc/ti,k3-r5f-rproc.yaml  |  2 +
 drivers/remoteproc/ti_k3_r5_remoteproc.c      | 95 ++++++++++++++++++-
 2 files changed, 95 insertions(+), 2 deletions(-)

-- 
2.28.0

