Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFDB5222DA0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 23:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgGPVSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 17:18:22 -0400
Received: from ale.deltatee.com ([204.191.154.188]:47682 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgGPVRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 17:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Y+jzSbXVvaGAj5ehPx9GFRrh0LwsI1Rxsrkj6tqzM/I=; b=ZWOXt3fEg5/BT5kbNGVRR4Dgop
        wB9IJI2xSxfo1veRo3U/KnB60/HQZGpcQAqI29O1bjtxfDD+46dWlekYeOnITdpLEVOREzWorrrpS
        f+Q8Eq9CEjN1fiBXtATSFbn+OcauBoY4gUsDs5pp3KK45Fgi2J/0kjmDpsR5fYuxAmOI8LfC17j8a
        rDEVQzJFRisAj6+UCGVB7B/n3ExzisP0IBkY0SLYX0QkJjkPHnJyvEc9gY0P8tieqVQwayfvXBdcU
        7uWrJF5OjznBlivzYuIQTTx8AAGDgSZB5PULaSxj+kORrA6QApm8LTz0aZN6r5SzKqmwU2oOlbmAA
        AcJIPGhg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1jwAZH-0005uI-GV; Thu, 16 Jul 2020 14:33:25 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1jwAZE-0004BK-Gn; Thu, 16 Jul 2020 14:33:20 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 16 Jul 2020 14:33:11 -0600
Message-Id: <20200716203319.16022-2-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200716203319.16022-1-logang@deltatee.com>
References: <20200716203319.16022-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, axboe@fb.com, Chaitanya.Kulkarni@wdc.com, maxg@mellanox.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_NO_TEXT,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.2
Subject: [PATCH v15 1/9] nvme-core: Clear any SGL flags in passthru commands
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The host driver should decide whether to use SGLs or PRPs and they
currently assume the flags are cleared after the call to
nvme_setup_cmd(). However, passed-through commands may erroneously
set these bits; so clear them for all cases.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f49085bcaa42..63a59186e68b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -759,6 +759,8 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 	case REQ_OP_DRV_IN:
 	case REQ_OP_DRV_OUT:
 		memcpy(cmd, nvme_req(req)->cmd, sizeof(*cmd));
+		/* passthru commands should let the driver set the SGL flags */
+		cmd->common.flags &= ~NVME_CMD_SGL_ALL;
 		break;
 	case REQ_OP_FLUSH:
 		nvme_setup_flush(ns, cmd);
-- 
2.20.1

