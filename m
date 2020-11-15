Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE832B3538
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 15:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgKOOP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 09:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbgKOOP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 09:15:56 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD13C0613D1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 06:15:56 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id c20so11045319pfr.8
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 06:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=69FFOlnrMLFrDHeax6Rw5jeALQVD9Q3UcMoPuHs6k74=;
        b=DOboKuvuE2VBEMf2rJSdDxVfGIhhaVulJ5h3OUb1bfjVf3k6mMoHQkfvc7TycqMQa7
         GQOomkXQJTXebpZtOkm5llOU+6lT1sc4Mb/Q30dEMllOAlGWC6/KypeoamHPMf5RJPh8
         b+BnUEtz1ImpTP8/efqC4IYXXzSm6k6h54R3CtBZJtRJDSAc0lnFnHiHFM2DrOADrwug
         kuNdy0re1ZQvjHdygh20l0FpTLEp/mBXAmv78IYvqNu4pmQ0fBIBMGIlRpZo9TJcMCGw
         Gjs+LBPbRDxXnBcX5F7kz1Aa0AZe6quz2F/JXYgr0m1z/gfVr2jwUilN3B0eypFNj2aN
         vI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=69FFOlnrMLFrDHeax6Rw5jeALQVD9Q3UcMoPuHs6k74=;
        b=qMm2yyH1WQ7UZI/aWLMvyw5UWjM5OERoGEuLn4cafuczW1745zVBsHRXSQLfi8WrlC
         qJIymhLgwtPiC9Uhcuk1QDf8a2xXgeeVzoH4DTNatKRWApU993hjMFYrALkc8FtRUYCw
         WZh89JQZtZWmf2IEli5nKIC7ENfGskjuEdxmzk8aybbVpG0tsWqUdgnooncEfzHeIfmo
         Pt1i4HSooZBKirwpTcDxJPZhxlyg1V+66Rj7lRWadTsHRiAsSfJ09MS0ebEG7CgnzdjY
         O2tDFblM97FuMEsZOaxsW5hpWoAfaesIY6XANCNL2BPMh5PbgfbIWDf5yO+rbTn5yHFI
         4quQ==
X-Gm-Message-State: AOAM533wZXCXDTdDknFVFWuV6U3q3G9hybRPGsEs61fSKomkHex+TnmJ
        54M81teBiJ6wDsvdkXh6XjWZtg16zWOYSQ==
X-Google-Smtp-Source: ABdhPJz4SfE0X8G4tcdqby7TJ21FQrDsBBPnGPwqIOxWfxklZ2hcjl/qAKp+jE/pWsRQbQXm3ZevYw==
X-Received: by 2002:a62:7ac2:0:b029:18b:c5bb:303d with SMTP id v185-20020a627ac20000b029018bc5bb303dmr10195622pfc.71.1605449755667;
        Sun, 15 Nov 2020 06:15:55 -0800 (PST)
Received: from hymmsx-virtual-machine.localdomain (170.146.201.35.bc.googleusercontent.com. [35.201.146.170])
        by smtp.gmail.com with ESMTPSA id ga18sm7444793pjb.5.2020.11.15.06.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 06:15:55 -0800 (PST)
From:   "logic.yu" <hymmsx.yu@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "logic.yu" <hymmsx.yu@gmail.com>
Subject: [PATCH] mm: remove the filename in the top of file comment in vmscan.c
Date:   Sun, 15 Nov 2020 22:15:41 +0800
Message-Id: <20201115141541.3878-1-hymmsx.yu@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No point in having the filename inside the file.

Signed-off-by: logic.yu <hymmsx.yu@gmail.com>
---
 mm/vmscan.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1b8f0e059767..16b9d82a7941 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *  linux/mm/vmscan.c
- *
  *  Copyright (C) 1991, 1992, 1993, 1994  Linus Torvalds
  *
  *  Swap reorganised 29.12.95, Stephen Tweedie.
-- 
2.17.1

