Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73126264D8B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 20:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgIJSoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 14:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbgIJSPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:15:50 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E947AC061756
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 11:15:33 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id ay8so7272034edb.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 11:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iVjDnzu3NoP5ee9O0uXdxD2nS2+K7rbMpfw/O/VU9gU=;
        b=dHatk3WeMWL6tirKnt2blyKK7+cg/jJ0U9wAPtz5uTVXFL98IUJQtM/7xUBZ2JD+Yn
         3krTqzEd7WhpOHqwCMjKUCTjchOFXIRXDz2gkptECSEfFx6e7FcWLDY1hM9rAsDDFJTY
         QU5b4sNKRkcnuevgD/rzqmBMZlzrpflSesulbTXDAGzjv2bWDRdaraaEZwd0lcbCvkcI
         Xm5+YD0fq8yIvI6gvA/N1jQJBiL1AwMR8yYdXILotu7wh4wquiUIM+yr6Yv8GaX9lI03
         FKMDpQ8Go/uGNLduR/fv4J6V5zHJqZxtEHRm/XRlMPTWlrXzG5Od3PF2HepPSrIZADY5
         ewpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iVjDnzu3NoP5ee9O0uXdxD2nS2+K7rbMpfw/O/VU9gU=;
        b=jfinlt12OM/j/zTBapuHUlghOE3J1HA97wNplrtA8CFvKn46SwONzh+RetOeewVRuT
         K/Io+dsWnsHo7RZi4zIRVWI0IzgY+YI/xhPr7RME9crFFzS/ywGxKXh8fhIV5AKMCWZ5
         2oUxdUzCvr6OP0Gstf7d2xNWX5FYH9J/QtwN8SKcBRKbZrddwc7gKubSFKYKn8lJEDND
         /yzWk2nmZLHDRQw4xJJEXz6a98TJQ0g6xRr6eGOAViQeBj8EBpNrqpJrnLx/1MANeOGT
         j2WlcbsTuxtKfGbCR4cgKZRQE8vQIV9IqH7DBAy1h1NYEiibm3g0V4QE2pO9qbiNbr29
         169A==
X-Gm-Message-State: AOAM533ZrASEn6pcoZfstSzu6oll1zHUT5mwWa7wcFp205hyE832zLU+
        V4bCx17inoEfN1nhnIxfhyxVZoAgxpg=
X-Google-Smtp-Source: ABdhPJy8/d1M2tEK7YpCQLDPzUayH/jFBGpmt36k44dz5ewvm7AJnF2TO7BXdDZ9PFXWU9QanZoWXQ==
X-Received: by 2002:a05:6402:1694:: with SMTP id a20mr10407058edv.286.1599761731975;
        Thu, 10 Sep 2020 11:15:31 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id y6sm8636117edj.50.2020.09.10.11.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 11:15:30 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     gregkh@linuxfoundation.org, Moti Haimovski <mhaimovski@habana.ai>
Subject: [PATCH 02/11] habanalabs: rename mmu.c to mmu_v1.c
Date:   Thu, 10 Sep 2020 21:15:15 +0300
Message-Id: <20200910181524.21460-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200910181524.21460-1-oded.gabbay@gmail.com>
References: <20200910181524.21460-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moti Haimovski <mhaimovski@habana.ai>

In the future we will have MMU v2 code, so we need to prepare the
driver for it. The first step is to rename the current MMU file to
mmu_v1.c.

Signed-off-by: Moti Haimovski <mhaimovski@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/common/Makefile            | 4 ++--
 drivers/misc/habanalabs/common/{mmu.c => mmu_v1.c} | 0
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/misc/habanalabs/common/{mmu.c => mmu_v1.c} (100%)

diff --git a/drivers/misc/habanalabs/common/Makefile b/drivers/misc/habanalabs/common/Makefile
index b984bfa4face..e8ed12810517 100644
--- a/drivers/misc/habanalabs/common/Makefile
+++ b/drivers/misc/habanalabs/common/Makefile
@@ -3,5 +3,5 @@ HL_COMMON_FILES := common/habanalabs_drv.o common/device.o common/context.o \
 		common/asid.o common/habanalabs_ioctl.o \
 		common/command_buffer.o common/hw_queue.o common/irq.o \
 		common/sysfs.o common/hwmon.o common/memory.o \
-		common/command_submission.o common/mmu.o common/firmware_if.o \
-		common/pci.o
+		common/command_submission.o common/mmu_v1.o \
+		common/firmware_if.o common/pci.o
diff --git a/drivers/misc/habanalabs/common/mmu.c b/drivers/misc/habanalabs/common/mmu_v1.c
similarity index 100%
rename from drivers/misc/habanalabs/common/mmu.c
rename to drivers/misc/habanalabs/common/mmu_v1.c
-- 
2.17.1

