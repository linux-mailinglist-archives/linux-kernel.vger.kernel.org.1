Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1ED2AFAA0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 22:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgKKVkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 16:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgKKVkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 16:40:22 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEA5C0613D1;
        Wed, 11 Nov 2020 13:40:22 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id q5so2512893pfk.6;
        Wed, 11 Nov 2020 13:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+fzlfnA2TEDDFFxjWmlVuY8W0FfkEiYNB2C9rSQv2Nw=;
        b=tGbRKnfEbiFdiYH22xCoHpmARpVopCQnFSWi+fbgjBIRTEZqkv26kgFRi+e+NEYG45
         x5jKQvvsKn7rvdRUSGKR2UkF57rw7akl7AZTiO79wtdtN4Y1yQkN8DIiK7evq8wR1k5H
         KvvyIaPcELxpO7Kv6t3OMKZ0vsuVNs++eO2lZ6O9wCbzqKQImq81kkZn4ht82+w8P0mx
         T0RTRqep7HTrig/hfSXmqlEkNW7oA8vDpPGtE2nz0fWPnuhsI2RIhqKGJb0TytXF8nVX
         GEyKZI+5ThdqLnNr7p6ObxR0UIlh75bnnx5UJwATfw7lHmSpTcQzyQHDSAZ4hzAU79L/
         gkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+fzlfnA2TEDDFFxjWmlVuY8W0FfkEiYNB2C9rSQv2Nw=;
        b=nWvYnfIrTVFxIsV4vEt3YxsiPUxYekQMwmDV7U8/XudQlrarX7X55ZZUWOwlMszbep
         9L8O5F74mi8ETQpYhfKdUJJBiKkjD/nFVsgrCBUU/c2ervIUbZ06TADqOqZBQcnITvvs
         Osco8rBESoWb8hPCAi206XbNWqeG1Pms8BaBiC3PV4oolLOUJtydVGlAGv3dE7IRgE3I
         R60eFBsjYYNDhdk4rkTGpjmpJdvbsG8D14KSMMQiZRGdbXpOLwnvePDjkQiB/49jUfZP
         jXIp4h68cyWuc0Jv5Uu5MW/vDN2zEfeJXbXQ2W4zlWQ/rC9tsu2mb9GntkbFw9IZFt6l
         Ed5g==
X-Gm-Message-State: AOAM530YAzjHgn/Rbtr8maWW14O3dyh3bw9UXAp334WDTCsHpgF6MohB
        64rsqbi7HXqLxJbBrEBfVYcuWI7JGBtsDQ==
X-Google-Smtp-Source: ABdhPJzcXpb4uTDj7Ogjg2XMxp+t0CrGGeSWWaRMxQObt1T6Y9+Ez39YZ+6uFOCTJKt/X6F6iszSbA==
X-Received: by 2002:a63:fb50:: with SMTP id w16mr22695107pgj.202.1605130821725;
        Wed, 11 Nov 2020 13:40:21 -0800 (PST)
Received: from localhost (g133.220-213-56.ppp.wakwak.ne.jp. [220.213.56.133])
        by smtp.gmail.com with ESMTPSA id a11sm3683616pfn.125.2020.11.11.13.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 13:40:20 -0800 (PST)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Filip Kokosinski <fkokosinski@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        devicetree@vger.kernel.org, openrisc@lists.librecores.org
Subject: [PATCH] openrisc: add support for LiteX
Date:   Thu, 12 Nov 2020 06:39:59 +0900
Message-Id: <20201111214003.1506246-1-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Filip Kokosinski <fkokosinski@antmicro.com>

This adds support for a basic LiteX-based SoC with a mor1kx soft CPU.

Signed-off-by: Filip Kokosinski <fkokosinski@antmicro.com>
Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
[shorne: Merged in soc-cntl patch, removed CROSS_COMPILE, sort MAINT.]
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 MAINTAINERS                               |  1 +
 arch/openrisc/boot/dts/or1klitex.dts      | 55 +++++++++++++++++++++++
 arch/openrisc/configs/or1klitex_defconfig | 18 ++++++++
 3 files changed, 74 insertions(+)
 create mode 100644 arch/openrisc/boot/dts/or1klitex.dts
 create mode 100644 arch/openrisc/configs/or1klitex_defconfig

diff --git a/MAINTAINERS b/MAINTAINERS
index 0b1f39b3938d..9c55a54c9673 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10177,6 +10177,7 @@ M:	Karol Gugala <kgugala@antmicro.com>
 M:	Mateusz Holenko <mholenko@antmicro.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/*/litex,*.yaml
+F:	arch/openrisc/boot/dts/or1klitex.dts
 F:	drivers/soc/litex/litex_soc_ctrl.c
 F:	drivers/tty/serial/liteuart.c
 F:	include/linux/litex.h
diff --git a/arch/openrisc/boot/dts/or1klitex.dts b/arch/openrisc/boot/dts/or1klitex.dts
new file mode 100644
index 000000000000..3f9867aa3844
--- /dev/null
+++ b/arch/openrisc/boot/dts/or1klitex.dts
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * LiteX-based System on Chip
+ *
+ * Copyright (C) 2019 Antmicro <www.antmicro.com>
+ */
+
+/dts-v1/;
+/ {
+	compatible = "opencores,or1ksim";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&pic>;
+
+	aliases {
+		serial0 = &serial0;
+	};
+
+	chosen {
+		bootargs = "console=liteuart";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu@0 {
+			compatible = "opencores,or1200-rtlsvn481";
+			reg = <0>;
+			clock-frequency = <100000000>;
+		};
+	};
+
+	pic: pic {
+		compatible = "opencores,or1k-pic";
+		#interrupt-cells = <1>;
+		interrupt-controller;
+	};
+
+	serial0: serial@e0002000 {
+		device_type = "serial";
+		compatible = "litex,liteuart";
+		reg = <0xe0002000 0x100>;
+	};
+
+	soc_ctrl0: soc_controller@e0000000 {
+			compatible = "litex,soc-controller";
+			reg = <0xe0000000 0xc>;
+			status = "okay";
+	};
+};
diff --git a/arch/openrisc/configs/or1klitex_defconfig b/arch/openrisc/configs/or1klitex_defconfig
new file mode 100644
index 000000000000..3c2c70d3d740
--- /dev/null
+++ b/arch/openrisc/configs/or1klitex_defconfig
@@ -0,0 +1,18 @@
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
+CONFIG_BUG_ON_DATA_CORRUPTION=y
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_EMBEDDED=y
+CONFIG_HZ_100=y
+CONFIG_INITRAMFS_SOURCE="openrisc-rootfs.cpio.gz"
+CONFIG_OF_OVERLAY=y
+CONFIG_OPENRISC_BUILTIN_DTB="or1klitex"
+CONFIG_PANIC_ON_OOPS=y
+CONFIG_PRINTK_TIME=y
+CONFIG_LITEX_SOC_CONTROLLER=y
+CONFIG_SERIAL_LITEUART=y
+CONFIG_SERIAL_LITEUART_CONSOLE=y
+CONFIG_SOFTLOCKUP_DETECTOR=y
+CONFIG_TTY_PRINTK=y
-- 
2.26.2

