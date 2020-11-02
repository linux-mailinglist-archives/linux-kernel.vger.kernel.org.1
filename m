Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFACA2A28CE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgKBLMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbgKBLMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:12:18 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2912C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:12:17 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id i16so8678650wrv.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WMZ5E1t1qQDSNwAwpQ30Zb2v4pyVaA5GpDGSolOQX1Q=;
        b=LBkxMl1lb0htq6UhKF5X3dV4UZ8HXQB0VsMvKeHXq8qGpaBdu4hG+1ovwTdvcX+uim
         umSR5iuJd+5K3Wgxb2Y1xfz0hovT6n8krHEnaS3T3AuNiMMYImSPc18CkH7aTskfG2Lz
         BFX4y2RgMJKr45IyqhKd8IBV2dssKps0fHrylhQ/ENnP6HycTkXPXKIwC9hPHlrpiCj5
         fhAeyhtv0vETqq4WctThTpwmuKEib0kF3VwllEepNvMmXYnw1iKpQjnsZV4C+jd1zLFy
         +dM7yhP6NJIaLYn26lLHnJ354evxWgtNLiqHJuA+48nyxwwuk0vVfF0BvXNOqvHCi6oG
         Lz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WMZ5E1t1qQDSNwAwpQ30Zb2v4pyVaA5GpDGSolOQX1Q=;
        b=pL7KgbEuhrNtja01awY4mtkOnm+zdJWK2bEQMXum5JHzmU+lXig/2StOEuxryD8aMh
         fpFbdEvuTc0dbV36j1CXdBRawzYE+WJvpBg+9US97KdZhVj7cw80eUVr9WuLwpAY5t3C
         ckIS0GEs3X/tjs+72Jn0w6ZvB6FNqB+DAsp7pkevwAj1zyR48HVhObhvwSnhNnIfI17t
         Il8G/LeUDei6WGzImtmdzrUppLO4M5yQIsm/pi+lJElgbuUUm0ajzq4EwzzlyY/Xdkl4
         27Bno9XwyRqn0bMOggFFLYOz4AGFEvcqK9YBdsPkSkhWoq8Sj8JH0zDHkFM/bDZ2AIeZ
         5i1Q==
X-Gm-Message-State: AOAM532iIuJi6qatDaUeH7TMDSy+RxCeS6R7z+5kFSLcRE0/3k8TJVQZ
        6jIvd0aW3rO1WekiBLXuQu7gTQ==
X-Google-Smtp-Source: ABdhPJxFM1/0yWDQjZqgHdoWsIZK0844ZEFz2gcDyTA+tLjIU9hOJSlbeWI6QEjZuMSGxOVtNSJb9w==
X-Received: by 2002:adf:df91:: with SMTP id z17mr18938665wrl.379.1604315536326;
        Mon, 02 Nov 2020 03:12:16 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id v24sm22431972wrv.80.2020.11.02.03.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:12:15 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] misc: ocxl: config: Rename function attribute description
Date:   Mon,  2 Nov 2020 11:12:11 +0000
Message-Id: <20201102111211.1047972-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102111211.1047972-1-lee.jones@linaro.org>
References: <20201102111211.1047972-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/misc/ocxl/config.c:81: warning: Function parameter or member 'dev' not described in 'get_function_0'
 drivers/misc/ocxl/config.c:81: warning: Excess function parameter 'device' description in 'get_function_0'

Cc: Frederic Barrat <fbarrat@linux.ibm.com>
Cc: Andrew Donnellan <ajd@linux.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/ocxl/config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/ocxl/config.c b/drivers/misc/ocxl/config.c
index 4d490b92d951f..a68738f382521 100644
--- a/drivers/misc/ocxl/config.c
+++ b/drivers/misc/ocxl/config.c
@@ -73,7 +73,7 @@ static int find_dvsec_afu_ctrl(struct pci_dev *dev, u8 afu_idx)
 
 /**
  * get_function_0() - Find a related PCI device (function 0)
- * @device: PCI device to match
+ * @dev: PCI device to match
  *
  * Returns a pointer to the related device, or null if not found
  */
-- 
2.25.1

