Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5DC2F2693
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 04:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbhALDLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 22:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbhALDLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 22:11:25 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051B6C061575;
        Mon, 11 Jan 2021 19:10:39 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id d2so529686pfq.5;
        Mon, 11 Jan 2021 19:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=19kmUE1BPrGpUGDBCk/ABxpLH6xa1Vvslov055dejaA=;
        b=ej7g91rlEQ+qxzJ0QvQoBRi3TpCToZa5lqGi/eCpRKLUuYm1ZyLSu3S/JWn9L13DBF
         1QxnyK4j4d8d9YxnrPjaQUZei7bCElR1AULeK/ju6mSWppJ02WlCZxGIYJiTFMn+5oKL
         vyjR2MiSS8yqdKxy48olMytl25ETBYlrqHndidtwGuKkVOQJ6m/4bp4qvrfgLeE905Wa
         VZGHYJbDyytrAHF6erACmPOFXB5MJFEJJKW+3X7svkwxD8wUgI+KwPY6xoFkWBAOAFLI
         UCvv6UudfTNN70K08N3yDsuG4wyVTnVNUeQ2nKgcwyasDXZQ0zze8/bU9CFYLYnw4G56
         rDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=19kmUE1BPrGpUGDBCk/ABxpLH6xa1Vvslov055dejaA=;
        b=BBM9TwZqyud1eF4nR0SB/rMD0ziNTf91KeUzJOPKgcbhjGqhVmW9iw19gh3yeIVzXm
         ESwuEptZEuCZVhhrSE4eIAC++pkA7usJyi/H/NF3/4WZbyGdSsYGzRDw+6qIDGMt6cVt
         vrzV0smuKG5+Oz8QcSo318GJkio0+0sk4UxNxpt0qyo+Ta+HaDAq4nws7aD8YWCKDrd5
         9XX2E2uVA1hbCsBmfuom17eHu6AUgsDZ4k1kDxYLtk6dA+JMTIUN6E2oLYs/HAHiSsn7
         PrDO+e+B4F7xtcPo0b3qNfWTD/+9jopk6iYmnyCGh6XRzBqDQb6WdgMY+I9qNo/2WJK+
         fCfw==
X-Gm-Message-State: AOAM530nbOP9D2PiJM4Pm3wENhY11odLyLllzEzLshXFILRfzOr+Tkxl
        kn8rZoE9IkQqOw+NTtl8I8w=
X-Google-Smtp-Source: ABdhPJx+R5Gqmiy6NPeymhNp4TS4og79l55Efs5bBh9sHD5tlNh0p0Xd2sC6/01exCTWyASDq1BIuQ==
X-Received: by 2002:a62:7711:0:b029:1aa:3203:73c9 with SMTP id s17-20020a6277110000b02901aa320373c9mr2473160pfc.65.1610421038532;
        Mon, 11 Jan 2021 19:10:38 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id w9sm1039825pfj.128.2021.01.11.19.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 19:10:37 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: dong.menglong@zte.com.cn
To:     guoren@kernel.org
Cc:     dong.menglong@zte.com.cn, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] csky: kprobe: fix unreachable code in simulate_blz32
Date:   Mon, 11 Jan 2021 19:10:25 -0800
Message-Id: <20210112031025.5970-1-dong.menglong@zte.com.cn>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Menglong Dong <dong.menglong@zte.com.cn>

The type of 'val' is 'unsigned long' in simulate_blz32, so 'val < 0'
can't be true.

Cast 'val' to 'long' here to determine branch token or not,
as Guo Ren suggested.

Fixes: 33e53ae1ce41 ("csky: Add kprobes supported")
Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
---
v2:
- Cast 'val' to 'long'.
---
 arch/csky/kernel/probes/simulate-insn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/csky/kernel/probes/simulate-insn.c b/arch/csky/kernel/probes/simulate-insn.c
index 4e464fed52ec..9ad771c47670 100644
--- a/arch/csky/kernel/probes/simulate-insn.c
+++ b/arch/csky/kernel/probes/simulate-insn.c
@@ -348,7 +348,7 @@ simulate_blz32(u32 opcode, long addr, struct pt_regs *regs)
 
 	csky_insn_reg_get_val(regs, tmp, &val);
 
-	if (val < 0) {
+	if ((long)val < 0) {
 		instruction_pointer_set(regs,
 			addr + sign_extend32((opcode & 0xffff0000) >> 15, 15));
 	} else
-- 
2.17.1

