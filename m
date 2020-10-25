Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3CC0298184
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 12:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415520AbgJYLwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 07:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1415513AbgJYLwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 07:52:11 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEF1C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 04:51:55 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id b19so3337612pld.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 04:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=1KiygqGWwb0F23sQdKfIGxFeP8lZb1Vly0G9w/101ss=;
        b=y/DXhF2Fqdumgt3Pn9ix0eB8zltPQXKFobDlC+s+Gy3EYJnN6bNZ6GiSh1q49Ryyts
         3kbXB3zqV2t1RB+apb5MB21aaO0Y3bJ5wzz0KtxT3HEh+wOiaBnsES6jQ35l3jpnPdZU
         EAtF1m+9Kx9VhqcjY4O9cE3Fi1fC/JyYE44EzlkNKBiHar5gRRglKGHICWmboBXDaREa
         n83pjMWieUbnY9M3aH0deeluCrnfdMC/gwfQxyXZtN0U5uKigD7/phsu+I3iM6eywBil
         jm4y43ZGTY8TzshFJNrlzINHO6ITTn21atoxGf66wjlMGwkHgazdw1zUTW41ulLfDOkl
         mzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1KiygqGWwb0F23sQdKfIGxFeP8lZb1Vly0G9w/101ss=;
        b=cgUq2EChMafvgCEt6qcY9ta2ljM1YPcMd2J+9aGeD5Jrn2PvjrWK11dIrjVxUiPfuU
         faZYpRoMKdy7X0XsgWLOAFJ9c3EnhXKo7JA07oXnU5+xfqa5dajgToVYkfO3DSa79h/5
         HVRHRL92A+x2b37/f5CIzVpyk5Bdx4fa65SaaRk/94PLXvBQLKq+KKde9SxusHRtcdeP
         P3D56pvfWMqg7+YkIzz4Y3d+nbKRprTktFPG/fHMXJXshrEWjAHn0Ml4S9OqXgLs+JQf
         DvOkm4ABgyf6vGsFroPK+O+ytwlQM2nOAo0DLyoSZ4I/y10BMUz0QJkrSTBGmThnznso
         XkjA==
X-Gm-Message-State: AOAM532LF+7wvnehmTzIw5kVJnv/qn3+ye7Af1JxJaG/rq8Pqq7sSJqI
        pVw6/fitxWyqxPYtF5JhSjnBWUgheSULJA==
X-Google-Smtp-Source: ABdhPJx1F1ZJkSgr74ZVrgG2Doqqo6qZpxGo/7X3N66an+FJd02Y5pof4gQDqWmycZHAtJoDUaGBwg==
X-Received: by 2002:a17:90a:17a8:: with SMTP id q37mr11244997pja.44.1603626714849;
        Sun, 25 Oct 2020 04:51:54 -0700 (PDT)
Received: from libai.bytedance.net ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id q23sm8825394pfg.192.2020.10.25.04.51.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Oct 2020 04:51:54 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        lengchao@huawei.com, pizhenwei@bytedance.com
Subject: [PATCH v3] nvme-rdma: handle nvme completion data length
Date:   Sun, 25 Oct 2020 19:51:24 +0800
Message-Id: <20201025115124.1430678-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hit a kernel warning:
refcount_t: underflow; use-after-free.
WARNING: CPU: 0 PID: 0 at lib/refcount.c:28

RIP: 0010:refcount_warn_saturate+0xd9/0xe0
Call Trace:
 <IRQ>
 nvme_rdma_recv_done+0xf3/0x280 [nvme_rdma]
 __ib_process_cq+0x76/0x150 [ib_core]
 ...

The reason is that a zero bytes message received from target, and the
host side continues to process without length checking, then the
previous CQE is processed twice.

Do sanity check on received data length, try to recovery for corrupted
CQE case.

Because zero bytes message in not defined in spec, using zero bytes
message to detect dead connections on transport layer is not
standard, currently still treat it as illegal.

Thanks to Chao Leng & Sagi for suggestions.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/nvme/host/rdma.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index aad829a2b50d..40a0a3b6476c 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1768,6 +1768,14 @@ static void nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 		return;
 	}
 
+	/* sanity checking for received data length */
+	if (unlikely(wc->byte_len < len)) {
+		dev_err(queue->ctrl->ctrl.device,
+			"Unexpected nvme completion length(%d)\n", wc->byte_len);
+		nvme_rdma_error_recovery(queue->ctrl);
+		return;
+	}
+
 	ib_dma_sync_single_for_cpu(ibdev, qe->dma, len, DMA_FROM_DEVICE);
 	/*
 	 * AEN requests are special as they don't time out and can
-- 
2.11.0

