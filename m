Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28F131A0C11
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 12:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgDGKgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 06:36:50 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36382 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbgDGKgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 06:36:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id d202so1283229wmd.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 03:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hso2J7opfoi1MkF9CkeZd0bKFD2GyxBW+ac7H4bJoMg=;
        b=Ro5qVrJkPFnjtYrlSuf/QfRk79xkL8m7WYpCs6ceAQ2l70aA6hP07c2uAKy4X2gwJd
         67IwMKItcK23hnZF1SlVGJMyuqUGI20px9JNeguaMI/ym//WD+OIDbOcgGWrnAlWSchz
         j3UuVvrnrwhWWuhSCVXS0alb3wnnh4dG0J30BeyiQlc4n5mTn6aVW/o4uIkkmw7Xk4rY
         /swqWwxFOg8VqPr7bec+BbDjSto4j31edxuySuag9F830z7hqnd1CkJlepdomyU/1S87
         mTEUALmihunfuZB/HvhCA+33bPBuz8ZQXRU3LxaLYFp7QMZTfh/bt1NHmljZTco0zota
         3jiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hso2J7opfoi1MkF9CkeZd0bKFD2GyxBW+ac7H4bJoMg=;
        b=jFV4DsUCmcZnWyIDyznfI9MAS4rvYFs50vJKQdIfChOUU3nMI9VNTmf4At/Q8Bm3zw
         WbaUrQwyZczxkN2w7/esUY/adyKi7KOs/6VyDxLumJ6n7V0dj4OmoSkuTPp4E/dM9qk+
         EZSIkKxPoyUUD5Zkx3VwumOwfPEInemQF8V4vokrONgHAK9LJPAxHReVw6L0tJ0R/y9M
         avc/LnBGglMW5cpklE3WNXKsbfl+XKfkX8QXnn5VDoqkYwF7ah7pp/9obSbKqSx2kY77
         bl2Fq8e/cjohXaRtjS1HPa3QKUXUABYVg90VBdSTqHOdFr4PRkD9ZRIPGh3VQYdfXfBC
         OVEg==
X-Gm-Message-State: AGi0Pua6S1U467BSnlC/Au0nH++YzY6J01dFWMXOFiWChUJh98NdCMWD
        drmNKdp+FUjzQFaDmn4MQxg=
X-Google-Smtp-Source: APiQypLrTiTAAK5rH+3jpeNejuPDIwUbyTsA42840oxs2Nv7LjBiUmVXh9o1TGwDcxXRzjEWIuvMVQ==
X-Received: by 2002:a1c:b684:: with SMTP id g126mr1637639wmf.163.1586255807131;
        Tue, 07 Apr 2020 03:36:47 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id c17sm25016722wrp.28.2020.04.07.03.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 03:36:46 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
X-Google-Original-From: Max Krummenacher <max.krummenacher@toradex.com>
To:     Max Krummenacher <max.krummenacher@toradex.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
        Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 2/4] arm64: defconfig: PCIE_TEGRA194: follow changed config symbol name
Date:   Tue,  7 Apr 2020 12:35:35 +0200
Message-Id: <20200407103537.4138-3-max.krummenacher@toradex.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200407103537.4138-1-max.krummenacher@toradex.com>
References: <20200407103537.4138-1-max.krummenacher@toradex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adding PCIE EP functionality the config symbol name logic for
PCIE RC was also changed.

Fixes commit c57247f940e8e ("PCI: tegra: Add support for PCIe endpoint
mode in Tegra194")

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

 arch/arm64/configs/defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ae908c3f43c76..7e2690b449328 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -208,7 +208,7 @@ CONFIG_PCIE_QCOM=y
 CONFIG_PCIE_ARMADA_8K=y
 CONFIG_PCIE_KIRIN=y
 CONFIG_PCIE_HISI_STB=y
-CONFIG_PCIE_TEGRA194=m
+CONFIG_PCIE_TEGRA194_HOST=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_FW_LOADER_USER_HELPER=y
-- 
2.20.1

