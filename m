Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93C62E72C4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 18:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgL2Rkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 12:40:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52457 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726156AbgL2Rkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 12:40:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609263565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0N2HePoQRmdLA5K1yApdE8rhkgViaY5rXeLPZJah4TQ=;
        b=jMpiFj7Ask+V4EtR0+NsdkUwNA4p2O1VC2Aw4EBlwDRPqk79nyELs/tgy5ZIaGAz0lObOW
        grRapjeQeuFAgbrVJ7H/YMM74sneNwjvfGKJS8xeO5/fIA6zIA2IYUQrxpUC1oQDYZXFmX
        WIXV6c1F+ichQrvt8z/NLp+2vx9dQUQ=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-TuRcaRarNDKZI2O69l1yFQ-1; Tue, 29 Dec 2020 12:39:22 -0500
X-MC-Unique: TuRcaRarNDKZI2O69l1yFQ-1
Received: by mail-ot1-f69.google.com with SMTP id c18so10002190ots.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 09:39:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0N2HePoQRmdLA5K1yApdE8rhkgViaY5rXeLPZJah4TQ=;
        b=e9oEb55XhTfxGKjnubz1tddXSYKiUEaB2LXbbpaqHqx39tik/fh71IGo5Hfq1BmpuW
         nk9sF2Y+LOaSZNWGoRv36FzxsMFnYqT2o4KjxKsHWfFT4KDUTtXqQt2QKOAFiuok1Xip
         u5ls8HEYnAN6RM5fpL+lbk6iQl8D1AXh9cSAREfjLFM7rjv/jx8JeeB9CjQJlmYcbYxj
         7wTa17SkE4QA+PRrLtf1h4eB89PAgWwXECAT4dFDaw33/UO+hkwy6JNCcmkWcorpo12/
         8oTnImWZ7S3Ztxd+ru3idVjsbybIRoyRh05mTXp0iBm4WOYJBlNOs1ddo25f+n94pG7O
         rxlA==
X-Gm-Message-State: AOAM531DvzSnINtWEermBTCs0394/07oZCs+Dq1A4letLZdInzkBLOaW
        VFOL/S4/6M+V/+v3xSidUZBykuRuv4YGka1e5Ff9MMpt1GCtrmm+Uk1uzVEK3a/rIEL8lDM17wv
        31vjJkVbclWyo4wB+AZN0jQOS
X-Received: by 2002:a4a:c4c7:: with SMTP id g7mr34109287ooq.50.1609263562111;
        Tue, 29 Dec 2020 09:39:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwZkhEccaqdwFw1KqH+CndueSbBG4594RPWMr0slNPBBY1NHS22T8wMLn2iZEPQfjiQTKuBeQ==
X-Received: by 2002:a4a:c4c7:: with SMTP id g7mr34109277ooq.50.1609263561902;
        Tue, 29 Dec 2020 09:39:21 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s26sm9997234otd.8.2020.12.29.09.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 09:39:21 -0800 (PST)
From:   trix@redhat.com
To:     dhowells@redhat.com, davem@davemloft.net, kuba@kernel.org,
        natechancellor@gmail.com, ndesaulniers@google.com
Cc:     linux-afs@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] rxrpc: fix handling of an unsupported token type in rxrpc_read()
Date:   Tue, 29 Dec 2020 09:39:16 -0800
Message-Id: <20201229173916.1459499-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports this problem

net/rxrpc/key.c:657:11: warning: Assigned value is garbage or undefined
                toksize = toksizes[tok++];
                        ^ ~~~~~~~~~~~~~~~

rxrpc_read() contains two loops.  The first loop calculates the token
sizes and stores the results in toksizes[] and the second one uses the
array.  When there is an error in identifying the token in the first
loop, the token is skipped, no change is made to the toksizes[] array.
When the same error happens in the second loop, the token is not
skipped.  This will cause the toksizes[] array to be out of step and
will overrun past the calculated sizes.

Change the error handling in the second loop to be consistent with
the first.  Simplify the error handling to an if check.

Fixes: 9a059cd5ca7d ("rxrpc: Downgrade the BUG() for unsupported token type in rxrpc_read()")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 net/rxrpc/key.c | 48 ++++++++++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/net/rxrpc/key.c b/net/rxrpc/key.c
index 9631aa8543b5..eea877ee6ab3 100644
--- a/net/rxrpc/key.c
+++ b/net/rxrpc/key.c
@@ -587,20 +587,19 @@ static long rxrpc_read(const struct key *key,
 	for (token = key->payload.data[0]; token; token = token->next) {
 		toksize = 4;	/* sec index */
 
-		switch (token->security_index) {
-		case RXRPC_SECURITY_RXKAD:
-			toksize += 8 * 4;	/* viceid, kvno, key*2, begin,
-						 * end, primary, tktlen */
-			if (!token->no_leak_key)
-				toksize += RND(token->kad->ticket_len);
-			break;
-
-		default: /* we have a ticket we can't encode */
+		if (token->security_index != RXRPC_SECURITY_RXKAD) {
+			/* we have a ticket we can't encode */
 			pr_err("Unsupported key token type (%u)\n",
 			       token->security_index);
 			continue;
 		}
 
+		/* viceid, kvno, key*2, begin, end, primary, tktlen */
+		toksize += 8 * 4;
+
+		if (!token->no_leak_key)
+			toksize += RND(token->kad->ticket_len);
+
 		_debug("token[%u]: toksize=%u", ntoks, toksize);
 		ASSERTCMP(toksize, <=, AFSTOKEN_LENGTH_MAX);
 
@@ -654,28 +653,25 @@ static long rxrpc_read(const struct key *key,
 
 	tok = 0;
 	for (token = key->payload.data[0]; token; token = token->next) {
+		/* error reported above */
+		if (token->security_index != RXRPC_SECURITY_RXKAD)
+			continue;
+
 		toksize = toksizes[tok++];
 		ENCODE(toksize);
 		oldxdr = xdr;
 		ENCODE(token->security_index);
 
-		switch (token->security_index) {
-		case RXRPC_SECURITY_RXKAD:
-			ENCODE(token->kad->vice_id);
-			ENCODE(token->kad->kvno);
-			ENCODE_BYTES(8, token->kad->session_key);
-			ENCODE(token->kad->start);
-			ENCODE(token->kad->expiry);
-			ENCODE(token->kad->primary_flag);
-			if (token->no_leak_key)
-				ENCODE(0);
-			else
-				ENCODE_DATA(token->kad->ticket_len, token->kad->ticket);
-			break;
-
-		default:
-			break;
-		}
+		ENCODE(token->kad->vice_id);
+		ENCODE(token->kad->kvno);
+		ENCODE_BYTES(8, token->kad->session_key);
+		ENCODE(token->kad->start);
+		ENCODE(token->kad->expiry);
+		ENCODE(token->kad->primary_flag);
+		if (token->no_leak_key)
+			ENCODE(0);
+		else
+			ENCODE_DATA(token->kad->ticket_len, token->kad->ticket);
 
 		ASSERTCMP((unsigned long)xdr - (unsigned long)oldxdr, ==,
 			  toksize);
-- 
2.27.0

