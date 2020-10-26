Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACE0299730
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 20:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgJZTlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 15:41:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbgJZTlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 15:41:17 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2380F20760;
        Mon, 26 Oct 2020 19:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603741276;
        bh=uy/Dd88vKPnPfb5LV8zDZKHQiy07h3pNTguOKFJpBdI=;
        h=From:To:Cc:Subject:Date:From;
        b=DIcusht26pawNI4TxAoolmq4mmWZTDn2U2FCjskbQl7Zjaeih5EGLOlghAy2ks4tV
         ZG9+SXQJ2e0AUxWpIdp9D9lBkHIPYxM64wU8XHZ1VIGIh2jcL9UfrFT1Ls+XcqlMuF
         +/oi+5rG84fIyxQ55mUkvb1d5Fo3OTIhZBuqQrDM=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jyri Sarha <jsarha@ti.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emil Velikov <emil.velikov@collabora.com>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] drm/tilcdc: avoid 'make W=2' build failure
Date:   Mon, 26 Oct 2020 20:41:01 +0100
Message-Id: <20201026194110.3817470-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The -Wmissing-field-initializer warning when building with W=2
turns into an error because tilcdc is built with -Werror:

drm/tilcdc/tilcdc_drv.c:431:33: error: missing field 'data' initializer [-Werror,-Wmissing-field-initializers] { "regs", tilcdc_regs_show, 0 },
drm/tilcdc/tilcdc_drv.c:432:33: error: missing field 'data' initializer [-Werror,-Wmissing-field-initializers] { "mm",   tilcdc_mm_show,   0 },

Add the missing field initializers to address the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/tilcdc/tilcdc_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index 4f5fc3e87383..754a66051a21 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -428,8 +428,8 @@ static int tilcdc_mm_show(struct seq_file *m, void *arg)
 }
 
 static struct drm_info_list tilcdc_debugfs_list[] = {
-		{ "regs", tilcdc_regs_show, 0 },
-		{ "mm",   tilcdc_mm_show,   0 },
+		{ "regs", tilcdc_regs_show, 0, NULL },
+		{ "mm",   tilcdc_mm_show,   0, NULL },
 };
 
 static void tilcdc_debugfs_init(struct drm_minor *minor)
-- 
2.27.0

