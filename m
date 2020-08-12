Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B543324263E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 09:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgHLHpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 03:45:14 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43192 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726517AbgHLHpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 03:45:13 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EF1D0ACA78552426F5C4;
        Wed, 12 Aug 2020 15:45:10 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Wed, 12 Aug 2020 15:45:00 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH drm/hisilicon v3 0/2] hibmc clean up and code refactoring
Date:   Wed, 12 Aug 2020 15:42:57 +0800
Message-ID: <1597218179-3938-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

patch #1 and #3 is clean up, patch #2 is for code refactoring

Changes since v1:
- Rewrite the commits messages and patch name in #1
- Rewrite the commits message in #2.
- Add the new patch #3

Changes since v2:
- merge patch #3 into patch #2

Tian Tao (2):
  drm/hisilicon: Remove the unused include statements
  drm/hisilicon: Code refactoring for hibmc_drv_de

 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c   | 58 ++++++------------------
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c  |  5 --
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h  |  2 +
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c |  2 -
 4 files changed, 15 insertions(+), 52 deletions(-)

-- 
2.7.4

