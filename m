Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D976828E5C0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 19:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgJNRx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 13:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbgJNRx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 13:53:57 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE55DC061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 10:53:57 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id p9so267156ilr.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 10:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kNA7XdpIZYXKzRQjpHvs7EGpy//348CMdfmkrip0gJQ=;
        b=nKZUjGXMEvm82reNTDrwwnVGhfvkR8nBHBIkIGWc/7najPmnztimJ2Y2MPbe1HVnEZ
         PE4xmTrONc8ehF8itOwCT9lxIwpW7MfMK9kAtK4odWRlyCtm4y/TJzaSFx7ptXtz+jT+
         mnXIHov8FSkxTJh4b/zJvUAZ40Hb/bqcIl8CYPAxQlRrvNVSkaH+JzjQ455IxqxYa+ug
         9SOKt27fCZruecRT05ajlf4UytbgJw0kAalMZManyBLVyKhBgrewbeKHFpsZFsb0cNP7
         2hjUlQAxt79uBrN/WLGHxDnO48hXuKaJFkd1J+peAdp5qzztUtBP5+ybmwKMKdLhHZF0
         pN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kNA7XdpIZYXKzRQjpHvs7EGpy//348CMdfmkrip0gJQ=;
        b=hXj/mHSmGIYSaUvKzGol/f43g8JDcFdA7uan13DgZRK4os8VsyqaX97f6MWqI11M6z
         eEIYLxl3z3LTYpMrszWquAFM6q79M5kIA90n5mJklt4irOV4Tslni24LfsZ8ADBWOIAJ
         pataQZssAcitTdhstvBmdhoVIVPVf5fzlnmYlsYiJPItH3yHVPHO6k80ivxY/xldDo+H
         Fa6pNzGCCCEzcKU+lR8EuV4msv13iyb0Ka2bDqi9mGmRDwYNK7USjv2xnfajsCj0lFGP
         PFen4qUg3xC1Hgi3Zyofnuz0ZYYgWwotasqNQ0neXzJerJ1GcXoQ2gVAVs25DDBWJByg
         1UfA==
X-Gm-Message-State: AOAM531GNOao/QbRm8MG6HfY5M9h2WJvhUHLJjuupBghL6cxg+D0NPvj
        B69BzV49kfBopAbE6M7XXa4=
X-Google-Smtp-Source: ABdhPJwK36uGgi3FZj3ET63aoMSgUwsTywlp/l6U8zvhBjSeEYqB2o8vtAMqwJulJ8pMwnCSxMQw/g==
X-Received: by 2002:a92:d5c1:: with SMTP id d1mr269086ilq.212.1602698036971;
        Wed, 14 Oct 2020 10:53:56 -0700 (PDT)
Received: from pm2-ws13.praxislan02.com ([2001:470:8:67e:ba27:ebff:fee8:ce27])
        by smtp.gmail.com with ESMTPSA id v15sm67765ile.37.2020.10.14.10.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 10:53:56 -0700 (PDT)
From:   Jason Andryuk <jandryuk@gmail.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     Jason Andryuk <jandryuk@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] xen: Remove Xen PVH/PVHVM dependency on PCI
Date:   Wed, 14 Oct 2020 13:53:40 -0400
Message-Id: <20201014175342.152712-2-jandryuk@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201014175342.152712-1-jandryuk@gmail.com>
References: <20201014175342.152712-1-jandryuk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A Xen PVH domain doesn't have a PCI bus or devices, so it doesn't need
PCI support built in.  Currently, XEN_PVH depends on XEN_PVHVM which
depends on PCI.

Introduce XEN_PVHVM_GUEST as a toplevel item and change XEN_PVHVM to a
hidden variable.  This allows XEN_PVH to depend on XEN_PVHVM without PCI
while XEN_PVHVM_GUEST depends on PCI.

In drivers/xen, compile platform-pci depending on XEN_PVHVM_GUEST since
that pulls in the PCI dependency for linking.

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
---
---
 arch/x86/xen/Kconfig | 18 ++++++++++++------
 drivers/xen/Makefile |  2 +-
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
index 218acbd5c7a0..b75007eb4ec4 100644
--- a/arch/x86/xen/Kconfig
+++ b/arch/x86/xen/Kconfig
@@ -39,16 +39,20 @@ config XEN_DOM0
 	  Support running as a Xen PV Dom0 guest.
 
 config XEN_PVHVM
-	bool "Xen PVHVM guest support"
-	default y
-	depends on XEN && PCI && X86_LOCAL_APIC
-	help
-	  Support running as a Xen PVHVM guest.
+	def_bool y
+	depends on XEN && X86_LOCAL_APIC
 
 config XEN_PVHVM_SMP
 	def_bool y
 	depends on XEN_PVHVM && SMP
 
+config XEN_PVHVM_GUEST
+	bool "Xen PVHVM guest support"
+	default y
+	depends on XEN_PVHVM && PCI
+	help
+	  Support running as a Xen PVHVM guest.
+
 config XEN_512GB
 	bool "Limit Xen pv-domain memory to 512GB"
 	depends on XEN_PV
@@ -76,7 +80,9 @@ config XEN_DEBUG_FS
 	  Enabling this option may incur a significant performance overhead.
 
 config XEN_PVH
-	bool "Support for running as a Xen PVH guest"
+	bool "Xen PVH guest support"
 	depends on XEN && XEN_PVHVM && ACPI
 	select PVH
 	def_bool n
+	help
+	  Support for running as a Xen PVH guest.
diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
index babdca808861..c3621b9f4012 100644
--- a/drivers/xen/Makefile
+++ b/drivers/xen/Makefile
@@ -21,7 +21,7 @@ obj-$(CONFIG_XEN_GNTDEV)		+= xen-gntdev.o
 obj-$(CONFIG_XEN_GRANT_DEV_ALLOC)	+= xen-gntalloc.o
 obj-$(CONFIG_XENFS)			+= xenfs/
 obj-$(CONFIG_XEN_SYS_HYPERVISOR)	+= sys-hypervisor.o
-obj-$(CONFIG_XEN_PVHVM)			+= platform-pci.o
+obj-$(CONFIG_XEN_PVHVM_GUEST)		+= platform-pci.o
 obj-$(CONFIG_SWIOTLB_XEN)		+= swiotlb-xen.o
 obj-$(CONFIG_XEN_MCE_LOG)		+= mcelog.o
 obj-$(CONFIG_XEN_PCIDEV_BACKEND)	+= xen-pciback/
-- 
2.26.2

