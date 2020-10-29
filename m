Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B0C29F11E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgJ2QTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgJ2QTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:19:22 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D115C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:19:22 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x13so2736209pfa.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tdn8zYja6ZnnvPughg+VajC16181giqWqrqj5qN7zzs=;
        b=htgqCAk1Jl2PIAGpUfJqq5a/p+5W9bm9ASok0Vvi4w2NKZcotc+f+FncaFNpSO2gnU
         eRqFDfYCVqKNbG58wvrqE2hLLQ4tWUwK/0a4XjOjWv86ruDvQoRT+8JGSBLLr441/Lg4
         nk/Do1RPBltNtTe+urZPsjYY4ui7uavaq/WqRbr9CFZ4apSPCyCvTPyY8q+EzkSpcbek
         icBJhCs6svwOg9oPfQU8WASf3lX0QAZyftF8+FEkYy/Yw3jlBx2yXT258Uc4k11t76+7
         TFOriPtYiGXuUfmi1W99165G8L2HUs3AKt7uo+NDkDBB/W0iufZHHMV17nuLposZpgAl
         UFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tdn8zYja6ZnnvPughg+VajC16181giqWqrqj5qN7zzs=;
        b=W8aNZX2lmXDtpdTgfD37EtTVSJlLJF8N8nDABmSsXsL263d/ODoeGY4ie6DgPxoTuR
         xzH3JhnKdzicDi06W3IXO71C9Ngc7/npjqJ75P67rNBc2kn3eyTOI92Kph2UMWPotXpn
         wkO0RK/KjvCnvejrruZWQOnMybOVMUUJR60VTU36mvCl81KnqcgiwYFLTMRlE6Rxp13K
         9kjzosyrTrVyvrMOc6v1DotIOMgaeILbnBjgRWxarOoOAQQDwH8j2ahtSKM2X1pH2FfV
         HgqKFazPq1gSMKNoNCTr4aLocAeToEKAhHnkhSDtq4xYPaoa9TeIHq97hdZ94WcSDXCc
         Unew==
X-Gm-Message-State: AOAM533xwXKXuoy1eUjokCimjcxy4IOroPehlZF7AH/8GgQxVuNK/z1j
        Md2zbCWiMigVOd5SRzTG2Kk=
X-Google-Smtp-Source: ABdhPJw+6HCNRl+3SE26ZEu+DARUImXYTb8e1sg8nXwAZwaomu7mni/hN+RuxKopG8qtP04N1ufeog==
X-Received: by 2002:a17:90a:4083:: with SMTP id l3mr516866pjg.111.1603988361829;
        Thu, 29 Oct 2020 09:19:21 -0700 (PDT)
Received: from localhost (42-3-19-186.static.netvigator.com. [42.3.19.186])
        by smtp.gmail.com with ESMTPSA id d190sm3427309pfc.185.2020.10.29.09.19.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 09:19:21 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH v4] tracing: Fix out of bounds write in get_trace_buf
Date:   Fri, 30 Oct 2020 00:19:05 +0800
Message-Id: <20201029161905.4269-1-hqjagain@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subscript should be nesting - 1, as nesting had self-added.

Fixes: 3d9622c12c887 ("tracing: Add barrier to trace_printk() buffer nesting modification")
Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
v4:
Find the right patch which cause the problem.
v3:
Modify the way of array reference instead.
v2:
Fix a typo in the title.
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 528971714fc6..daa96215e294 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3132,7 +3132,7 @@ static char *get_trace_buf(void)
 
 	/* Interrupts must see nesting incremented before we use the buffer */
 	barrier();
-	return &buffer->buffer[buffer->nesting][0];
+	return &buffer->buffer[buffer->nesting - 1][0];
 }
 
 static void put_trace_buf(void)
-- 
2.17.1

