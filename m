Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8E22CB8CC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 10:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbgLBJ1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 04:27:32 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9091 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbgLBJ1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 04:27:31 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CmD9R4kk2zLyXN;
        Wed,  2 Dec 2020 17:26:03 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Wed, 2 Dec 2020 17:26:34 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH drm/hisilicon v2 0/3] Add the new api to install irq
Date:   Wed, 2 Dec 2020 17:26:49 +0800
Message-ID: <1606901212-8214-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

patch #1 is code refactorings to use devm_drm_dev_alloc.
patch #2 add the new api to install irq, patch #3 is hibmc driver uses
the newly added api to register interrupts.

Changes since v1:
The devm_drm_irq_install function returns devm_add_action_or_reset directly
without checking that devm_add_action_or_reset returns the correct value.

Tian Tao (3):
  drm/hisilicon: Code refactoring for hibmc_drm_drv
  drm/irq: Add the new api to install irq
  drm/hisilicon: Use the new api devm_drm_irq_install

 drivers/gpu/drm/drm_irq.c                        | 32 +++++++++++++++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c   |  2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c  | 51 ++++++++++--------------
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h  |  4 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c |  2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c      |  8 ++--
 include/drm/drm_irq.h                            |  2 +-
 7 files changed, 64 insertions(+), 37 deletions(-)

-- 
2.7.4

