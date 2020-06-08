Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783B71F1F48
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 20:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgFHSuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 14:50:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50853 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725280AbgFHSuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 14:50:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591642199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dkjrEf8Yt71FwL283bqD2ueNl/sna0+6OZ0XINyDznM=;
        b=Q85BsSk39DHc4uC53v29wOlAvfSejAYoeD6Hk+GumEfJ0t1sTs1GZz8EkZcHC5HwHqAGtU
        BF13mF0VY5/sE7mPUrLOkDHBX9HMGFLWlM0pxzCstjZyhAoj12uiLX3Ki0Nk/Jy3NtX43c
        KZ68RzbJvmWp8eKy1lWgPXpbQ4mULEg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-N6U05wR3N72vA-qL8DLqdA-1; Mon, 08 Jun 2020 14:49:57 -0400
X-MC-Unique: N6U05wR3N72vA-qL8DLqdA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D26018A8225;
        Mon,  8 Jun 2020 18:49:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-66.rdu2.redhat.com [10.10.114.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3570A10013D4;
        Mon,  8 Jun 2020 18:49:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net 1/2] rxrpc: Move the call completion handling out of line
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Marc Dionne <marc.dionne@auristor.com>, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 08 Jun 2020 19:49:54 +0100
Message-ID: <159164219444.2758133.4300247600455553049.stgit@warthog.procyon.org.uk>
In-Reply-To: <159164218727.2758133.1046957228494479308.stgit@warthog.procyon.org.uk>
References: <159164218727.2758133.1046957228494479308.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the handling of call completion out of line so that the next patch can
add more code in that area.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Marc Dionne <marc.dionne@auristor.com>
---

 net/rxrpc/ar-internal.h |  119 ++++++++++-------------------------------------
 net/rxrpc/recvmsg.c     |   74 +++++++++++++++++++++++++++++
 net/rxrpc/sendmsg.c     |    8 ++-
 3 files changed, 103 insertions(+), 98 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 9fe264bec70c..9a2139ebd67d 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -809,100 +809,6 @@ static inline bool rxrpc_is_client_call(const struct rxrpc_call *call)
 	return !rxrpc_is_service_call(call);
 }
 
-/*
- * Transition a call to the complete state.
- */
-static inline bool __rxrpc_set_call_completion(struct rxrpc_call *call,
-					       enum rxrpc_call_completion compl,
-					       u32 abort_code,
-					       int error)
-{
-	if (call->state < RXRPC_CALL_COMPLETE) {
-		call->abort_code = abort_code;
-		call->error = error;
-		call->completion = compl,
-		call->state = RXRPC_CALL_COMPLETE;
-		trace_rxrpc_call_complete(call);
-		wake_up(&call->waitq);
-		return true;
-	}
-	return false;
-}
-
-static inline bool rxrpc_set_call_completion(struct rxrpc_call *call,
-					     enum rxrpc_call_completion compl,
-					     u32 abort_code,
-					     int error)
-{
-	bool ret;
-
-	write_lock_bh(&call->state_lock);
-	ret = __rxrpc_set_call_completion(call, compl, abort_code, error);
-	write_unlock_bh(&call->state_lock);
-	return ret;
-}
-
-/*
- * Record that a call successfully completed.
- */
-static inline bool __rxrpc_call_completed(struct rxrpc_call *call)
-{
-	return __rxrpc_set_call_completion(call, RXRPC_CALL_SUCCEEDED, 0, 0);
-}
-
-static inline bool rxrpc_call_completed(struct rxrpc_call *call)
-{
-	bool ret;
-
-	write_lock_bh(&call->state_lock);
-	ret = __rxrpc_call_completed(call);
-	write_unlock_bh(&call->state_lock);
-	return ret;
-}
-
-/*
- * Record that a call is locally aborted.
- */
-static inline bool __rxrpc_abort_call(const char *why, struct rxrpc_call *call,
-				      rxrpc_seq_t seq,
-				      u32 abort_code, int error)
-{
-	trace_rxrpc_abort(call->debug_id, why, call->cid, call->call_id, seq,
-			  abort_code, error);
-	return __rxrpc_set_call_completion(call, RXRPC_CALL_LOCALLY_ABORTED,
-					   abort_code, error);
-}
-
-static inline bool rxrpc_abort_call(const char *why, struct rxrpc_call *call,
-				    rxrpc_seq_t seq, u32 abort_code, int error)
-{
-	bool ret;
-
-	write_lock_bh(&call->state_lock);
-	ret = __rxrpc_abort_call(why, call, seq, abort_code, error);
-	write_unlock_bh(&call->state_lock);
-	return ret;
-}
-
-/*
- * Abort a call due to a protocol error.
- */
-static inline bool __rxrpc_abort_eproto(struct rxrpc_call *call,
-					struct sk_buff *skb,
-					const char *eproto_why,
-					const char *why,
-					u32 abort_code)
-{
-	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
-
-	trace_rxrpc_rx_eproto(call, sp->hdr.serial, eproto_why);
-	return rxrpc_abort_call(why, call, sp->hdr.seq, abort_code, -EPROTO);
-}
-
-#define rxrpc_abort_eproto(call, skb, eproto_why, abort_why, abort_code) \
-	__rxrpc_abort_eproto((call), (skb), tracepoint_string(eproto_why), \
-			     (abort_why), (abort_code))
-
 /*
  * conn_client.c
  */
@@ -1101,8 +1007,33 @@ extern const struct seq_operations rxrpc_peer_seq_ops;
  * recvmsg.c
  */
 void rxrpc_notify_socket(struct rxrpc_call *);
+bool __rxrpc_set_call_completion(struct rxrpc_call *, enum rxrpc_call_completion, u32, int);
+bool rxrpc_set_call_completion(struct rxrpc_call *, enum rxrpc_call_completion, u32, int);
+bool __rxrpc_call_completed(struct rxrpc_call *);
+bool rxrpc_call_completed(struct rxrpc_call *);
+bool __rxrpc_abort_call(const char *, struct rxrpc_call *, rxrpc_seq_t, u32, int);
+bool rxrpc_abort_call(const char *, struct rxrpc_call *, rxrpc_seq_t, u32, int);
 int rxrpc_recvmsg(struct socket *, struct msghdr *, size_t, int);
 
+/*
+ * Abort a call due to a protocol error.
+ */
+static inline bool __rxrpc_abort_eproto(struct rxrpc_call *call,
+					struct sk_buff *skb,
+					const char *eproto_why,
+					const char *why,
+					u32 abort_code)
+{
+	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
+
+	trace_rxrpc_rx_eproto(call, sp->hdr.serial, eproto_why);
+	return rxrpc_abort_call(why, call, sp->hdr.seq, abort_code, -EPROTO);
+}
+
+#define rxrpc_abort_eproto(call, skb, eproto_why, abort_why, abort_code) \
+	__rxrpc_abort_eproto((call), (skb), tracepoint_string(eproto_why), \
+			     (abort_why), (abort_code))
+
 /*
  * rtt.c
  */
diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index 8578c39ec839..6c4ba4224ddc 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -58,6 +58,80 @@ void rxrpc_notify_socket(struct rxrpc_call *call)
 	_leave("");
 }
 
+/*
+ * Transition a call to the complete state.
+ */
+bool __rxrpc_set_call_completion(struct rxrpc_call *call,
+				 enum rxrpc_call_completion compl,
+				 u32 abort_code,
+				 int error)
+{
+	if (call->state < RXRPC_CALL_COMPLETE) {
+		call->abort_code = abort_code;
+		call->error = error;
+		call->completion = compl,
+		call->state = RXRPC_CALL_COMPLETE;
+		trace_rxrpc_call_complete(call);
+		wake_up(&call->waitq);
+		return true;
+	}
+	return false;
+}
+
+bool rxrpc_set_call_completion(struct rxrpc_call *call,
+			       enum rxrpc_call_completion compl,
+			       u32 abort_code,
+			       int error)
+{
+	bool ret;
+
+	write_lock_bh(&call->state_lock);
+	ret = __rxrpc_set_call_completion(call, compl, abort_code, error);
+	write_unlock_bh(&call->state_lock);
+	return ret;
+}
+
+/*
+ * Record that a call successfully completed.
+ */
+bool __rxrpc_call_completed(struct rxrpc_call *call)
+{
+	return __rxrpc_set_call_completion(call, RXRPC_CALL_SUCCEEDED, 0, 0);
+}
+
+bool rxrpc_call_completed(struct rxrpc_call *call)
+{
+	bool ret;
+
+	write_lock_bh(&call->state_lock);
+	ret = __rxrpc_call_completed(call);
+	write_unlock_bh(&call->state_lock);
+	return ret;
+}
+
+/*
+ * Record that a call is locally aborted.
+ */
+bool __rxrpc_abort_call(const char *why, struct rxrpc_call *call,
+			rxrpc_seq_t seq, u32 abort_code, int error)
+{
+	trace_rxrpc_abort(call->debug_id, why, call->cid, call->call_id, seq,
+			  abort_code, error);
+	return __rxrpc_set_call_completion(call, RXRPC_CALL_LOCALLY_ABORTED,
+					   abort_code, error);
+}
+
+bool rxrpc_abort_call(const char *why, struct rxrpc_call *call,
+		      rxrpc_seq_t seq, u32 abort_code, int error)
+{
+	bool ret;
+
+	write_lock_bh(&call->state_lock);
+	ret = __rxrpc_abort_call(why, call, seq, abort_code, error);
+	write_unlock_bh(&call->state_lock);
+	return ret;
+}
+
 /*
  * Pass a call terminating message to userspace.
  */
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 5e9c43d4a314..5dd9ba000c00 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -261,10 +261,10 @@ static int rxrpc_queue_packet(struct rxrpc_sock *rx, struct rxrpc_call *call,
 		case -ENETUNREACH:
 		case -EHOSTUNREACH:
 		case -ECONNREFUSED:
-			rxrpc_set_call_completion(call,
-						  RXRPC_CALL_LOCAL_ERROR,
-						  0, ret);
-			rxrpc_notify_socket(call);
+			if (rxrpc_set_call_completion(call,
+						      RXRPC_CALL_LOCAL_ERROR,
+						      0, ret))
+				rxrpc_notify_socket(call);
 			goto out;
 		}
 		_debug("need instant resend %d", ret);


