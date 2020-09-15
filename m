Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8974326A347
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 12:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgIOKjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 06:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgIOKjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 06:39:00 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265BAC06174A;
        Tue, 15 Sep 2020 03:38:59 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id w1so2533792edr.3;
        Tue, 15 Sep 2020 03:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c3jB30FXinHk1vqreTb0FjmJR543UrMd5qpLCkLHc4w=;
        b=FkbLqe5j79Y3flURMQRs/zE0angx6uXxaL+yCDWTZbw6YGqIh+xfK4nj1K+aBQrI5O
         eTuCXP1ezFqunylOKHBXMvg272EsC5q7+w4pkEXOmdVOYCr8gScWxLYC3r+YhofKTeBl
         sB6V54nQiIfvQ9j0cKZ0KCzhmL78uQdhH3ea4TxcPMW/l17C3GgCGRzdfnBlZ2eiim7N
         B932/rQJgZ4QlWKQgCoQSZPLYTdIwYIgETxb9UxY5kGWs7ELCjKzKOuI5Y/u7/wrLTFr
         xK6s76kG84XIl6dvsEek8QTsQMKVa6gLadOaEs4zTzjoEAZC/327Xmgi3V0VfOj4gofw
         aZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c3jB30FXinHk1vqreTb0FjmJR543UrMd5qpLCkLHc4w=;
        b=mtuoxgxiHDJues461j14VkIlS59WzklwXGQ/esshOPNBFOdTGchZ8LrRpogQcHminq
         /AX3JLHrbFTv+IoClhO+u7fmh095Sew4D8f9T0/hI/muJzA1oIoRlbkqgo2dodnli3kF
         r1wZuldQP9138w0sCw3DJ8EFJ4KxwDklqRZUzD/GMuRb2rT8YEh/9hHzWaL6ZZcG4zUm
         djTR/JTc1ZiknN1IRhzN+jQPVq43QbKQkvd5CmJRoE2eUwv/O7kUdE5ZVbKJXqY7t2AD
         iIUPYH4CSEsbYc6CQGAwP0DJ6hMYEgC5loXjSwtWt2refWafHvFz7fKKL7p+mngd4Rlc
         O2xw==
X-Gm-Message-State: AOAM5318EX/oxFnbV+JZMeaw5k62+ybqgzTjNrsFlXToGu+tg4iKD2gM
        acjne07tsk/0dlZVujIFTNBdNxRR5fC2yw==
X-Google-Smtp-Source: ABdhPJy/SPLxboZEOboeecHx7QJmOx9MPRY7Y2Mc4rraWHknoawIb2y19wvi4nnJXhjGwkEeOBLxQA==
X-Received: by 2002:aa7:de82:: with SMTP id j2mr22683170edv.3.1600166338376;
        Tue, 15 Sep 2020 03:38:58 -0700 (PDT)
Received: from localhost.localdomain ([85.153.229.188])
        by smtp.gmail.com with ESMTPSA id q26sm9886066ejr.97.2020.09.15.03.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 03:38:57 -0700 (PDT)
From:   Necip Fazil Yildiran <fazilyildiran@gmail.com>
To:     mturquette@baylibre.com
Cc:     maxime@cerno.tech, sboyd@kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, paul@pgazz.com, jeho@cs.utexas.edu,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>
Subject: [PATCH] clk: bcm: fix kconfig dependency warning for CLK_BCM2711_DVP
Date:   Tue, 15 Sep 2020 13:37:50 +0300
Message-Id: <20200915103749.38126-1-fazilyildiran@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CLK_BCM2711_DVP is enabled and RESET_CONTROLLER is disabled, it
results in the following Kbuild warning:

WARNING: unmet direct dependencies detected for RESET_SIMPLE
  Depends on [n]: RESET_CONTROLLER [=n]
  Selected by [y]:
  - CLK_BCM2711_DVP [=y] && (ARCH_BCM2835 [=n] || COMPILE_TEST [=y]) && COMMON_CLK [=y]

The reason is that CLK_BCM2711_DVP selects RESET_SIMPLE without depending
on or selecting RESET_CONTROLLER while RESET_SIMPLE is subordinate to
RESET_CONTROLLER.

Honor the kconfig menu hierarchy to remove kconfig dependency warnings.

Fixes: 1bc95972715a ("clk: bcm: Add BCM2711 DVP driver")
Signed-off-by: Necip Fazil Yildiran <fazilyildiran@gmail.com>
---
 drivers/clk/bcm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/bcm/Kconfig b/drivers/clk/bcm/Kconfig
index 784f12c72365..ec738f74a026 100644
--- a/drivers/clk/bcm/Kconfig
+++ b/drivers/clk/bcm/Kconfig
@@ -5,6 +5,7 @@ config CLK_BCM2711_DVP
 	depends on ARCH_BCM2835 ||COMPILE_TEST
 	depends on COMMON_CLK
 	default ARCH_BCM2835
+	select RESET_CONTROLLER
 	select RESET_SIMPLE
 	help
 	  Enable common clock framework support for the Broadcom BCM2711
-- 
2.25.1

