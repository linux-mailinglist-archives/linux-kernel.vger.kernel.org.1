Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869A02A9F29
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbgKFVhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbgKFVhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:37:04 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951BAC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:37:03 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p8so1961452wrx.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S8hCxezfBEukY2Vv+vLD9fRtFnmoWP6TcMu+uvwdTys=;
        b=zN3HMYCqikaYDuFdN2FyT7u1VRBPEI1jhuTxeWKaEIUEJEKqczXhiXmdNxeF6BmXsf
         xW9j8LJ7SzpuZcqhnLLyfNyoIW3rdRprihAgL0oTBi0RnS2fkAFBNYUSTGrj88V70rLT
         0MV45KU6Qa96eMsyRzSVrCgdDVY6iHGNGWgKOWMcPME6nSjytk/o1eP6y+ligHh3cIiA
         ryg/AXa0ihDFKoEXvUeOkxw2wGY0RyCYut+/y33995zEnQ6MiLrd1IPWtY99+no3nP08
         F4Y34O0g62eVXcCb4JnpX+dBzbAfsNVK2uSnuRCjxVglxPBkgPW1LFnuS9LMkG4JwOId
         f5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S8hCxezfBEukY2Vv+vLD9fRtFnmoWP6TcMu+uvwdTys=;
        b=MnweC+c5RiXZeQAb9yn9ucoqyIx8gKKwcu3vmGaBeXrEUGxz3RGAIbS7hZoYCGMUd/
         iVhlJfw/BYMgE5BbiIlaaBnZPIghckJ2Hvbhx2yYWe9rAEWjW2D/40Ge9da8mF7kTUFx
         NyqH7E5Lkmx+6CmHwa7FsIsCrUhlcAbY1KHD7Jebc/dnNKfrbMEOciHa2QkVMU06b05i
         IT0kp98IPifisbHQtSP+tQQk/2OvUN54s56FkJgFeEBZU+pe+5XJwnrNpzNCsNG91uZ0
         ISxQiHrq2P9/lp/rnp03zFFBS2qPE9gskogh1uRDFI0VTltoXB3vOmdMRIFMXf8QYIrv
         hH4A==
X-Gm-Message-State: AOAM532rlm/1m30peKa0vrcYrT7MDDG/I444HwiDTxFpixY8oHVsLc10
        0HHnJQKJHR8MzB7eBSrH6EM95g==
X-Google-Smtp-Source: ABdhPJwnOfmE+grSUy3IUuxC8O/dxfml4JKVdl13CBjGOKdbiK0k4DZK2tnynZ8Gmo76dXrd+t6Thw==
X-Received: by 2002:adf:ce12:: with SMTP id p18mr4707669wrn.52.1604698622355;
        Fri, 06 Nov 2020 13:37:02 -0800 (PST)
Received: from dell.default ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id d16sm3984942wrw.17.2020.11.06.13.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:37:01 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        =?UTF-8?q?Jochen=20Sch=C3=A4uble?= <psionic@psionic.de>,
        linux-mtd@lists.infradead.org
Subject: [PATCH v2 02/23] mtd: devices: phram: File headers are not good candidates for kernel-doc
Date:   Fri,  6 Nov 2020 21:36:34 +0000
Message-Id: <20201106213655.1838861-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106213655.1838861-1-lee.jones@linaro.org>
References: <20201106213655.1838861-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/devices/phram.c:19: warning: Function parameter or member 'fmt' not described in 'pr_fmt'

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: "Jochen Schäuble" <psionic@psionic.de>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/devices/phram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/phram.c b/drivers/mtd/devices/phram.c
index 087b5e86d1bfb..9e4d60bd427fb 100644
--- a/drivers/mtd/devices/phram.c
+++ b/drivers/mtd/devices/phram.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * Copyright (c) ????		Jochen Schäuble <psionic@psionic.de>
  * Copyright (c) 2003-2004	Joern Engel <joern@wh.fh-wedel.de>
  *
-- 
2.25.1

