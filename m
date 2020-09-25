Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1008B279271
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgIYUng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728855AbgIYUnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:43:35 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAC6C0613AD
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 12:35:00 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id q10so1996494qvs.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 12:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L8ixCYO36+U1mLg2tiZDBw3lsO8JiDw+yiux6OWcwmo=;
        b=O0RI1qr+uU4z7NkR/TDSKFKkxbsRPplVlsrQdFYsljMV2EUmHJRiMvWIWbygzF178h
         G58iQjGosY2nyiZf13VyjvD2kgtwZ3QCLBFrw1ruBl+3lcQZF5sd0bbp9zs0EbND2Ytt
         hgFcLDSomL93pE/axja083Tx5BClWNc4C9QQ3rp5wr++O1MswIIRmHs6o6KDSznU2ba7
         UkW5uSranZDVJuyoO2ktHTrMYDy1dJWYrHZEaD3tPVoLyh0cHq2N9VM3NRB9o0jS2srl
         Uckp7VxyjO4PcURiyCLDV4AijpW6n+29rEH9QCwzpqxaxwCNHZjoZUDjp4t94/Luuz75
         rxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L8ixCYO36+U1mLg2tiZDBw3lsO8JiDw+yiux6OWcwmo=;
        b=CRTt8cvf9r54nHeo+Qd8aGWK5IMr0/h8JSkZ0uCA75l9N31Xrn3c2aoU/FkW0NTDcl
         FV/Mo9uzyQ+guRebMBsQa1/oFtJp6exx1knhQZXb932a8RQzaJGAXLLfmSHJoAOPDPn0
         EDWPDbTrz/8d2UnV6rWQUCM0XaU5IyihDM43tf1zm85zmYC/sWbpXzxSwsdInDpmcniq
         ymgxdhpggQLcr7VYqdSUbUq6GdNxbjLWID24NTM1jcBjxZ3Cm2V0RcWX1sK5UNPYjkEE
         Ng7dQPQEem1MDUjqkMMAAMeqh1boo7DDJ1m0Qw8B5FDkhvyMlfD8NEQ5wVIfGrEKmLyA
         iUVg==
X-Gm-Message-State: AOAM533ycYaRlBpVh4IZX/gMLxKY+MS/8la5nWBGlnaBO6Jw46ob5Cg8
        ec6zqfabZF5icaMFLRf6P0A=
X-Google-Smtp-Source: ABdhPJzTraa5lDCISND1ESiagF1duHDOyixjOzQpAoX+Hu2yul2W67wnP+S+ngdmRy7eo340nkPxGQ==
X-Received: by 2002:a05:6214:d6b:: with SMTP id 11mr189902qvs.30.1601062499579;
        Fri, 25 Sep 2020 12:34:59 -0700 (PDT)
Received: from localhost.localdomain ([68.183.97.120])
        by smtp.gmail.com with ESMTPSA id b13sm2276391qkl.46.2020.09.25.12.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 12:34:58 -0700 (PDT)
From:   Mark Mossberg <mark.mossberg@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     hpa@zytor.com, jannh@google.com,
        Mark Mossberg <mark.mossberg@gmail.com>
Subject: [PATCH] x86/dumpstack: Fix misleading instruction pointer error message
Date:   Fri, 25 Sep 2020 19:31:51 +0000
Message-Id: <20200925193150.832387-1-mark.mossberg@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unconditionally printing "Bad RIP value" if copy_code() fails can be
misleading for userspace pointers, since copy_code() can fail if the
instruction pointer is valid, but the code is paged out.  This is
because copy_code() calls copy_from_user_nmi() for userspace pointers,
which disables page fault handling.

This is reproducible in OOM situations, where it's plausible that the
code may be reclaimed in the time between entry into the kernel and when
this message is printed. This leaves a misleading log in dmesg that
suggests instruction pointer corruption has occurred, which may alarm
users.

This patch changes the message printed for userspace pointers to more
accurately reflect the possible reasons why the code cannot be dumped.

Signed-off-by: Mark Mossberg <mark.mossberg@gmail.com>
---
 arch/x86/kernel/dumpstack.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 48ce44576947..37dbf16c7456 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -115,7 +115,10 @@ void show_opcodes(struct pt_regs *regs, const char *loglvl)
 	unsigned long prologue = regs->ip - PROLOGUE_SIZE;
 
 	if (copy_code(regs, opcodes, prologue, sizeof(opcodes))) {
-		printk("%sCode: Bad RIP value.\n", loglvl);
+		if (user_mode(regs))
+			printk("%sCode: Bad RIP value or code paged out.\n", loglvl);
+		else
+			printk("%sCode: Bad RIP value.\n", loglvl);
 	} else {
 		printk("%sCode: %" __stringify(PROLOGUE_SIZE) "ph <%02x> %"
 		       __stringify(EPILOGUE_SIZE) "ph\n", loglvl, opcodes,
-- 
2.25.1

