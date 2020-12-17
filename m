Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95DF52DCC13
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 06:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgLQF33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 00:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgLQF33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 00:29:29 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B817C061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 21:28:49 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id b8so8519207plx.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 21:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PTl0THDgn2AwC8r+qfcc/Bz2DnZdRIJWemtVkiRjcyw=;
        b=sV54iQ31ZWag4sHjxIiH/QQtEUskh3ORZUYZ182bmOyhiWsVJ/Er7htgqmFD6JaHmB
         IGy9y5qrktAzor6ioV7/bRwAF0VxFS1Qj5XrF6XxEs8qzJBX+bvAuqQQ1RgZYfUqKwcW
         JGvMOxKm5aGWidpI3gKlVTR0sgaIibe2aCzGTRgs35ClQTc7vgYOr8BhdXM+hGscQego
         0PDtXQZX7Zcd4gHetOu+RxO6S+b1TvtjN4ekUEu8EkbP2zfCl9vGnzikryC2XVgOB+5O
         Ouk1X0FONj7bBQdeZ9OJI40ooLsKRKvyHuSuTUgjP7VN+3psTzZI/zeggoQEEQFQCuTW
         1wZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PTl0THDgn2AwC8r+qfcc/Bz2DnZdRIJWemtVkiRjcyw=;
        b=JwPwlF9QXrudOBNgwF1Z+KaHqsz5vf0dCsCemSLKk/HgBMlFMO+uV492tUrKYx7h+F
         4LT/ti/bndsFF/ZKAuweM30GWW+JTNsn/h3y06ianf+M8/6iJyKjPmMDJpPy/INNCFPV
         b2t+WOLisfxpIlZV+tUw9roVPqgMgAlWDyaRpjmQpLCc3Qwb8GG95ZOSSKYRR1bbUjiR
         RcvlGRivskny+g1l1iHmAudbl2Z6cWaJnA6I4szDm2qLHEFNUINHtciUaeCjTsDlKU4F
         7bguSzi2T4KhQBUB8gGgFHIOsu4LRs0bY5GDXNzO/rwNpNKNn32svEXl9PAbwCRkPyUt
         Lucw==
X-Gm-Message-State: AOAM532OrJR6jHA/bTgymKcYw39/wU6Y2PtaX0NaXcIOF3H7W/Y1srTv
        N4dE4w6y5zgoi7vEedoWOOOmdu1sPaFbIiz9
X-Google-Smtp-Source: ABdhPJyZSGHrmNh+geax9BBtJ7wq+GH0p02FliGe0Xi3cRJXqsW6zlYdd7MB0LSELXIVterL92De8g==
X-Received: by 2002:a17:902:bf06:b029:dc:1f:ac61 with SMTP id bi6-20020a170902bf06b02900dc001fac61mr6102355plb.16.1608182928400;
        Wed, 16 Dec 2020 21:28:48 -0800 (PST)
Received: from AHUANG12-1LT7M0.lenovo.com (118-171-80-86.dynamic-ip.hinet.net. [118.171.80.86])
        by smtp.gmail.com with ESMTPSA id fs12sm3601478pjb.49.2020.12.16.21.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 21:28:47 -0800 (PST)
From:   Adrian Huang <adrianhuang0701@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Adrian Huang <adrianhuang0701@gmail.com>,
        Adrian Huang <ahuang12@lenovo.com>
Subject: [PATCH 1/1] x86/mm: Refine mmap syscall implementation
Date:   Thu, 17 Dec 2020 13:26:48 +0800
Message-Id: <20201217052648.24656-1-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Huang <ahuang12@lenovo.com>

It is unnecessary to use the local variable 'error' in the mmap
syscall implementation function, so use the return statement
instead of it.

Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
---
 arch/x86/kernel/sys_x86_64.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index 504fa5425bce..660b78827638 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -90,14 +90,10 @@ SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
 		unsigned long, prot, unsigned long, flags,
 		unsigned long, fd, unsigned long, off)
 {
-	long error;
-	error = -EINVAL;
 	if (off & ~PAGE_MASK)
-		goto out;
+		return -EINVAL;
 
-	error = ksys_mmap_pgoff(addr, len, prot, flags, fd, off >> PAGE_SHIFT);
-out:
-	return error;
+	return ksys_mmap_pgoff(addr, len, prot, flags, fd, off >> PAGE_SHIFT);
 }
 
 static void find_start_end(unsigned long addr, unsigned long flags,
-- 
2.17.1

