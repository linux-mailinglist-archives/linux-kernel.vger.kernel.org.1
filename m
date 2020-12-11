Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB892D6DE5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 03:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391845AbgLKCAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 21:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391610AbgLKB7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 20:59:50 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AEEC0617B0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 17:58:36 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id h1so5197058qvr.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 17:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=s48B060sFkliWSMPhDax2MNISlTZxiYugrX8TXTcWnw=;
        b=Ha6MMP9gBO2flV3HnS0n1AKPSoiptEWdNEVpBwfPnulYBrqPEvaN1p0hrJD0oRAQK1
         ThePFKSyg5x4nBiSyWL4h0uSfspJGTyfR04HID3LPoVoONKw+Tn5gJaYKJZR/JoH+pr5
         lRmk0o2D7l28SBLqViDp0uF8gvhLN3vKEJje2RuaaVZM1pxggHBQA0rS3rRl9YxC5Qrc
         sbXvnof8D0/zXOOvHSetBB9/Ul2quNUie0aDrjC32x+zSrfLtYhCYOv0W46wFhhCSFBL
         wCUN+lknoKk4amsca5DS2/np2d74phbA/pFKNyr/y6NYfyZtfxZUQSBbZI0/BNEDF6nA
         QUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=s48B060sFkliWSMPhDax2MNISlTZxiYugrX8TXTcWnw=;
        b=G4fywhoJ4HdvMG59ySRbM2RPmm1m1tvG+GrpLtGpG4Ttyu4SelWA9rhaksaI9/urv1
         scTVggIJsqQAUEQ+db1o8oKgTWAvpiOEJtcC5garyfzmFFBnVYBv5aHZxr0D/ErmOuj0
         bdhr/PV64JSFgNqzzwZrLsCmPs9VbBZ0AhRo1SQXOgGw6oM0p8Na1a+yW+NLN7VQh2Im
         vtcmc1vJE8BjIDWJ+5aqxTIFs1HnQMJzmJzoxxj5ikNN242MBlxEQ4/Yumz/Qa6aVz8v
         JwLQ1FfjSv+OyLtX3UGxrP4agl1QOipGzlimqHgRdQid95xMnAdmcvuW/LgRtliynIhi
         0DKg==
X-Gm-Message-State: AOAM530pAa+CKn8z4wviwyyNyIDGHhuVSdpvXivvJihv03QAKBdIUoXf
        DkDRfjHt1v0LHNAXUELL84WiIuklUG3+
X-Google-Smtp-Source: ABdhPJwWiVTd1ENEG7N/tUK2kb59tYDV1lHGWZeFGqgAdw9huCp6ZmOwH/0UrLGxrvBnJjQ6kEI4OwHBN4yr
Sender: "brianvv via sendgmr" <brianvv@brianvv.c.googlers.com>
X-Received: from brianvv.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:348])
 (user=brianvv job=sendgmr) by 2002:a0c:b3d1:: with SMTP id
 b17mr12561099qvf.41.1607651915781; Thu, 10 Dec 2020 17:58:35 -0800 (PST)
Date:   Fri, 11 Dec 2020 01:58:23 +0000
In-Reply-To: <20201211015823.1079574-1-brianvv@google.com>
Message-Id: <20201211015823.1079574-5-brianvv@google.com>
Mime-Version: 1.0
References: <20201211015823.1079574-1-brianvv@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH net-next 4/4] net: indirect call helpers for ipv4/ipv6
 dst_check functions
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Brian Vazquez <brianvv@google.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: brianvv <brianvv@google.com>

This patch avoids the indirect call for the common case:
ip6_dst_check and ipv4_dst_check

Signed-off-by: brianvv <brianvv@google.com>
---
 include/net/dst.h   |  7 ++++++-
 net/core/sock.c     | 12 ++++++++++--
 net/ipv4/route.c    |  6 ++++--
 net/ipv4/tcp_ipv4.c |  5 ++++-
 net/ipv6/route.c    |  6 ++++--
 net/ipv6/tcp_ipv6.c |  5 ++++-
 6 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index 9f474a79ed7d..26f134ad3a25 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -459,10 +459,15 @@ static inline int dst_input(struct sk_buff *skb)
 				  ip6_input, ip_local_deliver, skb);
 }
 
+INDIRECT_CALLABLE_DECLARE(struct dst_entry *ip6_dst_check(struct dst_entry *,
+							  u32));
+INDIRECT_CALLABLE_DECLARE(struct dst_entry *ipv4_dst_check(struct dst_entry *,
+							   u32));
 static inline struct dst_entry *dst_check(struct dst_entry *dst, u32 cookie)
 {
 	if (dst->obsolete)
-		dst = dst->ops->check(dst, cookie);
+		dst = INDIRECT_CALL_INET(dst->ops->check, ip6_dst_check,
+					 ipv4_dst_check, dst, cookie);
 	return dst;
 }
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 4fd7e785f177..753b831a9d70 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -526,11 +526,17 @@ int __sk_receive_skb(struct sock *sk, struct sk_buff *skb,
 }
 EXPORT_SYMBOL(__sk_receive_skb);
 
+INDIRECT_CALLABLE_DECLARE(struct dst_entry *ip6_dst_check(struct dst_entry *,
+							  u32));
+INDIRECT_CALLABLE_DECLARE(struct dst_entry *ipv4_dst_check(struct dst_entry *,
+							   u32));
 struct dst_entry *__sk_dst_check(struct sock *sk, u32 cookie)
 {
 	struct dst_entry *dst = __sk_dst_get(sk);
 
-	if (dst && dst->obsolete && dst->ops->check(dst, cookie) == NULL) {
+	if (dst && dst->obsolete &&
+	    INDIRECT_CALL_INET(dst->ops->check, ip6_dst_check, ipv4_dst_check,
+			       dst, cookie) == NULL) {
 		sk_tx_queue_clear(sk);
 		sk->sk_dst_pending_confirm = 0;
 		RCU_INIT_POINTER(sk->sk_dst_cache, NULL);
@@ -546,7 +552,9 @@ struct dst_entry *sk_dst_check(struct sock *sk, u32 cookie)
 {
 	struct dst_entry *dst = sk_dst_get(sk);
 
-	if (dst && dst->obsolete && dst->ops->check(dst, cookie) == NULL) {
+	if (dst && dst->obsolete &&
+	    INDIRECT_CALL_INET(dst->ops->check, ip6_dst_check, ipv4_dst_check,
+			       dst, cookie) == NULL) {
 		sk_dst_reset(sk);
 		dst_release(dst);
 		return NULL;
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 4fac91f8bd6c..f06dfba3d272 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -133,7 +133,8 @@ static int ip_rt_gc_timeout __read_mostly	= RT_GC_TIMEOUT;
  *	Interface to generic destination cache.
  */
 
-static struct dst_entry *ipv4_dst_check(struct dst_entry *dst, u32 cookie);
+INDIRECT_CALLABLE_SCOPE
+struct dst_entry	*ipv4_dst_check(struct dst_entry *dst, u32 cookie);
 static unsigned int	 ipv4_default_advmss(const struct dst_entry *dst);
 INDIRECT_CALLABLE_SCOPE
 unsigned int		ipv4_mtu(const struct dst_entry *dst);
@@ -1188,7 +1189,8 @@ void ipv4_sk_redirect(struct sk_buff *skb, struct sock *sk)
 }
 EXPORT_SYMBOL_GPL(ipv4_sk_redirect);
 
-static struct dst_entry *ipv4_dst_check(struct dst_entry *dst, u32 cookie)
+INDIRECT_CALLABLE_SCOPE struct dst_entry *ipv4_dst_check(struct dst_entry *dst,
+							 u32 cookie)
 {
 	struct rtable *rt = (struct rtable *) dst;
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index af2338294598..aba5061024c7 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1646,6 +1646,8 @@ u16 tcp_v4_get_syncookie(struct sock *sk, struct iphdr *iph,
 	return mss;
 }
 
+INDIRECT_CALLABLE_DECLARE(struct dst_entry *ipv4_dst_check(struct dst_entry *,
+							   u32));
 /* The socket must have it's spinlock held when we get
  * here, unless it is a TCP_LISTEN socket.
  *
@@ -1665,7 +1667,8 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 		sk_mark_napi_id(sk, skb);
 		if (dst) {
 			if (inet_sk(sk)->rx_dst_ifindex != skb->skb_iif ||
-			    !dst->ops->check(dst, 0)) {
+			    !INDIRECT_CALL_1(dst->ops->check, ipv4_dst_check,
+					     dst, 0)) {
 				dst_release(dst);
 				sk->sk_rx_dst = NULL;
 			}
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 22caee290b6c..071b5ff8f88f 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -81,7 +81,8 @@ enum rt6_nud_state {
 	RT6_NUD_SUCCEED = 1
 };
 
-static struct dst_entry	*ip6_dst_check(struct dst_entry *dst, u32 cookie);
+INDIRECT_CALLABLE_SCOPE
+struct dst_entry	*ip6_dst_check(struct dst_entry *dst, u32 cookie);
 static unsigned int	 ip6_default_advmss(const struct dst_entry *dst);
 INDIRECT_CALLABLE_SCOPE
 unsigned int		ip6_mtu(const struct dst_entry *dst);
@@ -2612,7 +2613,8 @@ static struct dst_entry *rt6_dst_from_check(struct rt6_info *rt,
 		return NULL;
 }
 
-static struct dst_entry *ip6_dst_check(struct dst_entry *dst, u32 cookie)
+INDIRECT_CALLABLE_SCOPE struct dst_entry *ip6_dst_check(struct dst_entry *dst,
+							u32 cookie)
 {
 	struct dst_entry *dst_ret;
 	struct fib6_info *from;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 1a1510513739..9e61e4fda03e 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1417,6 +1417,8 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 	return NULL;
 }
 
+INDIRECT_CALLABLE_DECLARE(struct dst_entry *ipv4_dst_check(struct dst_entry *,
+							   u32));
 /* The socket must have it's spinlock held when we get
  * here, unless it is a TCP_LISTEN socket.
  *
@@ -1470,7 +1472,8 @@ static int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 		sk_mark_napi_id(sk, skb);
 		if (dst) {
 			if (inet_sk(sk)->rx_dst_ifindex != skb->skb_iif ||
-			    dst->ops->check(dst, np->rx_dst_cookie) == NULL) {
+			    INDIRECT_CALL_1(dst->ops->check, ip6_dst_check,
+					    dst, np->rx_dst_cookie) == NULL) {
 				dst_release(dst);
 				sk->sk_rx_dst = NULL;
 			}
-- 
2.29.2.576.ga3fc446d84-goog

