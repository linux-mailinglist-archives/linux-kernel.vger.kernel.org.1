Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E782C2E0698
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 08:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgLVHIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 02:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgLVHIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 02:08:21 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186EEC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 23:07:41 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id x1so2221494pgh.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 23:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hk2cDE8u0WfTEuYjrU1tOKMdy/DIwU50dg41KTTX1vY=;
        b=TAX0WHuFrRIwxQK4VQQ7VfGtPivg6Taa0iYXDqthot+WKDJLmzAdowHd6jrSfxjT/P
         +XROVegmFV68XbQauNVV5RChR56iTTU+VIHWw4AWqL/BNIEHw1qEPCjvsL40TXaXOxRR
         rHKObdhOFZCXdL/qz4TtVK7DXGQDPge+FRnf031tOO+HP0WFZ4wNW2UyEftSBkAX9DTe
         R+mWHB7JTL2qLnNGknudhY/FAjBkd0kl8dd9mUnSQs4IpjXKOww07fuuxLPzY8dVOgn8
         Cbz224auC07X6ItxDVJ1pK2w6lhGlSrn2n/qAMdf6dMiAA4WA3ErVuQebfvOjYMe4Bat
         OkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=hk2cDE8u0WfTEuYjrU1tOKMdy/DIwU50dg41KTTX1vY=;
        b=o/w57gzv8Cz6PAs5Wyiui/axcB3/yaJq32M9oyPLEXO4gdk0yYEzYLGHF4suntMhR0
         ZjRwbCnk2P8Sr2QEEzZ+oD1xymT5FjcRv4lka3jmV7fhzK8rkx1K85rJWN7d/ZsRpVBX
         Z/np3PwbfCItVgf6rCUPXE8Ri272pyU5bO+Ub5hKoUyxkzJyqJqsbUvCGBpn/GO4u0Oj
         X6Xl2fDiVuKNGP1hOHMBy36FhMAAWotXl7gHFB3haOk8WqFoLl0cYlLiO4/FcaA0q4MU
         uvOZsCztOu+Qs1sw/zTrI+7PNvmpxtbB7pEMzG8wHEDqQUjWcK5dC9DpvsAef2/jk+3j
         otgA==
X-Gm-Message-State: AOAM532Zyg6EykjSHBJmx4GqLZMGJlyCkJn8g1oPU2upMjx5R4DDwhp/
        eiihzZRx32GNLr/3f/xXNHCx999PN9jLQQ==
X-Google-Smtp-Source: ABdhPJys6mesLl6Q93FSUHN93zC1WPhHApNiN/N1nf5C7DImS5AL0TJ4uHIZFoggPXamHti1LOVE3w==
X-Received: by 2002:a62:1ad0:0:b029:197:e389:fb26 with SMTP id a199-20020a621ad00000b0290197e389fb26mr18703472pfa.20.1608620860445;
        Mon, 21 Dec 2020 23:07:40 -0800 (PST)
Received: from localhost.localdomain ([45.124.203.19])
        by smtp.gmail.com with ESMTPSA id q16sm19232872pfg.139.2020.12.21.23.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 23:07:39 -0800 (PST)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>
Cc:     openrisc@lists.librecores.org, linux-kernel@vger.kernel.org,
        Mateusz Holenko <mholenko@antmicro.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2] openrisc: Add vmlinux.bin target
Date:   Tue, 22 Dec 2020 17:37:31 +1030
Message-Id: <20201222070731.491076-1-joel@jms.id.au>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build it by default. This is commonly used by fpga targets.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v2: Address review from Masahiro

 - Add vmlinux.bin to phony target
 - simplfy vmlinux.bin rule
 - add cleanup rule
 - add vmlinux.bin to targets
 - Add gitignore
---
 arch/openrisc/Makefile        | 12 ++++++++++++
 arch/openrisc/boot/.gitignore |  2 ++
 arch/openrisc/boot/Makefile   | 10 ++++++++++
 3 files changed, 24 insertions(+)
 create mode 100644 arch/openrisc/boot/.gitignore
 create mode 100644 arch/openrisc/boot/Makefile

diff --git a/arch/openrisc/Makefile b/arch/openrisc/Makefile
index bf10141c7426..b13404f1f8bd 100644
--- a/arch/openrisc/Makefile
+++ b/arch/openrisc/Makefile
@@ -24,6 +24,10 @@ LIBGCC 		:= $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
 
 KBUILD_CFLAGS	+= -pipe -ffixed-r10 -D__linux__
 
+all: vmlinux.bin
+
+boot := arch/$(ARCH)/boot
+
 ifeq ($(CONFIG_OPENRISC_HAVE_INST_MUL),y)
 	KBUILD_CFLAGS += $(call cc-option,-mhard-mul)
 else
@@ -49,3 +53,11 @@ else
 BUILTIN_DTB := n
 endif
 core-$(BUILTIN_DTB) += arch/openrisc/boot/dts/
+
+PHONY += vmlinux.bin
+
+vmlinux.bin: vmlinux
+	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
+
+archclean:
+	$(Q)$(MAKE) $(clean)=$(boot)
diff --git a/arch/openrisc/boot/.gitignore b/arch/openrisc/boot/.gitignore
new file mode 100644
index 000000000000..007d6fea3145
--- /dev/null
+++ b/arch/openrisc/boot/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+vmlinux.bin
diff --git a/arch/openrisc/boot/Makefile b/arch/openrisc/boot/Makefile
new file mode 100644
index 000000000000..5b28538f4dd1
--- /dev/null
+++ b/arch/openrisc/boot/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for bootable kernel images
+#
+
+targets += vmlinux.bin
+
+OBJCOPYFLAGS_vmlinux.bin := -O binary
+$(obj)/vmlinux.bin: vmlinux FORCE
+	$(call if_changed,objcopy)
-- 
2.29.2

