Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94879249D5A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 14:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgHSMFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 08:05:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728219AbgHSLrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 07:47:43 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1AD122DBF;
        Wed, 19 Aug 2020 11:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597837582;
        bh=ClOj9yCdunMaS320vDbGtPzjoJaPHr/Jec/oQrO5Wog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MVV06K30OMwQxMR9UYLuS5tjtvikFOPCCbBz4lYgjKxawcw5P+FsTnnDYXWE1i8/+
         6nzftgJ4wBkKmytQS2gjlp7HtmvtUtXbXGozU383UCoq/3B6jb6l7izdb9fJEBOriL
         73tA7qkvRhsEKDdLU6xURH6vvyIUnDu64g/5SiLw=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k8MXs-00EubC-Gf; Wed, 19 Aug 2020 13:46:20 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Xiubin Zhang <zhangxiubin1@huawei.com>,
        Liwei Cai <cailiwei@hisilicon.com>,
        Wanchun Zheng <zhengwanchun@hisilicon.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 29/49] staging: hikey9xx/gpu: add a possible implementation for atomic_disable
Date:   Wed, 19 Aug 2020 13:45:57 +0200
Message-Id: <57af4d50a42f4547344ff0a67bcdc4370dbe6d24.1597833138.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597833138.git.mchehab+huawei@kernel.org>
References: <cover.1597833138.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the method is empty. However, looking at the driver,
it sounds it shouldn't be hard to implement it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c
index e1f2557a6be1..26212c130b79 100644
--- a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c
+++ b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c
@@ -638,7 +638,14 @@ static void dss_plane_atomic_update(struct drm_plane *plane,
 static void dss_plane_atomic_disable(struct drm_plane *plane,
 				     struct drm_plane_state *old_state)
 {
-	//struct dss_plane *aplane = to_dss_plane(plane);
+	// FIXME: Maybe this?
+#if 0
+	struct dss_plane *aplane = to_dss_plane(plane);
+	struct dss_crtc *acrtc = aplane->acrtc;
+
+	disable_ldi(acrtc);
+	hisifb_mctl_sw_clr(acrtc);
+#endif
 }
 
 static const struct drm_plane_helper_funcs dss_plane_helper_funcs = {
-- 
2.26.2

