Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3074C2DAC63
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 12:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbgLOLuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 06:50:15 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:9447 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbgLOLuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 06:50:00 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CwGjd67mFzhsGB;
        Tue, 15 Dec 2020 19:48:21 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Tue, 15 Dec 2020 19:48:44 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <linux-kernel@vger.kernel.org>
CC:     Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH drm/hisilicon 0/2] Add the new api to enable msi
Date:   Tue, 15 Dec 2020 19:48:51 +0800
Message-ID: <1608032933-50187-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

patch #1 add the new api to enable pci mis.
patch #2 is hibmc driver uses the newly added api to enable msi.

Tian Tao (2):
  drm/irq: Add the new api to enable pci msi
  drm/hisilicon: Use the new api devm_drm_msi_install

 drivers/gpu/drm/drm_irq.c                       | 33 +++++++++++++++++++++++++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c |  3 +--
 include/drm/drm_irq.h                           |  1 +
 3 files changed, 35 insertions(+), 2 deletions(-)

-- 
2.7.4

