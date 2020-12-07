Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A122D0C9D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgLGJFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:05:34 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9021 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgLGJFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:05:32 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CqHS71CKwzhnj3;
        Mon,  7 Dec 2020 17:04:23 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Dec 2020 17:04:51 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH drm/hisilicon v2 0/2] Code refactoring
Date:   Mon, 7 Dec 2020 17:05:04 +0800
Message-ID: <1607331906-19005-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

patch #1 is used drmm_mode_config_init() to do code refactoring.
patch #2 is deleted unused variable ‘priv’ to avoid warning.

Changes since v1:
Remove the unused structure member variable mode_config_initialized.

Tian Tao (2):
  drm/hisilicon: Use managed mode-config init
  drm/hisilicon: Delete unused local parameters

 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 19 ++++---------------
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h |  1 -
 2 files changed, 4 insertions(+), 16 deletions(-)

-- 
2.7.4

