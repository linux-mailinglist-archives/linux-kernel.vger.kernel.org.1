Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17C2296D69
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 13:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462825AbgJWLOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 07:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S462811AbgJWLOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 07:14:04 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931D1C0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 04:14:02 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id q5so1090231wmq.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 04:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=memsql.com; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=GF9B6SYLRzLidzBBztBZX6WXKZIvIfWHBORPObBW6Xg=;
        b=N6PdIeG6ldrqc6d0LiMR+wuU6XlqBbBv958Vkf8bbgXEA10mpsxSx5YqP0OnCmjtoN
         gaa+cfAwZsHCBd4q22ghwCKsjMNTWFl6EsuKlHafyCh4JBOpGFVssHoJ0iiRQE/RHLLB
         LvwaSubDIaALd8pfwP4q1x8P063eilFg3TAwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=GF9B6SYLRzLidzBBztBZX6WXKZIvIfWHBORPObBW6Xg=;
        b=h8jXsxrYRwHl2Uw30/QYZ7CU1430qT2ab7tt0i8MPqfrEYpRvj9Y4FMQd3zqUSJaq1
         qVwFGgGl7UBvm030250SjbYoD2z3tXhxnZpKRuHCa0EaTC+byJQ1/+tRKRabklrXv3as
         HVHE5mkB80HELcrDLzpIM3TbwU0ictOUPgFCT9EKVlGlpFU80nH2wZCo0eY6YYub7Ws0
         jqICdM2mZtXP9L6BRHxcfrGHkvGPvYY2JeDIAEh2q204cFBgZ88ueUDr4BlLG7EPuGrl
         Vw3X8+NS147cMwyRyyXAl5BVeTOqZdx0LDi12qelE+Il5flHp+n0aQdHcMvD46L/5mBI
         dDnA==
X-Gm-Message-State: AOAM531PPXWUULTsgC44bGwZNuR7Jmv36qVzd2CEsx5H9g3TxNBU/qYc
        ScHpr6dYHyJIa8wb13fPTdNtsg==
X-Google-Smtp-Source: ABdhPJzFKRrv0FYAom527u+/LPePhF6kldFDrU2pQjDJZ93oTplTJEtCzAh4XGaOwSbIJ1zZ1bgIFg==
X-Received: by 2002:a7b:c957:: with SMTP id i23mr743086wml.155.1603451640129;
        Fri, 23 Oct 2020 04:14:00 -0700 (PDT)
Received: from rdias-suse-pc.lan (bl13-26-148.dsl.telepac.pt. [85.246.26.148])
        by smtp.gmail.com with ESMTPSA id o129sm2452861wmb.25.2020.10.23.04.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 04:13:59 -0700 (PDT)
Date:   Fri, 23 Oct 2020 12:13:52 +0100
From:   Ricardo Dias <rdias@memsql.com>
To:     davem@davemloft.net, kuba@kernel.org, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, edumazet@google.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tcp: fix race condition when creating child sockets from
 syncookies
Message-ID: <20201023111352.GA289522@rdias-suse-pc.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the TCP stack is in SYN flood mode, the server child socket is
created from the SYN cookie received in a TCP packet with the ACK flag
set.

The child socket is created when the server receives the first TCP
packet with a valid SYN cookie from the client. Usually, this packet
corresponds to the final step of the TCP 3-way handshake, the ACK
packet. But is also possible to receive a valid SYN cookie from the
first TCP data packet sent by the client, and thus create a child socket
from that SYN cookie.

Since a client socket is ready to send data as soon as it receives the
SYN+ACK packet from the server, the client can send the ACK packet (sent
by the TCP stack code), and the first data packet (sent by the userspace
program) almost at the same time, and thus the server will equally
receive the two TCP packets with valid SYN cookies almost at the same
instant.

When such event happens, the TCP stack code has a race condition that
occurs between the momement a lookup is done to the established
connections hashtable to check for the existence of a connection for the
same client, and the moment that the child socket is added to the
established connections hashtable. As a consequence, this race condition
can lead to a situation where we add two child sockets to the
established connections hashtable and deliver two sockets to the
userspace program to the same client.

This patch fixes the race condition by checking if an existing child
socket exists for the same client when we are adding the second child
socket to the established connections socket. If an existing child
socket exists, we return that socket and use it to process the TCP
packet received, and discard the second child socket to the same client.

Signed-off-by: Ricardo Dias <rdias@memsql.com>
---
 include/net/inet_hashtables.h |  1 +
 net/ipv4/inet_hashtables.c    | 59 +++++++++++++++++++++++++++++++++++
 net/ipv4/syncookies.c         |  5 ++-
 net/ipv4/tcp_ipv4.c           | 16 +++++++++-
 4 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 92560974ea67..e1d7fd20468a 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -248,6 +248,7 @@ void inet_hashinfo2_init(struct inet_hashinfo *h, const char *name,
 int inet_hashinfo2_init_mod(struct inet_hashinfo *h);
 
 bool inet_ehash_insert(struct sock *sk, struct sock *osk);
+struct sock *inet_ehash_insert_chk_dup(struct sock *sk);
 bool inet_ehash_nolisten(struct sock *sk, struct sock *osk);
 int __inet_hash(struct sock *sk, struct sock *osk);
 int inet_hash(struct sock *sk);
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 239e54474b65..5dbe3aa291e6 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -539,6 +539,65 @@ bool inet_ehash_insert(struct sock *sk, struct sock *osk)
 	return ret;
 }
 
+/* Inserts a socket into ehash if no existing socket exists for the same
+ * quadruple (saddr, sport, daddr, dport).
+ * If there is an existing socket, returns that socket, otherwise returns NULL.
+ */
+struct sock *inet_ehash_insert_chk_dup(struct sock *sk)
+{
+	struct inet_hashinfo *hashinfo = sk->sk_prot->h.hashinfo;
+	struct hlist_nulls_head *list;
+	struct inet_ehash_bucket *head;
+	const struct hlist_nulls_node *node;
+	struct sock *esk;
+	spinlock_t *lock; /* protects hashinfo socket entry */
+	struct net *net = sock_net(sk);
+	const int dif, sdif = sk->sk_bound_dev_if;
+
+	INET_ADDR_COOKIE(acookie, sk->sk_daddr, sk->sk_rcv_saddr);
+	const __portpair ports = INET_COMBINED_PORTS(sk->sk_dport, sk->sk_num);
+
+	WARN_ON_ONCE(!sk_unhashed(sk));
+
+	sk->sk_hash = sk_ehashfn(sk);
+	head = inet_ehash_bucket(hashinfo, sk->sk_hash);
+	list = &head->chain;
+	lock = inet_ehash_lockp(hashinfo, sk->sk_hash);
+
+	spin_lock(lock);
+begin:
+	sk_nulls_for_each_rcu(esk, node, list) {
+		if (esk->sk_hash != sk->sk_hash)
+			continue;
+		if (likely(INET_MATCH(esk, net, acookie,
+				      sk->sk_daddr, sk->sk_rcv_saddr, ports,
+				      dif, sdif))) {
+			if (unlikely(!refcount_inc_not_zero(&esk->sk_refcnt)))
+				goto out;
+			if (unlikely(!INET_MATCH(esk, net, acookie,
+						 sk->sk_daddr,
+						 sk->sk_rcv_saddr, ports,
+						 dif, sdif))) {
+				sock_gen_put(esk);
+				goto begin;
+			}
+			goto found;
+		}
+	}
+out:
+	esk = NULL;
+	__sk_nulls_add_node_rcu(sk, list);
+found:
+	spin_unlock(lock);
+	if (esk) {
+		percpu_counter_inc(sk->sk_prot->orphan_count);
+		inet_sk_set_state(sk, TCP_CLOSE);
+		sock_set_flag(sk, SOCK_DEAD);
+		inet_csk_destroy_sock(sk);
+	}
+	return esk;
+}
+
 bool inet_ehash_nolisten(struct sock *sk, struct sock *osk)
 {
 	bool ok = inet_ehash_insert(sk, osk);
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index e03756631541..c4bb895085f0 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -208,7 +208,7 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, struct sk_buff *skb,
 
 	child = icsk->icsk_af_ops->syn_recv_sock(sk, skb, req, dst,
 						 NULL, &own_req);
-	if (child) {
+	if (child && own_req) {
 		refcount_set(&req->rsk_refcnt, 1);
 		tcp_sk(child)->tsoffset = tsoff;
 		sock_rps_save_rxhash(child, skb);
@@ -223,6 +223,9 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, struct sk_buff *skb,
 
 		bh_unlock_sock(child);
 		sock_put(child);
+	}  else if (child && !own_req) {
+		__reqsk_free(req);
+		return child;
 	}
 	__reqsk_free(req);
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 592c73962723..c705d335bd80 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1501,6 +1501,8 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 	int l3index;
 #endif
 	struct ip_options_rcu *inet_opt;
+	struct sock *esk = NULL;
+	bool syncookie = false;
 
 	if (sk_acceptq_is_full(sk))
 		goto exit_overflow;
@@ -1535,6 +1537,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 			goto put_and_exit;
 	} else {
 		/* syncookie case : see end of cookie_v4_check() */
+		syncookie = true;
 	}
 	sk_setup_caps(newsk, dst);
 
@@ -1565,7 +1568,18 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 
 	if (__inet_inherit_port(sk, newsk) < 0)
 		goto put_and_exit;
-	*own_req = inet_ehash_nolisten(newsk, req_to_sk(req_unhash));
+	if (!syncookie) {
+		*own_req = inet_ehash_nolisten(newsk, req_to_sk(req_unhash));
+	} else {
+		esk = inet_ehash_insert_chk_dup(newsk);
+		/* We're going to notify tcp_get_cookie_sock through own_req
+		 * that an existing socket is going to be returned instead,
+		 * since own_req is not used by the syncookies code.
+		 */
+		*own_req = !esk;
+		if (esk)
+			newsk = esk;
+	}
 	if (likely(*own_req)) {
 		tcp_move_syn(newtp, req);
 		ireq->ireq_opt = NULL;
-- 
2.25.1

