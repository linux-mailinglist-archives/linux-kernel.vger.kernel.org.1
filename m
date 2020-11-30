Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04482C859D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgK3NhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:37:16 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8535 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgK3NhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:37:14 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Cl5pv3L5NzhkhQ;
        Mon, 30 Nov 2020 21:36:07 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Mon, 30 Nov 2020 21:36:25 +0800
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
Subject: [PATCH 0/3] drm/rockchip: fix reference leak of pm_runtime_get_sync
Date:   Mon, 30 Nov 2020 21:44:24 +0800
Message-ID: <20201130134427.57545-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace pm_runtime_get_sync with pm_runtime_resume_and_get to keep usage
counter balanced. 

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

