Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC4D2E08DE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 11:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgLVKdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 05:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgLVKdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 05:33:52 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D6AC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 02:33:12 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id x1so2526195pgh.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 02:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tKvj/bgBxxRfTrzQHkXMUBOh8hAoOnZqz+jw3Vt0T14=;
        b=nNPjFRIU5VfWu2eZMPupGYHVwbbiSWJ5G5SKF/W3DAmbSP6HN0+5C0/SctOdG8rwMC
         WZfZQQxPxbeBqDxHMcNM9G5bHCiTqaj4vAICZvFNUBocn+i3F1WyXlA3l1YRd4IeiL6P
         E/uT90uBqjA6XCB2k1hOBCNY19x5xxNRkZDH+aolxHlpzGXTf8H+2w26mp/Cx+Oqw8sn
         qFhZAkfl/7zXNZbYzts6wlWMtgzZGmLTD50htIz2ZBchIjH5IH16cHIW3FhR/EeWtTsU
         Rcc2LGwaUT4N3dczOM8w1VDhMIFdrnBQ9yz/BcB307XbFP/Dpf7lbfqNGyRNZRBT2U6y
         dxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tKvj/bgBxxRfTrzQHkXMUBOh8hAoOnZqz+jw3Vt0T14=;
        b=H8hpat9a3fpmHlUbHEEYdH3/mW2xSysleVbOsaQxeLfHM+lz9yAS1oVaDHCyQOrx/r
         21wPoeTfl0K5hWljddiMPnMuMh9NqEL5vRLWiFQQcgddmEGWDHg6gm684ec2H9pQZNIl
         5ovqemPAoxzoxGeeMZy1DHyt/3Ck23LUB09caT8ekic7l3vNbSwselgYUKMptcxTsptY
         sibsELNrLglMa4OTAfw3xLLgFPNtH7by5QOxytvStmkW8A8dXqC8TG5IvncYklFyvgnF
         yda0g3fOfvO0qIRHmj5OXWcJfOdp73ACU/YQMiclIvtMBLEFiHv82I8eh9lRszjPw30p
         /Aow==
X-Gm-Message-State: AOAM532DgAWcpgbJGLkMl0P+DgdnryN1Fj5cRhg6D4b0aHj2/kpJW7GL
        w4H6IGWK3sYQ86K1l7+jQL1Y4958LYCz5w==
X-Google-Smtp-Source: ABdhPJx8ERswps1fe+Wik010yphFdC7kHeZeeIx5Vrx53MSD1x2XRETDZmkQx10N1+t+ojyJC9+Ijg==
X-Received: by 2002:a63:ea01:: with SMTP id c1mr18979021pgi.138.1608633191960;
        Tue, 22 Dec 2020 02:33:11 -0800 (PST)
Received: from AHUANG12-1LT7M0.lenovo.com (220-142-211-188.dynamic-ip.hinet.net. [220.142.211.188])
        by smtp.gmail.com with ESMTPSA id b189sm19854229pfb.194.2020.12.22.02.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 02:33:11 -0800 (PST)
From:   Adrian Huang <adrianhuang0701@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Adrian Huang <adrianhuang0701@gmail.com>,
        Adrian Huang <ahuang12@lenovo.com>
Subject: [PATCH 1/1] mm: mmap: Remove unnecessary local variable
Date:   Tue, 22 Dec 2020 18:32:49 +0800
Message-Id: <20201222103249.30683-1-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Huang <ahuang12@lenovo.com>

The local variable 'retval' is assigned just for once in __do_sys_brk(),
and the function returns the value of the local variable right after
the assignment. Remove unnecessary assignment and local variable
declaration.

Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
---
 mm/mmap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index dc7206032387..482c0c0bbe06 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -189,7 +189,6 @@ static int do_brk_flags(unsigned long addr, unsigned long request, unsigned long
 		struct list_head *uf);
 SYSCALL_DEFINE1(brk, unsigned long, brk)
 {
-	unsigned long retval;
 	unsigned long newbrk, oldbrk, origbrk;
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *next;
@@ -281,9 +280,8 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	return brk;
 
 out:
-	retval = origbrk;
 	mmap_write_unlock(mm);
-	return retval;
+	return origbrk;
 }
 
 static inline unsigned long vma_compute_gap(struct vm_area_struct *vma)
-- 
2.17.1

