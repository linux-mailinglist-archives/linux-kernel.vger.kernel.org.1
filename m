Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97AF22E8FBE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 05:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbhADENO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 23:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbhADENL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 23:13:11 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62165C0617A2
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jan 2021 20:11:59 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id j1so13833028pld.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2021 20:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=icXjVyLr8ROGK9HCrfmW24KYFfrqOe76+5Eys2pUaYc=;
        b=MUCjeC0n9Jzu3Ybx2+wYVVQZHu+be4Ab/JPXX+mx10mppyE8coiYJHLOQtIFIiWFDu
         tBlRN12//WUM+lgkJ6PgC9GzcdK4GHlrAIP6kx+aY7vfmCUtpostUbWZCfZpQ12UkCNd
         YILCpHW+eidapdhkVCU2wnGb7ghd0CWy99a5KDahC2HjtHvatBy24V9XvqkEw13tpddq
         pYhhyexGjqX5E197g6JPx9sSYsm66uBLzbGojSD10uk6mLqL8umyT4wb09EKzPZPCZiq
         UxNrEFHQLeF5GjsYB/5icUIISqQFUxKDglWMdt8qNdZ5GPbR3ipp8tlvgXKgx4Jpab5X
         NTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=icXjVyLr8ROGK9HCrfmW24KYFfrqOe76+5Eys2pUaYc=;
        b=tvnVN7IHL+VO7rhv9M9/22R+I6OcpLwPUkzbaMA2K3qQ0QO8GR+GRfCpvagK+v6Z4d
         gjWJ+uAa8u/JhXRczpISKOTe8lBmWsLArj26dK7dxjAEGd16zot9az5fFmAAUHmfCABY
         Ygrzh1iVX48TdTWzNbTsQf5rv7u0w5qWWXBXn2NtqjYplZSTOVkm1QWcHm0CEXoMhca1
         9p71Rna1KoNb+uYqiZa1FZE0tQAvpjiJlkrU63eufDlo1IA3RX4aKyagvYVPBFl1Kv7p
         T5mp+bYWuQZO/oxI44B6iz59JO/+YU28lK/NZWHfgC7ckrhk5YchszEk17zra+Bj6+58
         qt2Q==
X-Gm-Message-State: AOAM531LRbMprh5DxGXKLkK2t0cELtocLw/Swh7A/oP+5WeEoYx7tMQK
        18T4T6ZFemqS4x5N6U+hU4uh
X-Google-Smtp-Source: ABdhPJwWuQlC9C42p7YriHVAU0fLFuzmlbs1I6A7poFZx8dMn5NBsQ8KChaZkRch5Lf4CybfrDMhpQ==
X-Received: by 2002:a17:902:6bca:b029:dc:34e1:26b1 with SMTP id m10-20020a1709026bcab02900dc34e126b1mr52162525plt.52.1609733518888;
        Sun, 03 Jan 2021 20:11:58 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.160])
        by smtp.gmail.com with ESMTPSA id x22sm54899930pfc.19.2021.01.03.20.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 20:11:58 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     bjorn.andersson@linaro.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 3/4] mtd: rawnand: qcom: Add support for Qcom SMEM parser
Date:   Mon,  4 Jan 2021 09:41:36 +0530
Message-Id: <20210104041137.113075-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210104041137.113075-1-manivannan.sadhasivam@linaro.org>
References: <20210104041137.113075-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for using Qualcomm SMEM based flash partition parser in
Qualcomm NAND controller.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 667e4bfe369f..fd4c318b520f 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2821,6 +2821,8 @@ static int qcom_nandc_setup(struct qcom_nand_controller *nandc)
 	return 0;
 }
 
+static const char * const probes[] = { "qcomsmem", NULL };
+
 static int qcom_nand_host_init_and_register(struct qcom_nand_controller *nandc,
 					    struct qcom_nand_host *host,
 					    struct device_node *dn)
@@ -2884,7 +2886,7 @@ static int qcom_nand_host_init_and_register(struct qcom_nand_controller *nandc,
 		}
 	}
 
-	ret = mtd_device_register(mtd, NULL, 0);
+	ret = mtd_device_parse_register(mtd, probes, NULL, NULL, 0);
 	if (ret)
 		nand_cleanup(chip);
 
-- 
2.25.1

