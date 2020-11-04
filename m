Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7162A697D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 17:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731068AbgKDQZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 11:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731005AbgKDQZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 11:25:07 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90A5C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 08:25:06 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id h62so2892755wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 08:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pzzgIIrLdF8ykN8u3cmmBIEsZtdCUyU67RK6IptSh0I=;
        b=LTaYEiE1iRu0RgzvlDDLlI7NXWBMFl8leMa2AJcx94kVBdqeKoOZg73o3NgB6i5xKE
         QW8+vYVvu65g10XKy2s+CLasqSTL7FsBQ/fAugv1JCZyaRrhl1eJyvnv9T5EFQDkq+Q8
         hqevmPcln8KUaoj0D98n72cGJK81JEs2P1A3rvNSVqrYHK1dLkfMDdz5whaE9u0qjLq3
         KcSrG8Wdw2PpFkLcHPsi6HNsV4pWZ5kM5d4aOBE7vhYRv50uEbVsPUSNYYukoIxZt8YL
         Bf6dqx+6FKzq7vqgr4n1c7GHu2re9sGE47pmCrHgPcm8NLr5Xl+MoAb0kcGmPL+dS1uo
         PArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pzzgIIrLdF8ykN8u3cmmBIEsZtdCUyU67RK6IptSh0I=;
        b=FuGv7L16NF3Ncvz52UJ2tQkSJ3lzUc4ZiOaYkJ0utyTA6iKJB4AdV+73xlKo5G+15F
         L29UyANw4ubey95a2UD0SCTWEjESsOqA1ZfY5kvnHExQ6lAjYjnSxoBX8vkq5cQLD4hH
         E3sO2KBiY3RGr363CvnhWPtoXjE975XBe7Fxtq9FdK8PDn4KEC2scFESJMxEVOfACDgo
         oibZH0ZSX3N0I54Fxv6PFKXxIVHPoIXcGWUlf10oYL3TfeCoatRyKSD6Z8WTqAswj21/
         N/dOVP/Yf9tfzd3QVe2vv7iVyM/Bb6A2jV2OgHuvNbrHWopgD30+ibohZk2GRuucTWDx
         PVnw==
X-Gm-Message-State: AOAM533Hy2Pu9ps8sduY8000Yi0q70pgEI2dLdokkD4kdoTQNRwVm2Ln
        9KwASthFf1lZ2NooJ4aRAKxqvA==
X-Google-Smtp-Source: ABdhPJxKrOSvHcePAUxBziapSUMd6iVGO2PGQTlj2QxxJ8/xho0A9F6lpZwcx365YE5E8QDiS0LVJg==
X-Received: by 2002:a1c:84:: with SMTP id 126mr3537081wma.160.1604507105380;
        Wed, 04 Nov 2020 08:25:05 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id o129sm3008564wmb.25.2020.11.04.08.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:25:04 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kumar G <naveen.gaddipati@stericsson.com>,
        Sundar Iyer <sundar.iyer@stericsson.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 19/20] input: keyboard: nomadik-ske-keypad: Provide some missing struct member docs
Date:   Wed,  4 Nov 2020 16:24:26 +0000
Message-Id: <20201104162427.2984742-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104162427.2984742-1-lee.jones@linaro.org>
References: <20201104162427.2984742-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/input/keyboard/nomadik-ske-keypad.c:71: warning: Function parameter or member 'pclk' not described in 'ske_keypad'
 drivers/input/keyboard/nomadik-ske-keypad.c:71: warning: Function parameter or member 'ske_keypad_lock' not described in 'ske_keypad'

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kumar G <naveen.gaddipati@stericsson.com>
Cc: Sundar Iyer <sundar.iyer@stericsson.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/input/keyboard/nomadik-ske-keypad.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/keyboard/nomadik-ske-keypad.c b/drivers/input/keyboard/nomadik-ske-keypad.c
index 608446e14614d..0d55a95347f16 100644
--- a/drivers/input/keyboard/nomadik-ske-keypad.c
+++ b/drivers/input/keyboard/nomadik-ske-keypad.c
@@ -58,6 +58,8 @@
  * @board:	keypad platform device
  * @keymap:	matrix scan code table for keycodes
  * @clk:	clock structure pointer
+ * @pclk:	clock structure pointer
+ * @ske_keypad_lock: spinlock protecting the keypad read/writes
  */
 struct ske_keypad {
 	int irq;
-- 
2.25.1

