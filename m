Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78DA224527A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Aug 2020 23:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbgHOVvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Aug 2020 17:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728864AbgHOVvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:37 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76F3C0F26E5
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 10:59:49 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r2so11062612wrs.8
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 10:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=jst3pZBrtEx+aeP9V9ZqpXF52QEJ/qakLq4lVq6NlmY=;
        b=Vd0d2VqTedRkkDf9Sv430Fuefubv5QJSghpasfCdtTyb7/wb4atmCCuLzuvrAIz478
         4jCzYETid41ls04FLOhBlpNoS+MfmHWeTiOxlTW/hh0f/OFEy5Y+vTaLH3SV8iILba5B
         6JJrPYtBQKh4Rm56sTyjpTcpi5YBVk2ru1PRYBLXGWB2BVKxd4NBngxw06QAaFwsyfN/
         wN8XGmchc0yfGcd2kvb0zzL/hKjGkWmu3y/xaqfK70JKjLdNJNzy12Dk9FUubueb9kwL
         zdu+gcb7dWA0mmtgK9N3M8G66lYY3Y+FIgDCNj3Rg+j+3ThU0OYu8Kj5ZG1G0bipxExE
         uoEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=jst3pZBrtEx+aeP9V9ZqpXF52QEJ/qakLq4lVq6NlmY=;
        b=dEUmo8LRaEKWYQEKGGJlR/pePJShsh7UtqL3QQArSRRD4n2aJW1k6s2YuByLzeZ87r
         /6dtkrlCZxL+wSdZd2MO705mOyQ/S0rbS1hjBmbYw8YlktMCkvTWZDysBY+Gpo1z/zV6
         cWMAX/guyRRZjPKTF8F8OCgLgSBgzDFXfeZxQCEUsfCz9zkkeBBLoAqu4A8wbaMAQ4M2
         lcp8KE0qqqe50sJScEGF6hwSrDdxUQgVJ7OPrtV6NJqChVN8Gvwk2mp+WWzYny0qrBaa
         ojHkeNFHJ38mieOxLh5Ke5k0fxFHL9JExPgAnUxGBSNerESHjTVTfn5XbHc5lI0MPMgd
         kZ8w==
X-Gm-Message-State: AOAM531GeYBmGsQz5uipPELOwjDpZqUA2Q9DDZUDHwvaJU/qR5e+27Ym
        1uXXMdAzXwYjPD9WRsydv3w8TGxENvQ=
X-Google-Smtp-Source: ABdhPJyXl0v2jSh03zIOtOXfO6QaU6jzC+sQGwv15g/it9xmavTx5RmHIkzgBORiHbeiDUABsxXSYw==
X-Received: by 2002:adf:ed0c:: with SMTP id a12mr7664665wro.24.1597514388281;
        Sat, 15 Aug 2020 10:59:48 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id e5sm24460775wrc.37.2020.08.15.10.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 10:59:47 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Subject: [PATCH 6/9] habanalabs: remove redundant assignment to variable
Date:   Sat, 15 Aug 2020 20:59:35 +0300
Message-Id: <20200815175938.16619-6-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200815175938.16619-1-oded.gabbay@gmail.com>
References: <20200815175938.16619-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

new_dma_pkt->ctl is assigned a value and then is reassigned a new value
without the first value ever being used.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index ed289a6ed622..ffd0849e8f2d 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -3944,8 +3944,6 @@ static int gaudi_patch_dma_packet(struct hl_device *hdev,
 			}
 		}
 
-		new_dma_pkt->ctl = user_dma_pkt->ctl;
-
 		ctl = le32_to_cpu(user_dma_pkt->ctl);
 		if (likely(dma_desc_cnt))
 			ctl &= ~GAUDI_PKT_CTL_EB_MASK;
-- 
2.17.1

