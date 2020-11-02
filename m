Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59A72A2C92
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgKBOUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgKBOUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:20:07 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC509C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 06:20:06 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id h62so4845153wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 06:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WMZ5E1t1qQDSNwAwpQ30Zb2v4pyVaA5GpDGSolOQX1Q=;
        b=oiIaP9Badbgwu6QFpYJ9CsxpG5czjN2vku9ZNvB9kwytZowUyfn5yg5e7GsH5eW8i+
         HvHd1MPW6YkXOEFu21i7+zAtirx2opS8FAGdXxByo+GH8iovk7bW76+knFUVPlZvn80z
         bbXbT+LKuopP0Rqx0gUdeIxSmjn/ON5sFVUdhIVdUMrPYo7Exafg3O/eWZZdTtoW5LBX
         qVVKY1FKlnRvE2JEAA/jCFm+Hqvs32Bnr2BIDc5wjpvqIJUnhivVymzYlTiR4ERXqV/9
         q6JpXpILw8YhI1gNELoSTHceJjOa5EMn5KGh4hbQm2/C0PDcV3cqv8v3Q9TMcfNn4NiI
         +wGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WMZ5E1t1qQDSNwAwpQ30Zb2v4pyVaA5GpDGSolOQX1Q=;
        b=TFukWsThTk4tfbb+Lc4r/WX5D/ovTJzH9Rtr1ub7RgRPAexVmR52TQ+BVXzrZ0shf9
         /Qeij2Rl96+CyFIdkeDw8qCExX9FxeIR7Zr5veO2LzmuA3Ci67/CK0IaWuVCQ07+dTP7
         O1CM/r1vxu/QkFXca10w7RF8gVz5tOs0GHmm7NQF2XnNQwca+1TsVDVMvH9dTTfJeQyR
         d7u8iitqmr9og6lnlIkRLkAJW3VrIJ9wY5oNJ/oD5KozG1nGHrPdMFpTjZireqEw0FrG
         u2GR10nZmRbb1G2WC5y56qKDjJGggB4ix2YkV2KXShcCJbucdVdm3CmGqzpfz5+iw3oA
         jfog==
X-Gm-Message-State: AOAM530w1OnZLvF1PfVGNoI6irUocZ9leAjd87tHqxKa0w8ZyhEZhDdf
        WLkuhizn1q6AoT0dFolgp213Kg==
X-Google-Smtp-Source: ABdhPJytjMicCjCL83paCEpnhL0UDEWTAFZl6rkXpfqixkC7yRArs0HNsBUVxg5/5SbL4TgRS5uu3A==
X-Received: by 2002:a7b:c418:: with SMTP id k24mr18745179wmi.118.1604326805546;
        Mon, 02 Nov 2020 06:20:05 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id 30sm22331472wrs.84.2020.11.02.06.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 06:20:04 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/2] misc: ocxl: config: Rename function attribute description
Date:   Mon,  2 Nov 2020 14:20:01 +0000
Message-Id: <20201102142001.560490-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102142001.560490-1-lee.jones@linaro.org>
References: <20201102142001.560490-1-lee.jones@linaro.org>
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

