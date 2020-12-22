Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673ED2E0601
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 07:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgLVGSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 01:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgLVGSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 01:18:55 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F8FC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 22:18:15 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id z12so771203pjn.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 22:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kkoDUqKrK9varFFokYUmOlkdQyjUoQaODT52KKjeRGs=;
        b=ZJb4h5oR883OgR0LJbi6evcaBdy413jnvRDXyTTTXe2cMTwgRidwOKw0hRw4BcIeyw
         5kfO5cuRZ/wO/h+Kzt0RgF1EQ2Uy1I2cgNa+ZJr+kfZxX6wCcPApDT2UkCMufR7YCbe3
         H4YSk0kqVo53dQ8UWqpWK5bBQH1t2daSTmSf9F2XrwZDt3m4eG0oOxPJdgnmzfw7TbYm
         rbXnERd2cHEQicpKU2wlHe+t1H19ocZtZZYGTmM3vNqwI696HYXZsD3XV4tiKCCOkiYs
         MxTx07EJInJ1yI88J6IAUD8P+HHZKDxF7cHVXrY5QX/qpTTx6C/wtc9/BYJYkkXmmLu/
         FhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=kkoDUqKrK9varFFokYUmOlkdQyjUoQaODT52KKjeRGs=;
        b=LVsfnfOizrjaKtAAi8j9N+hAZY+Y29mArIBtH7GfGGi47+5Xo32CWjoWoDcX59L0SD
         DOBdbdxDizvHu562KA38eOnz72nRN38Wd/QEGbuHOhpAS3Usw1DuUN4X1e+k/SlDZufQ
         A+brMeVPEAvaOTGOgvqK2KAgKMk7742FYvjVBvYLq8XUbpku+LEigdKldtLOlFWYQVsU
         gKXv+4J6tOnXXD/lB6BK/UAcyGzd0eWqiDSdQqRGmjhvP38Te13PGuRhvCyahYricIgP
         L7QcCS5dAjlsbpEAyAonecSKcEdc599CdaoCCI2rBrz8RVzAmcpUuQPlSbvcKZUJ0W+/
         iR8A==
X-Gm-Message-State: AOAM530RiMkQAC5R+lGrE8Wjucj0bhS8ZxHSrfXj22wXWTiKViytFjMf
        2KSAHQtzDN4VvBftck64nKg=
X-Google-Smtp-Source: ABdhPJwY2UiPFjcTR0XQuvixWysoQI+qVtD6lCIe4Yl1ewkjGsDFcvxsx41CUqgK+GtJmTRXGcCsqg==
X-Received: by 2002:a17:90b:4a50:: with SMTP id lb16mr20184767pjb.25.1608617894686;
        Mon, 21 Dec 2020 22:18:14 -0800 (PST)
Received: from localhost.localdomain ([45.124.203.19])
        by smtp.gmail.com with ESMTPSA id a23sm17769794pjh.19.2020.12.21.22.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 22:18:13 -0800 (PST)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>
Cc:     openrisc@lists.librecores.org, linux-kernel@vger.kernel.org,
        Mateusz Holenko <mholenko@antmicro.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] openrisc: Add vmlinux.bin target
Date:   Tue, 22 Dec 2020 16:48:05 +1030
Message-Id: <20201222061805.462460-1-joel@jms.id.au>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build it by default. This is commonly used by fpga targets.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/openrisc/Makefile      | 7 +++++++
 arch/openrisc/boot/Makefile | 8 ++++++++
 2 files changed, 15 insertions(+)
 create mode 100644 arch/openrisc/boot/Makefile

diff --git a/arch/openrisc/Makefile b/arch/openrisc/Makefile
index bf10141c7426..239bca2d1925 100644
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
@@ -49,3 +53,6 @@ else
 BUILTIN_DTB := n
 endif
 core-$(BUILTIN_DTB) += arch/openrisc/boot/dts/
+
+vmlinux.bin: vmlinux
+	$(Q)$(MAKE) $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
diff --git a/arch/openrisc/boot/Makefile b/arch/openrisc/boot/Makefile
new file mode 100644
index 000000000000..0e71e8f78bb2
--- /dev/null
+++ b/arch/openrisc/boot/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for bootable kernel images
+#
+
+OBJCOPYFLAGS_vmlinux.bin := -O binary
+$(obj)/vmlinux.bin: vmlinux FORCE
+	$(call if_changed,objcopy)
-- 
2.29.2

