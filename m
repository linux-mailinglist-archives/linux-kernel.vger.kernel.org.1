Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3251B2E2142
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 21:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbgLWUYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 15:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728942AbgLWUYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 15:24:22 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156FEC061794
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 12:23:42 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id t30so391959wrb.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 12:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZXRFrrDcrww8M8vgWXxY6IWFUaHEFqtQgKS5bQBGth8=;
        b=QU8lfLzf4X8n0hsshRASMf0d1ZrTY42pNDYqPstCmueqUnzcJUdxY5Hcp//Yg97XaD
         cyl1lbTuHcKGHrmoVOWRf18ARq9jzDDydPOPNM4j1xbUEoenmlwrl/MqzQR5xf8Dc9ab
         SnG4O/tw6zdLRP8nHlBrLWknHYPFCkE0Pd1w5xkMruwfRxpgyYNuT00OagRWymcFoKXE
         ZkqsWgjB/uB/88BgXYATrQuzngqjCXYPfQdKtSKt1xBrsd8uPpxsGpr64EOe0yrroB/h
         ySSj4bAv14MMGeyRDlaZ+iU0G0bGzfHD7Bsr9jMmIxlLdwItdlVXh4AFtzd70xWP6k95
         g78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZXRFrrDcrww8M8vgWXxY6IWFUaHEFqtQgKS5bQBGth8=;
        b=ZXWlBZHBuZ5yZMztRQX+7ykSuPrGaHFkRXZOs0DoyU6q7fRS5LmGOBFQYo7BfUeq8H
         hR+QIcHjhFXzxjOIB4xHMC8VFadguN32ocOC1BFf6whXMNGBImETi1laax/D6w+i6s3s
         Wpajv4j1QDLAkggX0RY+8SJE0zNeD1uSK/YofZNI/wddsiAsNlaiTnPFD70aHR9NpDzb
         3amwGewR8iEReCSqORBKJAcGBB0fEupDc9NC8iG7OAIzhMxSxnbDRjHIHmv/PvcDhWTa
         l1grogGKvnnJnNbcL3wJ2odpYwli9A1H8Cid/GclzTyGD/z8uYrV4LZn0pO4AOsTqg/a
         12kA==
X-Gm-Message-State: AOAM5301T+4taIlmDGiSELsVDClkqdS0GvBRS0U6g3zadRa7fcvSBKh3
        VHyn9hkq75m3i6ZFyzsHbCs=
X-Google-Smtp-Source: ABdhPJzgMmrmGKfnLCEtJGssuAwfvqcUohyxIw40FBih0zYT+eZzNBcVdDXG3P3p1KZx1oMd6/37jg==
X-Received: by 2002:adf:b1ca:: with SMTP id r10mr31166674wra.252.1608755020829;
        Wed, 23 Dec 2020 12:23:40 -0800 (PST)
Received: from localhost.localdomain (eth-east-parth2-46-193-67-123.wb.wifirst.net. [46.193.67.123])
        by smtp.gmail.com with ESMTPSA id r16sm38371141wrx.36.2020.12.23.12.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 12:23:40 -0800 (PST)
From:   Ayoub Soussi <ayoubfme@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ayoub Soussi <ayoubfme@gmail.com>
Subject: [PATCH] staging: ralink-gdma: Fixed blank line coding style issue
Date:   Wed, 23 Dec 2020 21:22:30 +0100
Message-Id: <20201223202230.31325-1-ayoubfme@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed coding style issue.

Signed-off-by: Ayoub Soussi <ayoubfme@gmail.com>
---
 drivers/staging/ralink-gdma/ralink-gdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/ralink-gdma/ralink-gdma.c b/drivers/staging/ralink-gdma/ralink-gdma.c
index 655df317d0ee..a6181a167814 100644
--- a/drivers/staging/ralink-gdma/ralink-gdma.c
+++ b/drivers/staging/ralink-gdma/ralink-gdma.c
@@ -122,6 +122,7 @@ struct gdma_dma_dev {
 	struct gdma_data *data;
 	void __iomem *base;
 	struct tasklet_struct task;
+
 	volatile unsigned long chan_issued;
 	atomic_t cnt;
 
-- 
2.17.1

