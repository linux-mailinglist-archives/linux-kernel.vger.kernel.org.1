Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF692F4F8D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbhAMQHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbhAMQHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:07:37 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89E1C061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:06:56 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id j13so1481514pjz.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fWYX5axM/7U2whKGEikiA25DwObp3mUK6JPnMa57LEI=;
        b=GA59jukFTT6iMUmAwfJg3XjWW6Ao2tQZ0kIPJ1t496PV+tsNcMA9uK5QUfiY9cQpz0
         UlWFRF8Mq2Ki0T+153ZL6r/j8Up/Lxik74QvpZFVTGVWHVNgF3Y4mEXpjNy4sCd71DFZ
         lmxphMcc7H20liGUcucFywLy0Uury7jUTP+Oqy0Gc0INLscFLaxUt6Gnjg9yb5A1fve0
         PYCwDj8viAqHWdwfnITTatsVpN17JZe31FXIHosIo+0t8efRifKUwMGQiDwWYedCKw66
         xzmBO5ruKnACJT+bQCLbtgk3sXSQ1R4C8o9CeC4mBTRQcOj+UjCf3U8njbjYLteohy3x
         K6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fWYX5axM/7U2whKGEikiA25DwObp3mUK6JPnMa57LEI=;
        b=CbO62GJdsKF4fxVKaTLvx2txdPWnAI5qHTCBsp5s2/NImvWGgV0cxhUcn9qcLpjMQC
         evb3YR/3ylTbDUVKDXlLBHoV5Z716/eUxmuUEGWoWs/hobBBei04YWVzAq0HoXHUaep7
         a7TpCiktf1ydWxZrYoqFZeos/W88Sr3uG03E5Rh6ERrNN9fGwuZuc3RqZtYY33x5MOTm
         DxarpEDXbIT5MOOpdy4CtqUFjOic8KqK00xK52CT+WS0rG3t2PbCZ6EFxAPvKuCTuRP6
         3r8RgImtlSLAROM1RaGJfN42nKxzhNIHHijiatWN4Y3VMEq0yIx+bUC2qoXPjqxapO1A
         Mpbg==
X-Gm-Message-State: AOAM5327U4ENObbq5CpqVc4M/l3XUG/g5HapML8xig6fZfFQ+I8PP4oR
        GVQ6hD43u8IPB0c09IFHEqUIUA==
X-Google-Smtp-Source: ABdhPJyIHERuVcZam0dSWgr2tqyRZNV0jSQu5v3V/s8IzWrs+7OAT1lO97HIK1ZvDbN0+FS5jwsPjA==
X-Received: by 2002:a17:90b:23d3:: with SMTP id md19mr3199618pjb.119.1610554016394;
        Wed, 13 Jan 2021 08:06:56 -0800 (PST)
Received: from localhost.localdomain (ec2-18-163-103-0.ap-east-1.compute.amazonaws.com. [18.163.103.0])
        by smtp.gmail.com with ESMTPSA id c11sm2425384pfl.185.2021.01.13.08.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 08:06:54 -0800 (PST)
From:   Li Feng <fengli@smartx.com>
To:     martin.petersen@oracle.com, Johannes.Thumshirn@wdc.com,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
        linux-kernel@vger.kernel.org (open list)
Cc:     lifeng1519@gmail.com, Li Feng <fengli@smartx.com>
Subject: [PATCH] nvme: reject the ns when the block size is smaller than a sector
Date:   Thu, 14 Jan 2021 00:06:21 +0800
Message-Id: <20210113160621.98615-1-fengli@smartx.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nvme spec(1.4a, figure 248) says:
"A value smaller than 9 (i.e., 512 bytes) is not supported."

Signed-off-by: Li Feng <fengli@smartx.com>
---
 drivers/nvme/host/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f320273fc672..1f02e6e49a05 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2161,6 +2161,12 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 
 	blk_mq_freeze_queue(ns->disk->queue);
 	ns->lba_shift = id->lbaf[lbaf].ds;
+	if (ns->lba_shift < 9) {
+		pr_warn("%s: bad lba_shift(%d)\n", ns->disk->disk_name, ns->lba_shift);
+		ret = -1;
+		goto out_unfreeze;
+	}
+
 	nvme_set_queue_limits(ns->ctrl, ns->queue);
 
 	if (ns->head->ids.csi == NVME_CSI_ZNS) {
-- 
2.29.2

