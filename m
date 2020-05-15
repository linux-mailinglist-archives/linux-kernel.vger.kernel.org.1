Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73501D5901
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 20:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgEOSWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 14:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgEOSWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 14:22:55 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175E8C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 11:22:55 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d67004cd1c8a6a574a4fa.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6700:4cd1:c8a6:a574:a4fa])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 922ED1EC028D;
        Fri, 15 May 2020 20:22:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1589566973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=Sq9tviaQNeT+bKn+8y6t6z3482J+xIgqd1tFGIStlew=;
        b=nbGpSns76YiTYHagolg68Lk4njOIOqjRS7tOrqLQ7D4tdCqZdPj/naAbE4JGrzJBUrGAYw
        PumSX9/TA82TI5/Pb3FIgt7NcwvuWWhueUwLL5n0K0zTFoueQ5wyHOwNx8eCrNPVgig3C5
        CxHAhMJpJTRneNx+bZrSljIZyQAlsao=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/nmi: Remove edac.h include leftover
Date:   Fri, 15 May 2020 20:22:46 +0200
Message-Id: <20200515182246.3553-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... which

  db47d5f85646 ("x86/nmi, EDAC: Get rid of DRAM error reporting thru PCI SERR NMI")

forgot to remove.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/nmi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 6407ea21fa1b..bdcc5146de96 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -25,10 +25,6 @@
 #include <linux/atomic.h>
 #include <linux/sched/clock.h>
 
-#if defined(CONFIG_EDAC)
-#include <linux/edac.h>
-#endif
-
 #include <asm/cpu_entry_area.h>
 #include <asm/traps.h>
 #include <asm/mach_traps.h>
-- 
2.21.0

