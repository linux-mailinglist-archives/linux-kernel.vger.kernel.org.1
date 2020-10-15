Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C7828EEDE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 10:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388476AbgJOI7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 04:59:49 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15296 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388330AbgJOI7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 04:59:43 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DD6D9D8C0D2F40740CF0;
        Thu, 15 Oct 2020 16:59:38 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 15 Oct 2020 16:59:29 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH drm/hisilicon v2 0/2] Use the same style of variable type
Date:   Thu, 15 Oct 2020 17:00:15 +0800
Message-ID: <1602752417-20598-1-git-send-email-tiantao6@hisilicon.com>
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

Changes since v1:
-Change part of unsigned int to size_t.

Tian Tao (2):
  drm/hisilicon: Use the same style of variable type in hibmc_drm_de
  drm/hisilicon: Use the same style of variable type in hibmc_drm_drv

 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c  | 59 ++++++++++++-------------
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 13 +++---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h |  8 ++--
 3 files changed, 39 insertions(+), 41 deletions(-)

-- 
2.7.4

