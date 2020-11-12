Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2560E2B0843
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 16:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgKLPS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 10:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbgKLPS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 10:18:26 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F3FC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 07:18:26 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id u2so2936176pls.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 07:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Y6n1j5ieoaPl104h2GHbkpjD3WvJfFbQ2oIyPHNuXic=;
        b=Nx8yqZwlit6FO5nSvh8TNxM82iABo5jdw7qRSU9d4EpVPv0BeZ9iHrxoOUh7HW75wu
         MQDbO+Ej3k58ZePcl9BxNm4Fy8uHVFADoN63GxERgNRIRCFeJQ2bcoT7mTk/BMJ+g5DF
         LOuTR5q9SOSlW3oGv9ZPZf/akdMvqjZtkjunxlnE/bPfHv2wJtzXluPXAkKkPP/Vxlhe
         QsIky5oLBQEixnKj3Tcf7/Pv9iwhqa5LAvKPh3ssEt6572rsWY7tFO2bE80lZgYcydIm
         dUsfguVNmb7eC7lhisPRXosEQ0n5NsW4FQE8Nobp1/LSDSfE1owtXOukX/OxtndU579o
         6y8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Y6n1j5ieoaPl104h2GHbkpjD3WvJfFbQ2oIyPHNuXic=;
        b=CSocvbLRC25zrdKgwdlR/q1LgQiCtZAmkdVWaq7yrcqxwFoIvHarEuxgd5YJVxIxXq
         GJdaS8roXb6xT8VqD7R/ZsaETq1GrS+5LL/4UDfp3/hBg4fCObnmciRQk5cYKsQiu8C5
         uS1amzyWc9GRHzCUlLS3p7u7e/gTCIitp5DlLPMzztEtygqBLjP8vo3ufRWLBKtENOzl
         GXZcnWyQDWqmLAWm7av6YBub0Z+ypcq28EjZv4TDg3dWQotT4YFI2vmU4sbCoZ3TnPHx
         aooTP931pOYlozhGrapauu1DYBbQnnFpolIzmM/2IKVKckXvwMLHKld8O8Wa8SWgbrND
         RDcQ==
X-Gm-Message-State: AOAM5304iiMy12bHd0+uGFVCxlYsRhTr+RQ5siusZgYtY7K/tsqBK4h6
        vsvXc0mLWz9qD2lHBCzjrUA=
X-Google-Smtp-Source: ABdhPJyKXAbdR8Baht6aCMlI8jEeiscwInTTCKAv+gzoRRc2vp7s7SINnKZIwm1ig4tTQJqHTG6l1Q==
X-Received: by 2002:a17:902:8c82:b029:d6:df6e:54ac with SMTP id t2-20020a1709028c82b02900d6df6e54acmr163084plo.29.1605194305331;
        Thu, 12 Nov 2020 07:18:25 -0800 (PST)
Received: from localhost (42-3-19-186.static.netvigator.com. [42.3.19.186])
        by smtp.gmail.com with ESMTPSA id q72sm115946pfq.62.2020.11.12.07.18.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Nov 2020 07:18:24 -0800 (PST)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] ring-buffer: Fix a typo in function description
Date:   Thu, 12 Nov 2020 23:18:00 +0800
Message-Id: <20201112151800.14382-1-hqjagain@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/ring_buffer_commit_discard/ring_buffer_discard_commit/

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 kernel/trace/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index dc83b3fa9fe7..27a7caf4e203 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3502,7 +3502,7 @@ rb_decrement_entry(struct ring_buffer_per_cpu *cpu_buffer,
 }
 
 /**
- * ring_buffer_commit_discard - discard an event that has not been committed
+ * ring_buffer_discard_commit - discard an event that has not been committed
  * @buffer: the ring buffer
  * @event: non committed event to discard
  *
-- 
2.17.1

