Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F5F2C4AD5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 23:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgKYWfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 17:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgKYWfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 17:35:21 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DE9C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 14:35:21 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id e8so3718467pfh.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 14:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z/shZxNcr/eh0s1FuPq4mg6XiplTCtJuhBAv+UXex+8=;
        b=bpzMW+GynMFKqUkOYAjiijs9fsMAcvOedHf3RUCzT9X4/7+hRRR7vjMjDgWSFfInAZ
         eIbmX2h8CA1OicjN9wpICFqkcuc3HLlqPJ2t/LKeqsm9/WWM/r3FwxIUpopYOa7kuxav
         3I6wnaZhD+tZBKP9b+9GwGOj5VuCJOWgSeQRiFFNFG6YsJMUPRGAMY5mp/QQ3T56prxu
         NqulMwBtIDzVnUSDCL+wLuOGJBabIwkW/qpvab9oA7jM+GLOri08v3DGSoQm4DGkz6jK
         SIj6bQX0sd0PHjiQig465r3TScoVucN5C8H1X8WRfJdOiOd68tVXISUyNfJQnpdNjsp3
         7x9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z/shZxNcr/eh0s1FuPq4mg6XiplTCtJuhBAv+UXex+8=;
        b=U495YBAI6wRcnA9xwMXl7o6oMEdoBgkKwThgcPdy+s9avc6ThyN7v1Hc4wzM558toc
         PFB02i0x5Be2cCC9utJfuwfX4L2e81KBBOBwy1GlCaxKc1+9eQwporEypgd0j5RtGhFs
         0PQ6YQ7jkv5NkkqR3Omgl5xKipdR5vZKrPE4dZhucWWCvUkajG5ygWmMfZvW+GfdlYen
         zeHdKUsLyj911sxAopyAdlGdKUUHTxNiJ5HfD/pR8kK7FAM+WDF90dfzwX8h2pHinqSk
         bpQrWZHIOPMl+xsSFfZx/5EgXIqNCzYdLTBWqcizeGavIjTi4MhZtoMOb6jfD9Hsr3zn
         C9vQ==
X-Gm-Message-State: AOAM530SzseXbaWZSqMiYmRFmJ51v6XcHsVJnTet0bEK0K+L2KIkMCWQ
        l5YPdGYb0GTAZewIb3ICKIfbyA==
X-Google-Smtp-Source: ABdhPJySg7H6dcqT/0/aaGtTbkmNgT1BvtM/9DLDr5iEtrmCXLEQ5ca7T5YwqL7c1B3dNglcF6CYDA==
X-Received: by 2002:a17:90a:f406:: with SMTP id ch6mr6917481pjb.88.1606343721031;
        Wed, 25 Nov 2020 14:35:21 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id w18sm54577pgf.30.2020.11.25.14.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 14:35:20 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org, suzuki.poulose@arm.com,
        leo.yan@linaro.org
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] MAINTAINERS: Adding help for coresight subsystem
Date:   Wed, 25 Nov 2020 15:35:19 -0700
Message-Id: <20201125223519.734388-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the steady stream of new features coming into the subsystem
it has been clear for some time now that help is needed.

Suzuki and Leo have worked extensively on various parts of the
project and have agreed to help.

While at it add the new location for the coresight git tree.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e73636b75f29..8d0b008c7781 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1723,11 +1723,13 @@ F:	arch/arm/mach-ep93xx/micro9.c
 
 ARM/CORESIGHT FRAMEWORK AND DRIVERS
 M:	Mathieu Poirier <mathieu.poirier@linaro.org>
-R:	Suzuki K Poulose <suzuki.poulose@arm.com>
+M:	Suzuki K Poulose <suzuki.poulose@arm.com>
 R:	Mike Leach <mike.leach@linaro.org>
+R:	Leo Yan <leo.yan@linaro.org>
 L:	coresight@lists.linaro.org (moderated for non-subscribers)
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git
 F:	Documentation/ABI/testing/sysfs-bus-coresight-devices-*
 F:	Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt
 F:	Documentation/devicetree/bindings/arm/coresight-cti.yaml
-- 
2.25.1

