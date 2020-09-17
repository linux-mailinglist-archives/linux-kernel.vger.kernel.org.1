Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7851D26E53C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 21:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgIQTQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 15:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728388AbgIQQSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 12:18:45 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D292C061226;
        Thu, 17 Sep 2020 09:18:09 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id z22so4082724ejl.7;
        Thu, 17 Sep 2020 09:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CwsCZGPPc4UztwJYa8ujzMQrMgcPcRryCeMG+FPPd0o=;
        b=jwvCOxibAW//ZJ3LBKpKwQb+MWCze3cCT9PoT+1UeRVR8pvOmQEH6Lz0gpWi8teTXI
         iCIZEz41kSt6ulScHaN2iX7F3eNDYCEwt2IPgduOnEaflG6/FmhxGHgmLypim4xYkrI1
         1XFCG4E6Wuq1bMdQwFjPUQ5/Ac4z9UOoR5809yK+fJZ5plLVpPbWWjxg4k/iwJkkCubH
         Jd5IAv1HWVV51zc9WFS8Xni8sHBo2LIYkEkd3raAG8yhqOcL7X4pzeW4pxVolnrp36g5
         zvCA+3Y/YOUTS5WhTgjrK3YN43bVEBWoXRdsJvvziZBWeo5BsEJCpvJSmuPwmxo9v5GY
         owzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CwsCZGPPc4UztwJYa8ujzMQrMgcPcRryCeMG+FPPd0o=;
        b=oaydIV1IbxgbqMU0ArJGhn295ehm/UwDNq0oUiGeupoP+WiG4DoVdfeR59+Q7F8DGq
         W0SMChRPLugFmD6eRPSjQXXXnwTKbE7Gq2KUsjqJMSR0L6NGmuhBQwu/oRR4kjcvSSph
         1lsdZCXD6YeQIKYxY052ykyH+iCWzv/3lGnuhlJtKVH6zVKKYxba0Fxc3+Hw4/ww7fek
         haNOA1GPGu6NZo2j1OfgbOg8nMlGjEUr7wuOld7c6KHQUd+IcyYT3IaJYlLW7k12Ja+T
         lo83AOCQlHx11LnPoTw9PVOH0oyGGvRA3DkOg5zHBZNVS5DSQu+PonBbaV0FufjcXQvK
         3bHg==
X-Gm-Message-State: AOAM533gwEshLgd5q/v529bamH3DJok50cAYiCoRNBZYnFmhSk60q2hb
        8LOUFfH2lJClVdp4zlOKk+o=
X-Google-Smtp-Source: ABdhPJxlYSJ4C4Rgl+RcS36v/pR8pI8wwmEvOL3Sv1i1PmWpwbGa2nxfM12nDkk7oVdu28K2HrK3yA==
X-Received: by 2002:a17:906:3913:: with SMTP id f19mr33272392eje.83.1600359487673;
        Thu, 17 Sep 2020 09:18:07 -0700 (PDT)
Received: from localhost.localdomain ([85.153.229.188])
        by smtp.gmail.com with ESMTPSA id bo8sm109242edb.39.2020.09.17.09.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 09:18:06 -0700 (PDT)
From:   Necip Fazil Yildiran <fazilyildiran@gmail.com>
To:     andy@infradead.org
Cc:     hdegoede@redhat.com, matan@svgalib.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@pgazz.com, jeho@cs.utexas.edu,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>
Subject: [PATCH] platform/x86: fix kconfig dependency warning for FUJITSU_LAPTOP
Date:   Thu, 17 Sep 2020 19:16:53 +0300
Message-Id: <20200917161652.147616-1-fazilyildiran@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When FUJITSU_LAPTOP is enabled and NEW_LEDS is disabled, it results in the
following Kbuild warning:

WARNING: unmet direct dependencies detected for LEDS_CLASS
  Depends on [n]: NEW_LEDS [=n]
  Selected by [y]:
  - FUJITSU_LAPTOP [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y] && ACPI [=y] && INPUT [=y] && BACKLIGHT_CLASS_DEVICE [=y] && (ACPI_VIDEO [=n] || ACPI_VIDEO [=n]=n)

The reason is that FUJITSU_LAPTOP selects LEDS_CLASS without depending on
or selecting NEW_LEDS while LEDS_CLASS is subordinate to NEW_LEDS.

Honor the kconfig menu hierarchy to remove kconfig dependency warnings.

Reported-by: Hans de Goede <hdegoede@redhat.com>
Fixes: d89bcc83e709 ("platform/x86: fujitsu-laptop: select LEDS_CLASS")
Signed-off-by: Necip Fazil Yildiran <fazilyildiran@gmail.com>
---
 drivers/platform/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 40219bba6801..3cd2b99628ba 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -469,6 +469,7 @@ config FUJITSU_LAPTOP
 	depends on BACKLIGHT_CLASS_DEVICE
 	depends on ACPI_VIDEO || ACPI_VIDEO = n
 	select INPUT_SPARSEKMAP
+	select NEW_LEDS
 	select LEDS_CLASS
 	help
 	  This is a driver for laptops built by Fujitsu:
-- 
2.25.1

