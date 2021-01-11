Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27AB12F183D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388700AbhAKO0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbhAKO0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:26:07 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F035C061794;
        Mon, 11 Jan 2021 06:25:27 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id t6so9613250plq.1;
        Mon, 11 Jan 2021 06:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kjus1H8C0QBAlALuC5Cx0BMQHU+YX+HglMSKKZRyJ+M=;
        b=ZjH9KXHTjPckjBfk6z2A+NQL3LfnBeZc1UzLr9XLv3Uf5AKeNth48r1nE1uKR2cjuA
         0HF7bp7YMH0khXjA4iNCPlA4hYY2J1ZJ6TZHN7oXI4DKrULNEEd12HU7d6rTwyy7WROz
         cvCkpd4wsPBNDGrFYKrWda1epW4AsrUQyQptkHMFMdTKbZtwZSlt7YGXnu0UVr+GW/Ui
         LR5qieqUr5XPzxLDCacA3kO4lw1xy4ajjIRby4inglRY5flR7xAmDm0psN7NkuccHhc5
         KQTb5cMeFlmynhrwcjHZJhLngkTwtgAU4CDOjJXm2QLYjQtRAWu296FQZHw9h6wxGzTw
         SsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kjus1H8C0QBAlALuC5Cx0BMQHU+YX+HglMSKKZRyJ+M=;
        b=TojvySmsMEtA51rBlz9ySxuaK3Lm3GMcWwv/oksAWGyEAiGu82CBQARWUR9T/F2bgk
         L35tlY9hI5XvwyIt2NArwhoBEfNgJDnidpMuP9MbH/hcjko/UQ9CugSmjaRDzt0HjM5y
         vpLU6rOONZpfBbFVYMNpyUb8pVnSlqrY7j+HYKbQxmabgUhTG3t5dvezCwB7lpTaNkYN
         Of+uocO0buxUGoCzLfZM4SYQXFsTP+prQSq27q/DGbl4+VkVhHN4TEDwj/AOkbZyEswk
         3Cp74KkhePcYkFnjw5kWPOyf4rQIXUvH0erWwMRrqo0dn/AzF21emJzMi6mSiyZiUpwD
         F7Qg==
X-Gm-Message-State: AOAM5336HDufquJdneu2EW4Qo6RH5cTf1wDKpdRtgJ3lLaDBpSGzWw4g
        CENfcvvDc6wWJFsW+WBAdmAwoQnFY8c=
X-Google-Smtp-Source: ABdhPJz5brRCSrb7yoX5wtnr8u6RGNZ2oK7yZ1dQjKGnluwqdlsF1I3YLgY/ov3vs9iWLXEzMIcMpA==
X-Received: by 2002:a17:902:6f01:b029:dc:3182:ce69 with SMTP id w1-20020a1709026f01b02900dc3182ce69mr16369769plk.10.1610375126720;
        Mon, 11 Jan 2021 06:25:26 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id q12sm19498300pgj.24.2021.01.11.06.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 06:25:25 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: dong.menglong@zte.com.cn
To:     guoren@kernel.org
Cc:     dong.menglong@zte.com.cn, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] csky: kprobe: fix unreachable code in simulate_blz32
Date:   Mon, 11 Jan 2021 06:25:17 -0800
Message-Id: <20210111142517.4959-1-dong.menglong@zte.com.cn>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Menglong Dong <dong.menglong@zte.com.cn>

The type of 'val' is 'unsigned long' in simulate_blz32, so 'val < 0'
can't be true.

When 'csky_insn_reg_get_val' fails, 'false' will be returned. We
can directly use its return value here.

Fixes: 33e53ae1ce41 ("csky: Add kprobes supported")
Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
---
 arch/csky/kernel/probes/simulate-insn.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/csky/kernel/probes/simulate-insn.c b/arch/csky/kernel/probes/simulate-insn.c
index 4e464fed52ec..b09ddcbcfa18 100644
--- a/arch/csky/kernel/probes/simulate-insn.c
+++ b/arch/csky/kernel/probes/simulate-insn.c
@@ -346,9 +346,7 @@ simulate_blz32(u32 opcode, long addr, struct pt_regs *regs)
 	unsigned long tmp = opcode & 0x1f;
 	unsigned long val;
 
-	csky_insn_reg_get_val(regs, tmp, &val);
-
-	if (val < 0) {
+	if (!csky_insn_reg_get_val(regs, tmp, &val)) {
 		instruction_pointer_set(regs,
 			addr + sign_extend32((opcode & 0xffff0000) >> 15, 15));
 	} else
-- 
2.17.1

