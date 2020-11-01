Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583F82A213A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 21:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgKAUIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 15:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbgKAUIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 15:08:20 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62993C0617A6;
        Sun,  1 Nov 2020 12:08:20 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id h12so7960777qtu.1;
        Sun, 01 Nov 2020 12:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dvVA6gJ7KOUrL6fUd23pqvXnztHm0oyioDDQWl4BAQQ=;
        b=gTwXMlWrggROudSV3s7R/3ux9AxsT2XgsNLRPfGJ5eEkv3uWqALu2Dl3r4fhN5BSlu
         iGAFnVQPOHHyL9MOh3U1TFQrDXDiWsBgapw62NJlJOHH5hLCR0Z0KuaRxioLvVj2Q0KR
         kiLZkqS0OyMhmQhBmUF8rxFOh5As/0HLSklXPCNniOHUr0Cyf9zhYaHdecKSe5q8rU/u
         rqHmqffa1t2JrUTk1L881tk+iP+chb/lT3Seu7jUAHlLHyev9fe5VOg/Ek6hyiIlaovR
         5rXtbTwOXF/l9u2mQdC/606Pw2imsW/GtqO5iRPrkPhbhaYDFkrm4vrgaofLR0dxq8KL
         8k7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dvVA6gJ7KOUrL6fUd23pqvXnztHm0oyioDDQWl4BAQQ=;
        b=jsVIRjpu7f1gAY8imVuLMoHUr1BKG6fNoyycqK54nfnLQ7IdUUjEo50Km+allCTYo+
         rgNBNtSI8hLfzLcKzIl1w4YSli7ZxhCv/pbNhb9pkStDijQYaDCnEfwtwpP0kix2MTqm
         ZITPJT1rck7TAjVPfGX2RWjLksZl2rJE8fu8N5ozS+v2XOQxlucnBi9szacKQufjxniC
         cAfY0PebLW5lGhxTjyFS9CukALnLtLkhGcjQ3l6Hw33UK4FA08Ze+8ZdCoyPKIPyi0Ik
         n6KDKa0I6INOLBU6+ubomiNr/pHVFnCpUiLrysSPeSuePvilfjGY/+4MtKtLJpz1rz6d
         yWiA==
X-Gm-Message-State: AOAM532W0PfYI9THVZy0/+28Vpl/fJcxnoLMHlJPHmz+xcJbR0+P528C
        44HbVMoefPXcgA/72uHD5+M=
X-Google-Smtp-Source: ABdhPJyGVh1O8s4DBhP7k6UVZLQ0DgS3fzpHcID2c71ukOTmFzz5xq7CF2qH0W3KLIZioeJ5DrIfrA==
X-Received: by 2002:aed:2ba6:: with SMTP id e35mr11806520qtd.251.1604261299551;
        Sun, 01 Nov 2020 12:08:19 -0800 (PST)
Received: from ubuntu.localdomain (ool-45785633.dyn.optonline.net. [69.120.86.51])
        by smtp.googlemail.com with ESMTPSA id z134sm6607386qka.21.2020.11.01.12.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 12:08:19 -0800 (PST)
From:   Vivek Unune <npcomplete13@gmail.com>
Cc:     florian.fainelli@broadcom.com,
        Vivek Unune <npcomplete13@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: dts: BCM5301X: Linksys EA9500 add fixed partitions
Date:   Sun,  1 Nov 2020 15:08:03 -0500
Message-Id: <20201101200804.2460-1-npcomplete13@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <e64d76cc-90bb-5b54-04de-fde21542e4fe@gmail.com>
References: <e64d76cc-90bb-5b54-04de-fde21542e4fe@gmail.com>
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
and fails with - cannot create duplicate 'linux' partition

The following patch works around both of these issues.

Signed-off-by: Vivek Unune <npcomplete13@gmail.com>
---
V2:
	- Removed 0x before partition offset
	- Renamed brcmnand to system 
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
+		partition@5200000 {
+			label = "system";
+			reg = <0x05200000 0x02E00000>;
+		};
+	};
+};
-- 
2.25.1

