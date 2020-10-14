Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4024928DD0F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbgJNJWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729994AbgJNJVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:21:55 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB0FC041E53
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 20:37:01 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a17so743809pju.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 20:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=5Ynua4zlOw/dc9Bn3pMgf022e9ahU9bnqg4Yj7JIYA0=;
        b=n8SdhhiWdJi7pLppFZCugO44YlOToQSjLhQzX1CKIJmR1YcwlYlN2RVwEip3Rb4QMI
         olpIG9tWz5xgWhH48fO2pPnNth1JG5yVokFr4kNUtKwmQHW6OHagDz3YzMvMXoCRyRGw
         +m+SUM+CHXTiHsGl0cIrYhsxJdr+BBT/t94RhoQ2fYL4U9mp8Ev2DMaB2TfcxAjsIoew
         31EI5sl1/452qlYgPXj+Qoqf99AiQ7jvRGPfMxeQVF51vUrLIjWotUkBZqU5OKqKVr9q
         mOWSx/8RmPNMiv4stlfJOek56naOioeDNfP6E5zQ67iz2p0RicqNOWdGxT/2eCJ7b7uF
         x2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5Ynua4zlOw/dc9Bn3pMgf022e9ahU9bnqg4Yj7JIYA0=;
        b=gdss0UZ7u5e6vEMO6UtPoluv2vgKjNuxUFkEECcpXKdU2gOvbHZ0VJO90n+WHIylKd
         GUxtpN1TnxNL11eur9qmE2+zvuYTpPLz8X6F1VzKexfqqGnPQER/jsTF5QMbl5vSto/N
         sgjrlVQlwbokKyQ/DC2Nfci1ewspC9XK7W2Ic1YIOt9RzSCidcbxdKbbi9ZKiYUhe0Hd
         5gPKyN/ZstGWRx0+0sqcI7fX7w7PphBB+AodsqCRRsVh+M0iaWcI7ZpJZjsPNN5Z8Knq
         LE4g0WuYB5POH/IFc9jtfQr5Qm3BcQJnTFxjP9RM0ke22WAflYhrrnyHFLTTp0ZbGVwk
         gmVQ==
X-Gm-Message-State: AOAM530m1rLNMtsJxcxIsRuXvqe7JFD4F2elXXWJ8VA6d/XX7tuyt9VU
        RncYsC2qjBjfSiRnnaC+4U3i4g==
X-Google-Smtp-Source: ABdhPJz2WbEqZy5yhIKqs728Bu4mTfOL1rUMk/g8tTGqS4SaEEYao1HuSiryoaHyAYvW9boPt4anzQ==
X-Received: by 2002:a17:90a:148:: with SMTP id z8mr1530873pje.173.1602646621003;
        Tue, 13 Oct 2020 20:37:01 -0700 (PDT)
Received: from libai.bytedance.net ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id 188sm1243272pga.35.2020.10.13.20.36.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Oct 2020 20:37:00 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     hch@lst.de, sagi@grimberg.me, chaitanya.kulkarni@wdc.com
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        pizhenwei@bytedance.com
Subject: [PATCH v2] nvmet: fix uninitialized work for zero kato
Date:   Wed, 14 Oct 2020 11:36:50 +0800
Message-Id: <20201014033650.953656-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hit a warning:
WARNING: CPU: 1 PID: 241 at kernel/workqueue.c:1627 __queue_delayed_work+0x6d/0x90
with trace:
  mod_delayed_work_on+0x59/0x90
  nvmet_update_cc+0xee/0x100 [nvmet]
  nvmet_execute_prop_set+0x72/0x80 [nvmet]
  nvmet_tcp_try_recv_pdu+0x2f7/0x770 [nvmet_tcp]
  nvmet_tcp_io_work+0x63f/0xb2d [nvmet_tcp]
  ...

This could be reproduced easily with a keep alive time 0:
nvme connect -t tcp -n NQN -a ADDR -s PORT --keep-alive-tmo=0

Starting an uninitialized work when initiator connects with zero
kato. Althrough keep-alive timer is disabled during allocating a ctrl
(fix in 0d3b6a8d213a), ka_work still has a chance to run
(called by nvmet_start_ctrl).

Fixes:
Don't run keep alive work with zero kato.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/nvme/target/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b7b63330b5ef..90e0c84df2af 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1126,7 +1126,8 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
 	 * in case a host died before it enabled the controller.  Hence, simply
 	 * reset the keep alive timer when the controller is enabled.
 	 */
-	mod_delayed_work(system_wq, &ctrl->ka_work, ctrl->kato * HZ);
+	if (ctrl->kato)
+		mod_delayed_work(system_wq, &ctrl->ka_work, ctrl->kato * HZ);
 }
 
 static void nvmet_clear_ctrl(struct nvmet_ctrl *ctrl)
-- 
2.11.0

