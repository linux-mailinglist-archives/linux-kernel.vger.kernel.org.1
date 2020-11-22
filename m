Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620F22BC458
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 08:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbgKVHJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 02:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbgKVHJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 02:09:04 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1B1C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 23:09:04 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id b63so11908315pfg.12
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 23:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tIWLDLxgHHbMnYBlFKmQF404/X4q6NlxjtbUaFoy66M=;
        b=AoG96uhpVszrOhyX/3vSp80TU6YkMJ462ehNRT2ymhqlC1P5Cr9mOF5xJfhdo9Z8E0
         dQtrKF5/7eXi7SJ1dVSu3+PZOC/V4W86NAC4woK6eviZyMXUSTy26DF21ShwtP8vqWE+
         otEjoaa7a7YCSC4C89eZq0XKkUmIUh04Z5NojZ26tdOXVEQFcX5lEWuMfBi+cg1bQaLJ
         WPQHgyt7KnGg3sWWGRadRBRMdVVVPTcql3JpSOVXxyALyDTv2trI70BcbwrXdQCqOxUW
         38bBzbuVE1XoSi5xs7HyZCO4fGPfOSqy5W00LVGOzFfx/sGFy+tCTkHsACZ0VOWkn/FW
         3OdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tIWLDLxgHHbMnYBlFKmQF404/X4q6NlxjtbUaFoy66M=;
        b=D4xAY3A9NjRdW9hdppqUdDPDIu6VIi//g94ZcAV5eI3U8yMedk7QRc3M6H+yx8eWY9
         bQ4rvNbVc8udGlUGb3cCCtTdmRVINEoNdDbzazQn/q5kX+popHye+3PBglj8nC6yco+d
         n+VMBUZD1GTzrQR6Ll746vheDHx/px5qDo0z94946OEECBpNBON0t1yyMUYnFc2T0dG5
         gj+Fvs0p1m9hzpLtZyQ7qh9FmxqqZDJGXiHFx33nP+h0n/mCeZ9MD1mxvdVcD/h19Uqo
         uzJHtZMB45NkmfB7+yxmOudCqUFUG9kh3XyaOqdY+59WP/aap8Olr21WpNeG29sN3hUU
         aRow==
X-Gm-Message-State: AOAM531aiNKGk7LpANxUCeGlsxGtEuIBnyNxSjAlTzPa0USBCEZSUnuG
        P3k8ECtbyj8XCw+MjcmtrUo=
X-Google-Smtp-Source: ABdhPJwd3pG7kY7Qsip+S8FqdJvhv0SmE7AN5Gi+r01wFUA2LKPe08BYwN4cVJmqifnhggYpMMRovQ==
X-Received: by 2002:a17:90a:62c3:: with SMTP id k3mr5830340pjs.24.1606028943711;
        Sat, 21 Nov 2020 23:09:03 -0800 (PST)
Received: from ubuntu.localdomain ([220.116.27.194])
        by smtp.gmail.com with ESMTPSA id w22sm7557598pge.25.2020.11.21.23.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 23:09:03 -0800 (PST)
From:   youngjun <her0gyugyu@gmail.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        youngjun <her0gyugyu@gmail.com>
Subject: [PATCH] arm64: update RANDOMIZE_MODULE_REGION_FULL config description
Date:   Sat, 21 Nov 2020 23:08:55 -0800
Message-Id: <20201122070855.10506-1-her0gyugyu@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

module randomization is reduced. (range to 2 GB)
RANDOMIZE_MODULE_REGION_FULL config description is not updated.
update RANDOMIZE_MODULE_REGION_FULL config description.

Signed-off-by: youngjun <her0gyugyu@gmail.com>
---
 arch/arm64/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1515f6f153a0..0da551828a59 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1804,11 +1804,11 @@ config RANDOMIZE_BASE
 	  If unsure, say N.
 
 config RANDOMIZE_MODULE_REGION_FULL
-	bool "Randomize the module region over a 4 GB range"
+	bool "Randomize the module region over a 2 GB range"
 	depends on RANDOMIZE_BASE
 	default y
 	help
-	  Randomizes the location of the module region inside a 4 GB window
+	  Randomizes the location of the module region inside a 2 GB window
 	  covering the core kernel. This way, it is less likely for modules
 	  to leak information about the location of core kernel data structures
 	  but it does imply that function calls between modules and the core
-- 
2.17.1

