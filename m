Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB941E4D65
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 20:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgE0SvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 14:51:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgE0SvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 14:51:03 -0400
Received: from localhost.localdomain (unknown [194.230.155.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA0F92073B;
        Wed, 27 May 2020 18:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590605462;
        bh=NeNZBBEpgBxdxxRtK3QlUSh2OafwupclBD2H93fxlf8=;
        h=From:To:Cc:Subject:Date:From;
        b=FNpWQuggYB7TKKQg9sx2bJ+sLFLIcXuhOaETAqndqCIj3dDS+lCXX/cnxEXsYzB45
         /PPI7ECyG+9tM3n981KGYBnhBLsV7t3DvavPW9iqcdLgqo3syZfeULmpYcmA2Eg3gN
         0VCoKZ5lf9zQ5bU/ceOIa+ZxdkD3youU1/TmJmJk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RESEND PATCH] config: android: Remove left-over BACKLIGHT_LCD_SUPPORT
Date:   Wed, 27 May 2020 20:50:57 +0200
Message-Id: <20200527185057.13223-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CONFIG_BACKLIGHT_LCD_SUPPORT was removed in commit
8c5dc8d9f19c ("video: backlight: Remove useless BACKLIGHT_LCD_SUPPORT
kernel symbol"). Options protected by CONFIG_BACKLIGHT_LCD_SUPPORT are
now available directly.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 kernel/configs/android-recommended.config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/configs/android-recommended.config b/kernel/configs/android-recommended.config
index 81e9af7dcec2..c51f4c221ad6 100644
--- a/kernel/configs/android-recommended.config
+++ b/kernel/configs/android-recommended.config
@@ -7,7 +7,6 @@
 # CONFIG_PM_WAKELOCKS_GC is not set
 # CONFIG_VT is not set
 CONFIG_ARM64_SW_TTBR0_PAN=y
-CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_BLK_DEV_DM=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
-- 
2.17.1

