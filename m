Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B184216DED
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 15:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgGGNkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 09:40:25 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49294 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728182AbgGGNkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 09:40:25 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A2A2DC32DFB5654FB671;
        Tue,  7 Jul 2020 21:40:22 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Tue, 7 Jul 2020
 21:40:14 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <richard@nod.at>, <yi.zhang@huawei.com>, <s.hauer@pengutronix.de>
Subject: [PATCH v3 0/2] ubi: fastmap: Produce and release fm_anchor peb correctly
Date:   Tue, 7 Jul 2020 21:40:59 +0800
Message-ID: <20200707134101.562776-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 -> v2:
  Adapt Sascha's suggestions for fm_diabled checking in __erase_worker().
v2 -> v3:
  Free fm_anchor peb during cloing fastmap.

Zhihao Cheng (2):
  ubi: fastmap: Don't produce the initial next anchor PEB when fastmap
    is disabled
  ubi: fastmap: Free fastmap next anchor peb during detach

 drivers/mtd/ubi/fastmap-wl.c | 5 +++++
 drivers/mtd/ubi/wl.c         | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.25.4

