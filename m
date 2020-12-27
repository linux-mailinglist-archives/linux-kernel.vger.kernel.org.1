Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298E92E308B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 10:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgL0I60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 03:58:26 -0500
Received: from m15114.mail.126.com ([220.181.15.114]:49669 "EHLO
        m15114.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgL0I6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 03:58:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=m5oVi0TtWHQkthGZkb
        SLeLd7sFG2BGbk2xXapv0duR4=; b=eL7TScYOee7UjWzkvmx0DdVX31cX73QcLX
        9oZZVrlz9cccRKGpRZ0az7Jn4lulbkJuDoUQKzlpdegPmo/ehwTqSZhLto6gRLzj
        +chCXQ4zUAu3vBLFacn/EGx54FjlPGWQ10OQjqjPlT5r0oW9xy5Mn8FMu0nS+mWz
        I1I8cdDhk=
Received: from localhost.localdomain (unknown [36.112.86.14])
        by smtp7 (Coremail) with SMTP id DsmowADX32_DROhf0ypiMg--.29381S2;
        Sun, 27 Dec 2020 16:24:37 +0800 (CST)
From:   Defang Bo <bodefang@126.com>
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Defang Bo <bodefang@126.com>
Subject: [PATCH] drm/radeon:avoid null pointer dereference when dev is not bound
Date:   Sun, 27 Dec 2020 16:24:29 +0800
Message-Id: <1609057469-3844200-1-git-send-email-bodefang@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DsmowADX32_DROhf0ypiMg--.29381S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKryxurWxZFWUKw45ur47XFb_yoWkuwc_uw
        10va4xWaykZwnYqF1Y9F1Ivr9rtFsY9rZ5WFn7ta4fXry7X348ZayUXFyUWr47Wa1UAF90
        vF4vq3ySyrsFgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUgTmDUUUUU==
X-Originating-IP: [36.112.86.14]
X-CM-SenderInfo: pergvwxdqjqiyswou0bp/1tbi6wUI11pD9bQS2AAAsj
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Why]
Similar to commit<0fa375e6>. If the set_state/can_switch code access the drm_device when dev is not bound,
a null pointer dereference can happen.

[How]
Add sanity checks to prevent it.

Signed-off-by: Defang Bo <bodefang@126.com>
---
 drivers/gpu/drm/radeon/radeon_device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
index 266e3cb..50a1a60 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -1224,6 +1224,9 @@ static void radeon_switcheroo_set_state(struct pci_dev *pdev, enum vga_switchero
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
 
+	if (!dev)
+		return;
+
 	if (radeon_is_px(dev) && state == VGA_SWITCHEROO_OFF)
 		return;
 
@@ -1257,6 +1260,9 @@ static void radeon_switcheroo_set_state(struct pci_dev *pdev, enum vga_switchero
 static bool radeon_switcheroo_can_switch(struct pci_dev *pdev)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
+
+	if (!dev)
+		return false;
 
 	/*
 	 * FIXME: open_count is protected by drm_global_mutex but that would lead to
-- 
2.7.4

