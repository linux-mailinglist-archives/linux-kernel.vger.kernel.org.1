Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE522AC7D5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 22:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbgKIV6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 16:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgKIV6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 16:58:51 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2796C0613CF;
        Mon,  9 Nov 2020 13:58:50 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id w142so7654718lff.8;
        Mon, 09 Nov 2020 13:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TL7a4MNPE4WuOkoIqj/tHlQbdnLK+YvkRnIoJ+IccQA=;
        b=L6IRQqb2bMDZ7GWkj2nXB2EsOhZYUpVzUlDPmeS7ErwX31j3vhlgooushPwg7Ph148
         9tZQBhJYu+jYlYQh/LeqV6xKSy6DlsXZM2gM29XGT58c379QPsf5Mj6RHe0qTtN1uAVA
         mqzMAWABgHvrLZVYf7Ctl1QFraYhlsOEkmwgkRvft/zgyBFvLetu6nvqq2T7J2EdNGWO
         +FtRrESeFzYQEF4hE2guY9MWm9SsW5GleklegZ7yjUYC+fNgPwXoUPq61iJvfACCcQcR
         YMSWIYXpeZZZahHuqB3xMt/PnuyA58wxPYnFrrXodXQBu96b+9+bXBME/e/7XfR7X4Ru
         bSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TL7a4MNPE4WuOkoIqj/tHlQbdnLK+YvkRnIoJ+IccQA=;
        b=WggHRKXZ6l0Ab2z1I3laRJewM41IDt2nWNKXG2GpxmVzR7WosUKO4ANu6trT5qUzCq
         GgwRLuH3j7TfwL1tT3byWQSrZ/lYUsyHA/vcLoRCtv2BvB/X6SwlfU3eDC7pauOGIUK8
         Vxx8gau1cHO5sbJB9OihM5JSerpPmtSHxU/yMLFrQu7Kx64V5j6/1kSnDpKwCkuG9cGl
         UV9cu0n/OBRAiYkZa811V+fKVkejuoHtASUolfjIIHKKVfpvLNpQzgj1FlBozF/WQd2y
         u19fqlgnzxj/u0aNgXXWFLfLNwoV53o+lKl2CJeGv71lx7vBeKUkocxvxHscfvpw6RJB
         H5nA==
X-Gm-Message-State: AOAM530i2GyVT4COj66wX2cT1xgxm5bFXOw6F1HJI48RFPISBDiNW80i
        1+sFQ6pDwvMeJoTNc6UvJzmyn3RXi77xfw==
X-Google-Smtp-Source: ABdhPJzKIT18ca+jPIcYV3XXRV9f0o4FGHoswN6vE05uYnGEHQnk33qfVZuEsZ2NbO6W38/hZHRJxA==
X-Received: by 2002:ac2:47eb:: with SMTP id b11mr4326485lfp.512.1604959129295;
        Mon, 09 Nov 2020 13:58:49 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-112.NA.cust.bahnhof.se. [155.4.221.112])
        by smtp.gmail.com with ESMTPSA id r19sm447777lfm.231.2020.11.09.13.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 13:58:48 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     JC Kuo <jckuo@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] phy: tegra: Constify static device_type structs
Date:   Mon,  9 Nov 2020 22:58:44 +0100
Message-Id: <20201109215844.167954-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of tegra_xusb_pad_type and tegra_xusb_port_type is to
assign their address to the type field in the device struct, which is a
const pointer. Make them const to allow the compiler to put them in
read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/phy/tegra/xusb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index ad88d74c1884..70d95519d281 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -146,7 +146,7 @@ static void tegra_xusb_pad_release(struct device *dev)
 	pad->soc->ops->remove(pad);
 }
 
-static struct device_type tegra_xusb_pad_type = {
+static const struct device_type tegra_xusb_pad_type = {
 	.release = tegra_xusb_pad_release,
 };
 
@@ -513,7 +513,7 @@ static void tegra_xusb_port_release(struct device *dev)
 		port->ops->release(port);
 }
 
-static struct device_type tegra_xusb_port_type = {
+static const struct device_type tegra_xusb_port_type = {
 	.release = tegra_xusb_port_release,
 };
 
-- 
2.29.2

