Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF6D271C46
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 09:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgIUHuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 03:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgIUHuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 03:50:00 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B76C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 00:50:00 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y15so11493262wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 00:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eQeugMSbNm4MoGJLzLTQ1K90HqMCkQsDeLBTGL4VkMo=;
        b=zluKvCTLGO4Q1xNTMRSk0CyQwXbjLielLIiaHrs4aJ5B23YEK6UYXhfPZMmf68MMOU
         iXyvqIhrO/BHAKZf7qyHRQtoTetEsfzpsvASAnylyINqR4S2WdmLE/h6s8/Jnuk2wjJR
         fEPUhakN0RlOs2+ggSV6P5Xy7mjIdLSYAC+40Ghdh0WnDP2O+E85ah/3weYMe56st1sT
         L961A5Y/17Ncdz8TwYz8QJjIUHfR+8nMcSlRIUnr7CmhLHXpVPuFzY4xoXgLn7GGbr5t
         qicW/hvk80C9FR5o0cel+FJDhEML91OlwWYTx8HyuHfkGeB9u5qbtP5S/5szRwLCzVl4
         TjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eQeugMSbNm4MoGJLzLTQ1K90HqMCkQsDeLBTGL4VkMo=;
        b=LhAXP/WS33A1qZItL0vP1Imw0dQUYnLPMUjhqoEwQsfQtwAtpaLVaUXP0HCFG6l3of
         LPYcTdVHS8bAGDd86YHDI+TRHBZLBXZdNBU7FUlZ/bKQigbiJ9rtUhJ57piek4V2mOdm
         fJ++VCwcUv9RXgs1Tcl+6yXwv+33TzNbw+3Yt/l11uGKJyP9pXmJRr00tyXWXtZ10ImF
         IGFRslzWgU5wNPW0Rbu5ZX8B8abWr39T+U4LbRD0w/HTTjBZexsLwlxx2col4JhpBBV9
         43VsYEmnliZKOMhSFyCIvPFM3LvwRujEni45qSsCx4VsaTXWxZFbcu4C1DhZMaPsxEwE
         Rqhg==
X-Gm-Message-State: AOAM532BHk8P8TyeXlbP5dBRc2yU4u2Wh0o/0AhqTymPVrvnoWsZ04z6
        Q94W3CnbLaB7lMrfqAMxJ4cQsA==
X-Google-Smtp-Source: ABdhPJwM5F5CftRbSvYRv3kUr5yxBYf5c+QTnBmrJtpThRGN8qtcsxzNDcx41GF7jYUmHq+NVA49eA==
X-Received: by 2002:a7b:ca4a:: with SMTP id m10mr22398950wml.11.1600674598674;
        Mon, 21 Sep 2020 00:49:58 -0700 (PDT)
Received: from bender.baylibre.local (home.beaume.starnux.net. [82.236.8.43])
        by smtp.gmail.com with ESMTPSA id o16sm17854778wrp.52.2020.09.21.00.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 00:49:58 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     lorenzo.pieralisi@arm.com, yue.wang@Amlogic.com, robh@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] PCI: dwc/meson: do not fail on wait linkup timeout
Date:   Mon, 21 Sep 2020 09:49:53 +0200
Message-Id: <20200921074953.25289-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When establish link timeouts, probe fails but the error is unrelated since
the PCIe controller has been probed succesfully.

Align with most of the other dw-pcie drivers and ignore return of
dw_pcie_wait_for_link() in the host_init callback.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pci/controller/dwc/pci-meson.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 33deb290c4e7..846275e68fbc 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -383,10 +383,7 @@ static int meson_pcie_host_init(struct pcie_port *pp)
 
 	pp->bridge->ops = &meson_pci_ops;
 
-	ret = meson_pcie_establish_link(mp);
-	if (ret)
-		return ret;
-
+	meson_pcie_establish_link(mp);
 	dw_pcie_msi_init(pp);
 
 	return 0;
-- 
2.22.0

