Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931C03000FE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 12:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbhAVK53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 05:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbhAVKvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 05:51:48 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DD6C0617AA
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 02:51:05 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id md11so3475627pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 02:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mj8NkcRMiBcX8enUu0QdAFt4QvkXJ54u28VgjHZrnr8=;
        b=INxEBZOQHpe111nBfLB+3bNd6+RN9DFzc2OWu9iizQXyYIdz4XMaOf/jxNFMJBgmms
         vosF1GBO+qfSFoc+neKr0WcW+8P6DXBVECICNv3zAZ5t+CpDFhrmDlLyNdDwEVlWoeUj
         MBw2Mj2SYZt+XxyiQ4EKRqiNY/7+gu0R5LBVgu1DT3Fb9YPU/yl05KjbPi+QNaZhmUII
         9nN0rJfXEqKDTwtOSS1+Zwg0UhGxrFEoHNDaRkzRUdPH6g9hJcfSlo4Vd8plEC5Ty2AD
         LDFRixw/0gs70JkvlZuhGt+qO+BMV4hciyAWWj5zx3gbSC3mdAYLNo5L2kW4n1GovZG7
         LmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mj8NkcRMiBcX8enUu0QdAFt4QvkXJ54u28VgjHZrnr8=;
        b=WN8NYD2Y1RXi2iO/poBvX3tBuLD3HU56Nssh0iR+7J4nXvYFOnu7Ogdt/fUKpsRBCg
         DLE+g6KLv8dnzKEJDASYCsq7aKKK7UeCjGx4XtNHARjqSrAZuVwp9X6QAYUFudFAebMA
         djhssn1PNc6oCQfJ9dTT7KaM0tbA1wmVe9ojMuzbs3nSCjhnhG92B5Sbplzryt0EAj1j
         p3RxKuyEKHIWe5x3bA686z4XT9Iln1SCdGHUCn92cDWkRW68zqhGJ/PrCvXRNsEiFgrJ
         QHzvPM96jO25cSwA3Bgb5W+EayjhcMe/TaFuLaV4qCfzJnZooO19DlDdQm+kZOXjlGOK
         OOKQ==
X-Gm-Message-State: AOAM531VkPU8xwNeWVkZRT+tsSTeGqQQaq10/5dxvUB6XNDKhi2590u0
        qQ1V/ml+wkcjFA0qkYKq2lDszA==
X-Google-Smtp-Source: ABdhPJzzrRNMWc6u8vjsE/paDaL9qnO2/wq10WFkIh3pP+ZA1JjkWDpQESqc3BWG4h6v41bQshBi1A==
X-Received: by 2002:a17:90b:1a87:: with SMTP id ng7mr4801788pjb.211.1611312664993;
        Fri, 22 Jan 2021 02:51:04 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id c189sm8682506pfb.175.2021.01.22.02.51.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jan 2021 02:51:04 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, anmar.oueja@linaro.org,
        Bill Mills <bill.mills@linaro.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        devicetree@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH V6 2/6] scripts: dtc: Build fdtoverlay tool
Date:   Fri, 22 Jan 2021 16:20:32 +0530
Message-Id: <2dfec4acb1bfbab08b431908ace0a77cc3279434.1611312122.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1611312122.git.viresh.kumar@linaro.org>
References: <cover.1611312122.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will start building overlays for platforms soon in the kernel and
would need fdtoverlay going forward. Lets start building it.

The fdtoverlay program applies (or merges) one or more overlay dtb
blobs to a base dtb blob. The kernel build system would later use
fdtoverlay to generate the overlaid blobs based on platform specific
configurations.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 scripts/dtc/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
index 4852bf44e913..5f19386a49eb 100644
--- a/scripts/dtc/Makefile
+++ b/scripts/dtc/Makefile
@@ -1,13 +1,17 @@
 # SPDX-License-Identifier: GPL-2.0
 # scripts/dtc makefile
 
-hostprogs-always-$(CONFIG_DTC)		+= dtc
+hostprogs-always-$(CONFIG_DTC)		+= dtc fdtoverlay
 hostprogs-always-$(CHECK_DT_BINDING)	+= dtc
 
 dtc-objs	:= dtc.o flattree.o fstree.o data.o livetree.o treesource.o \
 		   srcpos.o checks.o util.o
 dtc-objs	+= dtc-lexer.lex.o dtc-parser.tab.o
 
+libfdt-objs	:= fdt.o fdt_ro.o fdt_wip.o fdt_sw.o fdt_rw.o fdt_strerror.o fdt_empty_tree.o fdt_addresses.o fdt_overlay.o
+libfdt		= $(addprefix libfdt/,$(libfdt-objs))
+fdtoverlay-objs	:= $(libfdt) fdtoverlay.o util.o
+
 # Source files need to get at the userspace version of libfdt_env.h to compile
 HOST_EXTRACFLAGS += -I $(srctree)/$(src)/libfdt
 
-- 
2.25.0.rc1.19.g042ed3e048af

