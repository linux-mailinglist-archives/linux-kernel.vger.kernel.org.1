Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E4E262F19
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 15:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730307AbgIINV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 09:21:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47366 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730236AbgIINSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 09:18:43 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 65E8EBEA3453F427F1BC;
        Wed,  9 Sep 2020 21:00:33 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Wed, 9 Sep 2020
 21:00:25 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH -next 0/8] drm/amd/amdgpu: fix comparison pointer to bool warning
Date:   Wed, 9 Sep 2020 21:07:12 +0800
Message-ID: <20200909130720.105234-1-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zheng Bin (8):
  drm/amd/amdgpu: fix comparison pointer to bool warning in gfx_v9_0.c
  drm/amd/amdgpu: fix comparison pointer to bool warning in gfx_v10_0.c
  drm/amd/amdgpu: fix comparison pointer to bool warning in sdma_v5_0.c
  drm/amd/amdgpu: fix comparison pointer to bool warning in sdma_v5_2.c
  drm/amd/amdgpu: fix comparison pointer to bool warning in si.c
  drm/amd/amdgpu: fix comparison pointer to bool warning in uvd_v6_0.c
  drm/amd/amdgpu: fix comparison pointer to bool warning in
    amdgpu_atpx_handler.c
  drm/amd/amdgpu: fix comparison pointer to bool warning in sdma_v4_0.c

 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c           | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c            | 2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c           | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c           | 2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c           | 2 +-
 drivers/gpu/drm/amd/amdgpu/si.c                  | 2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c            | 4 ++--
 8 files changed, 11 insertions(+), 11 deletions(-)

--
2.26.0.106.g9fadedd

