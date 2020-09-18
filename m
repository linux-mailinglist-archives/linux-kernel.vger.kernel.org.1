Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0BC26FDF1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 15:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgIRNOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 09:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbgIRNOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 09:14:10 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7D0C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 06:14:09 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id q13so8023635ejo.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 06:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h9RM0lB/HRjVWapVwauDh3GcmVkeqJuprfSIbmmhiDw=;
        b=aYwKf0itNWEbbNcpboiYR4ONcLbgu3ObEd8tjxkeDdZnZ6Ev9olACStb/a/TzbN+BN
         ZU15wqlx+uG+mxetzn8hNmbTk/gvwv/O3ujdy+KQJFSU3BBEB+I5Sz4NzI+Ez2SlOjeC
         DIqh08RTMQyIXUIgIAgggQEAO4t2wFb2dC2cvPKkV2/Pkh1VIko0DXj+V0h/FX9P4ZKO
         Kr9kzPae0p5JquoI4C/TMHIcE4BYyzrB5GK8L8z6wQ9eRcJ4VFCtHWtVBVlz7eqcLaHI
         VP59D/Ztj/r6qADoQ3AAUSKlHMTeEJ9Q4Ynp4lEGxCBIIl0JaQFUjRGST6mssueHLRHQ
         Uyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h9RM0lB/HRjVWapVwauDh3GcmVkeqJuprfSIbmmhiDw=;
        b=aI94nxes9lAlhrNwnSWxNu3z+PHN1W4M9urw+BciQQB0KlcV1keIzJx3KXNnrO509h
         pBNxo6cLoBQZVjE9xFTh7xHIl5jNfloE5O7/WoBcfL3OWIJllqRceeJbQqtcjVPU+KL9
         zbqYacP9uSKSxQ74fJShBdV1IPpwzdnzxVkoYPO84JaQcbS1Eq32YKYl0C+OiLsFWJ4o
         mkFd+h7XVTbKnuWGk873PBAL8E87i+KMb85/NMAbBHTSvKb+tmOCyX6aplCJoD4M7c1I
         6yvbi/eEWvVUe0sMxOGQQq2qo0e2l2Wb+TEXss29cszEaHVN/J77v2/wgUYYOceFIDxY
         7vPw==
X-Gm-Message-State: AOAM5335F/YCL2MaH4CISYh1OpbQFsh8+bSKRX1c5/TUXsIbKkCiDld7
        x+XfL01CnYfzaVDbtmD733gyFFG/qc/+bg==
X-Google-Smtp-Source: ABdhPJxFvCYXn6QKQxQjig9/JET66Bd4HCmh6BMLITBLNBgrZEU132Msm0GVujJ6ehpBMuGZV8HT3g==
X-Received: by 2002:a17:906:cf8b:: with SMTP id um11mr37458262ejb.540.1600434848122;
        Fri, 18 Sep 2020 06:14:08 -0700 (PDT)
Received: from localhost.localdomain ([85.153.229.188])
        by smtp.gmail.com with ESMTPSA id s14sm1530082eju.84.2020.09.18.06.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 06:14:07 -0700 (PDT)
From:   Necip Fazil Yildiran <fazilyildiran@gmail.com>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        paul@pgazz.com, jeho@cs.utexas.edu,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>
Subject: [PATCH] ASoC: fix kconfig dependency warnings for SND_SOC_WM8731
Date:   Fri, 18 Sep 2020 16:12:58 +0300
Message-Id: <20200918131257.5860-1-fazilyildiran@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SND_SOC_WM8731 was made visible and dependent on other symbols with commit
1291e14175e6 ("ASoC: codecs: Make OF supported CODECs visible in Kconfig").
To this respect, the symbols selecting SND_SOC_WM8731 turned out to be
overlooking its dependencies.

For example, enabling SND_SOC_DB1200 and disabling SND_SOC_I2C_AND_SPI
results in the following Kconfig warning since SND_SOC_DB1200 selects
SND_SOC_WM8731 but does not account for its dependencies:

WARNING: unmet direct dependencies detected for SND_SOC_WM8731
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_I2C_AND_SPI [=n]
  Selected by [y]:
  - SND_SOC_DB1200 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_AU1XPSC [=y]

Switch reverse dependencies on SND_SOC_WM8731 to normal dependencies.

Fixes: 1291e14175e6 ("ASoC: codecs: Make OF supported CODECs visible in Kconfig")
Signed-off-by: Necip Fazil Yildiran <fazilyildiran@gmail.com>
---
 sound/soc/atmel/Kconfig | 7 +++----
 sound/soc/au1x/Kconfig  | 3 +--
 sound/soc/pxa/Kconfig   | 4 ++--
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index 71f2d42188c4..abb1284835c0 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -44,8 +44,8 @@ config SND_AT91_SOC_SAM9G20_WM8731
 	tristate "SoC Audio support for WM8731-based At91sam9g20 evaluation board"
 	depends on ARCH_AT91 || COMPILE_TEST
 	depends on ATMEL_SSC && SND_SOC_I2C_AND_SPI
+	depends on SND_SOC_WM8731
 	select SND_ATMEL_SOC_SSC_PDC
-	select SND_SOC_WM8731
 	help
 	  Say Y if you want to add support for SoC audio on WM8731-based
 	  AT91sam9g20 evaluation board.
@@ -64,8 +64,8 @@ config SND_AT91_SOC_SAM9X5_WM8731
 	tristate "SoC Audio support for WM8731-based at91sam9x5 board"
 	depends on ARCH_AT91 || COMPILE_TEST
 	depends on ATMEL_SSC && SND_SOC_I2C_AND_SPI
+	depends on SND_SOC_WM8731
 	select SND_ATMEL_SOC_SSC_DMA
-	select SND_SOC_WM8731
 	help
 	  Say Y if you want to add support for audio SoC on an
 	  at91sam9x5 based board that is using WM8731 codec.
@@ -110,8 +110,7 @@ config SND_ATMEL_SOC_I2S
 config SND_SOC_MIKROE_PROTO
 	tristate "Support for Mikroe-PROTO board"
 	depends on OF
-	depends on SND_SOC_I2C_AND_SPI
-	select SND_SOC_WM8731
+	depends on SND_SOC_I2C_AND_SPI && SND_SOC_WM8731
 	help
 	  Say Y or M if you want to add support for MikroElektronika PROTO Audio
 	  Board. This board contains the WM8731 codec, which can be configured
diff --git a/sound/soc/au1x/Kconfig b/sound/soc/au1x/Kconfig
index 38de7c0efbc7..749e59fddfcd 100644
--- a/sound/soc/au1x/Kconfig
+++ b/sound/soc/au1x/Kconfig
@@ -53,12 +53,11 @@ config SND_SOC_DB1000
 
 config SND_SOC_DB1200
 	tristate "DB1200/DB1300/DB1550 Audio support"
-	depends on SND_SOC_AU1XPSC
+	depends on SND_SOC_AU1XPSC && SND_SOC_WM8731
 	select SND_SOC_AU1XPSC_AC97
 	select SND_SOC_AC97_CODEC
 	select SND_SOC_WM9712
 	select SND_SOC_AU1XPSC_I2S
-	select SND_SOC_WM8731
 	help
 	  Select this option to enable audio (AC97 and I2S) on the
 	  Alchemy/AMD/RMI/NetLogic Db1200, Db1550 and Db1300 evaluation boards.
diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 0ac85eada75c..eeb1dde59468 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -44,8 +44,8 @@ config SND_MMP_SOC_SSPA
 config SND_PXA2XX_SOC_CORGI
 	tristate "SoC Audio support for Sharp Zaurus SL-C7x0"
 	depends on SND_PXA2XX_SOC && PXA_SHARP_C7xx && I2C
+	depends on SND_SOC_WM8731
 	select SND_PXA2XX_SOC_I2S
-	select SND_SOC_WM8731
 	help
 	  Say Y if you want to add support for SoC audio on Sharp
 	  Zaurus SL-C7x0 models (Corgi, Shepherd, Husky).
@@ -70,8 +70,8 @@ config SND_PXA2XX_SOC_Z2
 config SND_PXA2XX_SOC_POODLE
 	tristate "SoC Audio support for Poodle"
 	depends on SND_PXA2XX_SOC && MACH_POODLE && I2C
+	depends on SND_SOC_WM8731
 	select SND_PXA2XX_SOC_I2S
-	select SND_SOC_WM8731
 	help
 	  Say Y if you want to add support for SoC audio on Sharp
 	  Zaurus SL-5600 model (Poodle).
-- 
2.25.1

