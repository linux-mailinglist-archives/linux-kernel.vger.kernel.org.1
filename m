Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A81E2B6BFA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbgKQRjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729026AbgKQRjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:39:31 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D10C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 09:39:31 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id ei22so895655pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 09:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=a081+5sEtLZdxVjnEsgO/mWDD8NzqZQtkeB5cfYLH30=;
        b=kCPiliRHIVUfr3L65ip40e8uAZiZ43JMLQyUgVBVtUA29OXaMwbzaSiamP11wt0nLi
         YVa3Qf38eA5gN/+rNsQ2yM+7QDY/yuP/UdK8t7jLdm57RGM4czTgeq4kP1cVpogmijvV
         wVjnFT8FXE1vJP4YXScEOzp/B9Pef8KcRULWWV4OzUD2rdL3nK/eh3z2bTvZw7qs9an7
         5QQE5YXAMymBZT4ZOuhJAS7VyRoE8JXOX2V/jyfYemcIdNu/N3KtrbCHfJ/sb+LCu0/B
         4xh1S+Bz4jEDDhMyHZgJGwX6DIIZ2Gr9XIAgLvexRPm71kwn/sfBOs90yUGokUHCxsoU
         E3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a081+5sEtLZdxVjnEsgO/mWDD8NzqZQtkeB5cfYLH30=;
        b=E6vUCOCrD4gkpF/Z+uXCxdlGmD/lHj71ScmS4X059gjKw4D3oDnYzokkK3YpgyUhHK
         eGL8OPuscAtBWZutjVWmolsMc5yL0kXVOBPyXZixRCVNxD+YQwlgPxYCM/i9IiM6VO1u
         66HIT5LDJMEyMrfYOX+/SUEBTAIYkcWDdzEQQ9VFYLmss9lBuAcLijYPHHv3jkazlRCb
         aPmHxu+jOc1PPerWGe9RbMU5PLrvcu7d/tnCflDJjRAZvZUR1XMeBHSLWo1bE1apbNIB
         /i6jXTkcNiQK5oodR5f+iCnz+msbE9uYlkIkzjea4oeakJ7NyOScDv2PzU4iyARDplUC
         Av0Q==
X-Gm-Message-State: AOAM532NclL6pwIoIbSyw1iPpRtL7Cno0VQBvqQWCk0scf/vkWUDxEKV
        C3BpIpIoxg9F0+D3m2Ip8iN/
X-Google-Smtp-Source: ABdhPJzen4z1mH9hBVGR9pVV33DpCmvTAdG0rBun1a5GKDaehYXQ3z704Mh6UStGa5Zhwit7VNd1Xw==
X-Received: by 2002:a17:90b:a02:: with SMTP id gg2mr149355pjb.225.1605634770702;
        Tue, 17 Nov 2020 09:39:30 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id a21sm1751330pjq.37.2020.11.17.09.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 09:39:29 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     bjorn.andersson@linaro.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/4] Add support for Qcom SMEM based NAND parser
Date:   Tue, 17 Nov 2020 23:09:05 +0530
Message-Id: <20201117173909.23585-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds support for parsing the partitions defined in Shared
Memory (SMEM) of the Qualcomm platforms supporting NAND interface.
Current parser only supports V3 and V4 of the partition tables.

This series has been tested on SDX55 MTP board which has an onboard NAND
device.

Thanks,
Mani

Manivannan Sadhasivam (4):
  dt-bindings: mtd: partitions: Add binding for Qcom SMEM parser
  mtd: parsers: Add Qcom SMEM parser
  mtd: rawnand: qcom: Add support for Qcom SMEM parser
  mtd: parsers: afs: Fix freeing the part name memory in failure

 .../mtd/partitions/qcom,smem-part.yaml        |  31 ++++
 drivers/mtd/nand/raw/qcom_nandc.c             |   4 +-
 drivers/mtd/parsers/Kconfig                   |   8 +
 drivers/mtd/parsers/Makefile                  |   1 +
 drivers/mtd/parsers/afs.c                     |   4 +-
 drivers/mtd/parsers/qcomsmempart.c            | 169 ++++++++++++++++++
 6 files changed, 213 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml
 create mode 100644 drivers/mtd/parsers/qcomsmempart.c

-- 
2.17.1

