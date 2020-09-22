Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42EF1273B68
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 09:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbgIVHG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 03:06:26 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36480 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728526AbgIVHGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 03:06:25 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 690638338FAEC12903A3;
        Tue, 22 Sep 2020 15:06:23 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Tue, 22 Sep 2020 15:06:16 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH drm/hisilicon v2 0/2] support reading resolutions from EDID 
Date:   Tue, 22 Sep 2020 15:03:48 +0800
Message-ID: <1600758230-13389-1-git-send-email-tiantao6@hisilicon.com>
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

Tian Tao (2):
  drm/hisilicon: Support i2c driver algorithms for bit-shift adapters
  drm/hisilicon: Features to support reading resolutions from EDID

 drivers/gpu/drm/hisilicon/hibmc/Makefile         |   2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h  |  28 ++++++-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c  | 100 +++++++++++++++++++++++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c |  40 +++++++--
 4 files changed, 163 insertions(+), 7 deletions(-)
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c

-- 
2.7.4

