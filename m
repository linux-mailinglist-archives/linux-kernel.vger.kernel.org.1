Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F102C6B03
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732740AbgK0RxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732711AbgK0RxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:53:14 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAFCC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:53:12 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id 34so4861651pgp.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=85JS+8ShgHGSS44fUukDoAiKL8KJ56VuugKdFyLJtn8=;
        b=bNnyvOK7m1LanzHzqDoJe+5ZtWCgOMSDV3e9cCLFsQwtlHVW/epkEQe0pXPe4g1mq7
         qr/z3PKMNyJJKw6XTMHsoJZppGXLgazMGmc9fExy0aXgmXZNmVg1exTlDqQsSC9dAxL3
         zAYuGcP6H2UsuZauREQqKiuR5nvmvYUOmgTM6QKEMzNfFoXNFoTxdXkeUN/ZkVblCg4N
         jc+AmGpHwOtntKremMVLVd9RgnwyWZNBXzapgJ5c5tjyA6ZmkjwWVQheBe+4n8CgxgX4
         nn1LOJMAEBzRqlHXRpatgBgDxcpiq3QkTwoPBOh9uI+gjsaCyhB0Qv/6gVEgi+2z9C4D
         rQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=85JS+8ShgHGSS44fUukDoAiKL8KJ56VuugKdFyLJtn8=;
        b=RlGlKW/CFySwyNHI2IdH/5o06DCiSRGvGlBSkOSqyTRJ3DYnfuYVq5+3m1FDUc4Uma
         OtzeNeheyBoXMHgvkNDZBJsPwdxWYAQwL0m8dRdhvY1Q9FlMuigAEWGDkHJcuxdAQkvb
         IC6DrcEzbHm14RxyT43ZaxmaE4xfm5Hb7uwmblZwzQk1pvFNxn01eNEIiuWNfc0T/7ol
         Z9vNjTYhm/ebXQ5SnKezbBjUONdmkg3lFmkkhoS90Qs9vgn10D3z4TDVdjvRJ/rqEjvP
         gopAOF3cTl1/1ugIzKhk0PeFG+VzPqGiDBdhw7DitlCjrrbo+QashKAlS1lRSOkDSiii
         HPUA==
X-Gm-Message-State: AOAM532rGKissGPQZsVw23NNgk0L6Jh2xjufBhF4YLjdEQ+MUwwYgaPe
        9OT4uUlWBj2ltdghXUtH6vrCfQ==
X-Google-Smtp-Source: ABdhPJwy61d+Yu899yRPw1qBoYAqqAfXCFpIr4iBgNUT2fdp3XYBapJnm8C5VOtJ+JolB17H4iUExQ==
X-Received: by 2002:a63:3308:: with SMTP id z8mr2389546pgz.93.1606499592051;
        Fri, 27 Nov 2020 09:53:12 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id t18sm10536724pji.1.2020.11.27.09.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 09:53:11 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/15] coresight-tpiu: Fix W=1 warning in TPIU driver
Date:   Fri, 27 Nov 2020 10:52:55 -0700
Message-Id: <20201127175256.1092685-15-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201127175256.1092685-1-mathieu.poirier@linaro.org>
References: <20201127175256.1092685-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  CC      drivers/hwtracing/coresight/coresight-etm4x-core.o
  CC      drivers/hwtracing/coresight/coresight-etm4x-sysfs.o
  CC      drivers/hwtracing/coresight/coresight-stm.o
drivers/hwtracing/coresight/coresight-tpiu.c:53: warning: Cannot understand  * @base:       memory mapped base address for this component.
 on line 53 - I thought it was a doc line
  CC      drivers/hwtracing/coresight/coresight-cpu-debug.o
  CC      drivers/hwtracing/coresight/coresight-catu.o

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tpiu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index 566c57e03596..010762a46087 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -49,7 +49,7 @@
 
 DEFINE_CORESIGHT_DEVLIST(tpiu_devs, "tpiu");
 
-/**
+/*
  * @base:	memory mapped base address for this component.
  * @atclk:	optional clock for the core parts of the TPIU.
  * @csdev:	component vitals needed by the framework.
-- 
2.25.1

