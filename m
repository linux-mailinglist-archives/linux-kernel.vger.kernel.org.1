Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F9E1A6C55
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 21:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387819AbgDMTHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 15:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387810AbgDMTHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 15:07:45 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E596C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 12:07:45 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id i27so7302100ota.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 12:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1SmeqPeiRq4ELCasPb+U8ymC5PsnIVQabtpniLNnwes=;
        b=nN2STru+RfJVvuJeMIFQLgrdkOGYez2Z1PYGTs0D1LYSJqvmKwJ2hDWXUCxBg4RLPj
         e0e6yWG4G4STB9CcnJSsYza2LirnlHEpPq9CIxdm1bQzwZd53tTbf3U+znQvdzflYhNy
         otoWjP/4C6Fk/LRiQjc+PsttIfXcDhrrAf3fEzdGIloBcTrcZpA/PoUnhq+2ufxHtAab
         I2k8gkE59CGciNYEXd696x1ikWYVljkoLDX5ifETtdViSYXS3Ig5PeYO7p/r0KM0FE3D
         8qzuFlyCOAzv3BNw9hAPgXYP1lVP2NQo6EzcJJoHavxWzECzexsRQbR/sIBa7Hw3nx6K
         Y6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1SmeqPeiRq4ELCasPb+U8ymC5PsnIVQabtpniLNnwes=;
        b=PQrzKWft756JXwscdOfl7PAB7ZnAVSd07aQy7MxN410h/iuivB13vP/Rn05EpMT7Cv
         81VINiZT5gJ96PrkTSTQpBk9hMp0aRUzPhbydPCaeUp6/6dM2DVukOToGMj1ekUceOtb
         KHf4LlPK25hEl0v6wL/t2CFtfGxfaZHmscAPqSF5CYox906rsP+LugkS8rFzJnYKEf4s
         SvL6U1vQdU60fG5dK2jr+bRBdYMhRrgQ3ZupichMFOCWEusjNAaRQJSPLiIilVZOAU7m
         wTFfeGU2uElR0TzbXHU69trxCUrnohKLMKFxCdQpw/rkxLrodbv4F7byNZ+bzgqsyon2
         gPVQ==
X-Gm-Message-State: AGi0Pub/WPEL/EzmHZhMhCGviwS8lkVwsI1diF7piQrT1r4CLcpdsFuf
        HjIJWoa/yg1DN9sHumihv2w=
X-Google-Smtp-Source: APiQypJDQOcmUsrOhKZoci5yeuiwCmqlB0ibqUMV3v1Bb9nK4GHKKBGKcCU+pe7P0SvzixrgJnKrjw==
X-Received: by 2002:a9d:4808:: with SMTP id c8mr15527587otf.313.1586804864550;
        Mon, 13 Apr 2020 12:07:44 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::3])
        by smtp.gmail.com with ESMTPSA id j17sm4920241otp.58.2020.04.13.12.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 12:07:44 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH] powerpc/wii: Fix declaration made after definition
Date:   Mon, 13 Apr 2020 12:06:45 -0700
Message-Id: <20200413190644.16757-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A 0day randconfig uncovered an error with clang, trimmed for brevity:

arch/powerpc/platforms/embedded6xx/wii.c:195:7: error: attribute
declaration must precede definition [-Werror,-Wignored-attributes]
        if (!machine_is(wii))
             ^

The macro machine_is declares mach_##name but define_machine actually
defines mach_##name, hence the warning.

To fix this, move define_machine after the is_machine usage.

Fixes: 5a7ee3198dfa ("powerpc: wii: platform support")
Reported-by: kbuild test robot <lkp@intel.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/989
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/powerpc/platforms/embedded6xx/wii.c | 25 ++++++++++++------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
index 67e48b0a164e..a802ef957d63 100644
--- a/arch/powerpc/platforms/embedded6xx/wii.c
+++ b/arch/powerpc/platforms/embedded6xx/wii.c
@@ -172,19 +172,6 @@ static void wii_shutdown(void)
 	flipper_quiesce();
 }
 
-define_machine(wii) {
-	.name			= "wii",
-	.probe			= wii_probe,
-	.setup_arch		= wii_setup_arch,
-	.restart		= wii_restart,
-	.halt			= wii_halt,
-	.init_IRQ		= wii_pic_probe,
-	.get_irq		= flipper_pic_get_irq,
-	.calibrate_decr		= generic_calibrate_decr,
-	.progress		= udbg_progress,
-	.machine_shutdown	= wii_shutdown,
-};
-
 static const struct of_device_id wii_of_bus[] = {
 	{ .compatible = "nintendo,hollywood", },
 	{ },
@@ -200,3 +187,15 @@ static int __init wii_device_probe(void)
 }
 device_initcall(wii_device_probe);
 
+define_machine(wii) {
+	.name			= "wii",
+	.probe			= wii_probe,
+	.setup_arch		= wii_setup_arch,
+	.restart		= wii_restart,
+	.halt			= wii_halt,
+	.init_IRQ		= wii_pic_probe,
+	.get_irq		= flipper_pic_get_irq,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+	.machine_shutdown	= wii_shutdown,
+};

base-commit: 8f3d9f354286745c751374f5f1fcafee6b3f3136
-- 
2.26.0

