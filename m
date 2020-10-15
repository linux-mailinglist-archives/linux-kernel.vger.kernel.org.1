Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314FB28EA57
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 03:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389359AbgJOBkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 21:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389083AbgJOBji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:39:38 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0FBC0F26DD
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 17:23:12 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id k25so2050987ioh.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 17:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N/ZNnvzbGq/DSZwz2Oqmm2mNYApnomyZsW1QceVJnHk=;
        b=vBf29QhCSCugzZIJ6+AhdT2Gb2FsQy4HvRgWnls3139N4gErLXWttYaX/Ev4qCDmAo
         Yc9omVWFoOs3960IUshS4UbbFv8wgqVYthDcEY2D6OTfP6tgV3l2lK3kc/CpO47X2B7J
         QDyaULoChBlT0dEssdXSf3gmFq3gzRnVd+/co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N/ZNnvzbGq/DSZwz2Oqmm2mNYApnomyZsW1QceVJnHk=;
        b=Q1xM9WjNoBe3OGofK2wIPhQ/RywojeyfajiN4nAyC/y/eHwQWQe2dAnKGO1AdC0X08
         jksBqaKgiOvvk0dSxE0K3moBf5mcabbj0j9zCEIsxnuq8v9t+WF+M4iQ0rl3EezMwT/K
         NBMUtptv5ASrWbYU/oHHuOqbJ5s+lPSehNBd2H0C65JbnsT+sVpZyHwpLGM5nyaxR4Ck
         uU8GOwzaVD3ll4DUdNB0gjyDuTDUyQvuO8QGacZslJDWeYgfh51exeWtcs1xuw9XAjPM
         9DKbPsrDH4jkRmjhMinsOZakf9b+PUilIVjCpgMmecHrZ70DO91M5dEpf9hLq/KWLdR+
         3EYw==
X-Gm-Message-State: AOAM533TwsGocSU2hD7fufuNj3wQwbv0LTXuM+POCMRyu2xmO0CuNh+3
        LQmlamJDr7NkzbA/ZEjDl5X90VtzNqSjmQ==
X-Google-Smtp-Source: ABdhPJydnmZUz7AgK8Mh5BtdbGQ+6k0J/j50suRV0PRydpmzG4IkWfdb6ev1wk3io1tPlXXy9AUR7g==
X-Received: by 2002:a05:6638:2395:: with SMTP id q21mr1515291jat.94.1602721391508;
        Wed, 14 Oct 2020 17:23:11 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id r4sm1075622ilc.32.2020.10.14.17.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 17:23:11 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: [PATCH v7 4/6] rcu/segcblist: Remove useless rcupdate.h include
Date:   Wed, 14 Oct 2020 20:22:59 -0400
Message-Id: <20201015002301.101830-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
In-Reply-To: <20201015002301.101830-1-joel@joelfernandes.org>
References: <20201015002301.101830-1-joel@joelfernandes.org>
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
index 2dccbd29cd3a..271d5d9d7f60 100644
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
2.28.0.1011.ga647a8990f-goog

