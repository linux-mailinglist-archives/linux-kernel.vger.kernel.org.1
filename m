Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A772B789E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 09:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgKRI26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 03:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgKRI26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 03:28:58 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04ADFC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 00:28:58 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id b6so1303427wrt.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 00:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kiiLAxXGH+3PZ2cJlSOiBDof+7XabswZxmu7q9McTjs=;
        b=gfs6phxOlIq8wS9oWyPtumLsa0G/DKewUQIxrvCB6+QVNzKUVn5isLhAGA1DfU7es4
         RSTWTwyEQAXCrfD/JhJQPKNtBFFs408EWudOIaGwYpTR5qFXduPauxCJ5TmZ3GP85p8Q
         i+QIQ60a6PDvmnOJ1cIx74XyCWfBfjVSiFGp57QPR7mx/fZwRQGsRd9zJjhs7G2I7bbA
         QKkz4AblXKbSVtKLoswGhiyH7SLk6Bo/MH7/02mpp16qEbmo6HO6cAusLzH5KE4o6qZz
         cbapm/wpbfUP56VhsKsJRi+hISshH2TuRsODHJ6tdZulis8uylOa13b9fwGwKLUL72Q/
         5/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kiiLAxXGH+3PZ2cJlSOiBDof+7XabswZxmu7q9McTjs=;
        b=DRHMJsf6g8965Klk8SfrKN8dDwtAYqD09n4U7W+BVC87Ntd47sNixWo8IILN+D8+LI
         uYCiKABIEJo81rdnjwQfDJEiN3yGmwcXZblTN3jf1kmgZNfzMZrwlekAx0BPBMK7SUhp
         GlCRRUlPXn6w8B06Uns7NN4ZUsqE3j4q6xrBZlu28OalBpxonwuaq1AFsO8Id4+Wvbg+
         xdT8zCZjbGgURCoUL2dnIAg98lWDWGWeHCj2616VskHZ5fdNu7AYoaw/JxQmlDeKM/aC
         4mYkn4+yr4zm9b5FlG0yAXoKx3ibGkji1Yhnmn3QkLVAp8K1xaK++mNqnmFSWCXyab8H
         RELA==
X-Gm-Message-State: AOAM531l9kt09sljAJWgGZ//UyJ25yiPle23uwvi+bFCUSxh6293lwxd
        XbgXAmM1tVtFZBtNB9KGPsE=
X-Google-Smtp-Source: ABdhPJzOEMaSdEMocArkOp8Bk3nbod8jt9VOKYHHA0TFEZLcdzPmdVVDeWOlUlQKqnVyGJJH63nVMA==
X-Received: by 2002:adf:ef4c:: with SMTP id c12mr3547384wrp.242.1605688136627;
        Wed, 18 Nov 2020 00:28:56 -0800 (PST)
Received: from localhost.localdomain ([5.209.181.42])
        by smtp.gmail.com with ESMTPSA id a128sm2510364wmf.5.2020.11.18.00.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 00:28:56 -0800 (PST)
From:   Armin Gholampoor <armingh379@gmail.com>
To:     davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org,
        Armin Gholampoor <armingh379@gmail.com>
Subject: [PATCH] net: ipv4: fixed brace and space style
Date:   Wed, 18 Nov 2020 11:58:45 -0500
Message-Id: <20201118165845.16078-1-armingh379@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed bracings for if statements

Fixed spacings around operators

Signed-off-by: Armin Gholampoor <armingh379@gmail.com>
---
 net/ipv4/tcp.c | 67 +++++++++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 31 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b2bc3d7fe..8c31ed8a6 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -581,8 +581,9 @@ __poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
 				if (__sk_stream_is_writeable(sk, 1))
 					mask |= EPOLLOUT | EPOLLWRNORM;
 			}
-		} else
+		} else {
 			mask |= EPOLLOUT | EPOLLWRNORM;
+		}
 
 		if (tp->urg_data & TCP_URG_VALID)
 			mask |= EPOLLPRI;
@@ -1479,8 +1480,9 @@ static int tcp_recv_urg(struct sock *sk, struct msghdr *msg, int len, int flags)
 			if (!(flags & MSG_TRUNC))
 				err = memcpy_to_msg(msg, &c, 1);
 			len = 1;
-		} else
+		} else {
 			msg->msg_flags |= MSG_TRUNC;
+		}
 
 		return err ? -EFAULT : len;
 	}
@@ -2194,8 +2196,9 @@ int tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int nonblock,
 						if (!used)
 							goto skip_copy;
 					}
-				} else
+				} else {
 					used = urg_offset;
+				}
 			}
 		}
 
@@ -2340,20 +2343,20 @@ EXPORT_SYMBOL_GPL(tcp_set_state);
  */
 
 static const unsigned char new_state[16] = {
-  /* current state:        new state:      action:	*/
-  [0 /* (Invalid) */]	= TCP_CLOSE,
-  [TCP_ESTABLISHED]	= TCP_FIN_WAIT1 | TCP_ACTION_FIN,
-  [TCP_SYN_SENT]	= TCP_CLOSE,
-  [TCP_SYN_RECV]	= TCP_FIN_WAIT1 | TCP_ACTION_FIN,
-  [TCP_FIN_WAIT1]	= TCP_FIN_WAIT1,
-  [TCP_FIN_WAIT2]	= TCP_FIN_WAIT2,
-  [TCP_TIME_WAIT]	= TCP_CLOSE,
-  [TCP_CLOSE]		= TCP_CLOSE,
-  [TCP_CLOSE_WAIT]	= TCP_LAST_ACK  | TCP_ACTION_FIN,
-  [TCP_LAST_ACK]	= TCP_LAST_ACK,
-  [TCP_LISTEN]		= TCP_CLOSE,
-  [TCP_CLOSING]		= TCP_CLOSING,
-  [TCP_NEW_SYN_RECV]	= TCP_CLOSE,	/* should not happen ! */
+	/* current state:        new state:      action:	*/
+	[0 /* (Invalid) */]	= TCP_CLOSE,
+	[TCP_ESTABLISHED]	= TCP_FIN_WAIT1 | TCP_ACTION_FIN,
+	[TCP_SYN_SENT]	= TCP_CLOSE,
+	[TCP_SYN_RECV]	= TCP_FIN_WAIT1 | TCP_ACTION_FIN,
+	[TCP_FIN_WAIT1]	= TCP_FIN_WAIT1,
+	[TCP_FIN_WAIT2]	= TCP_FIN_WAIT2,
+	[TCP_TIME_WAIT]	= TCP_CLOSE,
+	[TCP_CLOSE]		= TCP_CLOSE,
+	[TCP_CLOSE_WAIT]	= TCP_LAST_ACK  | TCP_ACTION_FIN,
+	[TCP_LAST_ACK]	= TCP_LAST_ACK,
+	[TCP_LISTEN]		= TCP_CLOSE,
+	[TCP_CLOSING]		= TCP_CLOSING,
+	[TCP_NEW_SYN_RECV]	= TCP_CLOSE,	/* should not happen ! */
 };
 
 static int tcp_close_state(struct sock *sk)
@@ -3043,7 +3046,7 @@ static int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 			return -EINVAL;
 
 		val = strncpy_from_sockptr(name, optval,
-					min_t(long, TCP_CA_NAME_MAX-1, optlen));
+					min_t(long, TCP_CA_NAME_MAX - 1, optlen));
 		if (val < 0)
 			return -EFAULT;
 		name[val] = 0;
@@ -3135,9 +3138,9 @@ static int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case TCP_REPAIR:
-		if (!tcp_can_repair_sock(sk))
+		if (!tcp_can_repair_sock(sk)) {
 			err = -EPERM;
-		else if (val == TCP_REPAIR_ON) {
+		} else if (val == TCP_REPAIR_ON) {
 			tp->repair = 1;
 			sk->sk_reuse = SK_FORCE_REUSE;
 			tp->repair_queue = TCP_NO_QUEUE;
@@ -3148,8 +3151,9 @@ static int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		} else if (val == TCP_REPAIR_OFF_NO_WP) {
 			tp->repair = 0;
 			sk->sk_reuse = SK_NO_REUSE;
-		} else
+		} else {
 			err = -EINVAL;
+		}
 
 		break;
 
@@ -3163,16 +3167,16 @@ static int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case TCP_QUEUE_SEQ:
-		if (sk->sk_state != TCP_CLOSE)
+		if (sk->sk_state != TCP_CLOSE) {
 			err = -EPERM;
-		else if (tp->repair_queue == TCP_SEND_QUEUE)
+		} else if (tp->repair_queue == TCP_SEND_QUEUE) {
 			WRITE_ONCE(tp->write_seq, val);
-		else if (tp->repair_queue == TCP_RECV_QUEUE) {
+		} else if (tp->repair_queue == TCP_RECV_QUEUE) {
 			WRITE_ONCE(tp->rcv_nxt, val);
 			WRITE_ONCE(tp->copied_seq, val);
-		}
-		else
+		} else {
 			err = -EINVAL;
+		}
 		break;
 
 	case TCP_REPAIR_OPTIONS:
@@ -3241,9 +3245,10 @@ static int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 				break;
 			}
 			tp->window_clamp = 0;
-		} else
+		} else {
 			tp->window_clamp = val < SOCK_MIN_RCVBUF / 2 ?
 						SOCK_MIN_RCVBUF / 2 : val;
+		}
 		break;
 
 	case TCP_QUICKACK:
@@ -4186,12 +4191,12 @@ void __init tcp_init(void)
 	tcp_init_mem();
 	/* Set per-socket limits to no more than 1/128 the pressure threshold */
 	limit = nr_free_buffer_pages() << (PAGE_SHIFT - 7);
-	max_wshare = min(4UL*1024*1024, limit);
-	max_rshare = min(6UL*1024*1024, limit);
+	max_wshare = min(4UL * 1024 * 1024, limit);
+	max_rshare = min(6UL * 1024 * 1024, limit);
 
 	init_net.ipv4.sysctl_tcp_wmem[0] = SK_MEM_QUANTUM;
-	init_net.ipv4.sysctl_tcp_wmem[1] = 16*1024;
-	init_net.ipv4.sysctl_tcp_wmem[2] = max(64*1024, max_wshare);
+	init_net.ipv4.sysctl_tcp_wmem[1] = 16 * 1024;
+	init_net.ipv4.sysctl_tcp_wmem[2] = max(64 * 1024, max_wshare);
 
 	init_net.ipv4.sysctl_tcp_rmem[0] = SK_MEM_QUANTUM;
 	init_net.ipv4.sysctl_tcp_rmem[1] = 131072;
-- 
2.29.2

