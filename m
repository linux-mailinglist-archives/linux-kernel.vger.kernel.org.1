Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF422F1960
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 16:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732487AbhAKPR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 10:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbhAKPR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 10:17:58 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAD7C061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 07:17:18 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id a6so162345wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 07:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0TcPx+7pAz4mOWYUryj7o7tYaRTL8G4UVxUnW9m5I0k=;
        b=DEoO57eOc347UcLngC0mqGHqk13ZR+N6Vrv8iz9hXRyaMX1xMe+Cs1ifYqtzUA0nvd
         NQ57pZZKtYCU7ijRMRto7TtcU5RkH+RdDSjvymjocAbTyvIAHRGm14km6TRxdbqYIQAw
         NvQAY7kBorhPVZWQmSrYKWvUXbk5uBHNXBpjLW6OWPG/lj4zfAQwpxJYm4sow14P5lmJ
         uPRpj9aOo8/dLS75aaWftnEmBxt8tOgOJyB3By8UYlLYz4OIegliGMPaWvq+pMtZIt2T
         IPsphoISuAHVfmmRfpSDUQPQGfjXQ5EpClKGkjrsyFwCjKUd9egsvOUJwuR7O3l9l4D/
         4sNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0TcPx+7pAz4mOWYUryj7o7tYaRTL8G4UVxUnW9m5I0k=;
        b=QHsshutn802NRKfBOYhfNeW8cboq62SdmB9GaBkvPEaIIIiPE6AZO/9WXkCMOBSKMq
         ymXuaJoogGFc4EkjTnpjJWXeqoGXGIKg4gMhXdwYO8UD5Bo/+B8V6rgPM1QMP8IekZjx
         Nie1HX/CY/2GxCxmCu+XilEkU71z9xIcBQXEizGTw0Ax99fmAsHzwMgZm0yqeU3757z9
         0WQfoT1hGCZxIXXU4ftmNluV1ifSRigIoBu+mAKf9rPopQrSr7M9XWh+c0XVY/0K+pVW
         PfFh29WFnyPkL0uV3t2U81fq5WmoUaHxccbrfYX3xikf4WdZ3fJRd3O7nnsKKmwd9wDK
         2f6g==
X-Gm-Message-State: AOAM531F/tcXQ2wdmaizMBP68YzD+CcHHsU1QDetyZ8AbKGMVyfnQnzy
        wzxt5FelMgANrEWaMrw3vV8=
X-Google-Smtp-Source: ABdhPJzw1xmUcOJ05wP+KGreicwg6Mno9pFPVs5TMOS191SkVsAXLEG9EhYrETFd4Xn1hNBtx1X5gA==
X-Received: by 2002:a05:600c:2117:: with SMTP id u23mr145106wml.153.1610378237257;
        Mon, 11 Jan 2021 07:17:17 -0800 (PST)
Received: from Saturn.local.all ([81.221.211.103])
        by smtp.gmail.com with ESMTPSA id h5sm25549623wrp.56.2021.01.11.07.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 07:17:16 -0800 (PST)
From:   Max Krummenacher <max.oss.09@gmail.com>
X-Google-Original-From: Max Krummenacher <max.krummenacher@toradex.com>
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH 0/1] ARM: imx: build suspend-imx6.S with arm instruction set
Date:   Mon, 11 Jan 2021 16:17:03 +0100
Message-Id: <20210111151704.26296-1-max.krummenacher@toradex.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the kernel is configured to use the Thumb-2 instruction set
"suspend-to-memory" fails to resume while in ARM mode it works as
expected.
(I used imx_v6_v7_defconfig and deselected ARCH_MULTI_V6 and selected
THUMB2_KERNEL)

The system prints what is expected when suspending but an event of a
wakeup source does give no output.

root@colibri-imx6ull:~# echo mem > /sys/power/state

[   58.610809] PM: suspend entry (deep)
[   58.629354] Filesystems sync: 0.014 seconds
[   58.653411] Freezing user space processes ... (elapsed 0.001 seconds) done.
[   58.661941] OOM killer disabled.
[   58.665176] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[   58.674028] printk: Suspending console(s) (use no_console_suspend to debug)

-> trigger wakeup event, no reaction.

It looks like the CPU resumes unconditionally in ARM instruction mode
and then chokes on the presented Thumb-2 code it should execute on resume.
With the following code change resume succeeds.

--- a/arch/arm/mach-imx/suspend-imx6.S
+++ b/arch/arm/mach-imx/suspend-imx6.S
@@ -287,11 +286,20 @@ rbc_loop:
 	bne	rbc_loop

 	/* Zzz, enter stop mode */
 	wfi
+#ifdef CONFIG_THUMB2_KERNEL
+	/* i.MX CPUs seem to leave stop mode set to ARM instruction set */
+	.arm
+#endif
 	nop
 	nop
 	nop
 	nop
+#ifdef CONFIG_THUMB2_KERNEL
+	/* switch to Thumb2 mode */
+	sub     pc, pc, #3
+	.thumb
+#endif

 	/*

I propose however to compile the whole file in ARM mode and have the
linker taking care of the ARM/Thumb-2 switching. This would also keep
the code working if a i.MX CPU variant exists that resumes in the same
mode in which it went to sleep.



Max Krummenacher (1):
  ARM: imx: build suspend-imx6.S with arm instruction set

 arch/arm/mach-imx/suspend-imx6.S | 1 +
 1 file changed, 1 insertion(+)

-- 
2.26.2

