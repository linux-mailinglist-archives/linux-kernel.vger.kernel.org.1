Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14EB1CE5D6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 22:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731839AbgEKUmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 16:42:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731796AbgEKUmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:42:44 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4824208D5;
        Mon, 11 May 2020 20:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589229764;
        bh=aS2dHDA9i9dVpEXVSuaAzW0bc8hhHuBHo2KXFxqH8YY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NAlC0C7D6Sr+uo5xkaGOad8OCmqulFcK1m1TefghYGH2tXmthDop8etqkcom4JoHE
         XOwtFxfpsQj5jknr7IANgWPHb0MDKKJ7L1FYufvnKeUFDS4NjOzzPY1a9iXoMELvsi
         n512NM+yADF0ZohAU6IbwWmnztbQDkFH6DKozuI8=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     elver@google.com, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, peterz@infradead.org, will@kernel.org
Subject: [PATCH v5 07/18] net: tls: Avoid assigning 'const' pointer to non-const pointer
Date:   Mon, 11 May 2020 21:41:39 +0100
Message-Id: <20200511204150.27858-8-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511204150.27858-1-will@kernel.org>
References: <20200511204150.27858-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tls_build_proto() uses WRITE_ONCE() to assign a 'const' pointer to a
'non-const' pointer. Cleanups to the implementation of WRITE_ONCE() mean
that this will give rise to a compiler warning, just like a plain old
assignment would do:

  | net/tls/tls_main.c: In function ‘tls_build_proto’:
  | ./include/linux/compiler.h:229:30: warning: assignment discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
  | net/tls/tls_main.c:640:4: note: in expansion of macro ‘smp_store_release’
  |   640 |    smp_store_release(&saved_tcpv6_prot, prot);
  |       |    ^~~~~~~~~~~~~~~~~

Drop the const qualifier from the local 'prot' variable, as it isn't
needed.

Cc: Boris Pismenny <borisp@mellanox.com>
Cc: Aviad Yehezkel <aviadye@mellanox.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Will Deacon <will@kernel.org>
---
 net/tls/tls_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 156efce50dbd..b33e11c27cfa 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -629,7 +629,7 @@ struct tls_context *tls_ctx_create(struct sock *sk)
 static void tls_build_proto(struct sock *sk)
 {
 	int ip_ver = sk->sk_family == AF_INET6 ? TLSV6 : TLSV4;
-	const struct proto *prot = READ_ONCE(sk->sk_prot);
+	struct proto *prot = READ_ONCE(sk->sk_prot);
 
 	/* Build IPv6 TLS whenever the address of tcpv6 _prot changes */
 	if (ip_ver == TLSV6 &&
-- 
2.26.2.645.ge9eca65c58-goog

