Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540582A4801
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 15:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbgKCO0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 09:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729730AbgKCO0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 09:26:15 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A84C061A47
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 06:26:14 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id da2so5595984qvb.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 06:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UWA3bMlvW4N5Fl/v5aclEUikeTP5FjCaUq8wZh7hr9Q=;
        b=X5nKl7HlekDq5FcdnDtjpwl28bs3Yda3gv+ZUNyDQeBOk+e28XFtBp44vbC5VOSuz/
         +7iieKExTfLxeJU3ltBl3Sh+UeNY+YlmHYpitMgHpYj8xnwhQGwWWxLwBLzy6fNwdzco
         x10aoRlMEmT5bDH6fmEEkWGY6FRDQESTD2Fek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UWA3bMlvW4N5Fl/v5aclEUikeTP5FjCaUq8wZh7hr9Q=;
        b=t43dd+gwPWVXa1tFgmX2tFRxd/IIih7iTIcYZjv7+2wu2kXhubjamMTfTMxKO8+Qz8
         5wN6jO/NlpXrhwV/cVhNERY9sS9kBUM8FpcvT4KqYghIhGF30JOqDWQg5mP4NNn8RX4p
         pWzx/GZ3ihspGBGBxmtxr1wwgLBTLIuosbuZDT+7Ysytn6IdsSJJI4uY2KOJnmMfwwh0
         kJitpjuEzDZpnnoYKdLFB1wEmAVc4qtWFU/+FGvYvzK4jv21MG3A212KkIOtkeiEbs1U
         MBvwGaX1QscYupx3vocPbzLJ529ib5O71lXAtjbOIjTwStIygusjGMmsYu7896NSN6SM
         dE6g==
X-Gm-Message-State: AOAM531Usp1mZnmiTpJHrFeSZLG0cA24gsLGQTvlZNxPOEdnRhG2jDbP
        9OXBuAMOX82ktyNSabcOzUrePRoD1lXH4g==
X-Google-Smtp-Source: ABdhPJx1mZsv7yB+jw7z7ImAS5whuvURddlx/0IRvh0+OXQgCgVnZagcjye613kJ904FbL13V+xI5Q==
X-Received: by 2002:a0c:8644:: with SMTP id p62mr27338963qva.30.1604413573986;
        Tue, 03 Nov 2020 06:26:13 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id l30sm10564967qta.73.2020.11.03.06.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 06:26:13 -0800 (PST)
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
Subject: [PATCH v9 5/7] rcu/segcblist: Remove useless rcupdate.h include
Date:   Tue,  3 Nov 2020 09:26:01 -0500
Message-Id: <20201103142603.1302207-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201103142603.1302207-1-joel@joelfernandes.org>
References: <20201103142603.1302207-1-joel@joelfernandes.org>
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
index 2a03949d0b82..e9e72d72f7a6 100644
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
2.29.1.341.ge80a0c044ae-goog

