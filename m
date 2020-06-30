Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94A320EB68
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 04:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgF3CWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 22:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgF3CWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 22:22:33 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652BCC061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 19:22:33 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e9so9196245pgo.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 19:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=90iGbWnZQvzyoyYYX1aI3WuUPDwZTHkcVJZ1gtygVfs=;
        b=B8on8zwCEHxEEytA265c1m/uSWXHG5+LH9fkpt16It4D+dnPiQ1JgcNgigITKJuKuY
         rOiEn3BbZ3OAf5yprtQvaeSrqajiNj3juoILKsAi55q6nFZxMVRy5r4iI1AxdNRPQyF+
         0/QgmBsRol2GgmCERGh2mYmKj8JPYYvH1nXtJdkpwWUNMuo8FPUioX89AG0hfFp3/Cne
         Z/dTpIrjfSpS4yeP88KBIjgnU7OVgQgtrTiuDXvnarGUrjwJ4wYcIxiUg5VuNjbbl6Is
         ZZn6U6HMBuzvimnOYufosYBcf18gexZYcmJLH/86b+1kUx7kH2HhZTIBeg4afKoVCZxa
         mffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=90iGbWnZQvzyoyYYX1aI3WuUPDwZTHkcVJZ1gtygVfs=;
        b=boU/f0JJHweN3weT4nlxmjOB26Cv+yHpA1h6q688VpsLV7WGc3Eddh2KxVlpnxAh6E
         BojZprjZFZbaiN/TehQZXBMEaL8MlzqxKQO2zjyBopCsXo/U9F/XGIzlJ+Uc7Za1x8mm
         wHlNDlb56eCEJFTx+cKUbbxK2z9ETtTdsaKzw4WVH51CrgPnSJB/sxuZZM7YXIsTlbs6
         Si8E7QTXcSdnrklcr6BpiOiCYSbaszcpQbHVhz0v+ltoOzC1FYW2ybDR6wLRLFz05+Ib
         hDZMoz9/5NJoXMPlAFZVgP/XxgBQbTau9/WYK7+/Yp8+HjRhYaHPVigsF5HyPfIcmUx+
         P0wQ==
X-Gm-Message-State: AOAM530l+xhafI8IAjUyf7qExke7rSJ2ehQc9Z+TQfNz56QpVmVQwHJO
        /nekSqFRwaVe+WfH+zbdbK0=
X-Google-Smtp-Source: ABdhPJyiBmGpHuEUFMc0bYmUbStDsACPIG/Qk5JupF0XACmd6kClws1TCwfbftRdnqGPXP5PKMVa/Q==
X-Received: by 2002:a63:b18:: with SMTP id 24mr13544182pgl.406.1593483752755;
        Mon, 29 Jun 2020 19:22:32 -0700 (PDT)
Received: from simon-pc (n11923716050.netvigator.com. [119.237.16.50])
        by smtp.gmail.com with ESMTPSA id n11sm914545pgm.1.2020.06.29.19.22.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jun 2020 19:22:32 -0700 (PDT)
Date:   Tue, 30 Jun 2020 10:22:28 +0800
From:   Simon Fong <simon.fodin@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     gregkh@linuxfoundation.org, simon.fodin@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtl8188eu: core: Fix WARNING of Block comments
Message-ID: <20200630022228.GA580@simon-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a WARNING of Block comments use * on subsequent lines.

Signed-off-by: Simon Fong <simon.fodin@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_recv.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/core/rtw_recv.c
index 9caf7041ad60..bceae18e4373 100644
--- a/drivers/staging/rtl8188eu/core/rtw_recv.c
+++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
@@ -163,12 +163,12 @@ int rtw_enqueue_recvframe(struct recv_frame *precvframe, struct __queue *queue)
 }
 
 /*
-caller : defrag ; recvframe_chk_defrag in recv_thread  (passive)
-pframequeue: defrag_queue : will be accessed in recv_thread  (passive)
-
-using spinlock to protect
-
-*/
+ * caller : defrag ; recvframe_chk_defrag in recv_thread  (passive)
+ * pframequeue: defrag_queue : will be accessed in recv_thread  (passive)
+ *
+ * using spinlock to protect
+ *
+ */
 
 void rtw_free_recvframe_queue(struct __queue *pframequeue,  struct __queue *pfree_recv_queue)
 {
-- 
2.17.1

