Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A7D275B95
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgIWPW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbgIWPWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:22:23 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9862DC0613D5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 08:22:21 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id v54so159831qtj.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 08:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B8xq+fCDo/vu8CjnIMXFVGoGMGuT1VF/zHBuR0NfskQ=;
        b=Mq8zKvJjqHKv2wrRkPwZFKEIE7VWCHKj66KghdiL0FxqS99AkdtOedD0OsXw680dsc
         i7/KikWD/p8ktqbDnmJoxESjZuRf7Bjn6MG9AE2CAwfvVBLYU/FTn6JG3hpTZtGrjzmY
         w0qB3pUGLXpnQyr42RI78j6IzfHUYj4fTZC7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B8xq+fCDo/vu8CjnIMXFVGoGMGuT1VF/zHBuR0NfskQ=;
        b=QwVoGZmc8CahYIZOof4XvFmA6liMfec52enVYZSe3+tWy650hsO/o40ZBm3zPXnXa0
         S4SVkEIi49u5xFyJ32pKwHJdor2OUXRygI72ojvFcuQvKj2AQMYilZ+a7yb0C66SGw8/
         t8jw1IovESCfGgg/+w4v3HGS51ORxuGl7+CZah9v4jrndegkrNgXGRy0lMcdOtL4Gam0
         78TaeagyZm87cV2rK3O8zDiHboiwNGOVz0oVuU983/Ytt0XJBjMrD1oWSD6UhZ8PpnTF
         gNZIJeR7c3Zf1XBqyICOlfi8E3yutEYVITBCXc1jXVdx52pl2FF5OW/u/87LRbHWVWS/
         UPog==
X-Gm-Message-State: AOAM531YDyNJvjyKcwYkPTXqSOIbuAR4GO5+TCJzF2goZvFlusJfPICu
        yCS2/hAijy/TT8wklEshE64gfGO0ezvUNQ==
X-Google-Smtp-Source: ABdhPJz0/nQpiHyn7rGKxteTNmCnymn00QqB+C+NlBaqtGqnC2ygp4UuKVH3leJnkajL/jc9NZkrdw==
X-Received: by 2002:aed:2986:: with SMTP id o6mr512699qtd.269.1600874540711;
        Wed, 23 Sep 2020 08:22:20 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id g5sm37909qtx.43.2020.09.23.08.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 08:22:19 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neeraj.iitr10@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [PATCH v6 4/4] rcu/segcblist: Remove useless rcupdate.h include
Date:   Wed, 23 Sep 2020 11:22:11 -0400
Message-Id: <20200923152211.2403352-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200923152211.2403352-1-joel@joelfernandes.org>
References: <20200923152211.2403352-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcu_segcblist.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index df0f31e30947..b65ac8c85b56 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -10,7 +10,6 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
-#include <linux/rcupdate.h>
 
 #include "rcu_segcblist.h"
 #include "rcu.h"
-- 
2.28.0.681.g6f77f65b4e-goog

