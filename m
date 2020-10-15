Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1468928F828
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 20:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388327AbgJOSJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 14:09:23 -0400
Received: from m12-12.163.com ([220.181.12.12]:43031 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbgJOSJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 14:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=fY1SD
        dSOE9vgbQVlj+o4OQBPE0d3FUxwXztxRh1S/fU=; b=Sb+sw71VU8jWM2CIDKbVy
        Df8WbcjDLp8U0c3VAUR3+8m1sqgtCrVlq1IdETib6RqadfTrIIASh3M73D714XyK
        de3rY/1tOJLKxSlbBhMAfI0N4tg4qfbDIL98l4IDa/h6OYMgDQd9p1AAMQdC26Kq
        XXceS0PDSyRIt2nqVgLJ/4=
Received: from localhost (unknown [101.228.30.83])
        by smtp8 (Coremail) with SMTP id DMCowADH32sOWYhfUYW+Rw--.35207S2;
        Thu, 15 Oct 2020 22:13:34 +0800 (CST)
Date:   Thu, 15 Oct 2020 22:13:34 +0800
From:   Hui Su <sh_def@163.com>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, corbet@lwn.net, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     sh_def@163.com
Subject: [PATCH] docs/rcu: update the api of call_rcu()
Message-ID: <20201015141334.GA20723@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: DMCowADH32sOWYhfUYW+Rw--.35207S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr13WF1ruF1fAF1rCw1kGrg_yoWfXrbEvr
        45XF4Syw4UtFn7JF4UGrnakryrWayrCF18uw4kXa98ta4xKwsxuF1vvr9Fy348u3ya9r9x
        G3s3Xr9rJwnxtjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbrOzDUUUUU==
X-Originating-IP: [101.228.30.83]
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbByxa+X1PAPRsUFgAAsL
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update the api of call_rcu()

Signed-off-by: Hui Su <sh_def@163.com>
---
 Documentation/RCU/whatisRCU.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index c7f147b8034f..aa7d5ed20da5 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -497,8 +497,7 @@ long -- there might be other high-priority work to be done.
 In such cases, one uses call_rcu() rather than synchronize_rcu().
 The call_rcu() API is as follows::
 
-	void call_rcu(struct rcu_head * head,
-		      void (*func)(struct rcu_head *head));
+	void call_rcu(struct rcu_head *head, rcu_callback_t func);
 
 This function invokes func(head) after a grace period has elapsed.
 This invocation might happen from either softirq or process context,
-- 
2.25.1


