Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A8B256B00
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Aug 2020 03:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbgH3BEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Aug 2020 21:04:52 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:33434 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728246AbgH3BEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 21:04:51 -0400
X-Greylist: delayed 308 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Aug 2020 21:04:51 EDT
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 1E86E1B44E0;
        Sun, 30 Aug 2020 10:04:51 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-20) with ESMTPS id 07U14nYt321827
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 30 Aug 2020 10:04:50 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-20) with ESMTPS id 07U14nL03061478
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 30 Aug 2020 10:04:49 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id 07U14n7l3061477;
        Sun, 30 Aug 2020 10:04:49 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] block: Set default value to bdi->io_pages instead of zero
Date:   Sun, 30 Aug 2020 10:04:49 +0900
Message-ID: <878sdxosem.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This may not enough to guarantee ->io_pages is not zero though,
instead of leaving ->io_pages as zero, this initializing ->io_pages to
sane value. (maybe some part of NVMe driver seems to be)

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---
 block/blk-core.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 03252af..619a3dc 100644
--- a/block/blk-core.c	2020-08-30 06:47:21.221530450 +0900
+++ b/block/blk-core.c	2020-08-30 06:48:05.805875540 +0900
@@ -526,6 +526,7 @@ struct request_queue *__blk_alloc_queue(
 		goto fail_stats;
 
 	q->backing_dev_info->ra_pages = VM_READAHEAD_PAGES;
+	q->backing_dev_info->io_pages = VM_READAHEAD_PAGES;
 	q->backing_dev_info->capabilities = BDI_CAP_CGROUP_WRITEBACK;
 	q->node = node_id;
 
_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
