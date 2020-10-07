Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB702867F8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 21:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgJGTCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 15:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbgJGTCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 15:02:08 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F65C061755;
        Wed,  7 Oct 2020 12:02:07 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c2so4133165qkf.10;
        Wed, 07 Oct 2020 12:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cn3dG5n0vqcoPNTEYGHnnPIs7oCE0YkkaB1qoJ0Mljo=;
        b=tqIldT8RHozyj/3vaZGZ8+d1+EMoZ5vLRTCAxszk5TvN4UqGTdv/vTPAAsvkVluGur
         EG6FGuv5KKLjH3T3BtL5rMQJtynEXGd8MEopTzzz2UHZSLOME45Gjh3pp26KVRityd7s
         siRT70pMrCTq7ArIiBnHccZIbDIYoLth8ADsN0Kn1nwxW+ptAZQl/efK1kJbGdXsxt5P
         Hfs+MgzXHWmAbPMKTCGm13i6HCAoA9+EmFyGqH3ZQZTeqMlMfM6pb4eE0mcgpCf8hES3
         77iNxhTi4RZJJq/2dzNqmX6fMcnE1by6Chs0ZxHCOkKYThQJCjcqLyjUlbZVp12SFlhH
         SGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cn3dG5n0vqcoPNTEYGHnnPIs7oCE0YkkaB1qoJ0Mljo=;
        b=M/BXIdO2et1A7fz5OtUH/oQsrUi+j+PSfd3c99V4ekfacX0T2hOhGoLZE+voNEvYsO
         PJLNI4xFjqe1/4iSh2tG0lRA+3cW7nt5vEz6Smg2OXh0sK96tkVbVgQDbAgB+B6/384o
         6sGuDbXxh6s0jwKEePrQHkzhUBAbJwidA2T0JtvEGuQEJc/bVc/MIwegvpY99g6Kphe6
         T9k6Y9g/A11cX16qKI4GjHQX3oK0LM46rIvlvBBnUSwxiYSUvIO1YoXtM2UO8YflNFf0
         GctfRunbQpF3cfUCzntQuX7DgGd0CtqtLAXqSIIWIjSIV1t+tOIYVUuzY/PvQVfeN9Wp
         f1Mw==
X-Gm-Message-State: AOAM531MSHh4ayknOiwYxWLZWTrKLJLrJfNKtGfOR4iQzHnr07v9/Vvc
        toDWiRXQeK22KCkHsJwMYCTkC66YXqAW9Q==
X-Google-Smtp-Source: ABdhPJwM3NpsNzFNkkIjvGBnVgmByNkpsiEMEm7SUKpoQCCciFzerxExh0Z7HH6draGub+YZ/FDBHw==
X-Received: by 2002:a37:a46:: with SMTP id 67mr4435265qkk.477.1602097327111;
        Wed, 07 Oct 2020 12:02:07 -0700 (PDT)
Received: from ubuntu.localdomain (ool-45785633.dyn.optonline.net. [69.120.86.51])
        by smtp.googlemail.com with ESMTPSA id j16sm2087078qkg.26.2020.10.07.12.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 12:02:06 -0700 (PDT)
From:   Vivek Unune <npcomplete13@gmail.com>
Cc:     Vivek Unune <npcomplete13@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ARM: dts: BCM5301X: Linksys EA9500 add fixed partitions
Date:   Wed,  7 Oct 2020 15:01:52 -0400
Message-Id: <25a5a438aef1d158a57872de963ac870ab13507c.1601655904.git.npcomplete13@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1601655904.git.npcomplete13@gmail.com>
References: <cover.1601655904.git.npcomplete13@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This router has dual paritions to store trx firmware image and
dual partitions for nvram. The second one for acts as a backup store.

When tested with OpenWrt, the default partition parser causes two issues:

1. It labels both nvram partitions as nvram. In factory, second one is
labeled devinfo.
2. It parses second trx image and tries to create second 'linux' partition
and fails with - cannot create another 'linux' partition

The following patch works around both of these issues.

Signed-off-by: Vivek Unune <npcomplete13@gmail.com>
---
 .../boot/dts/bcm47094-linksys-panamera.dts    | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
index b36ed0ead733..488e83c1780d 100644
--- a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
+++ b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
@@ -281,3 +281,44 @@ fixed-link {
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

