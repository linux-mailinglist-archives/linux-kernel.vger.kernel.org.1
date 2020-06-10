Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641B01F4B0D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 03:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgFJBuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 21:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgFJBuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 21:50:15 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F13FC03E96B
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 18:50:15 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id w20so254488pga.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 18:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=Ji4TCSq1luwwD59iAjzvhlqpXXUHZW0S8n/qjFRWtds=;
        b=VqbebF/hIoKIYMSnRIAXVxrJsWmsYY1Q1a6Y5T8v1po+fKjVh3y3tr3RiCtZdSmtVU
         DiNquBe8RsWhB/VPctmZq/x97WsVKOmdP7gNnl9wVSgcTEb2jTo4BhtOVzIkC5PMe0bF
         pYVuB2gjRhsmDovCFix66napGVnDlDwZcbDv4NQcYU+fuJMpMZ13XRB9ncikYG+1sgfk
         p+DmanuMgYEy1UYibt7HoD50vhZjo7R9lP6Jvc2bZzUVywpce1pPKlUcqfrF2b9wN2x8
         hvM+elvhLI4j2TM6lK/JNLPM7qI07CR2ZOjodwp9KjWATnx/dx6i5vtsAyNRLqEbAzxW
         H2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=Ji4TCSq1luwwD59iAjzvhlqpXXUHZW0S8n/qjFRWtds=;
        b=iysPs/2gKAz7CDa5nARdKgpwBu48a8T4OqacHEn7BfHKiD4iq2+n9znC7cavOreXXD
         D3oUQD2jTdg1QjAh5/CdhUVLMHURp/ZU9T9gTL0dq/XouaL+1VbpeUl05NAgcc8K2Mcg
         sw8L/xabay4biQyYoogYfFnAhx3JqUcDvHM+Q1Ys7iUDdPZFCwyyhj7S4XI+IUujW3K1
         xbi00BXo/Lz22FUBxE4cG0yCyg57jo0ZXzgnputQKwrBCDouvwm9tC2bPZHe49Xj/jPC
         hiRllp/vTxT8+uKlGT+gYU84qadlkuKlNW5tEMln5w8k6jl0+Jev6L8mwXq0EyNF1o0x
         DGNw==
X-Gm-Message-State: AOAM531WSdtxgCtiWXuOl6C/b8yDBVodp0GMrahilBeEkXQy4vEwQRtF
        cOlUCNuv/DUUJUrki4++JVC3Hg==
X-Google-Smtp-Source: ABdhPJw4A+RLG6MFwR9MaBg+WR7M9Uc+Zen7Q0tkAEkS7GFJz3O02Rfe3oJicXzNNubIBXI0OMwbYw==
X-Received: by 2002:a63:2248:: with SMTP id t8mr717470pgm.113.1591753814587;
        Tue, 09 Jun 2020 18:50:14 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id m5sm9320727pga.3.2020.06.09.18.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 18:50:13 -0700 (PDT)
Subject: [PATCH] e1000e: Squash an unused function warning
Date:   Tue,  9 Jun 2020 18:49:07 -0700
Message-Id: <20200610014907.148473-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     jeffrey.t.kirsher@intel.com, kuba@kernel.org,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Palmer Dabbelt <palmerdabbelt@google.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     davem@davemloft.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

e1000e_check_me is only used under CONFIG_PM_SLEEP but exists
unconditionally, which triggers a warning.

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index a279f4fa9962..f7148d1fcba2 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -134,6 +134,7 @@ static const struct e1000e_me_supported me_supported[] = {
 	{0}
 };
 
+#ifdef CONFIG_PM_SLEEP
 static bool e1000e_check_me(u16 device_id)
 {
 	struct e1000e_me_supported *id;
@@ -145,6 +146,7 @@ static bool e1000e_check_me(u16 device_id)
 
 	return false;
 }
+#endif
 
 /**
  * __ew32_prepare - prepare to write to MAC CSR register on certain parts
-- 
2.27.0.278.ge193c7cf3a9-goog

