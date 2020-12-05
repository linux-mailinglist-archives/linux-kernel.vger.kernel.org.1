Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B720F2CF96C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 06:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgLEFCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 00:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgLEFCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 00:02:45 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A86DC0613D1;
        Fri,  4 Dec 2020 21:02:05 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id b5so499652pjl.0;
        Fri, 04 Dec 2020 21:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YCKTyFzGWQzeG8F5871ZshFHNgeYjCwjk1SIyTgC11I=;
        b=eq16rucFzScxn8GzYn77vYCBpTykfUf+O4hYsPPoKBsUq5nFP6LmiN0yTE8HJFyEEU
         yiItJGJaGDA6eaHyTUuu4t9ERnZzR+2cgDfqchbrvCi7urRz2zT5kM5M8aEsfoVDkg35
         fuqL4mH7gjXpZpvNUpg3FzSXe8Ba/ootIGqcQNkQSWRqmSUpAknFF7TqB+TOum8hBOZK
         sOk3JfqsjIRZDn13E3DHOa/gBBvDR6J1cQDm2oJt0vsHbI3b2ur9zL78jb4snJP5ow4v
         qIeqLAE6nzsaVrQ1QHQ1Jb1UkR43/9AgLA4Vfm+YAEK4WXr0d0855FqpABkeREZRtLYh
         rzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YCKTyFzGWQzeG8F5871ZshFHNgeYjCwjk1SIyTgC11I=;
        b=J0vXg1z2ptlhP6D1bL9AI2OFvM6B3OVVRAI9EjiO7VtgRV9jtLzgvnFwNXmhdeiXaN
         /tqr/ZYM4gElthRkyZHUZnYJB/NOFHJzEkHA4/fEkcJyaPafCR3uP+xPl6UFQGsjJQQf
         NODksA1OQnSPytAzstGCvQyAYXfGW8KOH7hyNVcnVeQ9QXqXlbZSvXLB6di0bItDj6FK
         HZndxZ/VY4nO1ZTNGIRamlAL734N6VdyrXxUVDCRKUHPIgRAE59x6K6eD931+vjmkkYz
         3SYf0CErz3ytYTbmiGFWEcueWyRwD/wLgW8YigccNTEPQMd1ENRXbkYtpSbFu2q6TQDt
         Q6RA==
X-Gm-Message-State: AOAM532HtMkP29fhO5qfWk5SPo437NdcNTdhSyRYo+2FotME3bFOs6Tp
        6i4LI6ICz+/uBSrGF2ooFyY=
X-Google-Smtp-Source: ABdhPJxgsN/0/42E6/xL2IvNL5t20vqK49omNAJMc6BVnqjO7aNbjhTA9Ag3+6LykIGWYlajB7Hkgg==
X-Received: by 2002:a17:902:c215:b029:da:b079:b9a3 with SMTP id 21-20020a170902c215b02900dab079b9a3mr6763811pll.67.1607144524517;
        Fri, 04 Dec 2020 21:02:04 -0800 (PST)
Received: from localhost.localdomain.localdomain ([39.182.0.228])
        by smtp.gmail.com with ESMTPSA id d8sm3596888pjv.3.2020.12.04.21.01.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Dec 2020 21:02:03 -0800 (PST)
From:   Mingzhe Yang <cainiao666999@gmail.com>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, hpa@zytor.com, corbet@lwn.net,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, David.Laight@aculab.com,
        Mingzhe Yang <cainiao666999@gmail.com>
Subject: [PATCH] Documentation: x86: update the thread_info's position
Date:   Sat,  5 Dec 2020 13:01:36 +0800
Message-Id: <1607144496-10635-1-git-send-email-cainiao666999@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to kernel 4.9 the thread_info structure was at the bottom of
the kernel stack. kernel 4.9 moved it into the task_struct.

See commits c65eacb ("sched/core: Allow putting thread_info into
task_struct"), 15f4eae ("x86: Move thread_info into task_struct")
and 883d50f ("scripts/gdb: fix get_thread_info").

Signed-off-by: Mingzhe Yang <cainiao666999@gmail.com>
---
 Documentation/x86/kernel-stacks.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/x86/kernel-stacks.rst b/Documentation/x86/kernel-stacks.rst
index 6b0bcf0..e9097f3 100644
--- a/Documentation/x86/kernel-stacks.rst
+++ b/Documentation/x86/kernel-stacks.rst
@@ -15,7 +15,8 @@ Like all other architectures, x86_64 has a kernel stack for every
 active thread.  These thread stacks are THREAD_SIZE (2*PAGE_SIZE) big.
 These stacks contain useful data as long as a thread is alive or a
 zombie. While the thread is in user space the kernel stack is empty
-except for the thread_info structure at the bottom.
+except for the thread_info structure at the bottom (since kernel 4.9,
+the thread_info structure has been moved into task_struct).
 
 In addition to the per thread stacks, there are specialized stacks
 associated with each CPU.  These stacks are only used while the kernel
-- 
1.8.3.1

