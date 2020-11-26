Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2E82C55B9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390401AbgKZNcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390292AbgKZNcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:32:13 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280E5C061A04
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:32:13 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id k14so2177881wrn.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E25/s2pmN1jYHUWPVit1bHGpEi6jEbn1M/6HbkBpU14=;
        b=ghZh7I2ge1DGcrfEdOn9QQfpf2S4lE4sRCwhWNIAbqweD0VZJ5aW2MLrQ3M1U5QPS9
         T6pAJDHpuwlvjDev0DfaaajeTx6HZJNTfOUKd9jFcpLmhuAL4dw9pROU4JzLdRnr+nVS
         GnUTXR2iMIyQX0xlODvNhvrcaDWZD8EHhPCuwg89FEo57eHQygnDItIAA72Fld9+gV+1
         8WLRLNXAldZgbUbhiUezL1qzrhdRbQ+cTRwl24Y0m/rTKj4QLL50sW9hWgfCjD7MvwNZ
         j2IZghwRkM2WeoEJnPoevWQ08nPVeZexIBWrboKaB0SEJKV5hJRvhLLSaNf+h9QNydzJ
         0ZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E25/s2pmN1jYHUWPVit1bHGpEi6jEbn1M/6HbkBpU14=;
        b=dKBHeC16aaA/EaNmDBvN9dIq0o1/RmU6JI4I30R2eItSZsHA+uwM3PaUisdYImlEy8
         JrzbWSiDHst3ubvn3pozsfnyxW++3VrhQqOzvr6OjRholzF7HxKYfWSiqNBmpTSFYyoe
         OE5W9xWdSfWXEQ2UPDqBxdDlQpDeL/n3GCKyuOxVC5JJ5W+kq1zRlOMARKJn89xvt/O0
         S1nyd5z2rkxMlcF0PU/89GLMwRUTImyv+YybssYTgtcWNBfUBfgi2pe0pG+8OwTa19+Y
         HAVJqT721TfvyesrXeeFVLT/0l261iZacE9Ascd/qtuE+k4rhISULcs8WgNPXWQrQIH2
         fKxQ==
X-Gm-Message-State: AOAM533oRIE479sOCdwYo1vk+PztQWJXHQU8McwPdS6IlF+q0jX5Vio7
        dI7Fkia6E0QOkfhcm4sg9Uc68A==
X-Google-Smtp-Source: ABdhPJzGbGQMlN0MfvBGTz+3a9+vPyrAN5IP5cV1HGMaN8Z4XgGravGisSzs7eebgmtDEWS3ftsmfg==
X-Received: by 2002:a5d:4d92:: with SMTP id b18mr3997659wru.260.1606397530996;
        Thu, 26 Nov 2020 05:32:10 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id n10sm8701001wrv.77.2020.11.26.05.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:32:10 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org, kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 12/17] ath: dfs_pri_detector: Demote zero/half completed kernel-doc headers
Date:   Thu, 26 Nov 2020 13:31:47 +0000
Message-Id: <20201126133152.3211309-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126133152.3211309-1-lee.jones@linaro.org>
References: <20201126133152.3211309-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are only a couple of these and none of them are conformant.

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/ath/dfs_pri_detector.c:39: warning: Function parameter or member 'head' not described in 'pulse_elem'
 drivers/net/wireless/ath/dfs_pri_detector.c:46: warning: Function parameter or member 'val' not described in 'pde_get_multiple'
 drivers/net/wireless/ath/dfs_pri_detector.c:46: warning: Function parameter or member 'fraction' not described in 'pde_get_multiple'
 drivers/net/wireless/ath/dfs_pri_detector.c:46: warning: Function parameter or member 'tolerance' not described in 'pde_get_multiple'

Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/ath/dfs_pri_detector.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/dfs_pri_detector.c b/drivers/net/wireless/ath/dfs_pri_detector.c
index 05b0464c6b92c..d07c454c9c00d 100644
--- a/drivers/net/wireless/ath/dfs_pri_detector.c
+++ b/drivers/net/wireless/ath/dfs_pri_detector.c
@@ -29,18 +29,17 @@ struct ath_dfs_pool_stats global_dfs_pool_stats = {};
 	(MIN + PRI_TOLERANCE == MAX - PRI_TOLERANCE ? \
 	MIN + PRI_TOLERANCE : RUNTIME)
 
-/**
+/*
  * struct pulse_elem - elements in pulse queue
- * @ts: time stamp in usecs
  */
 struct pulse_elem {
 	struct list_head head;
 	u64 ts;
 };
 
-/**
+/*
  * pde_get_multiple() - get number of multiples considering a given tolerance
- * @return factor if abs(val - factor*fraction) <= tolerance, 0 otherwise
+ * Return value: factor if abs(val - factor*fraction) <= tolerance, 0 otherwise
  */
 static u32 pde_get_multiple(u32 val, u32 fraction, u32 tolerance)
 {
@@ -70,7 +69,7 @@ static u32 pde_get_multiple(u32 val, u32 fraction, u32 tolerance)
 	return factor;
 }
 
-/**
+/*
  * DOC: Singleton Pulse and Sequence Pools
  *
  * Instances of pri_sequence and pulse_elem are kept in singleton pools to
-- 
2.25.1

