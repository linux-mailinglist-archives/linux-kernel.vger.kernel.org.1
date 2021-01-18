Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20ADF2F970C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 02:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730670AbhARBBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 20:01:55 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:11397 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730534AbhARA67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 19:58:59 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DJtfZ3209z7Tv2;
        Mon, 18 Jan 2021 08:57:10 +0800 (CST)
Received: from huawei.com (10.175.112.125) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Mon, 18 Jan 2021
 08:58:13 +0800
From:   Yue Zou <zouyue3@huawei.com>
To:     <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] vgaarb: Remove unneeded semicolons
Date:   Mon, 18 Jan 2021 01:03:55 +0000
Message-ID: <20210118010356.214491-1-zouyue3@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove superfluous semicolons after function definitions.

Signed-off-by: Yue Zou <zouyue3@huawei.com>
---
 include/linux/vgaarb.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/vgaarb.h b/include/linux/vgaarb.h
index 977caf96c8d2..fc6dfeba04a5 100644
--- a/include/linux/vgaarb.h
+++ b/include/linux/vgaarb.h
@@ -121,9 +121,9 @@ extern struct pci_dev *vga_default_device(void);
 extern void vga_set_default_device(struct pci_dev *pdev);
 extern int vga_remove_vgacon(struct pci_dev *pdev);
 #else
-static inline struct pci_dev *vga_default_device(void) { return NULL; };
-static inline void vga_set_default_device(struct pci_dev *pdev) { };
-static inline int vga_remove_vgacon(struct pci_dev *pdev) { return 0; };
+static inline struct pci_dev *vga_default_device(void) { return NULL; }
+static inline void vga_set_default_device(struct pci_dev *pdev) { }
+static inline int vga_remove_vgacon(struct pci_dev *pdev) { return 0; }
 #endif
 
 /*
-- 
2.25.1

