Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A17E2CA1F4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 13:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388974AbgLAL4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 06:56:25 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8170 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbgLAL4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 06:56:24 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ClgX42jrnz15Vb1;
        Tue,  1 Dec 2020 19:55:16 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Tue, 1 Dec 2020 19:55:36 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH drm/hisilicon v2 0/4] Add the new api to install irq 
Date:   Tue, 1 Dec 2020 19:55:50 +0800
Message-ID: <1606823754-52451-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

patch #1 is code refactorings to use devm_drm_irq_install.
patch #2 add the new api to install irq, patch #3 is hibmc driver uses
the newly added api to register interrupts.

Changes since v1:
Splits the original patch #1 into two patches,rewrite
to_hibmc_drm_private() function in patch #2.Fix the
comment error in patch #3, and use
devm_add_action_or_reset instead of devm_add_action.

Tian Tao (4):
  drm/hisilicon: Assgin local variable to drm_device
  drm/hisilicon: Code refactoring for hibmc_drm_drv
  drm/irq: Add the new api to install irq
  drm/hisilicon: Use the new api devm_drm_irq_install

 drivers/gpu/drm/drm_irq.c                        | 35 ++++++++++++++++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c   |  2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c  | 51 ++++++++++--------------
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h  |  4 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c |  2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c      |  8 ++--
 include/drm/drm_irq.h                            |  2 +-
 7 files changed, 67 insertions(+), 37 deletions(-)

-- 
2.7.4

