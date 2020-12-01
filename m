Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964152CA319
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 13:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390324AbgLAMru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 07:47:50 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8545 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbgLAMru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 07:47:50 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ClhgP6VQszhl3X;
        Tue,  1 Dec 2020 20:46:41 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Tue, 1 Dec 2020 20:47:01 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH 0/3] drm/rockchip: fix reference leak when pm_runtime_get_sync fails
Date:   Tue, 1 Dec 2020 20:54:56 +0800
Message-ID: <20201201125459.142178-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_runtime_get_sync will increment the PM reference count
even failed. Forgetting to putting operation will result
in a reference leak here. 

Replace it with pm_runtime_resume_and_get to keep usage
counter balanced. 

BTW, pm_runtime_resume_and_get is introduced in v5.10-rc5 as
dd8088d5a896 ("PM: runtime: Add  pm_runtime_resume_and_get
to dealwith usage counter")

Qinglang Miao (3):
  drm/rockchip: cdn-dp: fix reference leak when pm_runtime_get_sync
    fails
  drm/rockchip: vop: fix reference leak when pm_runtime_get_sync fails
  drm/rockchip: lvds: fix reference leak when pm_runtime_get_sync fails

 drivers/gpu/drm/rockchip/cdn-dp-core.c      | 2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 4 ++--
 drivers/gpu/drm/rockchip/rockchip_lvds.c    | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.23.0

