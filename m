Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBB427909E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 20:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbgIYSdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 14:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729739AbgIYSdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 14:33:51 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93038C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 11:33:51 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x22so3989216pfo.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 11:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P7qkSkJYzDAlxMBmU/NPbl2KeJOU3g6WtyY+La0RA/4=;
        b=w+GhivlpXfTDhwn3vPYTmh2OA1kk2Sfja5xfWOST1L4zhQdO5NmjEo+zwi5hqcE03m
         sW80MG9dqqqH1e8AgXuoBQsBU4XnZCNnbX/oHzFmCiajo8yvTYrZ+RzFAvRF0rOP/ohA
         Oq+wbWHXX2anjvZ3bela+IrPODD2ZE+5nfBD84l8JmfYXjg1Wj3OjoPnqBqHf0Yrmzfm
         hfTuGtMYnILI4UCqLRJCtlYyhGerAQvlH/YXlRJDJeaIrC+1OsmumIwn7ZZFZ/7at2n9
         e2s5HWhjZb2GS8LI7N1h44oSGEwO+uCDHMTKot1tZzm2TWMffUxwaAB8SiDqDxlXmUbi
         FImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P7qkSkJYzDAlxMBmU/NPbl2KeJOU3g6WtyY+La0RA/4=;
        b=DwgPNMHYlIKAeVjDKKqjOVscvX6QD3SH4cB9CTle9kajqen5yB6u4LXNU8dxgvGV1z
         HT/VYNe/5mS6d1gIQ6uHVlJsGxbP9/Qf05y2Uf9wv1AKMd1UPB+iebFwCfVWyCWXhzLg
         Wk4877SDPnQbJvZSXUn0nyB83jFvSAQAI+Ng9R/eZug9mkaW34l4+ig/N5qrYyEU9Scw
         39+rBQMtlhTRe9yFVSYkpyb9j1LqRmsbvxCQHDm8CKeV758E4cZKRORPtvCMIf/AOp4R
         jAbth0OkGU4kzpZ1NU2Fqts3eriLFCSgnziXnd7/iqSfIbihdcIfgR+3coummO/9KVNi
         20YA==
X-Gm-Message-State: AOAM5330TmI2I/mSrGR4JF8ueLXA+b/pQoKenVOGtLg0mKaN5mo2J9XW
        sIDwaFuRwYsE3pneN/CmGvMa2Q==
X-Google-Smtp-Source: ABdhPJyZwzYc8iEvhjhcYe9XSf/hc3p3lgjmIh4hvWoOn/1fBt1JX1mueOh8rrQ5ElDNmmOw58LVAw==
X-Received: by 2002:a63:4c4e:: with SMTP id m14mr202944pgl.199.1601058831197;
        Fri, 25 Sep 2020 11:33:51 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id r16sm2554546pjo.19.2020.09.25.11.33.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2020 11:33:50 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     gregkh@linuxfoundation.org, mchehab@kernel.org, hverkuil@xs4all.nl,
        laurent.pinchart@ideasonboard.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH RFT/RFC v2 26/47] staging: media: zoran: convert irq to pci irq
Date:   Fri, 25 Sep 2020 18:30:36 +0000
Message-Id: <1601058657-14042-27-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601058657-14042-1-git-send-email-clabbe@baylibre.com>
References: <1601058657-14042-1-git-send-email-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch convert zoran to pci_irq functions.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/staging/media/zoran/zoran_card.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/zoran/zoran_card.c b/drivers/staging/media/zoran/zoran_card.c
index 8be7f8f0a020..706b040f5baa 100644
--- a/drivers/staging/media/zoran/zoran_card.c
+++ b/drivers/staging/media/zoran/zoran_card.c
@@ -1015,7 +1015,7 @@ static void zoran_remove(struct pci_dev *pdev)
 	zoran_set_pci_master(zr, 0);
 	/* put chip into reset */
 	btwrite(0, ZR36057_SPGPPCR);
-	free_irq(zr->pci_dev->irq, zr);
+	pci_free_irq(zr->pci_dev, 0, zr);
 	/* unmap and free memory */
 	dma_free_coherent(&zr->pci_dev->dev, BUZ_NUM_STAT_COM * sizeof(u32), zr->stat_com, zr->p_sc);
 	iounmap(zr->zr36057_mem);
@@ -1175,8 +1175,7 @@ static int zoran_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto zr_unreg;
 	}
 
-	result = request_irq(zr->pci_dev->irq, zoran_irq,
-			     IRQF_SHARED, ZR_DEVNAME(zr), zr);
+	result = pci_request_irq(pdev, 0, zoran_irq, NULL, zr, ZR_DEVNAME(zr));
 	if (result < 0) {
 		if (result == -EINVAL) {
 			pci_err(pdev, "%s - bad IRQ number or handler\n", __func__);
@@ -1292,7 +1291,7 @@ static int zoran_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	zoran_unregister_i2c(zr);
 zr_free_irq:
 	btwrite(0, ZR36057_SPGPPCR);
-	free_irq(zr->pci_dev->irq, zr);
+	pci_free_irq(zr->pci_dev, 0, zr);
 zr_unmap:
 	iounmap(zr->zr36057_mem);
 zr_unreg:
-- 
2.26.2

