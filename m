Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CADAA2968C3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 05:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374878AbgJWDah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 23:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374855AbgJWDa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 23:30:29 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9919AC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 20:30:27 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id s9so114543qvd.17
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 20:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=6HFlEVpudWH5pffnpQkc+Yc/oxstkbax6tUIXieA0lk=;
        b=iVgGGpv/7FVDQ3pQoJo5ENDkVCIPPnAb2W/P85Q5YObYQ2qOZxGF5aIUBugdD4WxjU
         Z5RiS70Guwrf2/je+hqDDOaMglLC2zunZShamfYLdW7/LeCKyl0Jm+323jMv/JP4bdLn
         Cnc1mlvlswebVTlRL7llKF7A6RsRxb5HywKIzg2GugnXeaGy2yJebCLgsW4mT3HNGT67
         Q9Ykutn29AadOxcTFqlJfponLBNNUotM0TG5bkKPWwVkNvEfLOzYa4mI5lFBvayOC1b3
         zP5wOtjf8ftz3PMQHQr6qhUXN6Jm0YYw/T2c3+BrXI0d1YjElTouA69Vo9i4xhiZB1ok
         Vx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6HFlEVpudWH5pffnpQkc+Yc/oxstkbax6tUIXieA0lk=;
        b=p1t/h43LwhrM+uJ9DLDuv0EFsPzbSbC84v0j1zVHxW6NKleyOYSpy5JugspJB1uT2u
         ictlpx6ubSYy5MhdizLX9tbLFHPCL8iIgFu51QQLFbnvqfcI/YmV247aytKOEe3yf+zm
         b/w+mrixKKpljSYFRtKwm3Hsu1ALaWUC0fekmiUJ4g2udrtvDEL64be27DL4U/isjVTD
         J7mi4fB6UL0GJJAEUonpv1oCYdrBHcfkl6EWTwUUn4aQObx9MjiMtK+oHF1e1h+oAydo
         p0aKLiPd34xHq8HcJlR2ZY3EQ41NYACMGH9jBnVRkBxAZJ6HOUjJ+TPNIY18ZCmvN6Hq
         f4yQ==
X-Gm-Message-State: AOAM533P0v0p5VrgTkAKC4ZDcfxskfasROpOOGsehIezI7bAssBdG2sE
        bUVq9k3ekLiWneInE6nv2QfpOphZmB3V
X-Google-Smtp-Source: ABdhPJywFZ9nl2zxccBBMSoKLsYKnTzcd6iRKtoGpdGnB7NFOH56JsDER6SvXGz5MrN+E2VlfKYlk66r6HEj
Sender: "joshdon via sendgmr" <joshdon@joshdon.svl.corp.google.com>
X-Received: from joshdon.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee1:cc86])
 (user=joshdon job=sendgmr) by 2002:ad4:43ca:: with SMTP id
 o10mr376677qvs.33.1603423826790; Thu, 22 Oct 2020 20:30:26 -0700 (PDT)
Date:   Thu, 22 Oct 2020 20:29:44 -0700
In-Reply-To: <20201023032944.399861-1-joshdon@google.com>
Message-Id: <20201023032944.399861-3-joshdon@google.com>
Mime-Version: 1.0
References: <20201023032944.399861-1-joshdon@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH 3/3] net: better handling for network busy poll
From:   Josh Don <joshdon@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, Josh Don <joshdon@google.com>,
        Xi Wang <xii@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the new functions prepare_to_busy_poll() and friends to
napi_busy_loop(). The busy polling cpu will be considered an idle
target during wake up balancing.

Suggested-by: Xi Wang <xii@google.com>
Signed-off-by: Josh Don <joshdon@google.com>
Signed-off-by: Xi Wang <xii@google.com>
---
 net/core/dev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 266073e300b5..4fb4ae4b27fc 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6476,7 +6476,7 @@ void napi_busy_loop(unsigned int napi_id,
 	if (!napi)
 		goto out;
 
-	preempt_disable();
+	prepare_to_busy_poll(); /* disables preemption */
 	for (;;) {
 		int work = 0;
 
@@ -6509,10 +6509,10 @@ void napi_busy_loop(unsigned int napi_id,
 		if (!loop_end || loop_end(loop_end_arg, start_time))
 			break;
 
-		if (unlikely(need_resched())) {
+		if (unlikely(!continue_busy_poll())) {
 			if (napi_poll)
 				busy_poll_stop(napi, have_poll_lock);
-			preempt_enable();
+			end_busy_poll(true);
 			rcu_read_unlock();
 			cond_resched();
 			if (loop_end(loop_end_arg, start_time))
@@ -6523,7 +6523,7 @@ void napi_busy_loop(unsigned int napi_id,
 	}
 	if (napi_poll)
 		busy_poll_stop(napi, have_poll_lock);
-	preempt_enable();
+	end_busy_poll(true);
 out:
 	rcu_read_unlock();
 }
-- 
2.29.0.rc1.297.gfa9743e501-goog

