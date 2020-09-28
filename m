Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145FB27AB6C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 12:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgI1KAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 06:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgI1KAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 06:00:15 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2863EC061755;
        Mon, 28 Sep 2020 03:00:15 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id e22so623345edq.6;
        Mon, 28 Sep 2020 03:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SDDq2C7QLWNFyYFepbxAMacpxOBVCHMbzny/kHBr8TA=;
        b=R+pfU0Towmle8RJu/D2uVB6nF3nenvlxVFjiSEvSkMiG2Jlx3yvjSATbQ8+uGNBHHC
         /hxaVJSDGW/iXOGt0AzwAPlvP3FQWFp7uRePLRzNFXLrjI0cUmxzmB/Yo4f7rU2w/PgF
         QZZNVcmw/iC5SfxzSz2omZ3VEyF9P6mf8kLWBPl9DmsXVXIn00jKeEf2rX03yd0uCEhx
         cbYV3TC7vuKlE6QYK63WE8mIThW1ugvgD3GoYFnmga8LP66ybx8Bj4VvIj9Td0U8GFtB
         Lo3a8nFWXq4UkVdkgbsrgexuhXTY65G8VOE+r0bL/pwSau4c2qfKMF3pZa37/VqccADC
         1MIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SDDq2C7QLWNFyYFepbxAMacpxOBVCHMbzny/kHBr8TA=;
        b=dJSzkyNBWRcTnfFiVDEbtvAQdQfpTaPueibQ03JLXJbV5SPo592vnkF5K/RONPLUS7
         MQ2fikQYB4X93JzmOt9NI+KNLwQOLt9rqyA/s6GWvLbWdKFKko56uJVrtwPqI5zRtw7r
         qQ2sqnvEsU9NHsWXyvVgn8MCijSmy+LlHlOLmJ9fbqISNyi6hoOHdeFTcSVGXqionyT3
         PJj1yU2dTvliGSvEwqo+VaHyNJCZ8W1I8X/FlZjdZqjqqS9e5oQOWcRvQQpfrwt4etqn
         zAwrgQafwogYfdb83Seq9lxAVMTCxFzNlqcGdlvmwCP4/1BYg4szY8ucKl+7LQf/5ob6
         WNsg==
X-Gm-Message-State: AOAM530JMy8DwAjBAn+ry+JRfAmzu7VmHxteMehHg+m5wNyg0H9H0GZM
        IskSu4cl8AtZJSX9BCmS7yI=
X-Google-Smtp-Source: ABdhPJzlWRLg1EMg817RKK+Ds6y/qvJKdNZ7zwAaJGbykb2KswiX5HBOGUqqOfFCatcJ6+iB3eFoOQ==
X-Received: by 2002:a05:6402:1d93:: with SMTP id dk19mr800943edb.198.1601287213821;
        Mon, 28 Sep 2020 03:00:13 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d9d:5000:7872:7299:adfa:b749])
        by smtp.gmail.com with ESMTPSA id m10sm921048edf.11.2020.09.28.03.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 03:00:13 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-safety@lists.elisa.tech,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] x86/mm: drop superfluous initialization
Date:   Mon, 28 Sep 2020 12:00:04 +0200
Message-Id: <20200928100004.25674-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not required to initialize the local variable start in
memory_map_top_down(), as the variable will be initialized in any path
before it is used.

make clang-analyzer on x86_64 tinyconfig reports:

  arch/x86/mm/init.c:612:15: warning: Although the value stored to 'start' \
  is used in the enclosing expression, the value is never actually read \
  from 'start' [clang-analyzer-deadcode.DeadStores]

Compilers will detect this superfluous assignment and optimize that
expression anyway. So, the resulting binary is identical before and after
the change.

Drop this superfluous assignment to make clang-analyzer happy.

No functional change.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on v5.9-rc7 and next-20200925

Dave, Andy, Peter, please pick this minor non-urgent clean-up patch.

I quickly confirmed that the binary did not change with this change to the
source code; the hash of init.o remained the same before and after the change.

So, in my setup:
  md5sum arch/x86/mm/init.o
  b26f6380760f32d2ef2c7525301eebd3  init.o

linux-safety, please verify and validate this change.

 arch/x86/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index c7a47603537f..5632f02146ca 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -609,7 +609,7 @@ static void __init memory_map_top_down(unsigned long map_start,
 	step_size = PMD_SIZE;
 	max_pfn_mapped = 0; /* will get exact value next */
 	min_pfn_mapped = real_end >> PAGE_SHIFT;
-	last_start = start = real_end;
+	last_start = real_end;
 
 	/*
 	 * We start from the top (end of memory) and go to the bottom.
-- 
2.17.1

