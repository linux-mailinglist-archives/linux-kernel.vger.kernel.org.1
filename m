Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCB1249747
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 09:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgHSH2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 03:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbgHSHZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 03:25:47 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8C2C06137A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 00:24:33 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f18so1036898wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 00:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vEOfu47Y3L4UQX7xJ0CwMKmanBZGRJoANMK0AYiLhYY=;
        b=ONBkDFy4nvOfZy7Fb/jtxaeN/rlfFcWeeYSqwmA3J7/SlqyYyn5CfcuUN7cnycjoDR
         PdmVfEVuU/bda2pEVSTzq0R5q/7ChExwe96pxuWSx16se15S26yIBmGkQXP1ftDrZaAY
         jGn5RssGJLWMtx4n5Uw4ABkmS1HjH2QHzIreSWS55X18chzexHqZ5RdzvGU5oawhtF6E
         PeXlp947xRBTfUVg2CemnE1u3zudg3JtoKkTNjUXq2imQbPnJ0tfC9aOoEoD8g2cu+MM
         sOg01ZxL6X2GItpuOflCXO7I1eDtJiEYkqtedNLVTiSjQf6lFKcY/1gQ4v7lkBd0OeBS
         Iekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vEOfu47Y3L4UQX7xJ0CwMKmanBZGRJoANMK0AYiLhYY=;
        b=rQqkc4UQPc3Zi4ecG35bbg24Kqgic/eaV0HDw7P+d9hfsQ74yO1YeB8sHnSxGgWT/g
         tg1MCMKfbA0nmMMQCaltn5lpwymJZKIOmXsLM63DDImJ2UGY+Gz6GAE1jNZ3Zr/2em/H
         sAwU9DtzvUbjxQI7975Q8WMYZ7YuP+6NAjK40lTckHQ1hqOTQruMWvcgT7MS+s3xw7xv
         /PtyZJAOP9xwhZvhibXm1aq99+l2LSSA+KLa/jDr8YjUeTWTev8cKbXLMsJSiioxdaRy
         0wOYTjBHKHLoUpEil2L+doNCCy+0yNhvWauHS5KMatSC5Juj4Yt4d1fYgau3O+MugMyL
         I75A==
X-Gm-Message-State: AOAM533779dy6MsWSlRT5y9ljyPYCcw3LaDPBzVtqqRengR1l1XeS7f+
        5/j9ebLUvEN/c8pUOhqx+eKRBw==
X-Google-Smtp-Source: ABdhPJzrIC/A+inhohXhaCC31ocYq2x37yCHpex5pSLhP3NPf3zLly2VascvS2mzvSfx7ZZTMNX2Fw==
X-Received: by 2002:a1c:9e11:: with SMTP id h17mr3528644wme.106.1597821871698;
        Wed, 19 Aug 2020 00:24:31 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id c145sm3795808wmd.7.2020.08.19.00.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 00:24:30 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Maya Erez <merez@codeaurora.org>, wil6210@qti.qualcomm.com
Subject: [PATCH 21/28] wireless: ath: wil6210: debugfs: Fix a couple of formatting issues in 'wil6210_debugfs_init'
Date:   Wed, 19 Aug 2020 08:23:55 +0100
Message-Id: <20200819072402.3085022-22-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200819072402.3085022-1-lee.jones@linaro.org>
References: <20200819072402.3085022-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc expects attributes/parameters to be in '@*.: ' format and
gets confused if the variable does not follow the type/attribute
definitions.

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/ath/wil6210/debugfs.c:456: warning: Function parameter or member 'wil' not described in 'wil6210_debugfs_init_offset'
 drivers/net/wireless/ath/wil6210/debugfs.c:456: warning: Function parameter or member 'dbg' not described in 'wil6210_debugfs_init_offset'
 drivers/net/wireless/ath/wil6210/debugfs.c:456: warning: Function parameter or member 'base' not described in 'wil6210_debugfs_init_offset'
 drivers/net/wireless/ath/wil6210/debugfs.c:456: warning: Function parameter or member 'tbl' not described in 'wil6210_debugfs_init_offset'

Cc: Maya Erez <merez@codeaurora.org>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: wil6210@qti.qualcomm.com
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/ath/wil6210/debugfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/debugfs.c b/drivers/net/wireless/ath/wil6210/debugfs.c
index 11d0c79e90562..2d618f90afa7b 100644
--- a/drivers/net/wireless/ath/wil6210/debugfs.c
+++ b/drivers/net/wireless/ath/wil6210/debugfs.c
@@ -443,10 +443,10 @@ DEFINE_DEBUGFS_ATTRIBUTE(wil_fops_ulong, wil_debugfs_ulong_get,
 
 /**
  * wil6210_debugfs_init_offset - create set of debugfs files
- * @wil - driver's context, used for printing
- * @dbg - directory on the debugfs, where files will be created
- * @base - base address used in address calculation
- * @tbl - table with file descriptions. Should be terminated with empty element.
+ * @wil: driver's context, used for printing
+ * @dbg: directory on the debugfs, where files will be created
+ * @base: base address used in address calculation
+ * @tbl: table with file descriptions. Should be terminated with empty element.
  *
  * Creates files accordingly to the @tbl.
  */
-- 
2.25.1

