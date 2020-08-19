Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4816249D85
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 14:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgHSMJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 08:09:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728185AbgHSLrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 07:47:16 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5095422CAD;
        Wed, 19 Aug 2020 11:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597837582;
        bh=o+dPk81+NMDdJSOsQwMp59v7Nb6GFnjf15Zj5YFTNyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pxTMjf6viao+UPOT3FObbISMahb7HiZubwoMpjhYHlgFLC1S3o0d8cWuYsx5i4SWq
         5hx25kaLQqM8powYJVX//5OdWTui8WxYAUhJqVkpzKN3bJ11MoCOvQP3G8Kq5yU0IX
         9MhZQ2Q1Eizc8S5mmUdVS1mc+dS2HvaLjZfbD0RI=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k8MXs-00Euan-6z; Wed, 19 Aug 2020 13:46:20 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Liwei Cai <cailiwei@hisilicon.com>,
        Xiubin Zhang <zhangxiubin1@huawei.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        Liuyao An <anliuyao@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 20/49] staging: hikey9xx/gpu: get rid of ION headers
Date:   Wed, 19 Aug 2020 13:45:48 +0200
Message-Id: <322525a4e4cd9d594cfaf003d11fa100e813c6bc.1597833138.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597833138.git.mchehab+huawei@kernel.org>
References: <cover.1597833138.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is not used anymore on this version, so let's get rid
of them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/gpu/kirin960_dpe_reg.h | 3 ---
 drivers/staging/hikey9xx/gpu/kirin970_dpe_reg.h | 3 ---
 drivers/staging/hikey9xx/gpu/kirin9xx_drm_drv.h | 2 --
 3 files changed, 8 deletions(-)

diff --git a/drivers/staging/hikey9xx/gpu/kirin960_dpe_reg.h b/drivers/staging/hikey9xx/gpu/kirin960_dpe_reg.h
index 995ab8f7c9f4..a0f7732063a3 100644
--- a/drivers/staging/hikey9xx/gpu/kirin960_dpe_reg.h
+++ b/drivers/staging/hikey9xx/gpu/kirin960_dpe_reg.h
@@ -27,9 +27,6 @@
 #include <drm/drm_plane.h>
 #include <drm/drm_crtc.h>
 
-#include <linux/ion.h>
-#include <linux/hisi/hisi_ion.h>
-
 #define FB_ACCEL_HI62xx 	0x1
 #define FB_ACCEL_HI363x 	0x2
 #define FB_ACCEL_HI365x 	0x4
diff --git a/drivers/staging/hikey9xx/gpu/kirin970_dpe_reg.h b/drivers/staging/hikey9xx/gpu/kirin970_dpe_reg.h
index ece49b99dca7..84293d2d462e 100644
--- a/drivers/staging/hikey9xx/gpu/kirin970_dpe_reg.h
+++ b/drivers/staging/hikey9xx/gpu/kirin970_dpe_reg.h
@@ -27,9 +27,6 @@
 #include <drm/drm_plane.h>
 #include <drm/drm_crtc.h>
 
-#include <linux/ion.h>
-#include <linux/hisi/hisi_ion.h>
-
 #define FB_ACCEL_HI62xx 	0x1
 #define FB_ACCEL_HI363x 	0x2
 #define FB_ACCEL_HI365x 	0x4
diff --git a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_drv.h b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_drv.h
index 15ef96840e9f..b704f025d64b 100644
--- a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_drv.h
+++ b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_drv.h
@@ -17,8 +17,6 @@
 #include <drm/drm_print.h>
 
 #include <linux/iommu.h>
-#include <linux/ion.h>
-#include <linux/hisi/hisi_ion.h>
 #include <linux/hisi/hisi-iommu.h>
 
 #define MAX_CRTC	2
-- 
2.26.2

