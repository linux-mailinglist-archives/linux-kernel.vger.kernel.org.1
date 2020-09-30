Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8260127E26A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 09:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgI3HPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 03:15:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38688 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728173AbgI3HPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 03:15:52 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 36EAFF91806FDAD2CB86;
        Wed, 30 Sep 2020 15:15:49 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Wed, 30 Sep 2020 15:15:38 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH drm/hisilicon 0/2] Use the same style of variable type
Date:   Wed, 30 Sep 2020 15:13:06 +0800
Message-ID: <1601449988-41463-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

patch #1 and #2 Use the same style of variable type in hisilicon drm driver
and both are clean up, no actual functional changes.

Tian Tao (2):
  drm/hisilicon: Use the same style of variable type in hibmc_drm_de
  drm/hisilicon: Use the same style of variable type in hibmc_drm_drv

 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c  | 59 ++++++++++++-------------
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 13 +++---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h |  8 ++--
 3 files changed, 39 insertions(+), 41 deletions(-)

-- 
2.7.4

