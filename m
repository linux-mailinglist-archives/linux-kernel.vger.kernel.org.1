Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1651826F97E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 11:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgIRJnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 05:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgIRJnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 05:43:02 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C035C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 02:43:02 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id e23so7252166eja.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 02:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yzURNuHz4G++YxGUWeyjPl4/b+EZGSxoT1bXkO8QmdY=;
        b=TKx+r8PC4YXw/oizLbp+Y7zgi+vq8xswtGQgK3O3+aINvD9kT9ALVSdziB8OOwpuiI
         BovMwvF4TwC1MnUPbVmhTtFKhYheC2H9OKWdUxgw9xxhQaXLkr0Pms0bkkWHJsm8SC6x
         mv+Ni7xukxXFNC6IqKLvufGQSmrVu0IoU/2w5D+mmxUd8rsykxZHbEjX9BGXZRcgt4Kr
         WjH8nJz4eApBDjXqJv/WULUsZCyLLOA30VQqCDSGw5m43YCrlOUlPNIgjNu2dpaZINKW
         thO//78/Ge6YAJCQgYoB4kpG2d1xvNyeqP4QnzsY/31PK+aXW2rFpU3LyMlNITCNdLjd
         eFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yzURNuHz4G++YxGUWeyjPl4/b+EZGSxoT1bXkO8QmdY=;
        b=iBYUxmvj40giT0j9bhsjGr9dTMYqwrl5gkY1VEzoMlRQJ/xoyH6539/5E9NxDiLERq
         wDmBJg2S/bxuFMD3Z6urCeppYMhZq927KhZ+UeZYJ3IIlxjVsOOjNN9Hj578/C6QM93U
         Z1AV7u6KTH85WjFnj4WYy/p4fVnN53ZyYWBhgGMmS18YbQ0CxhfS5L5VAXE4SaiCE+o9
         Nrp9yS/cp/3mTFqnjvvPa5qXdtFvCHwORliGIvBfHdBLPWF5YcmxPkGNJRK6d0H2uH9h
         jPkFpHk84hEQql8jQT6y4KElFE4/xaLexuurVSQR1gGyctBPwGClj6zbHaj1kqi/0HVK
         Q1DA==
X-Gm-Message-State: AOAM532JX2y1n9mEgyTTu2kKhhccxEs09S4HUmSvUJDtaN203Zj4zInU
        QRxHIyRx/bK8uO/NIJ8kFHc=
X-Google-Smtp-Source: ABdhPJx4bwzAn/1/haSTf8TEN3XO5VpGqorkQTRB11qwLjsHvplO6NuOQmWO/V6uY9yy5Z+Uike4yw==
X-Received: by 2002:a17:906:ce30:: with SMTP id sd16mr34503383ejb.53.1600422180692;
        Fri, 18 Sep 2020 02:43:00 -0700 (PDT)
Received: from localhost.localdomain ([85.153.229.188])
        by smtp.gmail.com with ESMTPSA id dm22sm1798471edb.49.2020.09.18.02.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 02:42:59 -0700 (PDT)
From:   Necip Fazil Yildiran <fazilyildiran@gmail.com>
To:     fbarrat@linux.ibm.com
Cc:     mpe@ellerman.id.au, gregkh@linuxfoundation.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        paul@pgazz.com, jeho@cs.utexas.edu,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>
Subject: [PATCH] ocxl: fix kconfig dependency warning for OCXL
Date:   Fri, 18 Sep 2020 12:41:49 +0300
Message-Id: <20200918094148.20525-1-fazilyildiran@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When OCXL is enabled and HOTPLUG_PCI is disabled, it results in the
following Kbuild warning:

WARNING: unmet direct dependencies detected for HOTPLUG_PCI_POWERNV
  Depends on [n]: PCI [=y] && HOTPLUG_PCI [=n] && PPC_POWERNV [=y] && EEH [=y]
  Selected by [y]:
  - OCXL [=y] && PPC_POWERNV [=y] && PCI [=y] && EEH [=y]

The reason is that OCXL selects HOTPLUG_PCI_POWERNV without depending on
or selecting HOTPLUG_PCI while HOTPLUG_PCI_POWERNV is subordinate to
HOTPLUG_PCI.

HOTPLUG_PCI_POWERNV is a visible symbol with a set of dependencies.
Selecting it will lead to overlooking its other dependencies as well.

Let OCXL depend on HOTPLUG_PCI_POWERNV instead to avoid Kbuild issues.

Fixes: 49ce94b8677c ("ocxl: Add PCI hotplug dependency to Kconfig")
Signed-off-by: Necip Fazil Yildiran <fazilyildiran@gmail.com>
---
 drivers/misc/ocxl/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/ocxl/Kconfig b/drivers/misc/ocxl/Kconfig
index 6551007a066c..947294f6d7f4 100644
--- a/drivers/misc/ocxl/Kconfig
+++ b/drivers/misc/ocxl/Kconfig
@@ -9,9 +9,8 @@ config OCXL_BASE
 
 config OCXL
 	tristate "OpenCAPI coherent accelerator support"
-	depends on PPC_POWERNV && PCI && EEH
+	depends on PPC_POWERNV && PCI && EEH && HOTPLUG_PCI_POWERNV
 	select OCXL_BASE
-	select HOTPLUG_PCI_POWERNV
 	default m
 	help
 	  Select this option to enable the ocxl driver for Open
-- 
2.25.1

