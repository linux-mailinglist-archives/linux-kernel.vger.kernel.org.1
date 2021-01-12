Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE942F2A10
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 09:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405292AbhALIab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 03:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404835AbhALIaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 03:30:30 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A650BC0617A5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:29:15 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id n7so969477pgg.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R5AyTeEPJ4vRX5PQgPjGJ2ekXngPExcnmW5K8mA9ndI=;
        b=HNBCP45uMqAb3GYX1SPufcwilF/tFsFtyhEhjE2evQiVwZHQVWsYY7AZB49MMLxX6t
         hXp28EO9FPODeKvgpZZz8PvkjlWAm+0vkLRcXaGORIxWkkDxKl5JXWsOZaLXvG2gg01n
         /joKtPPF29ImmwZTNpGV5sHM5GZDGw9SLNiSwg5/habd551C13NN0huKn39AP7ckdjFB
         DKexvzeSRf9iYBGpYbXiRFEXbfeh1UzfvZab0P1gBdLCSVqoQWjNFpDsFa6rPqYI+0w1
         W+GyYmeAUickV3otbA6csurB1Cht5sncN58JPYGsRG0nLf+wTbeEf0tinMuwF3iKXpqu
         3y6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R5AyTeEPJ4vRX5PQgPjGJ2ekXngPExcnmW5K8mA9ndI=;
        b=mFfTO55raajsH4bBOedQGp31VbsJbTlz2h20wDRRHz+qvFW4keN0ugkr5nsgcLMYP0
         iTNs9MWwUAzAOMD1f1HS5e+LlUWijGIF4CHA8LQpdD8ZlZFQ9mhRGKS91/Zvqw7VvLdK
         XOyfvnsXPc2/6qk6/NwZ6xjcVR22UMv1r6ZMnQREJ4ND6SUWICp64RXmTWunXBR3S1NN
         I9PU6QSr8TQihfS3Ozgr2/Pho5EwhRMb61DQxef/gvqWtc64TINnA95IOzSg5LOL5IAu
         qjooNnD5qqaYL76074eDuj0x4hGXd71Vpo8O8RUcIwpuO8SyXV88xzqCA+sq8X5nxDRX
         B4PA==
X-Gm-Message-State: AOAM531V3xNj3m6gxNpnV+f1OeUyP1HbPVboDIyJsupAQMrScetKl9GG
        ZKBuv21cM9diSO/ay+ksvZiAcw==
X-Google-Smtp-Source: ABdhPJyi6voJlQYIRaZwp95Ebobizeh5zfKRf/lsVP6Y9YJQBdQw0kKRZsuNQfs2TIbd3zEZe7XOtw==
X-Received: by 2002:a62:7b86:0:b029:19d:f996:44f3 with SMTP id w128-20020a627b860000b029019df99644f3mr3562196pfc.65.1610440155263;
        Tue, 12 Jan 2021 00:29:15 -0800 (PST)
Received: from localhost ([122.172.85.111])
        by smtp.gmail.com with ESMTPSA id i67sm2258873pfc.153.2021.01.12.00.29.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jan 2021 00:29:14 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>, anmar.oueja@linaro.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH V4 2/3] scripts: dtc: Build fdtoverlay tool
Date:   Tue, 12 Jan 2021 13:59:01 +0530
Message-Id: <facca66aba8070ef8bdb075ec442287c81e7d23e.1610431620.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1610431620.git.viresh.kumar@linaro.org>
References: <cover.1610431620.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will start building overlays for platforms soon in the kernel and
would need fdtoverlay going forward. Lets start building it.

The fdtoverlay program applies (or merges) one ore more overlay dtb
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

