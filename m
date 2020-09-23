Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9033027553B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 12:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgIWKKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 06:10:53 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39434 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726424AbgIWKKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 06:10:51 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E522033E7639331DE340;
        Wed, 23 Sep 2020 18:10:47 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Wed, 23 Sep 2020 18:10:36 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <linux-accelerators@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangfei.gao@linaro.org>
CC:     Kai Ye <yekai13@huawei.com>
Subject: [PATCH v3 0/2] uacce: fix some coding styles
Date:   Wed, 23 Sep 2020 18:09:20 +0800
Message-ID: <1600855762-10031-1-git-send-email-yekai13@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. delete some redundant code.
2. modify the module author information. "Hisilicon"
spelling is error.

Changes v2 -> v3:
	Two things, splited to two patches.
Changes v1 -> v2:
	deleted extra NULL pointer check in uacce_fops.

Kai Ye (2):
  uacce: fix some coding styles
  uacce: modify the module author information.

 drivers/misc/uacce/uacce.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

-- 
2.8.1

