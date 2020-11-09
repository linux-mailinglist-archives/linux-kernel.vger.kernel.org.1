Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7763D2AC8D4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 23:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbgKIWrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 17:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729451AbgKIWrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 17:47:18 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D94C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 14:47:17 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id y8so3462706qvu.22
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 14:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=bZ4K6V7c259yMftAZeIl2XziiPdlo9z+jlCG4AliFbc=;
        b=ZMq8x5KWu1tR8/9xaagtBGrCWE3Jxz9i5QAxSaipt1dvB9rSMujsiMBdm+SlT1n+Kt
         e3rwO/oMIf/D4jl//OAhsCQjFOxBrHWbbC3CXEpOBWLLim8qxKpjjlT1B4lBqpVhODPa
         sRAew8k5ht7KhXFMRJWUDi1uMxhS3Bhj5AkOwqwBPaLdr1IXLT+spDH/2U61eVGhcns0
         TMNASfgBijcpVz/TH5PXU1V42GiBXUF9iSSxV967JmV6YYPCX9/kdTksJvrK+xIQruti
         EGey0eanibtx03F+FmjEHojcvEgt77ZD/LaePf3FPwl675/O/tD8FUIe22mUn2UsXW2C
         Rc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=bZ4K6V7c259yMftAZeIl2XziiPdlo9z+jlCG4AliFbc=;
        b=oZ7nB2byCA90LDlxsVFR8hspsK2y/F6GX0MpvqqX4nNB4IWIfNueQEMBteoC4kMNO6
         y6aRuCErTNwaSlnUHB9xqyNqjuiQv2v2QxcPc8UGBmYwm7JiXLCzYkZINPGYX8f3Pt4h
         0KIINpC/duggvy642NREfV6nMPJZJxWHNGw9gIh3nk/FwaKa7PW4OYcqyWcBdO/qXVUe
         nlENu7G8TSvFRPIWn+L3mBsRb8K36pVrg6MlrYR0GR0/3EyVlKTS6p3o++74EYgQxApQ
         3Lx+46ZimYqmqkqd6gwuQsiLlK9dwq0TM5wLD4T/m6feCPNmqlNyObJvsunwR3k11sx/
         cc8A==
X-Gm-Message-State: AOAM533PWA15Ke+mwbvy47cLJjuOtfjyYTL0biZJdjtDHcjEuPbjUgMg
        rDkOclDL0+V1oaHePqKVSiyzJXCmkqg4x9E2P44=
X-Google-Smtp-Source: ABdhPJz5xh4YuRwgUB3Qgv2UfvK/w6QHjuGWOP0FIZflbp9L6tYxvB8vXL//SwVVRFuX6G3O9MLGZNK1ypdoLyni+Wo=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:ad4:5345:: with SMTP id
 v5mr16851402qvs.15.1604962036983; Mon, 09 Nov 2020 14:47:16 -0800 (PST)
Date:   Mon,  9 Nov 2020 14:47:12 -0800
Message-Id: <20201109224713.16308-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH] ARM: Kconfig: CPU_BIG_ENDIAN depends on !LD_IS_LLD
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Fangrui Song <maskray@google.com>, Jian Cai <jiancai@google.com>,
        Peter Smith <peter.smith@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LLD does not yet support any big endian architectures. Make this config
non-selectable when using LLD until LLD is fixed.

Link: https://github.com/ClangBuiltLinux/linux/issues/965
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/arm/mm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 65e4482e3849..02692fbe2db5 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -743,6 +743,7 @@ config SWP_EMULATE
 config CPU_BIG_ENDIAN
 	bool "Build big-endian kernel"
 	depends on ARCH_SUPPORTS_BIG_ENDIAN
+	depends on !LD_IS_LLD
 	help
 	  Say Y if you plan on running a kernel in big-endian mode.
 	  Note that your board must be properly built and your board
-- 
2.29.2.222.g5d2a92d10f8-goog

