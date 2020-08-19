Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F5624994A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 11:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgHSJ0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 05:26:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43826 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726110AbgHSJZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 05:25:51 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 022F5165376BB3DC0107;
        Wed, 19 Aug 2020 17:25:48 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Wed, 19 Aug 2020 17:25:39 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH drm/hisilicon v2 0/4] Use drm_err instead of DRM_ERROR in hibmc driver
Date:   Wed, 19 Aug 2020 17:23:30 +0800
Message-ID: <1597829014-39942-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

patch #1 is using the drm_err instead of DRM_ERROR in hibmc_ttm.c
patch #2 is using the drm_err instead of DRM_ERROR in hibmc_drm_vdac.c
patch #3 is using the drm_err and drm_dbg_atomic instead of DRM_ERROR
and DRM_DEBUG_ATOMIC in hibmc_drm_de.c
patch #4 is using the drm_err and drm_warn instead of DRM_ERROR and
DRM_WARN in hibmc_drm_drv.c

Changes since v1:
-Fixed spelling errors in patch name.

Tian Tao (4):
  drm/hisilicon: Use drm_err instead of DRM_ERROR in hibmc_ttm
  drm/hisilicon: Use drm_err instead of DRM_ERROR in hibmc_drm_vdac
  drm/hisilicon: Use drm_err instead of DRM_ERROR in hibmc_drm_de
  drm/hisilicon: Use drm_err instead of DRM_ERROR in hibmc_drm_drv

 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c   | 14 +++++++-------
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c  | 24 ++++++++++++------------
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c |  4 ++--
 drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c      |  2 +-
 4 files changed, 22 insertions(+), 22 deletions(-)

-- 
2.7.4

