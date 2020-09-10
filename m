Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB2C264CC7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 20:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgIJSYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 14:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgIJSQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:16:35 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296FEC061798
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 11:15:47 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id gr14so10154961ejb.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 11:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BBhGbJY3zVAb5oh6xVMZK8x+cARggvbPy1324MgspqI=;
        b=Dxph1l2HyplaI4zApFt5jVjS/OPFaU7kyP5/ESP+3T3bORNWiO643pXqa92zIcsiH+
         zklJq6tL2pUf8Ec7O3o+zC+9qm+vZLvrIJQMxM1Azvk8aXGfWB5wuCw4CwpSyNMbOO9Q
         UY7+LijRA/c+ELk+tCBHhTIARxZxiX5GBe4cDbZuIxkkVSwagJbXymusyv23X3uH6TNK
         gnkR1F49xQTJHwvNz41r9+GrXKbRH5bPk0fAWJUwzzSA0z5j+jvv/Wn+T3rJH+RaL/Yl
         l6ZxHqS/e/zjpNjIUog+TC4l+ybBxX3uNOuBCGSSht6b5cT77jf9KFNVSSs6eQ3itMBI
         /tCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BBhGbJY3zVAb5oh6xVMZK8x+cARggvbPy1324MgspqI=;
        b=hl6SXcDsarLi+xaFfrNw+d9JJzdbCRw+9Ut4UB//i0Fz04sI9OpEtD2+den6PgO6rT
         yP6sa3meQ+0rPBclyMTTczS7fvQ/geUS2hTs0Z55yKXlQ7g8e0p8cweTjqs/ZXR4Acgj
         rIIqgoVO3GtefNwHFlVQ2MPMfZPlytozpt3AvvsPl9/nJt5vrmO0MAQX+xq+r7gpGB9g
         XLUBo/luKo1zqmxqN0dpBFYmZNyY3eFItDXOw0KXDNOjXHj58IdfkiTFQyu80dJ0awkj
         AWIBumKOhTag42kKxLRojthXyUzD7dx+fcr34Nylks8eKYHKv9TyppHdCnAdpSpkwk9U
         piig==
X-Gm-Message-State: AOAM531Hz3XVGjB837idCOBAQxNRNMAbhvaFb8rCR4YkFjK/puIcmJQF
        P30ti0CrUDKhrOVgUoq+OXUyjM0ZULA=
X-Google-Smtp-Source: ABdhPJyhAxIox0nt5A2XuwHGO8lwYvqTd04ity5d1xVubYhyGfMv/Q9TjFkd7f93m1yu9sYPDuEmnQ==
X-Received: by 2002:a17:907:408d:: with SMTP id nt21mr9884454ejb.355.1599761745164;
        Thu, 10 Sep 2020 11:15:45 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id y6sm8636117edj.50.2020.09.10.11.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 11:15:44 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 08/11] habanalabs: no need for DMA_SHARED_BUFFER
Date:   Thu, 10 Sep 2020 21:15:21 +0300
Message-Id: <20200910181524.21460-8-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200910181524.21460-1-oded.gabbay@gmail.com>
References: <20200910181524.21460-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the driver no longer uses dma_buf, we can remove the select of
DMA_SHARED_BUFFER from kconfig.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/habanalabs/Kconfig b/drivers/misc/habanalabs/Kconfig
index 8eb5d38c618e..1640340d3e62 100644
--- a/drivers/misc/habanalabs/Kconfig
+++ b/drivers/misc/habanalabs/Kconfig
@@ -7,7 +7,6 @@ config HABANA_AI
 	tristate "HabanaAI accelerators (habanalabs)"
 	depends on PCI && HAS_IOMEM
 	select FRAME_VECTOR
-	select DMA_SHARED_BUFFER
 	select GENERIC_ALLOCATOR
 	select HWMON
 	help
-- 
2.17.1

