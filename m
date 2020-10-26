Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA660298D9D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 14:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1776621AbgJZNO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 09:14:56 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37070 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407341AbgJZNOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 09:14:17 -0400
Received: by mail-qt1-f193.google.com with SMTP id h19so6597242qtq.4;
        Mon, 26 Oct 2020 06:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ArQe57gzFPxxZh8Z/D5KuSTLp6YyDg0xaQwMBg7tO24=;
        b=SMnxD2B1iAKOIt7VRf0VogijjHB3So1ZOaAIt8Q2b0Jqf+9bbrqc2CjG6hkqaHlX8l
         unP0y4vDjAazyP5ufrrRbmZUQPIpbzltcFXpSQzvQ0GWKEC8SH5cEBBlIT1a6qjqhsGl
         HMTI0l/0yw0Ah8MPmfekwILnv/2uRTeCOhZWs8/Mp5ioYrDDMiPN66HCN1h8KxAVyKn/
         /AvIFd9rSVs/yRKoqXCP0B36SOScqre6UHLJ4rD3fURAKVXxvfJh/1K76mCZKbuvMf+v
         LEg2z6XbNFCOV4rPbXzgHyTrPwPs70SXSzzqyxPIgQTzDqf0h9WdcUCNmUPrTCdjqXdR
         3VVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ArQe57gzFPxxZh8Z/D5KuSTLp6YyDg0xaQwMBg7tO24=;
        b=AcO/gqa7JPHI/aaXIWY/FgPh/B3Ol8Yi/7oToRKiTVkdJkLRWZ0/K2mosEQq98U3do
         FIiI0SV0IwlIWmbt5euVcMtTAU1ESsdOs0qyAJuuW83c0D451dZxbu3kqMhwt2e5sVFx
         5yjOfuwt/eD7oZsqXLygFiEojLULyGMHnb8khRFZ6HOvBoKXSAsxD0rST30ph4Si34S/
         ZcQu63U9FOF3s+GRLlZA91RZymzuF7UHcAp8NbmTz7FW0CmoPz9CEjjHuADTiTanMBIH
         5lu4YmbURLJPwUtoAOr1sfMydrY0kiNsGJPafH6E2aCASTzwJL+s3slBYkx3NJgR0qpa
         FXzA==
X-Gm-Message-State: AOAM533kMSP3OrBDKMyCXkY8ltb0WQ7LydCNQyFxB0oml/9LbgYdoPZn
        MwovHN0C/YhVGqdWUMfqhCI=
X-Google-Smtp-Source: ABdhPJwtj3nMNwHnoXTaw2Z8Wc4jWNqOGAI23KTp4ou5n8tA+t1AyeXS/WyPKgLG54dj8J2gE4Dfmw==
X-Received: by 2002:ac8:1095:: with SMTP id a21mr16664144qtj.260.1603718054715;
        Mon, 26 Oct 2020 06:14:14 -0700 (PDT)
Received: from ubuntu.localdomain (ool-45785633.dyn.optonline.net. [69.120.86.51])
        by smtp.googlemail.com with ESMTPSA id 61sm6598605qta.19.2020.10.26.06.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 06:14:13 -0700 (PDT)
From:   Vivek Unune <npcomplete13@gmail.com>
Cc:     Vivek Unune <npcomplete13@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: BCM5301X: Linksys EA9500 add fixed partitions
Date:   Mon, 26 Oct 2020 09:13:51 -0400
Message-Id: <20201026131351.258296-1-npcomplete13@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This router has dual paritions to store trx firmware image and
dual partitions for nvram. The second one in each of these cases acts
as a backup store.

When tested with OpenWrt, the default partition parser causes two issues:

1. It labels both nvram partitions as nvram. In factory, second one is
labeled devinfo.
2. It parses second trx image and tries to create second 'linux' partition
and fails with - cannot create duplicate 'linux' partition. I've set this
partition to read-only for now

The following patch works around both of these issues.

Signed-off-by: Vivek Unune <npcomplete13@gmail.com>
---
 .../boot/dts/bcm47094-linksys-panamera.dts    | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
index 5d5930edfb9d..13da16c5de68 100644
--- a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
+++ b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
@@ -292,3 +292,44 @@ fixed-link {
 &usb3_phy {
 	status = "okay";
 };
+
+&nandcs {
+	partitions {
+		compatible = "fixed-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition@0 {
+			label = "boot";
+			reg = <0x0000000 0x0080000>;
+			read-only;
+		};
+
+		partition@80000 {
+			label = "nvram";
+			reg = <0x080000 0x0100000>;
+		};
+
+		partition@180000{
+			label = "devinfo";
+			reg = <0x0180000 0x080000>;
+		};
+
+		partition@200000 {
+			label = "firmware";
+			reg = <0x0200000 0x01D00000>;
+			compatible = "brcm,trx";
+		};
+
+		partition@1F00000 {
+			label = "failsafe";
+			reg = <0x01F00000 0x01D00000>;
+			read-only;
+		};
+
+		partition@0x5200000 {
+			label = "brcmnand";
+			reg = <0x05200000 0x02E00000>;
+		};
+	};
+};
-- 
2.25.1

