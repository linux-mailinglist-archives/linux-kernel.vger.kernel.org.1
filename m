Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706A7282AC9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 14:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgJDM6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 08:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgJDM6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 08:58:45 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A874C0613CE;
        Sun,  4 Oct 2020 05:58:45 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id h24so1452753ejg.9;
        Sun, 04 Oct 2020 05:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PUKRKz2tpvOlgzU6T8LFm9id6xQAJB/MM9M3WUFXc+A=;
        b=CnISbJkoNvxTd5jIBOUlg9+BwkmuM63uKyfAmzazkQPXDTqNIA93w1bVoM2LjX9rcP
         oj8EpHnwqbDa3gONf7UUd83FE/mcIGUXIEphNUeP5ZdvxKQC/Mcqalfel8rl4eeoXDwV
         zzWfgSGtpUbv/hnt60yCzn7DeKx7iEkuhYh1721A9nrnW08qOvQB52N857lNypvzsK77
         8kV5CMdB5GI/65/AwAMlzexf8hxVxeGRw+U8uM/hFEUFHK7L0Gy2xQFXRv84seuGEv3/
         qOrTHwvSxKMwSLLoKZO1agRRV2g2Zqag0ei6n6PbFQ6+QmJvvni0+o59qD1f0MfoTJvi
         Upcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PUKRKz2tpvOlgzU6T8LFm9id6xQAJB/MM9M3WUFXc+A=;
        b=Rc4HebiD2JUi6AMNQzB0q9rzqFUJdZDQ2HDegEIEPximEhzev63BNW9lFqsNIs1K+Y
         4VXcD4OkGqO0ZrGsLM3J+LL3BkCq6Km0GLLYFdiIDH3WAdwEsEofNrB5WnNNvPWpO/VS
         AR4LbiHgDb4iDSpSFArcrwDeTMaqQM4jCT482aSXpbkWCtGKb7EmPHIoKJFpWuFBCLnF
         O8kTgI6o5TzsC4MzFHbKnMirsReyRitvfKU5u9/aaK/OiSv6oareBgQhlo0HKaOY5SGU
         tioaq1dQkbfc8ojkHPaGudstCzjUoRg3c5slaBrUFSmVjc9Y9Rtyn9wtc4+LzNoPMp+B
         p8Gg==
X-Gm-Message-State: AOAM533Clfs4YrkCMqhk13IcHwjKZw1tLkffeQ3b8i6lLuif1cTUjKhn
        1Y4DBs6/SeHdHVMB3e8uTrQ=
X-Google-Smtp-Source: ABdhPJxNxrY0nIitVq0DwnUHIuVobxEYUgHoqu1kxAvSNcHLXGtq22k3XIW26iFfBBt4+NxCMI6YUw==
X-Received: by 2002:a17:906:52d1:: with SMTP id w17mr10339057ejn.164.1601816324134;
        Sun, 04 Oct 2020 05:58:44 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d26:f700:59a3:d1dd:4e61:fceb])
        by smtp.gmail.com with ESMTPSA id a10sm2751747edu.78.2020.10.04.05.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 05:58:43 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-safety@lists.elisa.tech,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] mm/vmscan: drop unneeded assignment in kswapd()
Date:   Sun,  4 Oct 2020 14:58:27 +0200
Message-Id: <20201004125827.17679-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The refactoring to kswapd() in commit e716f2eb24de ("mm, vmscan: prevent
kswapd sleeping prematurely due to mismatched classzone_idx") turned an
assignment to reclaim_order into a dead store, as in all further paths,
reclaim_order will be assigned again before it is used.

make clang-analyzer on x86_64 tinyconfig caught my attention with:

  mm/vmscan.c: warning: Although the value stored to 'reclaim_order' is
  used in the enclosing expression, the value is never actually read from
  'reclaim_order' [clang-analyzer-deadcode.DeadStores]

Compilers will detect this unneeded assignment and optimize this anyway.
So, the resulting binary is identical before and after this change.

Simplify the code and remove unneeded assignment to make clang-analyzer
happy.

No functional change. No change in binary code.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on current master and next-20201002

Mel, please ack.
Andrew, please pick this minor non-urgent clean-up patch.

I quickly confirmed that the binary did not change with this change to the
source code; The hash of mm/vmscan.o remained the same before and after
the change.

So, in my setup:
md5sum mm/vmscan.o
7da4675477f186263e36b726cc2b859d  mm/vmscan.o

linux-safety, please verify and validate this change.

 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 466fc3144fff..130ee40c1255 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3896,7 +3896,7 @@ static int kswapd(void *p)
 					highest_zoneidx);
 
 		/* Read the new order and highest_zoneidx */
-		alloc_order = reclaim_order = READ_ONCE(pgdat->kswapd_order);
+		alloc_order = READ_ONCE(pgdat->kswapd_order);
 		highest_zoneidx = kswapd_highest_zoneidx(pgdat,
 							highest_zoneidx);
 		WRITE_ONCE(pgdat->kswapd_order, 0);
-- 
2.17.1

