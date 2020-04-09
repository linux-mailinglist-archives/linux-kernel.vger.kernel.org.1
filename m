Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCDE1A3143
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 10:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgDIIwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 04:52:36 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56882 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725783AbgDIIwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 04:52:35 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6385CDAECBD1790F8FE7;
        Thu,  9 Apr 2020 16:52:20 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Thu, 9 Apr 2020
 16:52:14 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] virtio-balloon: make virtballoon_free_page_report() static
Date:   Thu, 9 Apr 2020 16:50:47 +0800
Message-ID: <20200409085047.45483-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warning:

drivers/virtio/virtio_balloon.c:168:5: warning: symbol
'virtballoon_free_page_report' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/virtio/virtio_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 0ef16566c3f3..8c964b3eebdf 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -165,7 +165,7 @@ static void tell_host(struct virtio_balloon *vb, struct virtqueue *vq)
 
 }
 
-int virtballoon_free_page_report(struct page_reporting_dev_info *pr_dev_info,
+static int virtballoon_free_page_report(struct page_reporting_dev_info *pr_dev_info,
 				   struct scatterlist *sg, unsigned int nents)
 {
 	struct virtio_balloon *vb =
-- 
2.17.2

