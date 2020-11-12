Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2578E2B0F05
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 21:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgKLU1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 15:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgKLU1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 15:27:17 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A393C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 12:27:01 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id u12so165619wrt.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 12:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=I417kPjIaH5sJYe4glgDdNsJcOsQo07zhXmT2kj18Sc=;
        b=s1i+thpWCHKjLMBBUMSpSN1RRegTItOcJgyrmbxNyK0l5eYPxP9nH7xJbo9w327Cf5
         +7NL6tPK2hSORWE3j1Sf24NcCZwp3EpupN4N727uGpNdEQv4RTnuLtn4uwToXdFxRpMv
         nj06QLolM/ROGcUbSxl9OMewP8kU8a7+YcUFelKda+Wa9rv/NNu5sPV3tk7J5qeOMWfs
         jnAVKXaY4GT5lZFdNYvviR/R2bg5tgREWcMCqaUkw/tLXygO0lrU1MKZy5ZDKXj9pWPH
         9A217YU+zLvh51S+IAZD7v6CUBirYnyRnVj9SjB3/av1OXwSmf7evzFbQpORtebRoKdG
         Au5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I417kPjIaH5sJYe4glgDdNsJcOsQo07zhXmT2kj18Sc=;
        b=fzyx3IXf+yGOkGrYrQzOrETueIGACXDpAvJ2F26Bt4uaBdVw0t++o2knPruktsVCVP
         wmoaVGQnzGdQddEuVXqwEJZPneEnhyA6VMwlSXb/ZmkIFeOru9HMVRcIiSVFc1pIMUBl
         s0tUpUJ5rGEeihf7VdAHxx69lLG3O/x2eMI8r+yg05QOeHPu0t13EKU7UE0Jkp2MpSRl
         shRcPeIoatqMXexuiOMgF1iVmEkmFt4VgXY/Ks5VbKwVqo1EEcOE/bcga5mmcWDkekhS
         kOaDd5BxZjQnqb5IlMgX3ZiOeQPp0Lmj3idn92viWeIQVSq69SAZPy5D71fttZ7HigD3
         lClg==
X-Gm-Message-State: AOAM533mPiKOiUC8xx9Lmyz7QDdCIpxztGqZhl+P0XKw4IUceK+o1AKz
        HR7QWGMPLJIRTDY0dTtAz6SfpQ==
X-Google-Smtp-Source: ABdhPJxD9OByGgZj1peDNF9gNS5XGf5YeQ4nNMKgvwunTjflZxWfMWX72t9wYplXqWmmLJIN5lAQYA==
X-Received: by 2002:a5d:5701:: with SMTP id a1mr1509945wrv.120.1605212820243;
        Thu, 12 Nov 2020 12:27:00 -0800 (PST)
Received: from localhost.localdomain ([163.172.76.58])
        by smtp.googlemail.com with ESMTPSA id e5sm6935572wrs.84.2020.11.12.12.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 12:26:59 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     mripard@kernel.org, jernej.skrabec@siol.net, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] ARM: configs: sunxi: enable Realtek PHY
Date:   Thu, 12 Nov 2020 20:26:52 +0000
Message-Id: <20201112202652.27676-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lot of sunxi boards has a Realtek PHY, so let's enable it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm/configs/sunxi_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 244126172fd6..05f7f4ed8ded 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -51,6 +51,7 @@ CONFIG_STMMAC_ETH=y
 # CONFIG_NET_VENDOR_VIA is not set
 # CONFIG_NET_VENDOR_WIZNET is not set
 CONFIG_MICREL_PHY=y
+CONFIG_REALTEK_PHY=y
 # CONFIG_WLAN is not set
 CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_SUN4I_LRADC=y
-- 
2.26.2

