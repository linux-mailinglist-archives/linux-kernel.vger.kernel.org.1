Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924022FE362
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbhAUHEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:04:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:37006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbhAUHAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:00:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99E6C239FE;
        Thu, 21 Jan 2021 06:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611212266;
        bh=X2ZbouhaD7Fh4Z4Fk+x6fXXUkQjlXINays174Qir0P0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dpZtFPbqLPIoFfy8sb30jz6gJLWAst64gKLcZGwLraTT0kJ0TZti0OZ3v4YJxmK1x
         3K4ilFl+cM5a5U14I2RZda4JvDrpgv9o/DLrWVeeOmc6UoD9juhDc/WQwH3UQen0NB
         PidVmihHiRp1XrqGt7qDOU0yHf7W8HP3APap+UMDbb6QgNnRMcs3LWcsux+KwxCcob
         T76YXPjVDpaI5pyQDCvDC9KyvhQMMjsrgTkeokHihUr8whzrsPHYAcJXuBG4vC6FGB
         aXgzKs1rfuBRraOsyT7D95w4t6T1LCa/Hjc/KF+uVgh23tQcZrqImGVhRsnyxUF/fP
         RxU+NDGsNPIXQ==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 28/29] csky: Using set_max_mapnr api
Date:   Thu, 21 Jan 2021 14:53:48 +0800
Message-Id: <20210121065349.3188251-28-guoren@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210121065349.3188251-1-guoren@kernel.org>
References: <20210121065349.3188251-1-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Using set_max_mapnr API instead of setting the value directly.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/mm/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/csky/mm/init.c b/arch/csky/mm/init.c
index bc05a3be9d57..03970f4408f5 100644
--- a/arch/csky/mm/init.c
+++ b/arch/csky/mm/init.c
@@ -86,9 +86,9 @@ void __init mem_init(void)
 #ifdef CONFIG_HIGHMEM
 	unsigned long tmp;
 
-	max_mapnr = highend_pfn;
+	set_max_mapnr(highend_pfn);
 #else
-	max_mapnr = max_low_pfn;
+	set_max_mapnr(max_low_pfn);
 #endif
 	high_memory = (void *) __va(max_low_pfn << PAGE_SHIFT);
 
-- 
2.17.1

