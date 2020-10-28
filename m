Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4BA29E238
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgJ2CLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbgJ1Vgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:36:44 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B03C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:36:44 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id b3so383111vsc.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xbnd0NoFYoB7PfypZO6wzt43HHnGRWSv9fNX9Bj+o+o=;
        b=e1rhlCuidEDRA6xsenaviIPZgQzmsCnwlrTnpqgID06fQ3I9pXukFQQdtyW3D92Td7
         aLWXCR0OQ50cedoKVFpP8HqMJ7kzrkE3oAHEZxn8/mPnLwoGXJJK13ROnz9ttvBXXeXU
         m1zZtWbMEE6FIvMKN+AZ7D3P9fjHILILej/BOL+DAMc7+BzEyUW4t/z35KZLZeXT0+QW
         Ki1MmuJo1PYZBBzdXsvPNXIIWUUiDnQx1l/La8fWos24XJnV5ncCy0ge0DTbozAgyiWy
         27nLvRP+O6uOP7ZuSq51MlpO+14WeC73J0mU6HLOBM5FJ5SJbAp46XixTfteTqPo7neE
         veiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xbnd0NoFYoB7PfypZO6wzt43HHnGRWSv9fNX9Bj+o+o=;
        b=No7XX19rY0THXWNw7SOzTldlbcMZGja1X/4FP3yZyMXvU73a5G1HmbVPwSbT6Y+coW
         Yn/oXc5UD4Te2RfOeQdLz0qV/uR1QFeWXvle0nErStXtrv7g4vHH8KCG+0iVVfAqCWbo
         ScpTXB3rbeWjXmZ6Lk4G326Hm+IKYK2nCvm2RmPXvCEarCsOXJC+w7C1zSDgb9/bG46F
         xuMY0r8NkG5GE9ZuSxGbCzqwkB9ULYiJngmfkuWMrEs87YZFIMb5gdqXNBY1xyokaPym
         CMtwmjRUkxfAVi8zjptq7bDUEKV8oMTmqrBgnDFJaMAsK0QV3WD2fkkljcaYs5nFnRc/
         CIww==
X-Gm-Message-State: AOAM530Ase4YHCKLgrGPG+rh2AAYYOVcXFDbwQ+QQFoZjETM97GZkw/Q
        bouWhLcfc6P3QK2V8eaxtcHDzI1WlAhHs8lG
X-Google-Smtp-Source: ABdhPJxIIAWNccilmnOg3jeLcpktP0phggzqkcg+C6gGrrev83l5rtt27FjHbuliuVU+nwTHvb/IXg==
X-Received: by 2002:aa7:95bb:0:b029:152:b32d:6935 with SMTP id a27-20020aa795bb0000b0290152b32d6935mr7446338pfk.54.1603887643018;
        Wed, 28 Oct 2020 05:20:43 -0700 (PDT)
Received: from Monkey.fios-router.home ([47.144.162.13])
        by smtp.gmail.com with ESMTPSA id a143sm6329137pfd.138.2020.10.28.05.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 05:20:42 -0700 (PDT)
From:   "John B. Wyatt IV" <jbwyatt4@gmail.com>
To:     "' Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        chris.hyser@oracle.com, Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen ' <tim.c.chen@intel.com>
Cc:     "John B. Wyatt IV" <jbwyatt4@gmail.com>
Subject: [PATCH 3/8] sched: Fix some style issues in test_coresched.c
Date:   Wed, 28 Oct 2020 05:19:12 -0700
Message-Id: <20201028121917.635203-4-jbwyatt4@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201028121917.635203-1-jbwyatt4@gmail.com>
References: <20201028121917.635203-1-jbwyatt4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Line 825: open brace '{' following function definitions go
on the next line.
Line 459: that open brace { should be on the previous line
Line 459: space required before the open parenthesis '('

Issues reported by checkpatch.

There are other issues including over a hundred instances of using spaces
instead of tabs in this file.
I am currently fixing these specific issues in this patch.

Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>
---
 tools/testing/selftests/sched/test_coresched.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/sched/test_coresched.c b/tools/testing/selftests/sched/test_coresched.c
index 91cfb00f15b5..f11ed8370c07 100644
--- a/tools/testing/selftests/sched/test_coresched.c
+++ b/tools/testing/selftests/sched/test_coresched.c
@@ -459,9 +459,8 @@ char *get_task_core_cookie(char *pid)
     sprintf(proc_path, "/proc/%s/sched", pid);
 
     fp = fopen(proc_path, "r");
-    while ((fgets(line, 1024, fp)) != NULL)
-    {
-        if(!strstr(line, "core_cookie"))
+    while ((fgets(line, 1024, fp)) != NULL) {
+        if (!strstr(line, "core_cookie"))
             continue;
 
         for (j = 0, i = 0; i < 1024 && line[i] != '\0'; i++)
@@ -826,7 +825,8 @@ static void test_prctl_in_group(char *root)
     print_pass();
 }
 
-int main(void) {
+int main(void)
+{
     char *root = make_group(NULL, NULL);
 
     test_cgroup_parent_tag_child_inherit(root);
-- 
2.28.0

