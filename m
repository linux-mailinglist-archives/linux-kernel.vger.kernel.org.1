Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE5629F0A0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbgJ2P5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbgJ2P5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:57:31 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128A2C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 08:57:31 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id z24so2703944pgk.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 08:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lTUHb90aDzUDND2rdKN/gp3QHYuHZ8nhx0Wf1vd5LKk=;
        b=SDwP3bmCckPi50TqdnAe0CylVXD+7kN3COsGzSsGefI8VFYkD7B3Ho/P8O8ynYZhCk
         LPG0V8C30rS+4DVC+7fLC0YlLyXQeKQuZgXXEPSM7P02ULNgtffyE6T4FN72Os+znoCT
         WnQpUcGYwect55FclV7ILmJNzmvf0ozzWSwgo0Vim71OZ4NNqwAihzOPHxEP4+BKkFaH
         Kpm5Wy8i6n3sxgFHOe1WXFNWOEcwB42oCsdq90WkqvGSu6NoXs4WTb6kRMnKaKXNmjOM
         2V4yweaQFPXWzJ1B1p8JJ6ktFfCfDk1cGq6c3SYzXkgxfgKipSvnwZjBOkwXIrTvHByT
         L5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lTUHb90aDzUDND2rdKN/gp3QHYuHZ8nhx0Wf1vd5LKk=;
        b=KfioNyzQ43mwyPsjZHsW9BY4rt08m6rGosfSZL4Y1svWcL012RCRMI2ND3qwuVkoMm
         P2r7BHJDUkvnZrBVYSrfIU2Mb1zIEgR5nyyYwTTUBbuUNR4DfzzlWj6l9XpFJmkza5An
         9IwxAWsoFcV8W9mUGKVJ4JXIhqTiFcYe9qsIzGV4kwbnwv/0xsgXTUPp0bpwUyosWS1a
         uZJ7MOix6UPA5AKsvB8WTRyBbn6dscLKfrS/nkcy4Cc6+Q0TjXH8/MrHpGXqlzRiCDe6
         cPOGeQItwKj0dWTu7wKb9ZuAsRU2+np6bCfQ978jvRaClUPnBTmYLmYJE6Qm5gznVWXo
         jqyA==
X-Gm-Message-State: AOAM530K9xODalt2A6oHio067Ug91ICxvzvc5ApQvmyFy3QP3T9rNRbW
        6v6SO0K7y76sCrUDrrOdW+Cl1Engva8=
X-Google-Smtp-Source: ABdhPJxAu1s9liEFd0hMoyqKpHvMlfa8tbf7TMNPDGJQI94lKcxpaJvjw5F+/MHuBTIu8YmXYd9L0Q==
X-Received: by 2002:a62:a10a:0:b029:154:fd62:ba90 with SMTP id b10-20020a62a10a0000b0290154fd62ba90mr4946523pff.62.1603987050708;
        Thu, 29 Oct 2020 08:57:30 -0700 (PDT)
Received: from localhost (42-3-19-186.static.netvigator.com. [42.3.19.186])
        by smtp.gmail.com with ESMTPSA id s11sm263481pjm.4.2020.10.29.08.57.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 08:57:30 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH v3] tracing: Fix out of bounds write in get_trace_buf
Date:   Thu, 29 Oct 2020 23:57:14 +0800
Message-Id: <20201029155714.3935-1-hqjagain@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subscript should be nesting - 1, as nesting had self-added.

Fixes: e2ace001176dc ("tracing: Choose static tp_printk buffer by explicit nesting count")
Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
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

