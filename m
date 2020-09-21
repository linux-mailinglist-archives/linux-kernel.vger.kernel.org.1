Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8743271901
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 03:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgIUBWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 21:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbgIUBWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 21:22:04 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D953BC0613D0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 18:22:03 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id o5so13389799qke.12
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 18:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sVeTc22l2Yk1++iDs1yD3RDP6qVn0kRlubPHnWoYwfY=;
        b=UKQ0cyg17UPDOQxX0IKs6/oYH6ICoTLY8ktXXVjaPWoAfWPZHvgqU92tfWPv7B4l3Y
         9OPFblk7kmiNEtRI2DFmUfi/Hc1LKMMOC9XNY0Qva3ftOjIpuBzhYaLJo/GCD6uNolk+
         Q2xJxzXM2/Rbdst9YVcgtHCD45XZuevdIyfU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sVeTc22l2Yk1++iDs1yD3RDP6qVn0kRlubPHnWoYwfY=;
        b=TWp4HlJtUkGtvY8dZU69UO0CeeHYsAX3YaGJhioAVRDo3A0vYpKo4Ldu9krBUwdRTY
         0+kirYoNboCtX4uNiz3Gmn11SESggQRd+P1hsC5aVH/8CKE9MUiLY/k3m61lkfUvddNz
         7roNYkG/DK/bAyjKnsCiAxGO5j3j/e4nmiS6XwSwbFjfE1aBIZ0NnmqefK6+SDUQqQGS
         U5oeTwA3e2ROcA+P1847KXUmZ+blSj3g7OT0xcki1pUn5SgOBERdEZifIrvdY6gkyijS
         SHKfy0I36R+0eOJ+WeAh/TgnuYFg2vOnrcz/0e3BAHSMXqL+u4xKjRzFxiAzqfseNYDB
         NUrQ==
X-Gm-Message-State: AOAM533LIJRTKZK77I63Y6ywVjD1n15Ajj2jJ4mmwgS1gMI+Mci4Mqs3
        31gLNsGTmZOpgmqgKHdLjDtIRM9Uilf5sg==
X-Google-Smtp-Source: ABdhPJwzyAJEG9M68QHHaE64aAC7CGbk1CV9+tmUuo0qNXu8ncMma1htQvSvSCKU7lEYDAnmXWtQrg==
X-Received: by 2002:a37:474c:: with SMTP id u73mr45470844qka.45.1600651322970;
        Sun, 20 Sep 2020 18:22:02 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id l26sm7741951qki.62.2020.09.20.18.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 18:22:02 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neeraj.iitr10@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [RFC v5 5/5] rcu/segcblist: Remove useless rcupdate.h include
Date:   Sun, 20 Sep 2020 21:21:52 -0400
Message-Id: <20200921012152.2831904-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200921012152.2831904-1-joel@joelfernandes.org>
References: <20200921012152.2831904-1-joel@joelfernandes.org>
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
index 72b284f965aa..13f8f181521d 100644
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

