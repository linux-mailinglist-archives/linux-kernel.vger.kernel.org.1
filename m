Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBDBA2952BC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 21:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504739AbgJUTIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 15:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504696AbgJUTIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 15:08:23 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794B2C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 12:08:23 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id t9so2981646qtp.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 12:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mqpQ8VKwhCakuKl+8ZdrWs1pgorQAyuJMScy1hw3GSI=;
        b=HdiigIUU7wpMvysc+2FdMzdwy0L8epE8pNACz8W4jrAotJDvJpbJ7cyAk6FiykkBOQ
         xAY2fUAOLEIEkS/BX9/zJMvurv9BbMmyAdUtEtY1IfPb98Cg5bbd+d2eDYKmfLpipCPz
         bWU7EfjX6qMI2/zjjBu7KJY4dX+DJPmIGgdlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mqpQ8VKwhCakuKl+8ZdrWs1pgorQAyuJMScy1hw3GSI=;
        b=E/bbGBC0t1gBdSLVMZ/Weg/N5DksCgoo49eVFDaC4AGp30AwA+UKUpCD4qDkXEutrF
         7zNaKlEIvp9mKJA1R+Sk3UWv3uPsL8ndHrY1XoQ9VBXSgxoIezZQ50rW4d8Gu4qTu6ke
         oMXuWD8DFrWdbrrwM9ZSHaoKkBJuEhtS0ZmIepjRPopkWUGp4D31sQW7pvtmvEwmpd/g
         1UHv0r2OBmJXImFWlU43LUWJEyuDIY6dJTjyn54A8Ao4YATHDOmP0ib4J3cvDQMgSWLI
         3UGUe2ZuVB7HXI9A7iJ1ZRAXZR+PHM8t/7nnvQm3aweXkHxnBChOKv2ZS6ZulWCYSIDI
         VnAA==
X-Gm-Message-State: AOAM533pZ3h7GfY1tHsyLZhDN5V9sBgqQFu79YeQUF/BbRhwAKlzYz+K
        Kzaml13w8bfXc4gUgLx7LP5JZQR6lFQcjA==
X-Google-Smtp-Source: ABdhPJxiMBp9392GKZvHb5LXYrEPt9gX3rDiIYT25TvkHHWbyqF05/DANlgpV8tEJq5mQbp6Iz9UwA==
X-Received: by 2002:aed:35cb:: with SMTP id d11mr4532121qte.324.1603307302587;
        Wed, 21 Oct 2020 12:08:22 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id g11sm1913982qkl.30.2020.10.21.12.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 12:08:22 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: [PATCH v8 4/6] rcu/segcblist: Remove useless rcupdate.h include
Date:   Wed, 21 Oct 2020 15:08:11 -0400
Message-Id: <20201021190813.3005054-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201021190813.3005054-1-joel@joelfernandes.org>
References: <20201021190813.3005054-1-joel@joelfernandes.org>
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
index b0aaa51e0ee6..19ff82b805fb 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -10,7 +10,6 @@
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
-#include <linux/rcupdate.h>
 #include <linux/types.h>
 
 #include "rcu_segcblist.h"
-- 
2.29.0.rc1.297.gfa9743e501-goog

