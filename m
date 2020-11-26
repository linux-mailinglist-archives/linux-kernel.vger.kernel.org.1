Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4C82C56A7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 15:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390388AbgKZOFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 09:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389970AbgKZOFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 09:05:07 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34154C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 06:05:06 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id f9so907338ejw.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 06:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IR/x5ppg0wZJxqnSWD4QBn+IO7HGLxlSw1Ip7OHvr2U=;
        b=eSQRSkHDHxJpGRZx48zDMHSQApFE6qcCNRpRf0pE7BWtGOQCTmM4C3P0zzIY7oHk7e
         CLmsvn+WzYqU+jCO7fi3ZyDQek3W0BWW5xU7d6WKH+m8VcnFJ4eBDn8r6vPLoOc4pK62
         +TGdfGxT6y8iZ8Yb7Rtf0Sn7UJEdC5WVLezdc4qgL4YDi7Z5dqY5NuhWXYHEGL3QXV8b
         gRYuvwEepC8v3DpgLZNG7XG/FegZMMHBT2bJHoyKD0njG63oRRkax4dCyCd2Z4QNYOYa
         cxNGRycYEXaQVzcEUtf+vYbDHv7mcjvmi3DR5RbeC8WuHqBLxlbTGFdJPd7mL1CKv84n
         H/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=IR/x5ppg0wZJxqnSWD4QBn+IO7HGLxlSw1Ip7OHvr2U=;
        b=CRnVZZsB3XSNUF/TzZeIMwoa3S/Q1UsUnKLaunQW03Iqg9Iqkwmf0n/YRL/bjz0+9C
         Dpf0M5MRGwiJPCxkg39N1BysDNfKrafC5r4IDs2tIdM6pKP9ikUh0cgVs6uaxozqCdQi
         mXD3nFSoFGZa7RQkUt/nhzxjCU/TKVWoDrqOgvsNws6PWy/jeM02yCQe1n0rDQMIPNd6
         5BzjyxWGrhIHUJo0atSjnfZie8A0dvtFn9fMUpHy/uiUl6qPLUjyzxOPouw7wL7FWZXx
         H3bav87x176pnheV68t95gUmwqy8U23xsQliwrS5mzGOpM1if0ZvOwyEbnT81R3/OElm
         mB6g==
X-Gm-Message-State: AOAM531M5iAP06CpTvkvjIDfidEvlZDqNF/aDXAG3TJtS4R/Kf/iuRcs
        GmUnx/QdVkb22dwz1JSrhgJIQBANPQ86XDSe
X-Google-Smtp-Source: ABdhPJzSMYfd2Kmru4HnfgP50Cxw9b3MaPKHFEhAqa44DK5nvRY/yjEIqNjmvpfpr6q9nlo/Bxwb9g==
X-Received: by 2002:a17:906:a183:: with SMTP id s3mr2928234ejy.60.1606399504680;
        Thu, 26 Nov 2020 06:05:04 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id q26sm3127131ejt.73.2020.11.26.06.05.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Nov 2020 06:05:04 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: zynq: Fix incorrect reference to XM013 instead of XM011
Date:   Thu, 26 Nov 2020 15:05:02 +0100
Message-Id: <39e16e667aa8f132496092d4fa554935ddd5a55f.1606399500.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix comment about targeted extension card. It was likely just c&p error.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/boot/dts/zynq-zc770-xm011.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/zynq-zc770-xm011.dts b/arch/arm/boot/dts/zynq-zc770-xm011.dts
index b7f65862c022..56732e8f6ca1 100644
--- a/arch/arm/boot/dts/zynq-zc770-xm011.dts
+++ b/arch/arm/boot/dts/zynq-zc770-xm011.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Xilinx ZC770 XM013 board DTS
+ * Xilinx ZC770 XM011 board DTS
  *
  * Copyright (C) 2013-2018 Xilinx, Inc.
  */
-- 
2.29.2

