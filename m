Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787BA2179C8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 22:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgGGUzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 16:55:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:55410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbgGGUzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 16:55:50 -0400
Received: from localhost.localdomain (unknown [194.230.155.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D45A206F6;
        Tue,  7 Jul 2020 20:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594155349;
        bh=XnF1pN+IJFHwFtadwbx3LPlPCtLa6RG3KhJruPiqXfw=;
        h=From:To:Subject:Date:From;
        b=eX2Dqz90oWR/baZVInWfXYUL6AJemRPPMMWSZCcPqpvAi+OUKUbBArizOeFJfzrzj
         9EZXCwv/uVoGn4Y9BB0wfygq1okSAbWBY1HFNPfD0Chre3KVd+hgOGvgOhABjfVynI
         xaC0Z+0oCEFUp2kUafsFuKx+9/pgORTuhAn3U+OE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Brian Cain <bcain@codeaurora.org>,
        Rob Herring <robh@kernel.org>,
        Richard Kuo <rkuo@codeaurora.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 1/2] config: android: Remove left-over BACKLIGHT_LCD_SUPPORT
Date:   Tue,  7 Jul 2020 22:55:25 +0200
Message-Id: <20200707205526.32649-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CONFIG_BACKLIGHT_LCD_SUPPORT was removed in commit 8c5dc8d9f19c
("video: backlight: Remove useless BACKLIGHT_LCD_SUPPORT kernel
symbol"). Options protected by CONFIG_BACKLIGHT_LCD_SUPPORT are now
available directly.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---

This patchset is not an important cleanup but removes few lines which I
think everyone likes.  I posted it on the list some time ago and wasn't
applied.

Dear Andrew,
Maybe you could pick it up?

Best regards,
Krzysztof


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

