Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64842CE4FE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 02:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbgLDBX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 20:23:57 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9000 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbgLDBXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 20:23:48 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CnFLk5RBvzhmDb;
        Fri,  4 Dec 2020 09:22:38 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Fri, 4 Dec 2020 09:23:03 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH drm/hisilicon 0/3] support reading resolutions from EDID 
Date:   Fri, 4 Dec 2020 09:23:06 +0800
Message-ID: <1607044999-47666-1-git-send-email-tiantao6@hisilicon.com>
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
patch #3 update the destroy callback function to release the i2c adapters.

Tian Tao (3):
  drm/hisilicon: Support i2c driver algorithms for bit-shift adapters
  drm/hisilicon: Features to support reading resolutions from EDID
  drm/hisilicon: Releasing Resources in the Destroy callback Function

 drivers/gpu/drm/hisilicon/hibmc/Makefile         |  2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h  | 21 ++++-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c  | 98 ++++++++++++++++++++++++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c | 45 +++++++++--
 4 files changed, 157 insertions(+), 9 deletions(-)
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c

-- 
2.7.4

