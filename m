Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8DFB27425C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 14:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgIVMrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 08:47:13 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14213 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726605AbgIVMrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 08:47:06 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7C254AA28BC1671FAC51;
        Tue, 22 Sep 2020 20:47:03 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Tue, 22 Sep 2020 20:46:56 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH drm/hisilicon v3 0/2] support reading resolutions from EDID 
Date:   Tue, 22 Sep 2020 20:44:28 +0800
Message-ID: <1600778670-60370-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

patch #1 add a new file to implements i2c adapters, #2 read the
resolution from the edid, if that fails, set the resolution to fixed.
and update the destroy callback function to release the i2c adapters

Changes since v1:
-merge patch #3 into patch #2.
-add new function to_hibmc_drm_private, modify three functions in
hibmc_drm_i2c.c with the newly added function.
-deleting the member variable dev from the structure hibmc_connector.
-modify print log incorrectly.
-Modify hibmc_connector_get_modes.

Changes since v2:
-rewrite the function to_hibmc_drm_private, and rename GPIO_SCL_MASK
to I2C_SCL_MASK

Tian Tao (2):
  drm/hisilicon: Support i2c driver algorithms for bit-shift adapters
  drm/hisilicon: Features to support reading resolutions from EDID

 drivers/gpu/drm/hisilicon/hibmc/Makefile         |  2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h  | 25 +++++-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c  | 99 ++++++++++++++++++++++++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c | 38 ++++++++-
 4 files changed, 158 insertions(+), 6 deletions(-)
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c

-- 
2.7.4

