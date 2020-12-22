Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8747D2DD02B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 12:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgLQLMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 06:12:53 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:9461 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbgLQLMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 06:12:52 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CxTp32Sk6zhsq9;
        Thu, 17 Dec 2020 19:11:23 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Thu, 17 Dec 2020 19:11:43 +0800
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hch@lst.de>, <hare@suse.de>, <ppvk@codeaurora.org>,
        <bvanassche@acm.org>, <kashyap.desai@broadcom.com>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [RFC PATCH v2 0/2] blk-mq: Avoid use-after-free for accessing old requests
Date:   Thu, 17 Dec 2020 19:07:51 +0800
Message-ID: <1608203273-170555-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series aims to tackle the various UAF reports, like:
- https://lore.kernel.org/linux-block/8376443a-ec1b-0cef-8244-ed584b96fa96@huawei.com/
- https://lore.kernel.org/linux-block/5c3ac5af-ed81-11e4-fee3-f92175f14daf@acm.org/T/#m6c1ac11540522716f645d004e2a5a13c9f218908
- https://lore.kernel.org/linux-block/04e2f9e8-79fa-f1cb-ab23-4a15bf3f64cc@kernel.dk/

Details are in the commit messages. Most important detail is that
fastpath is untouched.

The issue addressed in patch 1/2 is pretty easy to reproduce, 2/2 not so
much.

Differences to v1:
- add 2nd patch

John Garry (2):
  blk-mq: Clean up references to old requests when freeing rqs
  blk-mq: Lockout tagset iter when freeing rqs

 block/blk-mq-sched.c |  2 +-
 block/blk-mq-tag.c   | 22 +++++++++++++++++++---
 block/blk-mq-tag.h   |  3 +++
 block/blk-mq.c       | 22 ++++++++++++++++++++--
 block/blk-mq.h       |  2 ++
 5 files changed, 45 insertions(+), 6 deletions(-)

-- 
2.26.2

