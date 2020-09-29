Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3572227C7E0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 13:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731522AbgI2L5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 07:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730540AbgI2Ln0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 07:43:26 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C986C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 04:43:26 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id k14so6003523edo.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 04:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+dyqjEM4Nfg9QjzaQRM4PsDpBxhgsJm9EEpCrS6WSrk=;
        b=O0++lOrlF2XUoAEtNzozVCcPXrdX7huM9vUeXKDytO2VKXxu0ZRnc0EpFX9PZxlNon
         73iM1/M6/V7EO/ghCCnZUXpzvveURB9toTusdPOtKR2Eb9j8HH86IjGpK0ailyx/7glw
         sXi+37IDeJVNn5EFAMVzb8P3AOFo+sFtKJgv4QutZ6WIHevlqEbNfI38T8LHa5hYJvkf
         scNKi99pTqfzwaDwypeqtPpH7VurjDzn1VpCU/7YZbs+N5Bt03NBydp32SX8Y+BqK42G
         HiF+zVFa7xVmOO5cgNo+ie30kvsz8/xinJ1pw7QC1NLzlMHAocQ3NO0eTzpyvSVeSo8o
         Vspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=+dyqjEM4Nfg9QjzaQRM4PsDpBxhgsJm9EEpCrS6WSrk=;
        b=sqqnioS1y63oT26w2K5sYMi3gmGbppicoap16ZjuA+Q2Z4CLjq7fVsMdz8E/UAkm2O
         mf3M6KptcegPMlHJc/6/TZ4fhCIlHiTlE5q/vv0JxFa7zknYQRT92h6ZSejGZAMAo5z4
         r5hUH3QXJFC9XKWMTgXyALWAhjvKTDk0q3SN9iP2r/TzEjBx3lfo2XMWVDTtJX3AVcJ3
         lGIPlngkdMh7WnXRo0f3cjdtQ9mh86OE1bS1bycHjZCoZRbdMOeL2oM2q7JXl3mDokzk
         0O3NutGf4SyUl4l8gx2kNpbP7NYcgs9D3Z+7Kr9yr4/skgUy9hBmHzzxqzUzQphp+MTc
         G+dA==
X-Gm-Message-State: AOAM533uGhgjw3X3jQ64mmBdDyOdZhAtDfK0lR/AfvPIJXRXAa/yFgnN
        LKcw4dt5DfvwGmHNM0NwK4lkoHOdkc678Q==
X-Google-Smtp-Source: ABdhPJwCkbYQryEp9zC575hahXkX43eYlCJKVmEK97uBI5MCJC/chZJXCBIYjPjwdb0tqSv08gc57A==
X-Received: by 2002:a50:84e8:: with SMTP id 95mr2662684edq.99.1601379804636;
        Tue, 29 Sep 2020 04:43:24 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id lc2sm1777629ejb.86.2020.09.29.04.43.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Sep 2020 04:43:24 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Kalyani Akula <kalyani.akula@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Nava kishore Manne <nava.manne@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: dts: zynqmp: Fix pcie ranges description
Date:   Tue, 29 Sep 2020 13:43:22 +0200
Message-Id: <f59a63d8cb941592de6d2dee8afa6f120b2e40c8.1601379794.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT schema is checking tuples which should be properly separated. The patch
is doing this separation to avoid the following warning:
..yaml: axi: pcie@fd0e0000:ranges: [[33554432, 0, 3758096384, 0,
3758096384, 0, 268435456, 1124073472, 6, 0, 6, 0, 2, 0]] is not valid under
any of the given schemas (Possible causes of the failure):
...dt.yaml: axi: pcie@fd0e0000:ranges: True was expected
...dt.yaml: axi: pcie@fd0e0000:ranges:0: [33554432, 0, 3758096384, 0,
3758096384, 0, 268435456, 1124073472, 6, 0, 6, 0, 2, 0] is too long

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

I have seen one conversation about it but don't have link which I can point
to.
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 771f60e0346d..98073f3223e5 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -542,8 +542,8 @@ pcie: pcie@fd0e0000 {
 			      <0x0 0xfd480000 0x0 0x1000>,
 			      <0x80 0x00000000 0x0 0x1000000>;
 			reg-names = "breg", "pcireg", "cfg";
-			ranges = <0x02000000 0x00000000 0xe0000000 0x00000000 0xe0000000 0x00000000 0x10000000	/* non-prefetchable memory */
-				  0x43000000 0x00000006 0x00000000 0x00000006 0x00000000 0x00000002 0x00000000>;/* prefetchable memory */
+			ranges = <0x02000000 0x00000000 0xe0000000 0x00000000 0xe0000000 0x00000000 0x10000000>,/* non-prefetchable memory */
+				 <0x43000000 0x00000006 0x00000000 0x00000006 0x00000000 0x00000002 0x00000000>;/* prefetchable memory */
 			bus-range = <0x00 0xff>;
 			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
 			interrupt-map = <0x0 0x0 0x0 0x1 &pcie_intc 0x1>,
-- 
2.28.0

