Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E6B2432E7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 05:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgHMDlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 23:41:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9799 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726078AbgHMDla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 23:41:30 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3436B93DFA66B6139B24;
        Thu, 13 Aug 2020 11:41:27 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Thu, 13 Aug 2020 11:41:17 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH] drm/hisilicon: Fix build error of no type of module_init
Date:   Thu, 13 Aug 2020 11:39:15 +0800
Message-ID: <1597289955-27381-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing include to fix build error:
hibmc_drm_drv.c:385:1: warning: data definition has no type or storage
class [enabled by default]
hibmc_drm_drv.c:385:1: error: type defaults to ‘int’ in declaration
of ‘module_init’ [-Werror=implicit-int]
hibmc_drm_drv.c:385:1: warning: parameter names (without types) in function
of ‘module_exit’ [-Werror=implicit-int]
hibmc_drm_drv.c:385:292:1: warning: parameter names (without types) in
function declaration [enabled by default]

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 1ae360d..2b4f821 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -11,6 +11,7 @@
  *	Jianhua Li <lijianhua@huawei.com>
  */
 
+#include <linux/module.h>
 #include <linux/pci.h>
 
 #include <drm/drm_atomic_helper.h>
-- 
2.7.4

