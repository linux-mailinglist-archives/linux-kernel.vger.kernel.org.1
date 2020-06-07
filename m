Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3B41F0B5B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jun 2020 15:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgFGNUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Jun 2020 09:20:33 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:27676 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgFGNUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 09:20:33 -0400
X-Greylist: delayed 767 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Jun 2020 09:20:32 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1591536031;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=y+pfta7yNhwYUoOid0wjMxSVJZWGEZuuSBhFq5hUIHM=;
        b=FzKcLYPMGs7r0Kd68NvJHpqiQH/IDA/W/lB6hhSUpPOEi3vELKNP5rq6FbzWLtGkPj
        U1P5EgYcjH8vN7qsg5Xixa8yEdb+RKUZqvNWeU1eogH5Noq8qjK5qEDoILf0rfFnhfga
        IHpeZGAGCMKgfVz7Pkc1K2thsW/wE+NRMEGrL/llLwzEhwhIaQOxl8Py3oGI6eWsszLf
        CFB5JUXsz2qGD/yjQHvm8WN79oIwcwhOCwDqmtRKef74gtsrpWNtOzZZKZgSYvU0wdhG
        5C51JZralCjjeH+kRm+XX4TH10Pivoyt7P9Gee8L8fB/8WxI0TfUPYMoPN3QREQ5TsWQ
        nDww==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXvdOeueZtw="
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 46.9.1 DYNA|AUTH)
        with ESMTPSA id I05374w57DKQFgz
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sun, 7 Jun 2020 15:20:26 +0200 (CEST)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+2e635807decef724a1fa@syzkaller.appspotmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v3] crypto: DRBG - always try to free Jitter RNG instance
Date:   Sun, 07 Jun 2020 15:20:26 +0200
Message-ID: <4563687.31r3eYUQgx@positron.chronox.de>
In-Reply-To: <2551009.mvXUDI8C0e@positron.chronox.de>
References: <0000000000002a280b05a725cd93@google.com> <20200603110919.GK30374@kadam> <2551009.mvXUDI8C0e@positron.chronox.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Jitter RNG is unconditionally allocated as a seed source follwoing
the patch 97f2650e5040. Thus, the instance must always be deallocated.

Reported-by: syzbot+2e635807decef724a1fa@syzkaller.appspotmail.com
Fixes: 97f2650e5040 ("crypto: drbg - always seeded with SP800-90B ...")
Signed-off-by: Stephan Mueller <smueller@chronox.de>
---
 crypto/drbg.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/crypto/drbg.c b/crypto/drbg.c
index 37526eb8c5d5..8d80d93cab97 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -1631,10 +1631,12 @@ static int drbg_uninstantiate(struct drbg_state *drbg)
 	if (drbg->random_ready.func) {
 		del_random_ready_callback(&drbg->random_ready);
 		cancel_work_sync(&drbg->seed_work);
-		crypto_free_rng(drbg->jent);
-		drbg->jent = NULL;
 	}
 
+	if (!IS_ERR_OR_NULL(drbg->jent))
+		crypto_free_rng(drbg->jent);
+	drbg->jent = NULL;
+
 	if (drbg->d_ops)
 		drbg->d_ops->crypto_fini(drbg);
 	drbg_dealloc_state(drbg);
-- 
2.26.2




