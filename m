Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D41919C150
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 14:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388312AbgDBMnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 08:43:12 -0400
Received: from mout02.posteo.de ([185.67.36.66]:48973 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387654AbgDBMnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 08:43:12 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 68BE0240101
        for <linux-kernel@vger.kernel.org>; Thu,  2 Apr 2020 14:43:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1585831390; bh=rrIDGUgOnKqtMc3GZAlKewSN2vPe/6rhqt+UH1hcTrE=;
        h=From:To:Cc:Subject:Date:From;
        b=YSQRxLCWTBVEhOADfjkeXIukI0EziMGQzBshvPJAx+uOGct8XLNOb0LeyXxcUxrU2
         /JcKlQ7ImGqOrIg1PeaJ5X0PJuQdFRzi6fp+E3oxKAWLy+uylAZRB5PC8jVBhxT/1X
         mIyImiiJ1mDoxaic3jpCgpMbzRexYzFZroLSBz8hCJWcBHSfL44wOlgEMVFX+OADtS
         7sXb/5NyxNZjv5IsWwvRpLtn5zn5wu98+ujsrFMMsV9O4m+8g4oTtapdbP8GcSi9zl
         fxxvJrvH2ecguBijWLODOqTmTKjQ0r/ltK6p+uJ50tChg58TAS3bwFIY+BLw7eh7fg
         gPtuGBVeRpD7g==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 48tN5T6y1bz9rxQ;
        Thu,  2 Apr 2020 14:43:09 +0200 (CEST)
From:   Benjamin Thiel <b.thiel@posteo.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     X86 ML <x86@kernel.org>, Benjamin Thiel <b.thiel@posteo.de>
Subject: [PATCH] x86/mm/mmap: Fix -Wmissing-prototypes warnings
Date:   Thu,  2 Apr 2020 14:43:07 +0200
Message-Id: <20200402124307.10857-1-b.thiel@posteo.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add includes for the prototypes of valid_phys_addr_range(),
arch_mmap_rnd() and valid_mmap_phys_addr_range() in order to fix
-Wmissing-prototypes warnings.

Signed-off-by: Benjamin Thiel <b.thiel@posteo.de>
---
 arch/x86/mm/mmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
index cb91eccc4960..c90c20904a60 100644
--- a/arch/x86/mm/mmap.c
+++ b/arch/x86/mm/mmap.c
@@ -18,7 +18,9 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/mm.h>
 #include <linux/compat.h>
+#include <linux/elf-randomize.h>
 #include <asm/elf.h>
+#include <asm/io.h>
 
 #include "physaddr.h"
 
-- 
2.17.1

