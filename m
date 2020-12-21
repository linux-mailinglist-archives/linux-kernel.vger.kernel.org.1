Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C612DF852
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 05:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgLUElF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 23:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgLUElF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 23:41:05 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1E4C0613D3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 20:40:24 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id s2so10156185oij.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 20:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xnnULIwW3D9/7gynLVL6RNjEWu7HuK6DqtIbPKOAjII=;
        b=ZRj9aP5NtyEyBNLn3pWbj5pAXSKjB5lvw3Rbdyw2V2VIAla0peK/hIt2oUYvt965dr
         qjG5jeAk7v2l62MI68frLHTwMtFM0p32JDYWrutg78DtwouHxCoQlmqueAwHw1DPgttF
         ADrbjZP+5UfenuRZvleL/fpBtUCBIoALHAraQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xnnULIwW3D9/7gynLVL6RNjEWu7HuK6DqtIbPKOAjII=;
        b=KRdNI5Qo3YQv6pbb8u+qb2rIGMzsvnKg892uRrMxLF1zW3rVyc7Eq1lo40dAPPVtw5
         44j82nJWKkx0keDt4tIY6K2eaK9Qj7xY5bBUTOB+J44KujNhyOYA/APlrAV1uWUiRsfc
         ts8MO0m9FitjYxi9SW/tQREtuTx/0JEwuRH9bttJ94YXvzPPy9zUEnnN+ONYxz2enm1T
         ntsImp2CG9+/7jBW1Mcm2wSjmuE6Zg5bgYUOaZRqjJOlifxBT+JQqYMS0NfpHsK64tnu
         AxzbUO2LbtJ5WJD4uKLN6xj/QUYJ78dG0iiz750U17HNxjuD5eRVyXo3p6aBKO+LufS5
         FGXw==
X-Gm-Message-State: AOAM532xZ4s2jHOR6kMrOeOXfAMmV2MpBkNqbteule8ME13ca7YZMoQv
        R7UsPXstNrpujSM12fo1JhP3npmLvf7qP9XC
X-Google-Smtp-Source: ABdhPJziC0/iPQlkGt4ZOx221h/vbiIoJX09aLTIEh4Cba8lLIdEBHb78136aaGnSCw1PzunjpIcSQ==
X-Received: by 2002:a17:90a:5b:: with SMTP id 27mr15395696pjb.207.1608523958288;
        Sun, 20 Dec 2020 20:12:38 -0800 (PST)
Received: from kafuu-chino.c.googlers.com.com (105.219.229.35.bc.googleusercontent.com. [35.229.219.105])
        by smtp.googlemail.com with ESMTPSA id y19sm14823118pfp.211.2020.12.20.20.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Dec 2020 20:12:37 -0800 (PST)
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
Subject: [PATCH v2 1/2] platform/chrome: cros_ec: Add host command to keep AP off after EC reset.
Date:   Mon, 21 Dec 2020 12:12:23 +0800
Message-Id: <20201221041231.14516-1-pihsun@chromium.org>
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

