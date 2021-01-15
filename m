Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C90B2F7C35
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 14:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731753AbhAONLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 08:11:55 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41806 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732537AbhAONJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 08:09:55 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1l0Oqm-0001DP-5Q; Fri, 15 Jan 2021 13:09:12 +0000
From:   Colin King <colin.king@canonical.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sumera Priyadarsini <sylphrenadin@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/vkms: Fix missing kmalloc allocation failure check
Date:   Fri, 15 Jan 2021 13:09:11 +0000
Message-Id: <20210115130911.71073-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the kmalloc allocation for config is not being null
checked and could potentially lead to a null pointer dereference.
Fix this by adding the missing null check.

Addresses-Coverity: ("Dereference null return value")
Fixes: 2df7af93fdad ("drm/vkms: Add vkms_config type")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/vkms/vkms_drv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 708f7f54001d..2173b82606f6 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -188,7 +188,11 @@ static int vkms_create(struct vkms_config *config)
 
 static int __init vkms_init(void)
 {
-	struct vkms_config *config = kmalloc(sizeof(*config), GFP_KERNEL);
+	struct vkms_config *config;
+
+	config = kmalloc(sizeof(*config), GFP_KERNEL);
+	if (!config)
+		return -ENOMEM;
 
 	default_config = config;
 
-- 
2.29.2

