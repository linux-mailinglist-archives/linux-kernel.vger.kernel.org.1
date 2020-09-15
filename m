Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC43226A1B9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 11:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgIOJKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 05:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgIOJKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 05:10:45 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E1DC06174A;
        Tue, 15 Sep 2020 02:10:44 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t10so2501836wrv.1;
        Tue, 15 Sep 2020 02:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=txzfbZrnakH2vaBjHQaalxnwyww01JCiom2JkdV9wmw=;
        b=kUnELQITvGByzN0wd3bKx6OJ8cJu1FkJ9Pr9qtd4PWLcZRGOmv2Ig3K2HXRQLNwwT3
         Z4Vak+BFA2C6caVthL7H6Nl0hDPfI0nmPbEJn5i+FrRPU09AsFQyAlWpYvZLhvLZzZXU
         MuePsAIavbIZHbxXqMd1q5YNAMQW0kBM30a2mabmO1DARz/MxyxXDAQ/FT5IgUe+hS7Y
         t1hlautpQ5hfbOzDumuqW4NCwbgmOLDFBATHnjI02gGFxidmilgni0GutfSB3QUxH8yH
         jOG1NSmiCsVPUY5iXX6lBwO6qoEI+g2fKq311AdqErkcp2+U5MBm+3nUbbYHeeJ3+DZZ
         3ZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=txzfbZrnakH2vaBjHQaalxnwyww01JCiom2JkdV9wmw=;
        b=sSp+/ksMyv+B+USefKPsIBXeidhlw6my9HNoWOf/79YdBedXw4qK1qFyTY6NxpJihm
         UdhXs82uML+NPXMRuNS4pK+FT0GpB7QoK9IY00gKRd+qy9UzpCASiep99E/gZaHx3QHg
         yQsLqSH1pb4gPRvHfTHmsnnREPD6OGQy1/3LG8VOU0Iucoo1AGJxApjY6ZdcL1KXRg2n
         BH82pUpks4MiiT3ibpOLx3hP5RjefPQAPzbHxEX629sJEJoWgRdOnp1CfVpcPUyOJ6Ic
         tOV0z9n9vs/U7Cw8hVGaWZl3X+4IpL3ShUye6n1IXgxxT7nUJHkxm0rh69suixiciAWB
         EuZQ==
X-Gm-Message-State: AOAM531nj9STB83gLLdBWuUBXhAbuuehAzBKhnhDRqi/gFNjvAG990ID
        8bko1ZPUHUQ9H0Ps77MzRAU=
X-Google-Smtp-Source: ABdhPJyrM+kjDYT88l6l/yATdBcYMsvxnYG7dYhRpSdBRWmEE30T7FpRxEL3HiiAJTKwT3PHNC4CwQ==
X-Received: by 2002:adf:f88d:: with SMTP id u13mr21801771wrp.213.1600161043205;
        Tue, 15 Sep 2020 02:10:43 -0700 (PDT)
Received: from localhost.localdomain ([85.153.229.188])
        by smtp.gmail.com with ESMTPSA id k4sm25899060wrx.51.2020.09.15.02.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 02:10:42 -0700 (PDT)
From:   Necip Fazil Yildiran <fazilyildiran@gmail.com>
To:     andy@infradead.org
Cc:     matan@svgalib.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, paul@pgazz.com, jeho@cs.utexas.edu,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>
Subject: [PATCH] platform/x86: fix kconfig dependency warning for LG_LAPTOP
Date:   Tue, 15 Sep 2020 12:09:23 +0300
Message-Id: <20200915090922.16423-1-fazilyildiran@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When LG_LAPTOP is enabled and NEW_LEDS is disabled, it results in the
following Kbuild warning:

WARNING: unmet direct dependencies detected for LEDS_CLASS
  Depends on [n]: NEW_LEDS [=n]
  Selected by [y]:
  - LG_LAPTOP [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y] && ACPI [=y] && ACPI_WMI [=y] && INPUT [=y]

The reason is that LG_LAPTOP selects LEDS_CLASS without depending on or
selecting NEW_LEDS while LEDS_CLASS is subordinate to NEW_LEDS.

Honor the kconfig menu hierarchy to remove kconfig dependency warnings.

Fixes: dbf0c5a6b1f8 ("platform/x86: Add LG Gram laptop special features driver")
Signed-off-by: Necip Fazil Yildiran <fazilyildiran@gmail.com>
---
 drivers/platform/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 40219bba6801..81f6079d08e6 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1112,6 +1112,7 @@ config LG_LAPTOP
 	depends on ACPI_WMI
 	depends on INPUT
 	select INPUT_SPARSEKMAP
+	select NEW_LEDS
 	select LEDS_CLASS
 	help
 	 This driver adds support for hotkeys as well as control of keyboard
-- 
2.25.1

