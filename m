Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777022E787D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 13:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgL3MWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 07:22:36 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39610 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbgL3MWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 07:22:35 -0500
Received: from zn.tnic (p200300ec2f0ae90049f6d027edb76631.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:e900:49f6:d027:edb7:6631])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 96BA11EC0136;
        Wed, 30 Dec 2020 13:21:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1609330914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=f4UWjyrRhOURpWlRdNmigkzGu1/VycQjkQmceTndONw=;
        b=BQq8rldbqP1mjMy5r/u1UCMEaOY2a11HUQEt4XazjJrqY0IdafuYRiV5Ka7d992oLaqYUi
        7vXB9AtxEPq40a8XZaJt5HrXvsdZ5majYJWG7hYOfBu7JJLtRPcMSDLFvPlfNwmHfvNDii
        dzbVlSiXV6ERptEpis5F4aeVGoImZF4=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/microcode: Make microcode_init() static
Date:   Wed, 30 Dec 2020 13:21:47 +0100
Message-Id: <20201230122147.26938-1-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/microcode.h     | 2 --
 arch/x86/kernel/cpu/microcode/core.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index 2b7cc5397f80..ab45a220fac4 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -127,14 +127,12 @@ static inline unsigned int x86_cpuid_family(void)
 }
 
 #ifdef CONFIG_MICROCODE
-int __init microcode_init(void);
 extern void __init load_ucode_bsp(void);
 extern void load_ucode_ap(void);
 void reload_early_microcode(void);
 extern bool get_builtin_firmware(struct cpio_data *cd, const char *name);
 extern bool initrd_gone;
 #else
-static inline int __init microcode_init(void)			{ return 0; };
 static inline void __init load_ucode_bsp(void)			{ }
 static inline void load_ucode_ap(void)				{ }
 static inline void reload_early_microcode(void)			{ }
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index ec6f0415bc6d..b935e1b5f115 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -830,7 +830,7 @@ static const struct attribute_group cpu_root_microcode_group = {
 	.attrs = cpu_root_microcode_attrs,
 };
 
-int __init microcode_init(void)
+static int __init microcode_init(void)
 {
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 	int error;
-- 
2.29.2

