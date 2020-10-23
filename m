Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB086296820
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 02:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374063AbgJWAjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 20:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2899730AbgJWAjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 20:39:46 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208E2C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 17:39:46 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id s1so2053107qvq.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 17:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=NNiDTcqLk6YfTSPesWSJAdgR2JuO2mqOIEmGdUScuIU=;
        b=a9ZkwetxhQ70V3wX14VvqMnmlVXt+GUq/lpNAMvDRnkESsnVTetbJU+jvVZqfrgWmS
         i9G3lRsK5F6CvmWjcHDoPQzHnJmsAkE/Lf3EEqGArKcl3DJKAgNMr0SXR4Y/Ff1MGp4b
         yEprzkFCNvhnlvPgAJAco2PmYNRMnC7xsXEl2FCwFoz5PRMo2phK5FeohCCr5HuMOstu
         Wi+ZVEd6biQcPrX7ybuZ3Z3obkQeBC3+nC7oYvBPct8W4JRewr4klp4xJa1Xtk6hro19
         qD8ftcbmdssmMB9H0bY4DEqxQeUtMOeesrfUC7NysyayOMZPzr5Z1iW08PPQNM+IGrEz
         73Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=NNiDTcqLk6YfTSPesWSJAdgR2JuO2mqOIEmGdUScuIU=;
        b=dx+NOCSj58PeAd7CrcvCj4KOiWqXpiNqRr/lUr1sT5Mglog927ZwyjRtoSD3Stpxie
         yFjmmOBZ9Y6S1XYn1CWGYon0axtkhlgsegc7VxtH9swNWqgV5n2fEZ64gLSI1BuTv87j
         T+j4MIRQJj8Ucc9LQhTVV+i1VKFjcwfNtD+zKv4+G7bRj3+adjAuvCj52Gqkmpp9Bcir
         4qNTIoRc6NbNAYjYiogFUme+EAu0xGx3w7YNjePl0Uj0yxzmC+cHc/oMAJXJLF73StAm
         Y525qHbXQW9nAkL5OnOXsnGY0zR62lRa3jTOzbvtLBz2vnKRNvdw3P2oibCYvMSw/Q6n
         fTkw==
X-Gm-Message-State: AOAM531RFEFyigU+6J0cJ8L4YYvLroMmvm/bGKChSKx1ZaEG87BNWm4p
        IInOjHq+YwOCNLJsYR9QlDw4QpKAjVDa
X-Google-Smtp-Source: ABdhPJw6C0icNSTPNvMwOFSLBlzJXaG8YSzExhQBnOgftpXlgJnQakqE39czOGqNJTFfYYE1lIKRAagC/OXO
Sender: "junaids via sendgmr" <junaids@js-desktop.svl.corp.google.com>
X-Received: from js-desktop.svl.corp.google.com ([2620:15c:2cd:202:f693:9fff:fef4:143])
 (user=junaids job=sendgmr) by 2002:a0c:9d04:: with SMTP id
 m4mr5145027qvf.50.1603413585156; Thu, 22 Oct 2020 17:39:45 -0700 (PDT)
Date:   Thu, 22 Oct 2020 17:39:16 -0700
Message-Id: <20201023003916.82906-1-junaids@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc2.309.g374f81d7ae-goog
Subject: [PATCH] x86/mm/KASLR: Account for minimum padding when calculating entropy
From:   Junaid Shahid <junaids@google.com>
To:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subtract the minimum padding between regions from the initial
remain_entropy. Without this, the last region could potentially
overflow past vaddr_end if we happen to get a specific sequence
of random numbers (although extremely unlikely in practice).
The bug can be demonstrated by replacing the prandom_bytes_state
call with "rand = entropy;"

Signed-off-by: Junaid Shahid <junaids@google.com>
---
 arch/x86/mm/kaslr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 6e6b39710e5f..fe3eec30f736 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -109,7 +109,8 @@ void __init kernel_randomize_memory(void)
 	kaslr_regions[2].size_tb = DIV_ROUND_UP(vmemmap_size, 1UL << TB_SHIFT);
 
 	/* Calculate entropy available between regions */
-	remain_entropy = vaddr_end - vaddr_start;
+	remain_entropy = vaddr_end - vaddr_start -
+			 (ARRAY_SIZE(kaslr_regions) - 1) * PUD_SIZE;
 	for (i = 0; i < ARRAY_SIZE(kaslr_regions); i++)
 		remain_entropy -= get_padding(&kaslr_regions[i]);
 
-- 
2.29.0.rc2.309.g374f81d7ae-goog

