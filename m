Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D021E301620
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 16:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbhAWPCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 10:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbhAWPCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 10:02:36 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B87CC0613D6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 07:01:56 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id v19so5866523pgj.12
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 07:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d4+SnLL/pfB4tjH64DZnSxWRgwnT8YcDl9zMUSjSJFI=;
        b=pZnfm94LD+NPwfT1XQ+rFjjC8uNFpYNgO2jTBFUS8l/5YcxRyn0k+dMEnOdzShD3IT
         qJb2t/Ec7hnooKnjaESg/KyEEs2uzpei23EgjG2dsndUET5a5lwqtEKBj7uvZ0/j6zym
         QuOkt7bXmS4m3G7weNFgE5XJAFrTTFnXDFQcQWkeNX7byizGXHAvRhZMDqmqHV6ckg2u
         OYget8yrcGSD32UFPwqWGrKNLzWV/N5iTBtJdiEnzDivPV0BAN2HneMaCLcvhU0eCDcA
         SZiXX+KQXhK5//1r8LMHVmRV/hv+0rJ5luuIBIpsj4Nrddzq/4p1gzHSuTc0aVTjpt6N
         dKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d4+SnLL/pfB4tjH64DZnSxWRgwnT8YcDl9zMUSjSJFI=;
        b=pcQOKGbBQ0d684Afl7vcDOvOSSpmEIxjZGYI4kCN0pHBzUBfZxjkhD1ugi7amVaxmd
         bJNSgD6Om7+l025sWjgkoKW3bXtNlLJDD32lhnwRJGaNQ7uSrDOV+ZpPLlpCU/a2vSc+
         otUMGgt0RTfidapNksjeKKglthPh1k3iXNJt0JkhgHAJdx6aikvBr9ywvg2ohSEGz4Xq
         55uaZT3QT4W0AMKHrJ+sr1WQUOxI9XwW5q6jUm5oc9wBrc5ygcLxkpDnIow/gjSDLm6d
         3DtxDIPLPSvJ/farKpVe5hPCn2kmrUnvicAr8pwocr+JmkV6sVrq461IAa7xpCFUWeC4
         HsOQ==
X-Gm-Message-State: AOAM533Cq5dv3TCr6uLbV4VzBff3ZanZ04K0KnGLP8ca7nxz2EMvpu+9
        goBXiSa3fMPVk6jzu096SMWoAcc4d+i0Hw==
X-Google-Smtp-Source: ABdhPJx39ei9ufwcC7Nlhq6LXgobQBDJqAJJfrOParl7AXD5F+Z9a1GdTGVBSHAOUEcAeEQln7CXYA==
X-Received: by 2002:a05:6a00:2281:b029:1bb:15d2:3b9f with SMTP id f1-20020a056a002281b02901bb15d23b9fmr1311253pfe.25.1611414116191;
        Sat, 23 Jan 2021 07:01:56 -0800 (PST)
Received: from localhost (42-3-19-066.static.netvigator.com. [42.3.19.66])
        by smtp.gmail.com with ESMTPSA id l2sm10753462pga.65.2021.01.23.07.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 07:01:55 -0800 (PST)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     kishon@ti.com, vkoul@kernel.org, zhouyanjie@wanyeetech.com,
        aric.pzqi@ingenic.com, paul@crapouillou.net,
        linux-kernel@vger.kernel.org
Cc:     Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] PHY: Ingenic: compile phy-ingenic-usb only if it was enabled
Date:   Sat, 23 Jan 2021 23:01:46 +0800
Message-Id: <20210123150146.11208-1-hqjagain@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should compile this driver only if we opened PHY_INGENIC_USB.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 drivers/phy/ingenic/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/ingenic/Makefile b/drivers/phy/ingenic/Makefile
index 65d5ea00fc9d..a00306651423 100644
--- a/drivers/phy/ingenic/Makefile
+++ b/drivers/phy/ingenic/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-y		+= phy-ingenic-usb.o
+obj-$(PHY_INGENIC_USB)		+= phy-ingenic-usb.o
-- 
2.25.1

