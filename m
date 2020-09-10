Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C06263E2E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 09:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbgIJHMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 03:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730175AbgIJG72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 02:59:28 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F66C061360
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 23:55:20 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id z9so4628256wmk.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 23:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rWq4EIZLBdjUFDSSQaVD1PvQUVhVWlX38rMGrIxZmlM=;
        b=vZf4VFr50U74u75SGpXYrch3+0R3YHtrpUnIDTh4Iwn8P9ALwP8X066Eu+kg8na2RZ
         0ff7H7RyyEqy0MTTFYq3oeaPMPYSvC2zLCiJDq6qwLzw8oP9EMJSZT6/GthEyT3irFBU
         spadF5xHegJ0j7SbOTJq+QvrQLiw/hvKrvjRkrbsBghA9/qgiLPkLUGHJ3ZPYpJjAVjw
         xXez+57QSZeI7Mo1d9eAtHA4hVN57fEP7rQEHgMv7QD2n5ASP4DPh8uphMBUj0Ui2/Rr
         ZpDz50hf/2nOJYpmKlqkNFlDT9LpJy191ux12isWCgMmFYcwuqZzi5Qd/zH9d1c/YMx9
         6o5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rWq4EIZLBdjUFDSSQaVD1PvQUVhVWlX38rMGrIxZmlM=;
        b=o9pZipFMEmnWgtoPgaI6uNN2ouCy0SlGhnhwtW7rrkMVdXLX8pkq7MVahG2jk1sdr+
         tyAHGCfzhbzzPR1TjC9B3vD26ulwYwWZ3M8KNBdxWvkf+66jz/xgV97erkOrgEbjmkkq
         TXN0k6/o+66QubtD0NYXn1g9cjtfDErw8WcLl4MDUKUp4VPhVqzOh3EzhcmVRkvu2oU9
         tt5w0lcr/fVOX+lTrhQMiROnjJ9RonMKySTvHxdMPqv7sZK5k4SiYibovOTeQ+vgFSHL
         0zgbPinqxwy+DrsjhTiUqsuEAqwF9BY2ZGHxpXEIgIpI8Kz+w0Qdy8Msj+Ci+a49sSmc
         DVSQ==
X-Gm-Message-State: AOAM530sxJinuNprE1Y0ENg8hpkQKVgMZU73cScyqO0v9dQqLBKG41vX
        iGd1ArL74yqUw/RaJVpr6klW7w==
X-Google-Smtp-Source: ABdhPJxYc4wxvPHg+Y+0uosZNsNdwaYE7td5fUHWGXb0CT4vstdMdqxPg6zr4aysxFfG6RuXte4dNw==
X-Received: by 2002:a1c:5f41:: with SMTP id t62mr6870731wmb.22.1599720918933;
        Wed, 09 Sep 2020 23:55:18 -0700 (PDT)
Received: from dell.default ([91.110.221.246])
        by smtp.gmail.com with ESMTPSA id m3sm2444028wme.31.2020.09.09.23.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 23:55:18 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Maya Erez <merez@codeaurora.org>, wil6210@qti.qualcomm.com
Subject: [PATCH 22/29] wil6210: wmi: Correct misnamed function parameter 'ptr_'
Date:   Thu, 10 Sep 2020 07:54:24 +0100
Message-Id: <20200910065431.657636-23-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910065431.657636-1-lee.jones@linaro.org>
References: <20200910065431.657636-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/ath/wil6210/wmi.c:279: warning: Function parameter or member 'ptr_' not described in 'wmi_buffer_block'
 drivers/net/wireless/ath/wil6210/wmi.c:279: warning: Excess function parameter 'ptr' description in 'wmi_buffer_block'

Cc: Maya Erez <merez@codeaurora.org>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: wil6210@qti.qualcomm.com
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/ath/wil6210/wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireless/ath/wil6210/wmi.c
index 421aebbb49e54..8699f8279a8be 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -262,7 +262,7 @@ struct fw_map *wil_find_fw_mapping(const char *section)
 /**
  * Check address validity for WMI buffer; remap if needed
  * @wil: driver data
- * @ptr: internal (linker) fw/ucode address
+ * @ptr_: internal (linker) fw/ucode address
  * @size: if non zero, validate the block does not
  *  exceed the device memory (bar)
  *
-- 
2.25.1

