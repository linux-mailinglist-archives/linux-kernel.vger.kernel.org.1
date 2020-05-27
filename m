Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B821E464F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 16:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389121AbgE0Opn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 10:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387942AbgE0Opm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:45:42 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4D0C05BD1E;
        Wed, 27 May 2020 07:45:42 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id 5so1602606pjd.0;
        Wed, 27 May 2020 07:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L0mZZla+RguYf6l2WisG00wd84OrSxW1Va9Lo1ppJw4=;
        b=QASTJzCEOTtsNwR28ZurVRt9NscCH6Z4iZxynX5gVo6MS5DaepEu2RWmPTEOdEM71y
         YDpIG8HDrD/la7Pcjaju8Gv+H8PDNy98YitB6IUVY6Sbu5Ze2h+eRH/+HdqQJWqx3UQm
         GRExhsaTXGwFHo6mYcMg+a/6FFjt3+IY8WfeDq4WctqNnEDblHgOTRD5wdF9cv4yilP4
         8KQOvmcZcdNFoQPZhd1ON6tOfZymhs3TG0A9J6W1NINpa2uMR22N5NfIkU4bSSDbbpsL
         OPjVQ6JKcsx03cqJ4QeLcfhNd0NsBjQ8BriPYMbtnLcZlKcFiE2n0RX1LddyeNXL7rbJ
         fHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L0mZZla+RguYf6l2WisG00wd84OrSxW1Va9Lo1ppJw4=;
        b=coZSfaCNPIv/O3lmtsvxWEUcDe1CmYh3TWiaitM1f6sq9wiMS6/VJgdP9fooH4SEad
         rPO+BjoqJBlk4dJsYDISjD9KbHspmL8IxaZzw94g5Z7uoCW5A1urCyGlC7N+Zqf3GmWT
         lihEVproP2RQrBuTgB0fPlaG1uu0j/+Po08wnj2mh/yCIy+Gd0UwLIlMWLrrioubTl75
         bm/SOqSOSgdpVX6JvD3HHz9g5JUscjPsnMAsC1EnR2DFOlaEM9pCf34xROGU58hGIrRk
         qE8B9K4K4DviFN+LcsRPp59AtjyN6nKc25YYrNa4AwxobtlK5jNydX9k4cWpuTi1aTJW
         e8NA==
X-Gm-Message-State: AOAM533bkp+MtP/EmsP3Gwv55tY/JNW4QTOgp7KwSCsmyLzid2rUOU6C
        hvmTJ0IJeQ7XSMi3iogYA6E=
X-Google-Smtp-Source: ABdhPJwmQ+KbHNTB/Th5LBAsiSh8HrgfWlnBc4peNHPKT4jkUPURVxUkEd2i5gmGVVQjD4Vho0p+6Q==
X-Received: by 2002:a17:90b:515:: with SMTP id r21mr5508107pjz.217.1590590741984;
        Wed, 27 May 2020 07:45:41 -0700 (PDT)
Received: from localhost ([144.34.194.82])
        by smtp.gmail.com with ESMTPSA id i98sm2944735pje.37.2020.05.27.07.45.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 May 2020 07:45:41 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH v1] Documentation: devres: add missing entry for devm_platform_get_and_ioremap_resource()
Date:   Wed, 27 May 2020 22:45:31 +0800
Message-Id: <20200527144531.9376-1-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_platform_get_and_ioremap_resource() should be documented in
devres.rst. Add the missing entry.

Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
 Documentation/driver-api/driver-model/devres.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 89681264ee2c..713b44deb0bf 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -314,6 +314,7 @@ IOMAP
   devm_platform_ioremap_resource() : calls devm_ioremap_resource() for platform device
   devm_platform_ioremap_resource_wc()
   devm_platform_ioremap_resource_byname()
+  devm_platform_get_and_ioremap_resource()
   devm_iounmap()
   pcim_iomap()
   pcim_iomap_regions()	: do request_region() and iomap() on multiple BARs
-- 
2.25.0

