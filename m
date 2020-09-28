Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700ED27B1F6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgI1QfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgI1QfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:35:16 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13355C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:16 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 5so1330698pgf.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mhPB3SD/cztsuX6qmnMAjYP7h5Xc/N3TOgnRL69WxQw=;
        b=kr5Oqg5rgbz+BE0HjhxRGQ0QNlBinYZaTbP54+Sd6w6eBPbj26puveFA1Cthla3RqE
         Uf7rYMAcA2u+JKZMg5NYq8vhnEAP+76BIp+1+rqocckJmFbQ6+loEK2mcOsXK7Vod4Cx
         1NunEZTKPcasUe/7hOPTXIIxSGotv9nV1iui9r1KdkXjJpaOOMfr8p/Ny1mw8adO+YtA
         8vpl+pcXGZQbJjUXkRP6b4a3RCOgi543JumvbiKQsevxqbvZUNb05CtJnFytwrN+DbpX
         UpCRwn6XB6Ee6Y4s3GOEzItYjPWjYBnzrrJOBV3X+Fq4mP9s5UpSXKX4amscgCK59eVf
         Z/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mhPB3SD/cztsuX6qmnMAjYP7h5Xc/N3TOgnRL69WxQw=;
        b=pbi2S44x8+HJJeRB1kQdjqAdGBLIwHNtmRAjWj6uSDIFh3I/6RMFyQwoNhEC8zchMD
         VmOmYax0q3nvj6+66InaksecpHa2ETBbjw96nLXtIAlMQTtDlex9kvKTYUOyP3FZJ17u
         ef9T7NOdzicqqvBEvYftg058V7QoKfwwZkn3LMdotj3xcmkYPSkiPG8YtrzrzaaeFwTU
         9fniUJyQnk+swUKq5trUn7dPBECaXZ63UmlFQT9ULbO/d50KrUBhWrbYbxOsoF9/jrFE
         LHIUeCvFBlZsAmkGbxkXfi6oAz/H7GSRpFZTV1GwyvxVQPL7p6JoLG2A2d5918sRmUK3
         b3Kw==
X-Gm-Message-State: AOAM532IgmxdmssaA064cghhqbf0DbBSgaKApvIHVxO+LDKvydlCeL4t
        Uy/9QENd1pp9Cb89oJqRx2x63oJNo/ACmA==
X-Google-Smtp-Source: ABdhPJx7cmBJ7mcYC0d9P9oJ7xWnnGRLozhDMrgPge4N7B9k8b8V7InFSl4AG8SbcGN1tN38cR3jjA==
X-Received: by 2002:a63:7d8:: with SMTP id 207mr1794517pgh.173.1601310915642;
        Mon, 28 Sep 2020 09:35:15 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id f19sm2345640pfd.45.2020.09.28.09.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 09:35:15 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/25] coresight: cpu_debug: Add module name in Kconfig
Date:   Mon, 28 Sep 2020 10:34:49 -0600
Message-Id: <20200928163513.70169-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928163513.70169-1-mathieu.poirier@linaro.org>
References: <20200928163513.70169-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tingwei Zhang <tingwei@codeaurora.org>

Provide name of cpu_debug module in Kconfig help section.

Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Tested-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index 02dbb5ca3bcf..4663fd1bbffc 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -110,6 +110,9 @@ config CORESIGHT_CPU_DEBUG
 	  properly, please refer Documentation/trace/coresight/coresight-cpu-debug.rst
 	  for detailed description and the example for usage.
 
+	  To compile this driver as a module, choose M here: the
+	  module will be called coresight-cpu-debug.
+
 config CORESIGHT_CTI
 	bool "CoreSight Cross Trigger Interface (CTI) driver"
 	depends on ARM || ARM64
-- 
2.25.1

