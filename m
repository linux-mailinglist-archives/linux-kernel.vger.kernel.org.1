Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3BE2F4DF0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbhAMOyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbhAMOvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:51:52 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8459C06138C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:39 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id e25so1864841wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DB5ZhlcS73D7+78VKV5C4ED9gkOhY09FF/WaEagoeZU=;
        b=AONsu4c49jYlWKZxIV71Fh+XZdaNm/Vzg4dgCbN9JbxTF4zXdk0hxy5yUAjRqlY1Xp
         nIupPjhqoIDmU9VkNJPtK0bN3YDe0f2AqkiUUwaqnLI5f/UzmCGOhingAiMylna4SnJ7
         hLXn2MQXPU6i1MKuVELPGT8kK+K/FZOJI4dUhj0jPoBZq2Enr9vntVzkeQDu+4qMmsGJ
         v9PLkQKSiH7g77yfRhELqhLTHFPLU2Zj+6aaz97t1aI4q7b6mzr8jI36fIERyEk5M18O
         pFAOSj+Sqvp1t7uHTA6T4HOtbxb08KOCHlGCDgPp2Qf5TW3Vp2vXs9ztiYrfKzPx/xqZ
         1DRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DB5ZhlcS73D7+78VKV5C4ED9gkOhY09FF/WaEagoeZU=;
        b=PZ7YshbdnrnyMg6sxtSR9EQi4Jnm7bP0PEWn6HhvxiWF0JszArg3qVGMWUEqKSNce9
         mjtxFyyBHcmSxu3WOINAj3dd+7i+qSkrMngTHpMmY+JMooFlXuwfbGIljyiY5Pk2BD3X
         xwMm3+s/jRj0xYiJ4D0Rkt9nIIPaRB/MVrWnU4UzcjNd50yXggG8xsRzI+PQvDFQ9qMy
         BiUpEWX7fBppgaUcKvFmDxeyC/84eoarBnXssLdyFmyuJP5wALDH8DCHIkBfVvhXRmWr
         Ywtqgue1LDdZRorLptZNL3Qrv+Zz7Hzpyt5fI+dCv0MpwHZO93ikXoZajgomUDeElBI5
         ECOg==
X-Gm-Message-State: AOAM5320y5kq2ZV7J54vJcLPR5UWSqdUwnkRixRif8SrfFk/r6x4tifs
        SEGNMkS7M8XTQ1mpejnSYJMh1A==
X-Google-Smtp-Source: ABdhPJwgYTdZ2SuZ1GC/GjtSB8bSmqwzQcGAszf80Fej8Y4hpcF1LKJ1kwg1EITnZXMFsMy/JoGVCg==
X-Received: by 2002:a1c:4843:: with SMTP id v64mr2570638wma.186.1610549438672;
        Wed, 13 Jan 2021 06:50:38 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:38 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jim Hague <jim.hague@acm.org>,
        Ilario Nardinocchi <nardinoc@CS.UniBO.IT>,
        Jakub Jelinek <jakub@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 16/31] video: fbdev: pm2fb: Fix some kernel-doc formatting issues
Date:   Wed, 13 Jan 2021 14:49:54 +0000
Message-Id: <20210113145009.1272040-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113145009.1272040-1-lee.jones@linaro.org>
References: <20210113145009.1272040-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/video/fbdev/pm2fb.c:1515: warning: Function parameter or member 'pdev' not described in 'pm2fb_probe'
 drivers/video/fbdev/pm2fb.c:1515: warning: Function parameter or member 'id' not described in 'pm2fb_probe'
 drivers/video/fbdev/pm2fb.c:1721: warning: Function parameter or member 'pdev' not described in 'pm2fb_remove'
 drivers/video/fbdev/pm2fb.c:1765: warning: Function parameter or member 'options' not described in 'pm2fb_setup'

Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jim Hague <jim.hague@acm.org>
Cc: Ilario Nardinocchi <nardinoc@CS.UniBO.IT>
Cc: Jakub Jelinek <jakub@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/pm2fb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/pm2fb.c b/drivers/video/fbdev/pm2fb.c
index 27893fa139b08..6a30096676374 100644
--- a/drivers/video/fbdev/pm2fb.c
+++ b/drivers/video/fbdev/pm2fb.c
@@ -1504,12 +1504,12 @@ static const struct fb_ops pm2fb_ops = {
 
 
 /**
- * Device initialisation
+ * pm2fb_probe - Device initialisation
  *
  * Initialise and allocate resource for PCI device.
  *
- * @param	pdev	PCI device.
- * @param	id	PCI device ID.
+ * @pdev:	PCI device.
+ * @id:		PCI device ID.
  */
 static int pm2fb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
@@ -1711,11 +1711,11 @@ static int pm2fb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 }
 
 /**
- * Device removal.
+ * pm2fb_remove - Device removal.
  *
  * Release all device resources.
  *
- * @param	pdev	PCI device to clean up.
+ * @pdev:	PCI device to clean up.
  */
 static void pm2fb_remove(struct pci_dev *pdev)
 {
@@ -1756,7 +1756,7 @@ MODULE_DEVICE_TABLE(pci, pm2fb_id_table);
 
 
 #ifndef MODULE
-/**
+/*
  * Parse user specified options.
  *
  * This is, comma-separated options following `video=pm2fb:'.
-- 
2.25.1

