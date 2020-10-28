Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D3329D60D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbgJ1WLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730640AbgJ1WLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:11:16 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA70AC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:11:15 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id b129so446899vsb.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W3QC+JVE0ZEdiKPTXrMhqd8y9ZLhpKEDdsU2s9XNOHo=;
        b=dDph4uOBN3SJtbT3h6bTWkY0XwObHL1T7Smyv0lKNQWniMP5EJE4WO5V7BumPwoKs3
         fRisM+abk2m1K00BlG2e1InkKGo+TmCP35X0sq+d/aLMDorZpYmLqz2LByDW55cZ/KRf
         rF/RwAJ/RyGcQIRyGpGvFroo//zNghXKKUwi3O2T7e/i1BEIv4emUGPGdWNwcwREnnUV
         0zToi2GlWSfX0mRZyOlThtdvpvirIdngjcbLimcbw5jo56ZqDLQLVrgJPyxXOLyIKw6L
         i8NHx9JyRmc6ecUa0dNQTn5JuPo/dLNHWKNmOxQgxxSLqQvWFtnDvtdjREx+1Pc8jlVW
         zzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W3QC+JVE0ZEdiKPTXrMhqd8y9ZLhpKEDdsU2s9XNOHo=;
        b=oNBAnNvqF3m3xy700ytHXvxkhAxcZpl3e685NSoWHdS5HBPi6gpN8HE2yByJ/mKp6y
         XdpzBeuAvt/G/DH1o94NQeNaMvy7JyAI4fJVZDKVLngT2e3M+Gs8yd9CeIppsyfBj0Uu
         PHNhpwA/auPnTCSyt/h4bIPdBDvb7TIHjkhgUAfFR84Viadsb4xSg4V4EHD4B1LdV4Qm
         gASW15EA6/NDzI8iFtlxURrtjWP898Iyv/ihPzwEN1fvBZ/LW3fpvSSu2DzESmNRiH00
         LpNBnPRlnVzmLb+THr9Mu237Dsc3eX1CItPU5oGFi9u48ulZeqoMvQQCDMk6dEdrXV3K
         vkYQ==
X-Gm-Message-State: AOAM531rddCgelwSxdSAP3BQCt/iBkDzIf0XGIXH3n0l3V6CPd2HEOAo
        OHitHsfDFbLxE8XJoN7hpiva4DP5YAR9ZQZE
X-Google-Smtp-Source: ABdhPJyTELBZSVaUHJvL4uZO7Gu+a7tgkZxRyhXn0xJBSo4gQ380lbVwDNesKiFyRrdpDWeemWjK5w==
X-Received: by 2002:a62:8097:0:b029:153:ce1d:c46 with SMTP id j145-20020a6280970000b0290153ce1d0c46mr7298476pfd.68.1603887640351;
        Wed, 28 Oct 2020 05:20:40 -0700 (PDT)
Received: from Monkey.fios-router.home ([47.144.162.13])
        by smtp.gmail.com with ESMTPSA id a143sm6329137pfd.138.2020.10.28.05.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 05:20:39 -0700 (PDT)
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
Subject: [PATCH 2/8] sched: Fix bad function definition
Date:   Wed, 28 Oct 2020 05:19:11 -0700
Message-Id: <20201028121917.635203-3-jbwyatt4@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201028121917.635203-1-jbwyatt4@gmail.com>
References: <20201028121917.635203-1-jbwyatt4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

main() should have a void.

Issue reported by checkpatch.

Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>
---
 tools/testing/selftests/sched/test_coresched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sched/test_coresched.c b/tools/testing/selftests/sched/test_coresched.c
index 2fdefb843115..91cfb00f15b5 100644
--- a/tools/testing/selftests/sched/test_coresched.c
+++ b/tools/testing/selftests/sched/test_coresched.c
@@ -826,7 +826,7 @@ static void test_prctl_in_group(char *root)
     print_pass();
 }
 
-int main() {
+int main(void) {
     char *root = make_group(NULL, NULL);
 
     test_cgroup_parent_tag_child_inherit(root);
-- 
2.28.0

