Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D7A28EA7F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 03:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732398AbgJOBwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 21:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729516AbgJOBwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:52:23 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE7BC061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 18:52:21 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id g16so828427pjv.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 18:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Ef3HnQQahVPNGpzniRVNSgNHLilFmnzUisJ433euhLE=;
        b=2OfDrONnaWuvb73Idi8of8nziQnBEO4nKhRgyFliSwV3I9RTEO5MoSro1gAzplA57c
         +Z8PbCizdEvVBDVj//dX0z9eD+npsdsWZbxohJnzuK5cw91GU6wToWoAV5w5pYgJVWab
         WJc1VwaayRA5KKtaNalifoXxrxerDvUTiE916PoY4Mc/iP21S2G0JwGdC5ZJzAEWymYQ
         tw8Rka4iRmV44MeIYs6yY9JBXfqPfoNVObyujhP+uwsx3UrrOVekVdmEF4uBTUAUnRvX
         lYTLKP2rfTKARe4qWN+yl/DpU6lOQLsdZ9IhHZVQNEh/WTQfbGMadhdLpkWloWHH8AWo
         qhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ef3HnQQahVPNGpzniRVNSgNHLilFmnzUisJ433euhLE=;
        b=UPhnWy8oiHSRgu3U/3D4quNbfL9v3S9JJ61jmps7075fcVqJf8BDA1Qb536WY5sk8a
         QFJVZSMhFZwGc5Or1OG5SbOBkSzN+PYqdjZ+We9KDk9Gpn1AX2sn67GO1SLLYpW132sx
         yBJyXfdNo/ietiNscMRPLRZaDohYBOWdeWbxw8k8d7EuEp88lrMnQeVjqGG9OoMIQJty
         ylpoUG6PPy5i5fM3mbXk7w0kNiA9GPG6snqNOz7T54BfnBdUvDOVJ9AxQ8pV+6MM04Sb
         7QuuamPItPw1APsO4/dB3l3k1lGVKtQD3uzbQPVvpkQqHwZ71x7NuYsIGtUXALU20y1h
         sOzQ==
X-Gm-Message-State: AOAM533IVuLhiVxUpxgrLC1jcmXsT1QAqonw5eSnFrvElthzi8LsjDz9
        n0ENcItCph+CpM8cj0LwqeVrWQ==
X-Google-Smtp-Source: ABdhPJyJDjtzgpgvCAIEqnrTv322gS69GtuqnRltoYel1FD3Ea5+kYrrKMLH8mYJarxPN7ABBUe/Jg==
X-Received: by 2002:a17:902:a983:b029:d5:a524:8710 with SMTP id bh3-20020a170902a983b02900d5a5248710mr1731041plb.28.1602726741015;
        Wed, 14 Oct 2020 18:52:21 -0700 (PDT)
Received: from libai.bytedance.net ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id t15sm3308125pjq.3.2020.10.14.18.52.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Oct 2020 18:52:20 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     hch@lst.de, sagi@grimberg.me, chaitanya.kulkarni@wdc.com
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        pizhenwei@bytedance.com
Subject: [PATCH v3] nvmet: fix uninitialized work for zero kato
Date:   Thu, 15 Oct 2020 09:51:40 +0800
Message-Id: <20201015015140.1061936-1-pizhenwei@bytedance.com>
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

Fixes: 0d3b6a8d213a ("nvmet: Disable keep-alive timer when kato is cleared to 0h") 
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/nvme/target/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 25d62d867563..aafcbc424b7a 100644
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

