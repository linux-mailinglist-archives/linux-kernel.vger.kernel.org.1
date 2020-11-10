Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73DA72AD8A5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbgKJOVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgKJOVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:21:35 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B331C0613CF;
        Tue, 10 Nov 2020 06:21:35 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id t18so6557471plo.0;
        Tue, 10 Nov 2020 06:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mHzmMaAp5/arsxlv9YourskeSIsJ2uw/Y2sk7NfH8wc=;
        b=f+5Eq+JmQGA7kTV4M39Lj5CndnYx6Ldzw8FLdt4hoRdqc07ILJ7b9d6KqginHU/5J2
         QcKWIlyjJCMIPxYnQnkxfnfby/xnyrBiVlKp35i82OmqAPcbHaCwPQJpAIPZ+F5P/64/
         2oBGWjU4K3NG4unVRy4nnxPJvsTiyMAiG/KwjRm545Ly4mmkrPJKiNpIFDr90e6p+y9S
         7DKf8AN2mmXU8+b2KR4FAqqiJ2NzK4CUhdGHg8C19RCI0TB51JPbC3hRCoWCZaPYjVBm
         ZAK/lCAgAESDqjxdvkhW99kBjG5USSMF1xBTRA0zgyDbFJ8EXKwLv9BZRPIy2NB56VTr
         pFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mHzmMaAp5/arsxlv9YourskeSIsJ2uw/Y2sk7NfH8wc=;
        b=QgweInex20bgwRo/fIzrWdjfpj6uaGVgR3tX+6iikrKA11wcQffX/1+4UF91bctx8Z
         70CC5WhegMAJFKUtfnDm0qz2nuLVHJ7e0tnQmMlNy/9Xv8sfdmc4FTLjEJctPsq838cC
         CDxA7H7XBE69xBzMlORRwDsxDbwLivy7/usUZ7TUsMhM0vIy3ghFLI2ql51gnHoxEIML
         3tPgipft6ZoGYcNNRJfaVy//FVhsKbg1SdFv+Zmnh4EURI4J1gttE4/viS0Y1hrbnygC
         3fU0T3yIl+t8QXzBvIUirXMU/hJT6hmG3ELfBwL91YVc+yNyApbXm5EEGH93P6yiZedr
         3mYg==
X-Gm-Message-State: AOAM5310fUcz5dAdZxWbkRZeHJCs0T53UQZubv3Ez9ZD15okY9mp+QW1
        JlAc4vZO++7CqWL41MJsJJEvPw9zO4CDNqY+xyE=
X-Google-Smtp-Source: ABdhPJxClzU0bPRCnh9Nrj9s4VAfadOYVsDnMtWLkBzAzpfP8vAEaQ4C5u8fgAs7W97ITY1LscClmA==
X-Received: by 2002:a17:902:b410:b029:d6:b42c:7af9 with SMTP id x16-20020a170902b410b02900d6b42c7af9mr16629970plr.21.1605018094746;
        Tue, 10 Nov 2020 06:21:34 -0800 (PST)
Received: from centos-7.shared.localdomain ([39.182.2.118])
        by smtp.gmail.com with ESMTPSA id c24sm13551218pgk.34.2020.11.10.06.21.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2020 06:21:33 -0800 (PST)
From:   Yang Mingzhe <cainiao666999@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        corbet@lwn.net
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Yang Mingzhe <cainiao666999@gmail.com>
Subject: [PATCH] Documentation: x86: fix thread_info's position
Date:   Tue, 10 Nov 2020 22:21:00 +0800
Message-Id: <1605018060-11571-1-git-send-email-cainiao666999@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bottom of the stack is where the first item was added to the stack,
usually at the zero offset. Actually, the thread_info structure at the
end of the stack.

Please see attached picture:
https://github.com/Mutated1994/kernel-beginner/blob/master/kernel-stack.md

See commits c65eacb ("sched/core: Allow putting thread_info into
task_struct"), 15f4eae ("x86: Move thread_info into task_struct")
and 883d50f ("scripts/gdb: fix get_thread_info").

Signed-off-by: Yang Mingzhe <cainiao666999@gmail.com>
---
 Documentation/x86/kernel-stacks.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/x86/kernel-stacks.rst b/Documentation/x86/kernel-stacks.rst
index 6b0bcf0..b88b9e12 100644
--- a/Documentation/x86/kernel-stacks.rst
+++ b/Documentation/x86/kernel-stacks.rst
@@ -15,7 +15,9 @@ Like all other architectures, x86_64 has a kernel stack for every
 active thread.  These thread stacks are THREAD_SIZE (2*PAGE_SIZE) big.
 These stacks contain useful data as long as a thread is alive or a
 zombie. While the thread is in user space the kernel stack is empty
-except for the thread_info structure at the bottom.
+except for the thread_info structure at the end (since kernel 4.9, the
+thread_info has been moved into task_struct, no longer locates at the
+end of kernel stack).
 
 In addition to the per thread stacks, there are specialized stacks
 associated with each CPU.  These stacks are only used while the kernel
-- 
1.8.3.1

