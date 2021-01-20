Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A49B2FCB50
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 08:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbhATHJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 02:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbhATHJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 02:09:02 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48066C061786
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 23:07:46 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id g15so14588663pgu.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 23:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mj8NkcRMiBcX8enUu0QdAFt4QvkXJ54u28VgjHZrnr8=;
        b=RCNvvfTpxIdN/nNDfGHT1EcShTnBb7HFMbpIVOvEPPfcuiAHYkrYTnuq7rBrspS2gc
         PvxboNcM9aHa/GE7yejLB/Wr4HMsWKHzLvfFXD99uuMRqI9BxCU64HAehQ5AKT2l8/Nv
         ZZKXO35K9jIvLuLIUp5Dx2a2EkE0h74ujyg4fUSQ6kKL0AG0t6RxaPsYO9/xFcG4iOn5
         d7u1rUGnow9POp8IBN9rOisee6bfnSrT37a9ft/fPBF+WZt5/y2AgoEBtqZdQOkBzCED
         vXoDy2QWo/bo+ws6aq+xe4uSpEzJOdanRA7WpSt3wRL5BuR/4njVAq5Uc7inIIOwESt/
         Ku7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mj8NkcRMiBcX8enUu0QdAFt4QvkXJ54u28VgjHZrnr8=;
        b=mijYt41F4Vkc4w6BqQjWYba5iOO3zMdsj+wIEwD02zpt9/TFlfc+UHdmoF0qIia9Bs
         CjuXZjHDAD7vGWroybZfJewCEnKnPAG0T9GmjDkrfMqNCxEuDgzWfufOdVZvQm9QM92I
         IHbxP6b6HMnjbaNhq9ePKFoA1f3FqoeD28kJBBrz8kgVIi8n55voc40IDl3/j3uylPW/
         DXRlA+3RiWyuAV/eyuwJ40/O9OB9dPAAsgwqy36CuYJYLGnpSDxj7xrCtKS1FxG/7zHK
         Be0Jvx5XwQ8lo/k96wTY5Gjhq6lXbjaKzriUahYmZR+KyYbt9HZIXLWSadG6Cq8zL4Pk
         31wA==
X-Gm-Message-State: AOAM532NBtcg7jFhypAgF/45CfYIJEpM4bS8hs/s3nzOOheGZ3pGLdTF
        GtaAN7nWMQSxQEFpDCG1Dewixg==
X-Google-Smtp-Source: ABdhPJxjPS2Eo1iJwhHbaP6ne2bXfC+xNz7zwxpjR3pbzALH6A+qdsMH32vIdns0aexJnjSTk3G/Gg==
X-Received: by 2002:a05:6a00:8d4:b029:1b7:7ad9:4864 with SMTP id s20-20020a056a0008d4b02901b77ad94864mr7762488pfu.34.1611126465763;
        Tue, 19 Jan 2021 23:07:45 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id x81sm1188873pfc.46.2021.01.19.23.07.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jan 2021 23:07:45 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Gibson <david@gibson.dropbear.id.au>,
        Bill Mills <bill.mills@linaro.org>, anmar.oueja@linaro.org
Subject: [PATCH V5 2/5] scripts: dtc: Build fdtoverlay tool
Date:   Wed, 20 Jan 2021 12:36:44 +0530
Message-Id: <2dfec4acb1bfbab08b431908ace0a77cc3279434.1611124778.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1611124778.git.viresh.kumar@linaro.org>
References: <cover.1611124778.git.viresh.kumar@linaro.org>
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

