Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E7D28FC20
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 02:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388471AbgJPAhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 20:37:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55972 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388280AbgJPAhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 20:37:53 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 43A1052D9A770CB9D9E9;
        Fri, 16 Oct 2020 08:37:50 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 16 Oct 2020 08:37:45 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH drm/hisilicon v3 0/2] Use the same style of variable type 
Date:   Fri, 16 Oct 2020 08:38:29 +0800
Message-ID: <1602808711-65193-1-git-send-email-tiantao6@hisilicon.com>
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

Changes since v2:
-Modify the type of fb_base and fb_size to resource_size_t. 

Tian Tao (2):
  drm/hisilicon: Use the same style of variable type in hibmc_drm_de
  drm/hisilicon: Use the same style of variable type in hibmc_drm_drv

 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c  | 59 ++++++++++++-------------
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 13 +++---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h |  8 ++--
 3 files changed, 39 insertions(+), 41 deletions(-)

-- 
2.7.4

