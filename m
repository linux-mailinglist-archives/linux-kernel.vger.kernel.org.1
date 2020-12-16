Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A27B2DC0ED
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 14:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgLPNPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 08:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgLPNPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 08:15:50 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF048C0617A6;
        Wed, 16 Dec 2020 05:15:09 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id h205so4694093lfd.5;
        Wed, 16 Dec 2020 05:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M2hDyNKbfINfDFRORNR8XoQ5cqYbb7cXlIAuvUco70E=;
        b=r1M6lNd1dK0MDMzthu2JU42zFfdRbmIN1RJ77QVCrgshlM6fY4gK2LkLmUCVsnFFPH
         B41sKXEpCiTzWKMCUCByEYPil5XYC8LpsLVXecRDUQtjsd5sG1LLfPFI8/mH3haIYGE7
         mFRPI+YVVckUZEExAPpY6WkVKQa7/LbGf7kCzujSEcLsAgCK2ckYiJfKAcT3BG8XZs5m
         pb7ijRc209Zo2xvjrj7YE8w3levq+OSz5sL4d3ZSK0y5HqGkLnHfGfAQRrlu4b5Uyjdu
         9zmO8rtCt38jSbb+eQUf7fh8oFxhfv/g39zxdU0RPor/kKcGtQvK/zXv/AJk0K4/vD6U
         KVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M2hDyNKbfINfDFRORNR8XoQ5cqYbb7cXlIAuvUco70E=;
        b=W80/d05wSXsbz1qPnSOMwqcRAFjsFp1K04mdFCggHprUYNyXphTWgqNyBszlru1+wc
         N3oKUfH6XK8rd5fUegb+yDTtoAvw3nA3q+LNQQZO4hgxcyx8xIXBY7qHAmvmrPBtDdMB
         GKuXZ2LCRN/tfewHVSXD7yV9M/FP9Sv5UmSKFzkBaNwQvmj9U19FFLTUSfYBAq4UmTs9
         exQPfnFWhUNgGupaMrJw9RrUotUANR6tsCibWT9uEBc2KojSU/yIKIm4r8GDUQSYhaXM
         PxaNLWM8JVCPn8UdJH1/Xtl6l5Vj/16rN4nJKzm87qIUfaDumBdYRX7oVbP8mOmv0jkD
         HUPA==
X-Gm-Message-State: AOAM530u1j0Yn7VT2Tl/CZMNe1QDissNkd/ZjGvpnJaUnni2h3YAyiWj
        mU+hiY2+QgZaLNqizmHWclc=
X-Google-Smtp-Source: ABdhPJyXWA0QgL3q7AEk+SqALSfLxFwcsmvaBfVABbY0fFhfid17DwJcUij17H+RJ1GE318GRMK9lQ==
X-Received: by 2002:a19:770c:: with SMTP id s12mr6889155lfc.367.1608124507954;
        Wed, 16 Dec 2020 05:15:07 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id n84sm220899lfd.176.2020.12.16.05.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 05:15:07 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 3/3] phy: phy-brcm-usb: support BCM4908 binding
Date:   Wed, 16 Dec 2020 14:14:51 +0100
Message-Id: <20201216131451.16900-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201216131451.16900-1-zajec5@gmail.com>
References: <20201216131451.16900-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

BCM4908 seems to have slightly different registers but work when
programmed just like the STB one.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/phy/broadcom/phy-brcm-usb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/phy-brcm-usb.c
index 99fbc7e4138b..63f922a5f29b 100644
--- a/drivers/phy/broadcom/phy-brcm-usb.c
+++ b/drivers/phy/broadcom/phy-brcm-usb.c
@@ -285,6 +285,10 @@ static const struct match_chip_info chip_info_7445 = {
 };
 
 static const struct of_device_id brcm_usb_dt_ids[] = {
+	{
+		.compatible = "brcm,bcm4908-usb-phy",
+		.data = &chip_info_7445,
+	},
 	{
 		.compatible = "brcm,bcm7216-usb-phy",
 		.data = &chip_info_7216,
-- 
2.26.2

