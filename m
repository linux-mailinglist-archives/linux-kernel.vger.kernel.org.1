Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918FA249D71
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 14:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgHSMIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 08:08:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728200AbgHSLrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 07:47:22 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CBE322D06;
        Wed, 19 Aug 2020 11:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597837582;
        bh=1sNGLXo9ZA3HXNAzNStAdZUhW9U41Rh3Ah+qraORED8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tsJsLql88Y/1AEn2ZXDiOpKhDnxy6ZK1VvV9RNezYwJlTCwxvdyuNHSwe6Z0G/iET
         DmxS4UKEtSqcUTrzBgTXmUIoHrbM9MgEJ/LlUTxq/1TI9HWjHzd41OFEj7Z+clnzqd
         2W2rQKu5MVjOmSkfS7W6QIzugan/dlj3Aib7Aflk=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k8MXs-00Eub5-DV; Wed, 19 Aug 2020 13:46:20 +0200
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
        Chen Feng <puck.chen@hisilicon.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 26/49] staging: hikey9xx/gpu: use default GEM_CMA fops
Date:   Wed, 19 Aug 2020 13:45:54 +0200
Message-Id: <3defe6018773d9882fdf7daf70806cd23ca02cbd.1597833138.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597833138.git.mchehab+huawei@kernel.org>
References: <cover.1597833138.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of implementing it at the code, use the default
methods from CMA helper

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/gpu/kirin9xx_drm_drv.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_drv.c b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_drv.c
index cede6ccc2dd5..44f7c15f386a 100644
--- a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_drv.c
+++ b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_drv.c
@@ -141,19 +141,7 @@ static int kirin_drm_kms_init(struct drm_device *dev)
 	return ret;
 }
 
-static const struct file_operations kirin_drm_fops = {
-	.owner		= THIS_MODULE,
-	.open		= drm_open,
-	.release	= drm_release,
-	.unlocked_ioctl	= drm_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl	= drm_compat_ioctl,
-#endif
-	.poll		= drm_poll,
-	.read		= drm_read,
-	.llseek		= no_llseek,
-	.mmap		= drm_gem_cma_mmap,
-};
+DEFINE_DRM_GEM_CMA_FOPS(kirin_drm_fops);
 
 static int kirin_gem_cma_dumb_create(struct drm_file *file,
 				     struct drm_device *dev,
-- 
2.26.2

