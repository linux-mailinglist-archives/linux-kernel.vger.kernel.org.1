Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C082801FB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 17:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732593AbgJAO7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 10:59:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58241 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732913AbgJAO7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 10:59:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601564361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h8upbSMm5HSy3xdpB6lEtL/TJUkI3RchdUbTX39d/7c=;
        b=Rqk+i71EwM4DzbHQ/LPIB87hooFjAHzuMwggf+lXIJYogfjI8MfOWnB12VqeX4L4qZMux9
        wIGLKx1MjkPVjl8oHXlqkoO8rHwYoPbI8/5uglqCNmuI0NQ9jC0UDSLMeG/+i8RBQrNit9
        sjAv0NJoojRkY7CfJLPt3hdTMPxVZwI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-G-ZVHDhHOMqeJSQAdmPUuA-1; Thu, 01 Oct 2020 10:59:19 -0400
X-MC-Unique: G-ZVHDhHOMqeJSQAdmPUuA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4AE2803F50;
        Thu,  1 Oct 2020 14:59:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-116-196.rdu2.redhat.com [10.10.116.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC12861176;
        Thu,  1 Oct 2020 14:59:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net-next 22/23] rxrpc: Make the parsing of xdr payloads more
 coherent
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 01 Oct 2020 15:59:17 +0100
Message-ID: <160156435708.1728886.15158099093775622006.stgit@warthog.procyon.org.uk>
In-Reply-To: <160156420377.1728886.5309670328610130816.stgit@warthog.procyon.org.uk>
References: <160156420377.1728886.5309670328610130816.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the parsing of xdr-encoded payloads, as passed to add_key, more
coherent.  Shuttling back and forth between various variables was a bit
hard to follow.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/key.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/rxrpc/key.c b/net/rxrpc/key.c
index c08827b87979..19b730b58516 100644
--- a/net/rxrpc/key.c
+++ b/net/rxrpc/key.c
@@ -135,7 +135,7 @@ static int rxrpc_preparse_xdr_rxkad(struct key_preparsed_payload *prep,
  */
 static int rxrpc_preparse_xdr(struct key_preparsed_payload *prep)
 {
-	const __be32 *xdr = prep->data, *token;
+	const __be32 *xdr = prep->data, *p;
 	const char *cp;
 	unsigned int len, paddedlen, loop, ntoken, toklen, sec_ix;
 	size_t datalen = prep->datalen;
@@ -189,20 +189,20 @@ static int rxrpc_preparse_xdr(struct key_preparsed_payload *prep)
 		goto not_xdr;
 
 	/* check each token wrapper */
-	token = xdr;
+	p = xdr;
 	loop = ntoken;
 	do {
 		if (datalen < 8)
 			goto not_xdr;
-		toklen = ntohl(*xdr++);
-		sec_ix = ntohl(*xdr);
+		toklen = ntohl(*p++);
+		sec_ix = ntohl(*p);
 		datalen -= 4;
 		_debug("token: [%x/%zx] %x", toklen, datalen, sec_ix);
 		paddedlen = (toklen + 3) & ~3;
 		if (toklen < 20 || toklen > datalen || paddedlen > datalen)
 			goto not_xdr;
 		datalen -= paddedlen;
-		xdr += paddedlen >> 2;
+		p += paddedlen >> 2;
 
 	} while (--loop > 0);
 
@@ -214,13 +214,11 @@ static int rxrpc_preparse_xdr(struct key_preparsed_payload *prep)
 	 * - we ignore the cellname, relying on the key to be correctly named
 	 */
 	do {
-		xdr = token;
 		toklen = ntohl(*xdr++);
-		token = xdr + ((toklen + 3) >> 2);
 		sec_ix = ntohl(*xdr++);
 		toklen -= 4;
 
-		_debug("TOKEN type=%u [%p-%p]", sec_ix, xdr, token);
+		_debug("TOKEN type=%x len=%x", sec_ix, toklen);
 
 		switch (sec_ix) {
 		case RXRPC_SECURITY_RXKAD:
@@ -234,6 +232,8 @@ static int rxrpc_preparse_xdr(struct key_preparsed_payload *prep)
 			goto error;
 		}
 
+		xdr += (toklen + 3) / 4;
+
 	} while (--ntoken > 0);
 
 	_leave(" = 0");


