Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8922829EFA7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgJ2PYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbgJ2PYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:24:24 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F9CC0613D5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 08:24:23 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 133so2586133pfx.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 08:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zz1neG8HMbgvToMzk6oeXFbZ40cR4GHHMQiU0aR3A0M=;
        b=M1sgjLk+7cF8upAnv9lvL1TawADDInr7ihJzyQomg1453FnhLNCow9ta2dRDS4TvUi
         mXPZ7uoBawBDCACv36E4RPhNwaTARPt/XPW1PWW6aj2dCWEbkRJg0tKoO2M9ouKn+R7M
         my92xK0MK+5dcVkhNvu/cu2KMabnB1vv9npVy+D4837RZKZw2BBVHSblRmU0fsz2Vgo9
         oPfGbfn7R6e3CSXpVEWFL989yvxjv0NtOsTAldKGP5KdpGVVeuOTdT1mzVbE3afvKiYj
         mUG8zxfB2LZirUcD3r6tL++0omXNMwS5Oz/m4GWTCWBoEtP8bwLpdNNCi5+1KbHwgb6O
         pk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zz1neG8HMbgvToMzk6oeXFbZ40cR4GHHMQiU0aR3A0M=;
        b=XDqQMH44t3Kdt4qaVzwaxX3IQaloD+h+MZUtUNmFrcLsnvJ3hqJLdDfkxBgjXtX3dT
         IJn4TnvFIkOMTrvQPnnxc6zsUyMiQjLdvLjpbE/Gim8Kup2qGvvZYL+2ocw37WxNEcVu
         qig/NS0YaG2OZJs1b7wgfdpmrMf1m8JxYwfERImpFJXmGGwhbx3WoKiSuWuBxRoL/6Qs
         1NuNoizGRK9N/Xc8ng3oyXG1GkgVqUafw9wKzylvNZn5cmD/7R0tObXkkYTIs7XUorco
         9tfpKh3cs8gBPXpwM7OYXNnhkseIPtRwCeT6xj7vTWdOi51Lk7QLq/JUCIpRshVvhDn0
         7xCg==
X-Gm-Message-State: AOAM5324uyysM3lenRYSb5/2Wqpv/zVbWpOtOPC6olnz+crVDL1NKTUZ
        pvt+wTx9bdwcmnTBnfA9r5Xh9H66z2Y=
X-Google-Smtp-Source: ABdhPJzm73yplZ1kaQ5ol8UmDkRTXHndDZ1Rdq/JCaQJNfPUJLZZddfB5c8j7qjMQDn1CqhblROczw==
X-Received: by 2002:a62:1603:0:b029:160:98fc:ad23 with SMTP id 3-20020a6216030000b029016098fcad23mr4984589pfw.47.1603985063589;
        Thu, 29 Oct 2020 08:24:23 -0700 (PDT)
Received: from localhost (42-3-19-186.static.netvigator.com. [42.3.19.186])
        by smtp.gmail.com with ESMTPSA id h10sm2919356pgj.69.2020.10.29.08.24.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 08:24:23 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] tracing: Fix in out of bounds write in get_trace_buf
Date:   Thu, 29 Oct 2020 23:24:04 +0800
Message-Id: <20201029152404.3534-1-hqjagain@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The boundary condition should be 3 as we access
buffer[buffer->nesting][0].

Fixes: e2ace001176dc ("tracing: Choose static tp_printk buffer by explicit nesting count")
Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 528971714fc6..196a4b7de48a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3125,7 +3125,7 @@ static char *get_trace_buf(void)
 {
 	struct trace_buffer_struct *buffer = this_cpu_ptr(trace_percpu_buffer);
 
-	if (!buffer || buffer->nesting >= 4)
+	if (!buffer || buffer->nesting >= 3)
 		return NULL;
 
 	buffer->nesting++;
-- 
2.17.1

