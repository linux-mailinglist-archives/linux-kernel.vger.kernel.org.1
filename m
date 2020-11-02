Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7A42A2A17
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgKBLzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728838AbgKBLyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:54:32 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D2AC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:54:32 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id c18so9105842wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=agE410NhHkG/VilLjKYAizauXJMrtB10xUIGh/10Z74=;
        b=efDkt69iAXIfaFShsw8QdN8pMdlUr14fnqgER9/XWjM85qTpoLusGukH1GUpZoscQR
         2xzVomzsolZiM/cbJD2su7dGPNYjJIy1CpfOLwpKh6C3avFQzLVJxUsMif+2EoumKkg9
         qZ6x9zOQ7axeibb2gKvbLzzyP7ITWrBtWEdhhf0ZIbuI/ky0aK5diuxkjJtY405VPngU
         qbKmSEGfaXJsn4B/LeAbws3mRDGAK/uiUkXdgLgNepay+avLJAbhbj6IDJ1tBCQN26Z+
         ft+Ic1S3BNKvYLOg32UFxsHOkIhJaIk0gdBdgCLgDWjR2im3npYFNFelsQIPCtS9FuVy
         TntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=agE410NhHkG/VilLjKYAizauXJMrtB10xUIGh/10Z74=;
        b=Mm0PoNrFK/mxfuxA6Ryt1m9ZXrHs86gkMHBAT0siT33F5u3KFu5oHVVeIfVv2Q6LlS
         476o7lDP1nAL9VkDM51yKTIpBCA3/8nkaIZ8EtyZal1MELoSsu5wqFwN4uYrtkYSgTMl
         3d0x0FsX6uvhKcd67SfB93psaDfsQu31yapI6M/RmobHz1+FgFecBgPJ3IGtOGLKVToW
         18fOdFZjqRl6VfgsoFjn6ouVzLZWb1VDHuh18juoLDZ2abO++P+j+1PrR99nxvUOVTaY
         pPLDOv8YtJlQhu1N3zPBA5jSt6y/FPFEXcKdUGu7lhlJnW+8UKPLWxJe/wfYL0Lj5h7R
         InAw==
X-Gm-Message-State: AOAM533WtjkUGPiUAI13ruAxh9WrxQtBfFFXb6l8XF/NAWVb7KPv6u7p
        p8qrBiiqpt1X3a+oRyqnqXZGmA==
X-Google-Smtp-Source: ABdhPJwbjEHHr9F/MB3xAbI8XwcE4zqRABiYKvggAy+sYEL/4jiPJ2Srwe7vzWC7+ZG2ZhZubwUXfA==
X-Received: by 2002:a1c:7e82:: with SMTP id z124mr17324424wmc.8.1604318071129;
        Mon, 02 Nov 2020 03:54:31 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id t23sm14284010wmn.13.2020.11.02.03.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:54:30 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     vigneshr@ti.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 14/23] mtd: ubi: gluebi: Fix misnamed function parameter documentation
Date:   Mon,  2 Nov 2020 11:53:57 +0000
Message-Id: <20201102115406.1074327-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102115406.1074327-1-lee.jones@linaro.org>
References: <20201102115406.1074327-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/ubi/gluebi.c:446: warning: Function parameter or member 'ns_ptr' not described in 'gluebi_notify'
 drivers/mtd/ubi/gluebi.c:446: warning: Excess function parameter 'ptr' description in 'gluebi_notify'

Cc: Richard Weinberger <richard@nod.at>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/ubi/gluebi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/gluebi.c b/drivers/mtd/ubi/gluebi.c
index cc547b37cace5..1b980d15d9fbf 100644
--- a/drivers/mtd/ubi/gluebi.c
+++ b/drivers/mtd/ubi/gluebi.c
@@ -439,7 +439,7 @@ static int gluebi_resized(struct ubi_volume_info *vi)
  * gluebi_notify - UBI notification handler.
  * @nb: registered notifier block
  * @l: notification type
- * @ptr: pointer to the &struct ubi_notification object
+ * @ns_ptr: pointer to the &struct ubi_notification object
  */
 static int gluebi_notify(struct notifier_block *nb, unsigned long l,
 			 void *ns_ptr)
-- 
2.25.1

