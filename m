Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E463628E1D4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 16:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731455AbgJNOCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 10:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730583AbgJNOC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 10:02:29 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21464C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 07:02:29 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id o9so1801853plx.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 07:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=S/N1SODWJLkX37b/eMP2s/JDgKzBmR6KFWzVMoMkTjo=;
        b=sojv89TLTo176tP73poKyjiJIhvzUVHgjtzdDzoXgz2tdbjvZ1e4Chy/dyp6kM/e0g
         N1iDgHOfEFRPLlfddqq9s3ldCCWzE1TKEt6Ijdy+KcoWTWdX+cdpXWbJq934xuyOjoWq
         9c0MWdELpuqfEXGvT5lCtSqdfdwVQPO9g2DXSZxUA/Gcb1xYm+uFDwQWW5tAnFjLf36n
         6XVbmamC3Y6FDt4bASc/r2qYITQOEyxFRXTPNxxRZawyVPivpGTEMJUI02XHnvqhlrjc
         SVC9+i01JsJ063zjzMMuJqf38uK+2lqLsFZ3nO1kYrUAWSTAOTIn1l3k7tKVP1IX8fTA
         WUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=S/N1SODWJLkX37b/eMP2s/JDgKzBmR6KFWzVMoMkTjo=;
        b=UGVLjnyaKGmr18kIyDBthlOCppllwYQ0msVM0TzK/LY5B6qQp93YPhBXl24+6W0Rmf
         7zn9tKawx52ppm6Bn2YIXpkkeTlzgyuUie969MzJ69QaQWbz8hOEIW4HRM4DRfLmsOhg
         Pewy0jFsGhS/LhBbAQzrIytRhD0bEuND4FAajRs+OcHaGlMsQOP03EX84ucqIoO2v9lg
         rpcGHbFipoIYY4cMNeY110JlRtASVTpsO/uYpy0T+o9rPp/MYWXCOKLi+33l7lTZ8KCT
         aKaV5Mgix+IaPdyMnZw6D8/NRw/moPKMF8R27sKSSthFc31EQIvnxnPGdz6Cj4CcWEUJ
         bTsA==
X-Gm-Message-State: AOAM533+5PyGvyzF6haskXY6izRwLbvRN/fsBnk2H80cT2l2Q8xlXIEY
        cV7VU23XFsmCEcVvJs4aOWA=
X-Google-Smtp-Source: ABdhPJwKmpJ4lFiX1BYkMHufJudMfFTwjaCO7Yi9cvEBEFMLHUGS2DFluFACe0QEgdz0UTWOsyxWQQ==
X-Received: by 2002:a17:902:6545:b029:d3:d370:2882 with SMTP id d5-20020a1709026545b02900d3d3702882mr4537190pln.44.1602684148692;
        Wed, 14 Oct 2020 07:02:28 -0700 (PDT)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id x25sm3615561pfr.132.2020.10.14.07.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 07:02:28 -0700 (PDT)
From:   zhuguangqing83@gmail.com
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, gustavoars@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        zhuguangqing <zhuguangqing@xiaomi.com>
Subject: [PATCH] sched: Replace zero-length array with flexible-array
Date:   Wed, 14 Oct 2020 22:02:20 +0800
Message-Id: <20201014140220.11384-1-zhuguangqing83@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhuguangqing <zhuguangqing@xiaomi.com>

In commit 04f5c362ec6, a zero-length array cpumask[0] has been
replaced with cpumask[]. But there is still a cpumask[0] in
struct sched_group_capacity{} which maybe missed.

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: zhuguangqing <zhuguangqing@xiaomi.com>
---
 kernel/sched/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 28709f6b0975..648f02363ff9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1471,7 +1471,7 @@ struct sched_group_capacity {
 	int			id;
 #endif
 
-	unsigned long		cpumask[0];		/* Balance mask */
+	unsigned long		cpumask[];		/* Balance mask */
 };
 
 struct sched_group {
-- 
2.17.1

