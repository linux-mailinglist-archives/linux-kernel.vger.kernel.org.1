Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170CA2691CD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 18:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgINQkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 12:40:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21262 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726039AbgINPbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600097492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5wD/L5mjZXfk+6pxJFnXBeqTK1xBuAPBxiA5Ca9uTUk=;
        b=ZFZJJweimkwPGqTvt/0AL+M3mnlpHyVjIW2oapevUL37zhyW7FkEIhn15hPNWoH+K4W/CW
        2BB4I6Sb+BEZIDjR7Wbu9zxAeWNgE8o803ul6C3PSJswKZk546Bz+InmUbxATTxqYIzIl8
        3wvS1u8wvJGdo1NRmF1AULexEdpQfpg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-4C4YTQPLMrWCAbs-YskdTw-1; Mon, 14 Sep 2020 11:31:28 -0400
X-MC-Unique: 4C4YTQPLMrWCAbs-YskdTw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD49D802B77;
        Mon, 14 Sep 2020 15:31:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-6.rdu2.redhat.com [10.10.113.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 10B7575133;
        Mon, 14 Sep 2020 15:31:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net-next 5/5] rxrpc: Fix an overget of the conn bundle when
 setting up a client conn
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 14 Sep 2020 16:31:21 +0100
Message-ID: <160009748120.1014072.10308681243643184204.stgit@warthog.procyon.org.uk>
In-Reply-To: <160009744625.1014072.11957943055200732444.stgit@warthog.procyon.org.uk>
References: <160009744625.1014072.11957943055200732444.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When setting up a client connection, a second ref is accidentally obtained
on the connection bundle (we get one when allocating the conn and a second
one when adding the conn to the bundle).

Fix it to only use the ref obtained by rxrpc_alloc_client_connection() and
not to add a second when adding the candidate conn to the bundle.

Fixes: 245500d853e9 ("rxrpc: Rewrite the client connection manager")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/conn_client.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
index 0eb36ba52485..78c845a4f1ad 100644
--- a/net/rxrpc/conn_client.c
+++ b/net/rxrpc/conn_client.c
@@ -433,7 +433,6 @@ static void rxrpc_add_conn_to_bundle(struct rxrpc_bundle *bundle, gfp_t gfp)
 		if (!rxrpc_may_reuse_conn(old)) {
 			if (old)
 				trace_rxrpc_client(old, -1, rxrpc_client_replace);
-			candidate->bundle = rxrpc_get_bundle(bundle);
 			candidate->bundle_shift = shift;
 			bundle->conns[i] = candidate;
 			for (j = 0; j < RXRPC_MAXCALLS; j++)


