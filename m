Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC0D2DCD76
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 09:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbgLQIPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 03:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbgLQIPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 03:15:20 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F04C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 00:14:40 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id h186so8069893pfe.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 00:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uic0sPnjltV6E0cMnK22j2cm6zgIKdt7EkdgU+VE/XU=;
        b=UPKHUKx9m2ZFBG9BqyaObq47RqjgLlSuzIjk58fzVdZso912+DZ9VxOotJpTcoH9kd
         YoVHoR+xfL+95UeuTUo81tyBl0i4Y40FE9YPZkMoloBCBixh58flqJWAIBL4d/w05paA
         ouc0JNq3Fr6rlaeSrtx45k/b5wVIPSQoaLOJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uic0sPnjltV6E0cMnK22j2cm6zgIKdt7EkdgU+VE/XU=;
        b=AFyzgRurZMZnkHbk9ROHwlwYEurQc/p0oY+dfkWZCmXXCNBf6PrM1TxZfSddCACYWp
         tpMPaR5m1w+OuFRae12pv4lABbETKCDhVlk6tmG4t/nng72OHcm+eDhWJSZcOenD47ZT
         1pXZ2W3IzoEszKqwUhn+kzwWxWl3pbP3/x2yiOT7iI1A7+NgqSAhImoqv075doEd65DB
         Q4T8LOVDB8vt8hfDk7SnBLBMKiQN/tDJQgNmMhV/62ylKt7lNgIDaEwTWTmojM23BGhB
         smTCZv1utWudWIcDfjPiFtNx/32K3QC1/XGAbImM3t4vJDHK13kD5v2qwuVhtsyJePM1
         fxTA==
X-Gm-Message-State: AOAM533fk87ZsTYOOSDfbk1SyQ9lXUPdz6FNSAa3wLDudXO1YgICWjqu
        Ys5sr0Tohx5Ku1RfstB+Ss/6Ag==
X-Google-Smtp-Source: ABdhPJwSk50H6Lvx/nwm26SnoSqfJd+YnFbSO5l5IIXmXBxVwNpLd8t7SYr5Ae5EktT3JBu1/7J/Jw==
X-Received: by 2002:a63:8f19:: with SMTP id n25mr12803655pgd.17.1608192879725;
        Thu, 17 Dec 2020 00:14:39 -0800 (PST)
Received: from kafuu-chino.c.googlers.com.com (105.219.229.35.bc.googleusercontent.com. [35.229.219.105])
        by smtp.googlemail.com with ESMTPSA id e24sm4224686pjt.16.2020.12.17.00.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 00:14:38 -0800 (PST)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] platform/chrome: cros_ec: Add host command to keep AP off after EC reset.
Date:   Thu, 17 Dec 2020 16:14:19 +0800
Message-Id: <20201217081423.896862-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add command to EC_CMD_REBOOT_EC to reset EC but don't boot AP.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>

---

The corresponding changes in ChromeOS EC firmware is at crrev.com/c/2428361

---
 include/linux/platform_data/cros_ec_commands.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index a3a9a878415f..b80a4a7038e4 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -4729,6 +4729,7 @@ enum ec_reboot_cmd {
 	EC_REBOOT_DISABLE_JUMP = 5,  /* Disable jump until next reboot */
 	EC_REBOOT_HIBERNATE = 6,     /* Hibernate EC */
 	EC_REBOOT_HIBERNATE_CLEAR_AP_OFF = 7, /* and clears AP_OFF flag */
+	EC_REBOOT_COLD_AP_OFF = 8,   /* Cold-reboot and don't boot AP */
 };
 
 /* Flags for ec_params_reboot_ec.reboot_flags */

base-commit: accefff5b547a9a1d959c7e76ad539bf2480e78b
-- 
2.29.2.684.gfbc64c5ab5-goog

