Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBBB2A8196
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731280AbgKEOwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731205AbgKEOwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:52:18 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64957C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 06:52:18 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id h22so1892036wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 06:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ni2p/a1qgnbLwmmB/hD7NYV4hNmI7rYb9FSLzDt4vrQ=;
        b=P5kJIDqACB9jb6uMDWpBlxNm+8vQEgqLkWzRYli9z9drKI0ges+7m1XSxTElgGB3AT
         E0oeyDVSkgcv4ri+lAhxW9W1Rjd8mQSlGYbxwL6AFS5FAuMyfuFtdGv5mt4QXrMh4xfT
         zYHCgi3xcD3xAO69tRlyoU+DebIeOUPOcXIMIoBVt0wxrx5LPjYM2Zz8nk+c9XlApErS
         4mcJX7FEKH6tTZ+yIbjj7wxpsVd96+HHXxotJ+je7auaSELL8vfBLiBi5PoFeqpLcEsP
         Isi9cCHdhXswdhNbCfZm4nRVZ/OrcvswD2J1qP0rf3tRDIkmsGHB2ajoqWYR1HwYfYYd
         ZR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ni2p/a1qgnbLwmmB/hD7NYV4hNmI7rYb9FSLzDt4vrQ=;
        b=LfT/6tbfYb5fFWn0lQL5eVatV5J1bp+2VzQhx+lV93ZVVrQ+xlmCPusyrsAHa1Bv2w
         q5p/Hq0SeZgRfH6f+aFNs9mofam7XP08XlzXqRoE7t2avLPv5vp9eVM5CfN0MHjOIoAe
         UxabbFPwuPHPJ7sEPa6D+kS/AcLWii25m4THJF1075WzjK29P5cLzBMCH39Ouhd71QSn
         Qu2C4hJKFdRPqR2MhFHL0Y7NRo0SMIJVdcsC2nbkt7M7aZJ19PKhTOA0/EpjrUcRMZjj
         BsMzXnMDZD87mWoIx641d7RDrtVuGvhvlN3I1yVhHTNBDNPJXSG7DyN6cUgorR/wKZFp
         dGFw==
X-Gm-Message-State: AOAM531+WzF4KSr57M1wIO0eyKbnwHxb8oLOU1hxnyCgVRXHyoe8SnU4
        T2p2Jx9zuSAhpxbzK2aAd91bOA==
X-Google-Smtp-Source: ABdhPJwGZM99j8rfQFi86ZhM62w2thIu1iqbxZXuL7hmcT0j5pcCOVuEnqqDxPlt4cOh8LO2oNVTyA==
X-Received: by 2002:a1c:81c9:: with SMTP id c192mr3079205wmd.1.1604587937121;
        Thu, 05 Nov 2020 06:52:17 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id f5sm2631243wmh.16.2020.11.05.06.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 06:52:16 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 02/19] gpu: ipu-v3: ipu-di: Strip out 2 unused 'di_sync_config' entries
Date:   Thu,  5 Nov 2020 14:45:00 +0000
Message-Id: <20201105144517.1826692-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105144517.1826692-1-lee.jones@linaro.org>
References: <20201105144517.1826692-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They're taking up too much space on the stack.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/ipu-v3/ipu-di.c: In function ‘ipu_di_sync_config_noninterlaced’:
 drivers/gpu/ipu-v3/ipu-di.c:391:1: warning: the frame size of 1064 bytes is larger than 1024 bytes [-Wframe-larger-than=]

Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/ipu-v3/ipu-di.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-di.c b/drivers/gpu/ipu-v3/ipu-di.c
index b4a31d506fccf..e617f60afeea3 100644
--- a/drivers/gpu/ipu-v3/ipu-di.c
+++ b/drivers/gpu/ipu-v3/ipu-di.c
@@ -310,10 +310,6 @@ static void ipu_di_sync_config_noninterlaced(struct ipu_di *di,
 			/* unused */
 		} , {
 			/* unused */
-		} , {
-			/* unused */
-		} , {
-			/* unused */
 		},
 	};
 	/* can't use #7 and #8 for line active and pixel active counters */
-- 
2.25.1

